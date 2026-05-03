# SDK setup

Use these instructions to install, authenticate and instantiate the Spaces SDK.

## Authenticate 

<Aside data-type='important'>
Client-side applications must use [token authentication](https://ably.com/docs/auth/token.md). API keys should never be exposed in client-side code because they don't expire and cannot be scoped to specific users.
</Aside>

Spaces requires an authenticated client with a `clientId` to identify users. The recommended approach is:

1. **Client-side apps** (browsers, mobile apps): Use [JWT authentication](https://ably.com/docs/auth/token/jwt.md) with `authCallback` to fetch JWTs from your server
2. **Server-side apps** (Node.js, Python, etc.): Use your API key directly

[Sign up](https://ably.com/sign-up) to Ably to create an API key in the [dashboard](https://ably.com/dashboard) or use the [Control API](https://ably.com/docs/platform/account/control-api.md) to create an API programmatically. Your server will use this key to issue tokens to clients.

API keys and tokens have a set of capabilities assigned to them that specify which operations, such as `subscribe` or `publish` can be performed on which resources. To use the Spaces SDK, the API key requires the following [capabilities](https://ably.com/docs/auth/capabilities.md):

* Publish
* Subscribe
* Presence
* History

For space-scoped capabilities and channel architecture details, see [Spaces authentication](https://ably.com/docs/spaces/authentication.md).

### Client identification 

Every Spaces client must have a `clientId` - this is a **hard requirement**. The Spaces SDK uses the `clientId` to identify users in the avatar stack, track their locations, display their cursors, and manage component locking.

Your auth server sets the `clientId` when creating tokens. This ensures users can't impersonate each other - the identity is controlled server-side, not by the client.

If you try to connect without a `clientId`, the connection will fail.

## Install 

<Aside data-type='note'>
The JavaScript SDK can be used with React. We also provide a dedicated [React Hooks package.](https://ably.com/docs/spaces/react.md)
</Aside>

The Spaces SDK is built on top of the Ably JavaScript SDK and uses it to establish a connection with Ably. Therefore the Ably JavaScript SDK is installed alongside the Spaces SDK.

Both SDKs are available as [NPM modules](#npm) and via [CDN.](#cdn)

### Using NPM 

Install the Ably JavaScript SDK and the Spaces SDK:

<Code>

#### Shell

```
npm install @ably/spaces
```
</Code>

Import the SDKs into your project:

<Code>

#### Javascript

```
import Spaces from '@ably/spaces';
import { Realtime } from 'ably';
```
</Code>

### Using a CDN 

Reference the Ably JavaScript SDK and the Spaces SDK within the `<head>` of your HTML file:

<Code>

#### Javascript

```
<script src="https://cdn.ably.com/lib/ably.min-2.js"></script>
<script src="https://cdn.ably.com/spaces/0.4/iife/index.bundle.js"></script>
```
</Code>

## Instantiate 

Authentication is configured on the Ably JavaScript SDK client, which the Spaces client wraps. The Spaces SDK itself doesn't handle authentication directly - it uses the authenticated connection from the underlying Ably client.

Instantiate a realtime client using the Ably JavaScript SDK and pass the generated client into the Spaces constructor.

### Client-side authentication (recommended) 

Use token authentication for browsers and mobile apps. Your auth server endpoint validates the user and returns an Ably token with the appropriate `clientId`:

<Code>

#### Javascript

```
// Client-side: Token authentication (recommended for browsers)

// If installing via NPM
const client = new Realtime({
  authCallback: async (tokenParams, callback) => {
    try {
      const response = await fetch('/api/ably-token');
      const token = await response.text();
      callback(null, token);
    } catch (error) {
      callback(error, null);
    }
  },
});
const spaces = new Spaces(client);

// If installing via CDN
const client = new Ably.Realtime({
  authCallback: async (tokenParams, callback) => {
    try {
      const response = await fetch('/api/ably-token');
      const token = await response.text();
      callback(null, token);
    } catch (error) {
      callback(error, null);
    }
  },
});
const spaces = new Spaces(client);
```
</Code>

Your auth server endpoint (`/api/ably-token`) should authenticate the user and return a token with the user's `clientId`. See the [token authentication](https://ably.com/docs/auth/token.md) documentation for server implementation examples.

### Server-side authentication 

For server-side applications or local development, you can use an API key directly:

<Code>

#### Javascript

```
// Server-side only: API key authentication
// WARNING: Never use this in client-side code (browsers, mobile apps)
const client = new Realtime({
  key: process.env.ABLY_API_KEY,
  clientId: 'server-process-1'
});
const spaces = new Spaces(client);
```
</Code>

A [`ClientOptions`](https://ably.com/docs/api/realtime-sdk.md#client-options) object may be passed to the Ably JavaScript SDK to further customize the connection. When using token authentication, the `clientId` is set by your auth server. When using API key authentication server-side, you must provide a `clientId` so that the client is [identified](https://ably.com/docs/auth/identified-clients.md).

### Using Ably JWT (alternative) 

If you have existing JWT-based authentication infrastructure (Auth0, Firebase, Cognito, or custom), you can create Ably JWTs directly without using the Ably SDK on your server:

#### Server (no Ably SDK required)

<Code>

##### Javascript

```
import jwt from 'jsonwebtoken';

const [keyName, keySecret] = process.env.ABLY_API_KEY.split(':');

app.get('/api/ably-jwt', async (req, res) => {
  // Your existing auth middleware validates the user
  const userId = req.user.id;

  const ablyJwt = jwt.sign(
    {
      'x-ably-capability': JSON.stringify({
        '*': ['publish', 'subscribe', 'presence', 'history'],
      }),
      'x-ably-clientId': userId,
    },
    keySecret,
    { algorithm: 'HS256', keyid: keyName, expiresIn: '1h' }
  );

  res.send(ablyJwt);
});
```
</Code>

#### Client

<Code>

##### Javascript

```
const client = new Realtime({
  authCallback: async (tokenParams, callback) => {
    try {
      const response = await fetch('/api/ably-jwt', {
        headers: { 'Authorization': `Bearer ${yourAppJwt}` },
      });
      const jwt = await response.text();
      callback(null, jwt);
    } catch (error) {
      callback(error, null);
    }
  },
});
const spaces = new Spaces(client);
```
</Code>

**Why choose JWT for Spaces?**
- No Ably SDK required on your server
- Integrates with existing Auth0/Firebase/Cognito flows
- Supports [channel-scoped claims](https://ably.com/docs/auth/capabilities.md#custom-restrictions) for user metadata
- Eliminates client round-trip to Ably

See [Token authentication](https://ably.com/docs/auth/token.md#choosing) for detailed guidance on when to use JWT vs Ably Tokens.

<Aside data-type='note'>
Only the promises version of the Ably JavaScript is supported when using Spaces, not the callback version.
</Aside>

## Client connections 

A Spaces client exposes the underlying [connection](https://ably.com/docs/connect.md) to Ably that is established via the Ably JavaScript SDK. This means that Spaces clients benefit from the same functionality available in the Ably JavaScript SDK, such as automatic transport selection and [connection state recovery](https://ably.com/docs/connect/states.md) in the event of brief disconnections.

Connections transition through multiple states throughout their lifecycle. Whilst these transitions are handled by the Ably SDK, there are certain cases where you may need to observe and handle them within your application. Ably SDKs enable these transitions to be observed and triggered using methods available on the `connection` object. The Spaces SDK exposes the underlying connection with `spaces.connection`, which is a reference to [`client.connection`](https://ably.com/docs/api/realtime-sdk/connection.md) in the Ably JavaScript SDK.

## Related Topics

- [Authentication](https://ably.com/docs/spaces/authentication.md): Configure authentication for Spaces applications with the required capabilities.
- [React Hooks](https://ably.com/docs/spaces/react.md): Incorporate Spaces into your React application with idiomatic and user-friendly React Hooks.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
