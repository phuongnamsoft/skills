# Authentication

Authentication in AI Transport operates at three levels: Ably token authentication for channel access, HTTP headers for server endpoint authorization, and cancel authorization for controlling who can cancel turns.

## Authentication flow 

1. Your auth server authenticates the user.
2. Your auth server issues an Ably-compatible token (JWT format is recommended for most apps).
3. The client SDK fetches tokens with `authCallback` and refreshes them automatically before expiry.
4. The authenticated Pub/Sub client provides channels to AI Transport via `useChannel` or `channels.get`.

<Aside data-type='important'>
Never use API keys in client-side code. API keys do not expire and are not suitable for untrusted clients.
</Aside>

## Server setup 

Create an endpoint that validates user-provided credentials and returns JWTs with the appropriate AI Transport capabilities:

<Code>

### Javascript

```
// Server-side JWT with AI Transport capabilities
import jwt from 'jsonwebtoken';

const [keyName, keySecret] = process.env.ABLY_API_KEY.split(':');

const ablyJwt = jwt.sign(
  {
    'x-ably-capability': JSON.stringify({
      // Only allow access to a specific conversation channel
      'your-conversation': ['publish', 'subscribe', 'history'],
    }),
    'x-ably-clientId': userId,
  },
  keySecret,
  { algorithm: 'HS256', keyid: keyName, expiresIn: '1h' }
);
```
</Code>

## Client setup 

<Code>

### Javascript

```
import * as Ably from 'ably';

const realtimeClient = new Ably.Realtime({
  authCallback: async (tokenParams, callback) => {
    try {
      const response = await fetch('/api/ably-token', { credentials: 'include' });
      if (!response.ok) throw new Error('Auth failed');
      const jwt = await response.text();
      callback(null, jwt);
    } catch (error) {
      callback(error, null);
    }
  },
});

const channel = realtimeClient.channels.get('your-conversation');
```

### React

```
'use client'

import { useEffect, useState } from 'react';
import * as Ably from 'ably';
import { AblyProvider } from 'ably/react';
import { TransportProvider, useClientTransport } from '@ably/ai-transport/react';
import { UIMessageCodec } from '@ably/ai-transport/vercel';

// 1. Create an authenticated Ably client and wrap your app
export function Providers({ children }) {
  const [client, setClient] = useState(null);

  useEffect(() => {
    const ably = new Ably.Realtime({
      authCallback: async (_tokenParams, callback) => {
        try {
          const response = await fetch('/api/ably-token', { credentials: 'include' });
          callback(null, await response.text());
        } catch (err) {
          callback(err instanceof Error ? err.message : String(err), null);
        }
      },
    });
    setClient(ably);
    return () => ably.close();
  }, []);

  if (!client) return null;
  return <AblyProvider client={client}>{children}</AblyProvider>;
}

// 2. Wrap with TransportProvider, then access the transport inside
function App({ conversationId }) {
  return (
    <TransportProvider channelName={conversationId} codec={UIMessageCodec}>
      <Chat conversationId={conversationId} />
    </TransportProvider>
  );
}

function Chat({ conversationId }) {
  const transport = useClientTransport({ channelName: conversationId });
  // ...
}
```
</Code>

<Aside data-type='note'>
AI Transport uses `clientId` throughout the SDK to identify who started a turn, who is sending messages, and who is requesting cancellation. Set the client ID in the Ably token to ensure it is verified by the Ably service and cannot be spoofed.
</Aside>

