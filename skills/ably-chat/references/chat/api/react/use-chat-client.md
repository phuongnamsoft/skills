# useChatClient

The `useChatClient` hook provides access to the `clientId` of the `ChatClient` instance supplied by the [`ChatClientProvider`](https://ably.com/docs/chat/api/react/providers.md#chatClientProvider). It automatically monitors the `clientId` and refreshes when connection state transitions to `Connected`.

<Code>

#### React

```
import { useChatClient } from '@ably/chat/react';

const MyComponent = () => {
  const { clientId } = useChatClient();
  return <p>Connected as: {clientId}</p>;
};
```
</Code>

This hook must be used within a [`ChatClientProvider`](https://ably.com/docs/chat/api/react/providers.md#chatClientProvider).

## Returns 

The `useChatClient` hook returns an object with the following properties:

<Table id='UseChatClientResponse'>

| Property | Description | Type |
| --- | --- | --- |
| clientId | The current client identifier. Available immediately when using an Ably API key, but unavailable until a successful server connection when using token authentication. Monitor the connection status to determine connection readiness. | String or Undefined |

</Table>

## Example

<Code>

### React

```
import { useChatClient, useChatConnection } from '@ably/chat/react';

function UserStatus() {
  const { clientId } = useChatClient();
  const { currentStatus } = useChatConnection();

  if (!clientId) {
    return <p>Connecting...</p>;
  }

  return (
    <div>
      <p>Logged in as: {clientId}</p>
      <p>Connection status: {currentStatus}</p>
    </div>
  );
}
```
</Code>

## Related Topics

- [Providers](https://ably.com/docs/chat/api/react/providers.md): API reference for the ChatClientProvider and ChatRoomProvider components in the Ably Chat React SDK.
- [useChatConnection](https://ably.com/docs/chat/api/react/use-chat-connection.md): API reference for the useChatConnection hook in the Ably Chat React SDK.
- [useRoom](https://ably.com/docs/chat/api/react/use-room.md): API reference for the useRoom hook in the Ably Chat React SDK.
- [useMessages](https://ably.com/docs/chat/api/react/use-messages.md): API reference for the useMessages hook in the Ably Chat React SDK.
- [usePresence](https://ably.com/docs/chat/api/react/use-presence.md): API reference for the usePresence hook in the Ably Chat React SDK.
- [usePresenceListener](https://ably.com/docs/chat/api/react/use-presence-listener.md): API reference for the usePresenceListener hook in the Ably Chat React SDK.
- [useOccupancy](https://ably.com/docs/chat/api/react/use-occupancy.md): API reference for the useOccupancy hook in the Ably Chat React SDK.
- [useTyping](https://ably.com/docs/chat/api/react/use-typing.md): API reference for the useTyping hook in the Ably Chat React SDK.
- [useRoomReactions](https://ably.com/docs/chat/api/react/use-room-reactions.md): API reference for the useRoomReactions hook in the Ably Chat React SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
