# useOccupancy

The `useOccupancy` hook provides realtime room occupancy information, automatically tracking the number of connections and presence members in a room.

<Code>

#### React

```
import { useOccupancy } from '@ably/chat/react';

const MyComponent = () => {
  const { connections, presenceMembers } = useOccupancy();
  return <p>{connections} connections, {presenceMembers} present</p>;
};
```
</Code>

This hook must be used within a [`ChatRoomProvider`](https://ably.com/docs/chat/api/react/providers.md#chatRoomProvider).

## Parameters 

The `useOccupancy` hook accepts an optional configuration object:

<Table id='UseOccupancyParams'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Optional | A callback invoked whenever an occupancy event is received. Removed when the component unmounts. | <Table id='OccupancyListener'/> |
| onDiscontinuity | Optional | A callback to detect and respond to discontinuities. | [DiscontinuityListener](https://ably.com/docs/chat/api/react/providers.md#discontinuityListener) |
| onRoomStatusChange | Optional | A callback invoked when the room status changes. Removed when the component unmounts. | [RoomStatusChange](https://ably.com/docs/chat/api/react/use-room.md#roomStatusChange) |
| onConnectionStatusChange | Optional | A callback invoked when the connection status changes. Removed when the component unmounts. | [ConnectionStatusChange](https://ably.com/docs/chat/api/react/use-chat-connection.md#connectionStatusChange) |

</Table>

<Table id='OccupancyListener' >

| Parameter | Description | Type |
| --- | --- | --- |
| event | The occupancy event. | <Table id='OccupancyEvent'/> |

</Table>

<Table id='OccupancyEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The type of occupancy event. | <Table id='OccupancyEventType'/> |
| occupancy | The current occupancy data. | <Table id='OccupancyData'/> |

</Table>

<Table id='OccupancyEventType' >

| Value | Description |
| --- | --- |
| Updated | The room occupancy has been updated. The value is `occupancy.updated`. |

</Table>

<Table id='OccupancyData' >

| Property | Description | Type |
| --- | --- | --- |
| connections | The number of active connections to the room. | Number |
| presenceMembers | The number of users in the presence set. | Number |

</Table>

## Returns 

The `useOccupancy` hook returns an object with the following properties:

<Table id='UseOccupancyResponse'>

| Property | Description | Type |
| --- | --- | --- |
| connections | The current number of users connected to the room, kept up to date by the hook. | Number |
| presenceMembers | The current number of users present in the room, kept up to date by the hook. | Number |
| roomStatus | The current status of the room, kept up to date by the hook. | [RoomStatus](https://ably.com/docs/chat/api/react/use-room.md#roomStatus) |
| roomError | An error object if the room is in an errored state. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |
| connectionStatus | The current connection status, kept up to date by the hook. | [ConnectionStatus](https://ably.com/docs/chat/api/react/use-chat-connection.md#connectionStatus) |
| connectionError | An error object if there is a connection error. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |

</Table>

## Example

<Code>

### React

```
import { useOccupancy } from '@ably/chat/react';

function ViewerCount() {
  const { connections, presenceMembers } = useOccupancy({
    listener: (event) => {
      console.log('Occupancy updated:', event.occupancy);
    },
  });

  return (
    <div>
      <p>{connections} watching</p>
      <p>{presenceMembers} in chat</p>
    </div>
  );
}
```
</Code>

## Related Topics

- [Providers](https://ably.com/docs/chat/api/react/providers.md): API reference for the ChatClientProvider and ChatRoomProvider components in the Ably Chat React SDK.
- [useChatClient](https://ably.com/docs/chat/api/react/use-chat-client.md): API reference for the useChatClient hook in the Ably Chat React SDK.
- [useChatConnection](https://ably.com/docs/chat/api/react/use-chat-connection.md): API reference for the useChatConnection hook in the Ably Chat React SDK.
- [useRoom](https://ably.com/docs/chat/api/react/use-room.md): API reference for the useRoom hook in the Ably Chat React SDK.
- [useMessages](https://ably.com/docs/chat/api/react/use-messages.md): API reference for the useMessages hook in the Ably Chat React SDK.
- [usePresence](https://ably.com/docs/chat/api/react/use-presence.md): API reference for the usePresence hook in the Ably Chat React SDK.
- [usePresenceListener](https://ably.com/docs/chat/api/react/use-presence-listener.md): API reference for the usePresenceListener hook in the Ably Chat React SDK.
- [useTyping](https://ably.com/docs/chat/api/react/use-typing.md): API reference for the useTyping hook in the Ably Chat React SDK.
- [useRoomReactions](https://ably.com/docs/chat/api/react/use-room-reactions.md): API reference for the useRoomReactions hook in the Ably Chat React SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