For more details, see [token authentication](https://ably.com/docs/auth/token.md), [capabilities](https://ably.com/docs/auth/capabilities.md), and [identified clients](https://ably.com/docs/auth/identified-clients.md).

## Enable message updates and deletes 

AI Transport requires the *Message annotations, updates, deletes, and appends* channel rule to be enabled on the channel namespace used for conversations. Without this rule, the transport cannot function correctly.

<Aside data-type='important'>
When message updates and deletes are enabled, messages are [persisted](https://ably.com/docs/storage-history/storage.md#all-message-persistence) regardless of whether or not persistence is enabled, in order to support the feature. This may increase your usage since [we charge for persisting messages](https://faqs.ably.com/how-does-ably-count-messages).
</Aside>

<Tabs>
<Tab value="dashboard" label="Dashboard">

In your app [settings](https://ably.com/accounts/any/apps/any/settings):

1. Click **Add new rule**.
2. Enter the channel name or namespace on which to enable message updates and deletes.
3. Check **Message annotations, updates, deletes, and appends**.
4. Click **Create rule** to save.

</Tab>
<Tab value="control-api" label="Control API">

Create a rule with updates and deletes enabled using the Control API by sending a `POST` request to [`/apps/{app_id}/namespaces`](https://ably.com/docs/api/control-api.md):

<Code>

### Shell

```
curl -X POST https://control.ably.net/v1/apps/{APP_ID}/namespaces \
  -H "Authorization: Bearer {ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "id": "my-namespace",
    "mutableMessages": true
  }'
```
</Code>

</Tab>
<Tab value="cli" label="Ably CLI">

Use the [Ably CLI](https://ably.com/docs/platform/tools/cli.md) to create a rule with updates and deletes enabled:

<Code>

### Shell

```
ably apps rules create \
  --name "my-namespace" \
  --mutable-messages
```
</Code>

Run `ably apps rules create --help` for a full list of available options.

</Tab>
</Tabs>

## AI Transport capabilities 

Capabilities are permissions that control what operations a client can perform. When you create a token for an AI Transport user, specify which capabilities they have:

| Feature | Required capabilities |
|---------|----------------------|
| Send user messages to channel | `publish` |
| Receive streamed tokens | `subscribe` |
| Replay history on reconnect | `subscribe`, `history` |
| Cancel a turn | `publish` |
| All AI Transport features | `publish`, `subscribe`, `history` |

## Channel-scoped capabilities 

You can scope capabilities to specific conversation channels, a namespace of channels, or all channels:

* `my-conversation` - a specific conversation channel
* `conversations:*` - all channels in the `conversations:` namespace
* `*` - all channels

## Token lifecycle and permission updates 

- With `authCallback` or `authUrl`, token refresh is automatic and handled by the SDK.
- To change a user's capabilities during an active session, issue a new token from your auth server and re-authenticate:

<Code>

### Javascript

```
// Re-authenticate to pick up updated capabilities
await realtimeClient.auth.authorize();
```
</Code>

- To immediately remove access, [revoke issued tokens](https://ably.com/docs/auth/revocation.md).
- If your capability JSON is too large for JWT or must remain confidential, use native [Ably Tokens](https://ably.com/docs/auth/token/ably-tokens.md).

## Server endpoint authentication 

When the client sends user messages, it makes an HTTP POST to the server endpoint. `TransportProvider` accepts two props for authenticating these requests:

**headers**: Static or dynamic HTTP headers sent with every POST.

<Code>

### Javascript

```
<TransportProvider
  channelName={conversationId}
  codec={UIMessageCodec}
  headers={() => ({
    'Authorization': `Bearer ${getAuthToken()}`,
  })}
>
  <Chat />
</TransportProvider>
```
</Code>

**credentials**: Controls whether cookies are sent with the POST request. This maps directly to the Fetch API `credentials` option. Set to `'include'` if your server uses cookie-based session authentication (for example, NextAuth or `express-session`) and the endpoint is cross-origin. For same-origin requests, the browser sends cookies by default and this option is not needed.

<Code>

### Javascript

```
<TransportProvider
  channelName={conversationId}
  codec={UIMessageCodec}
  credentials='include'
>
  <Chat />
</TransportProvider>
```
</Code>

The server endpoint validates these credentials however it normally would: JWT verification, session cookies, or API keys.

## Cancel authorization 

When a client publishes a cancel signal, the server can authorize or reject it. The `onCancel` hook on `NewTurnOptions` receives a `CancelRequest` with the filter, matched turn IDs, and a map of turn owners:

<Code>

### Javascript

```
const turn = transport.newTurn({
  turnId,
  clientId,
  onCancel: async (request) => {
    // Only allow the turn owner to cancel
    const owner = request.turnOwners.get(request.filter.turnId)
    return owner === request.message.clientId
  },
})
```
</Code>

If `onCancel` returns `false`, the cancellation is rejected. If `onCancel` is not provided, all cancel requests are accepted by default.

## Read next 

- [Getting started with Vercel AI SDK](https://ably.com/docs/ai-transport/getting-started/vercel-ai-sdk.md): set up authentication in a working app.
- [Getting started with the Core SDK](https://ably.com/docs/ai-transport/getting-started/core-sdk.md): set up authentication without a framework wrapper.
- [Cancellation](https://ably.com/docs/ai-transport/features/cancellation.md): how cancel signals and authorization work in detail.

## Related Topics

- [Sessions](https://ably.com/docs/ai-transport/concepts/sessions.md): Understand sessions in AI Transport: persistent, shared conversation state that exists independently of any participant's connection.
- [Messages and conversation tree](https://ably.com/docs/ai-transport/concepts/messages-and-conversation-tree.md): Understand how AI Transport organises messages into a branching conversation tree, and how views provide each participant with their own linear perspective.
- [Turns](https://ably.com/docs/ai-transport/concepts/turns.md): Understand turns in AI Transport: the logical unit of agent work that structures prompt-response cycles with lifecycle states, cancellation, and execution resilience.
- [Transport](https://ably.com/docs/ai-transport/concepts/transport.md): Understand the transport layer in AI Transport: client transport, agent transport, and the codec that bridges your AI framework to Ably.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
