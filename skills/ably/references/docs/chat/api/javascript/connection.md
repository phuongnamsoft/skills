# Connection

The `Connection` interface represents the connection to Ably and provides methods to monitor connection status changes. Access the connection via `chatClient.connection`.

<Code>

#### Javascript

```
const connection = chatClient.connection;
```
</Code>

## Properties

The `Connection` interface has the following properties:

<Table id='ConnectionProperties'>

| Property | Description | Type |
| --- | --- | --- |
| status | The current connection status. | <Table id='ConnectionStatus'/> |
| error | The error that caused the connection to enter its current status, if any. | [ErrorInfo](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) or Undefined |

</Table>

<Table id='ConnectionStatus' >

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

## Subscribe to connection status changes 

`connection.onStatusChange(listener: ConnectionStatusListener): StatusSubscription`

Registers a listener to be notified of connection status changes.

<Code>

### Javascript

```
const { off } = chatClient.connection.onStatusChange((change) => {
  console.log('Status changed from', change.previous, 'to', change.current);
  if (change.error) {
    console.error('Error:', change.error);
  }
  if (change.retryIn) {
    console.log('Retrying in', change.retryIn, 'ms');
  }
});

// To unsubscribe
off();
```
</Code>

### Parameters 

The `onStatusChange()` method takes the following parameters:

<Table id='OnStatusChangeParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Required | A callback invoked on status changes. | <Table id='ConnectionStatusListener' /> |

</Table>

<Table id='ConnectionStatusListener' >

| Parameter | Description | Type |
| --- | --- | --- |
| change | The status change event. | <Table id='ConnectionStatusChange' /> |

</Table>

<Table id='ConnectionStatusChange' >

| Property | Description | Type |
| --- | --- | --- |
| current | The new connection status. | <Table id='ConnectionStatus' /> |
| previous | The previous connection status. | <Table id='ConnectionStatus' /> |
| error | An error that provides a reason why the connection has entered the new status, if applicable. | [ErrorInfo](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) or Undefined |
| retryIn | The time in milliseconds that the client will wait before attempting to reconnect, if applicable. | Number or Undefined |

</Table>

### Returns 

`StatusSubscription`

Returns an object with the following methods:

#### Deregister the listener 

`off(): void`

Call `off()` to deregister the connection status listener.

### Example

<Code>

#### Javascript

```
import { ConnectionStatus } from '@ably/chat';

// Monitor connection status
const { off } = chatClient.connection.onStatusChange((change) => {
  switch (change.current) {
    case ConnectionStatus.Connected:
      console.log('Connected to Ably');
      break;
    case ConnectionStatus.Disconnected:
      console.log('Disconnected, will retry...');
      break;
    case ConnectionStatus.Suspended:
      console.log('Connection suspended, retrying in', change.retryIn, 'ms');
      break;
    case ConnectionStatus.Failed:
      console.error('Connection failed:', change.error);
      break;
  }
});

// Check current status
console.log('Current status:', chatClient.connection.status);

// Clean up when done
off();
```
</Code>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/javascript/chat-client.md): API reference for the ChatClient class in the Ably Chat JavaScript SDK.
- [Rooms](https://ably.com/docs/chat/api/javascript/rooms.md): API reference for the Rooms interface in the Ably Chat JavaScript SDK.
- [Room](https://ably.com/docs/chat/api/javascript/room.md): API reference for the Room interface in the Ably Chat JavaScript SDK.
- [Messages](https://ably.com/docs/chat/api/javascript/messages.md): API reference for the Messages interface in the Ably Chat JavaScript SDK.
- [Message](https://ably.com/docs/chat/api/javascript/message.md): API reference for the Message interface in the Ably Chat JavaScript SDK.
- [MessageReactions](https://ably.com/docs/chat/api/javascript/message-reactions.md): API reference for the MessageReactions interface in the Ably Chat JavaScript SDK.
- [Presence](https://ably.com/docs/chat/api/javascript/presence.md): API reference for the Presence interface in the Ably Chat JavaScript SDK.
- [Occupancy](https://ably.com/docs/chat/api/javascript/occupancy.md): API reference for the Occupancy interface in the Ably Chat JavaScript SDK.
- [Typing](https://ably.com/docs/chat/api/javascript/typing.md): API reference for the Typing interface in the Ably Chat JavaScript SDK.
- [RoomReactions](https://ably.com/docs/chat/api/javascript/room-reactions.md): API reference for the RoomReactions interface in the Ably Chat JavaScript SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
