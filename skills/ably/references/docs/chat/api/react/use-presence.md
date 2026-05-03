# usePresence

The `usePresence` hook manages the current user's presence in a chat room. By default, it automatically enters presence on mount and leaves on unmount. Use [`usePresenceListener`](https://ably.com/docs/chat/api/react/use-presence-listener.md) to observe the presence state of all users.

<Code>

#### React

```
import { usePresence } from '@ably/chat/react';

const MyComponent = () => {
  const { update, myPresenceState } = usePresence();

  return (
    <div>
      <p>Present: {myPresenceState.present ? 'Yes' : 'No'}</p>
      <button onClick={() => update({ status: 'away' })}>Set Away</button>
    </div>
  );
};
```
</Code>

This hook must be used within a [`ChatRoomProvider`](https://ably.com/docs/chat/api/react/providers.md#chatRoomProvider).

<Aside data-type='important'>
Avoid using multiple instances of this hook within the same `ChatRoomProvider`, as they share the same underlying presence instance.
</Aside>

## Parameters 

The `usePresence` hook accepts an optional configuration object:

<Table id='UsePresenceParams'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| autoEnterLeave | Optional | Whether the hook should automatically enter presence on mount and leave on unmount. If `leave()` is invoked, automatic entry is disabled until `enter` or `update` is called. Default: `true`. | Boolean |
| initialData | Optional | Data to use when auto-entering the room. Only applies to the initial auto-enter on component mount; subsequent modifications are disregarded. Use `update` or `enter` for post-entry data changes. | <Table id='PresenceData'/> |
| onDiscontinuity | Optional | A callback to detect and respond to discontinuities. | [DiscontinuityListener](https://ably.com/docs/chat/api/react/providers.md#discontinuityListener) |
| onRoomStatusChange | Optional | A callback invoked when the room status changes. Removed when the component unmounts. | [RoomStatusChange](https://ably.com/docs/chat/api/react/use-room.md#roomStatusChange) |
| onConnectionStatusChange | Optional | A callback invoked when the connection status changes. Removed when the component unmounts. | [ConnectionStatusChange](https://ably.com/docs/chat/api/react/use-chat-connection.md#connectionStatusChange) |

</Table>

<Table id='PresenceData' >

| Property | Description | Type |
| --- | --- | --- |
| | JSON-serializable data that can be associated with a user's presence in a room. | JsonObject |

</Table>

## Returns 

The `usePresence` hook returns an object with the following properties:

<Table id='UsePresenceResponse'>

| Property | Description | Type |
| --- | --- | --- |
| enter | Enters the current user into the presence set. | [enter()](#enter) |
| leave | Removes the current user from the presence set. | [leave()](#leave) |
| update | Updates the current user's presence data. | [update()](#update) |
| myPresenceState | The current presence state of the user, including whether they are present and any errors. | <Table id='MyPresenceState'/> |
| roomStatus | The current status of the room, kept up to date by the hook. | [RoomStatus](https://ably.com/docs/chat/api/react/use-room.md#roomStatus) |
| roomError | An error object if the room is in an errored state. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |
| connectionStatus | The current connection status, kept up to date by the hook. | [ConnectionStatus](https://ably.com/docs/chat/api/react/use-chat-connection.md#connectionStatus) |
| connectionError | An error object if there is a connection error. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |

</Table>

<Table id='MyPresenceState' >

| Property | Description | Type |
| --- | --- | --- |
| present | Whether the current user is present in the room. | Boolean |
| error | An error associated with the presence state, if any. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |

</Table>

## Enter presence 

`enter(data?: PresenceData): Promise<void>`

Enters the current user into the chat room presence set. This notifies other users that you have joined the room.

### Parameters 

<Table id='EnterParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| data | Optional | JSON-serializable data to associate with the user's presence. | <Table id='PresenceData'/> |

</Table>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the user has successfully entered the presence set, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

## Update presence data 

`update(data?: PresenceData): Promise<void>`

Updates the presence data for the current user in the chat room. Use this to change your status or other presence information without leaving and re-entering. Automatically enters if not already present.

### Parameters 

<Table id='UpdateParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| data | Optional | JSON-serializable data to replace the user's current presence data. | <Table id='PresenceData'/> |

</Table>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the presence data has been updated, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

## Leave presence 

`leave(data?: PresenceData): Promise<void>`

Removes the current user from the chat room presence set. This notifies other users that you have left the room. If `autoEnterLeave` is `true`, calling `leave()` prevents automatic re-entry until `enter` or `update` is called.

### Parameters 

<Table id='LeaveParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| data | Optional | Final presence data to include with the leave event. | <Table id='PresenceData'/> |

</Table>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the user has left the presence set, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

## Example

<Code>

### React

```
import { usePresence } from '@ably/chat/react';

function PresenceControls() {
  const { enter, leave, update, myPresenceState } = usePresence({
    initialData: { status: 'online', nickname: 'Alice' },
  });

  return (
    <div>
      <p>Status: {myPresenceState.present ? 'Online' : 'Offline'}</p>
      {myPresenceState.error && <p>Error: {myPresenceState.error.message}</p>}
      <button onClick={() => update({ status: 'away' })}>Set Away</button>
      <button onClick={() => leave()}>Leave</button>
      <button onClick={() => enter({ status: 'online' })}>Rejoin</button>
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
