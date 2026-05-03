# useChatConnection

The `useChatConnection` hook provides the current connection status and error state between the client and Ably. It supports listener callbacks for status changes and automatically cleans up listeners on component unmount.

<Code>

#### React

```
import { useChatConnection } from '@ably/chat/react';

const MyComponent = () => {
  const { currentStatus, error } = useChatConnection();
  return <p>Connection: {currentStatus}</p>;
};
```
</Code>

This hook must be used within a [`ChatClientProvider`](https://ably.com/docs/chat/api/react/providers.md#chatClientProvider).

## Parameters 

The `useChatConnection` hook accepts an optional configuration object:

<Table id='UseChatConnectionOptions'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| onStatusChange | Optional | A callback invoked whenever the connection status changes. The listener is removed when the component unmounts. | [ConnectionStatusChange](#connectionStatusChange) |

</Table>

## Returns 

The `useChatConnection` hook returns an object with the following properties:

<Table id='UseChatConnectionResponse'>

| Property | Description | Type |
| --- | --- | --- |
| currentStatus | The current status of the connection, kept up to date by the hook. | [ConnectionStatus](#connectionStatus) |
| error | An error that provides a reason why the connection has entered the new status, if applicable. Kept up to date by the hook. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |

</Table>

## ConnectionStatus 

The status of the connection to Ably.

<Table id='ConnectionStatus'>

| Status | Description |
| --- | --- |
| Initialized | A temporary state for when the library is first initialized. The value is `initialized`. |
| Connecting | The library is currently connecting to Ably. The value is `connecting`. |
| Connected | A connection exists and is active. The value is `connected`. |
| Disconnected | The library is currently disconnected from Ably, but will attempt to reconnect. The value is `disconnected`. |
| Suspended | The library is in an extended state of disconnection, but will attempt to reconnect. The value is `suspended`. |
| Failed | The library is currently disconnected from Ably and will not attempt to reconnect. The value is `failed`. |
| Closing | An explicit request by the developer to close the connection has been sent to the Ably service. The value is `closing`. |
| Closed | The connection has been explicitly closed by the client. No reconnection attempts are made automatically. The value is `closed`. |

</Table>

## ConnectionStatusChange 

Describes a change in connection status.

<Table id='ConnectionStatusChange'>

| Property | Description | Type |
| --- | --- | --- |
| current | The new connection status. | [ConnectionStatus](#connectionStatus) |
| previous | The previous connection status. | [ConnectionStatus](#connectionStatus) |
| error | An error that provides a reason why the connection has entered the new status, if applicable. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |
| retryIn | The time in milliseconds that the client will wait before attempting to reconnect, if applicable. | Number or Undefined |

</Table>

## Example

<Code>

### React

```
import { ConnectionStatus } from '@ably/chat';
import { useChatConnection } from '@ably/chat/react';

function ConnectionIndicator() {
  const { currentStatus, error } = useChatConnection({
    onStatusChange: (change) => {
      console.log('Status changed from', change.previous, 'to', change.current);
      if (change.retryIn) {
        console.log('Retrying in', change.retryIn, 'ms');
      }
    },
  });

  return (
    <div>
      <span className={currentStatus === ConnectionStatus.Connected ? 'online' : 'offline'}>
        {currentStatus}
      </span>
      {error && <p>Error: {error.message}</p>}
    </div>
  );
}
```
</Code>

## Related Topics

- [Providers](https://ably.com/docs/chat/api/react/providers.md): API reference for the ChatClientProvider and ChatRoomProvider components in the Ably Chat React SDK.
- [useChatClient](https://ably.com/docs/chat/api/react/use-chat-client.md): API reference for the useChatClient hook in the Ably Chat React SDK.
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
