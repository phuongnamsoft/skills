# Presence

The `Presence` interface provides methods for tracking which users are currently in a chat room. Access it via `room.presence`.

<Code>

#### Javascript

```
const presence = room.presence;
```
</Code>

## Enter presence 

`presence.enter(data?: PresenceData): Promise<void>`

Enters the current user into the chat room presence set. This notifies other users that you have joined the room.

The room must be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) before calling this method.

<Code>

### Javascript

```
await room.presence.enter({ status: 'online', nickname: 'Alice' });
```
</Code>

### Parameters 

The `enter()` method takes the following parameters:

<Table id='EnterParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| data | Optional | JSON-serializable data to associate with the user's presence. | <Table id='PresenceData'/> |

</Table>

<Table id='PresenceData' >

| Property | Description | Type |
| --- | --- | --- |
| | JSON-serializable data that can be associated with a user's presence in a room. | JsonObject |

</Table>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the user has successfully entered the presence set, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Update presence data 

`presence.update(data?: PresenceData): Promise<void>`

Updates the presence data for the current user in the chat room. Use this to change your status or other presence information without leaving and re-entering.

The room must be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) before calling this method.

<Code>

### Javascript

```
await room.presence.update({ status: 'away', nickname: 'Alice' });
```
</Code>

### Parameters 

The `update()` method takes the following parameters:

<Table id='UpdateParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| data | Optional | JSON-serializable data to replace the user's current presence data. | <Table id='PresenceData'/> |

</Table>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the presence data has been updated, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Leave presence 

`presence.leave(data?: PresenceData): Promise<void>`

Removes the current user from the chat room presence set. This notifies other users that you have left the room.

The room must be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) before calling this method.

<Code>

### Javascript

```
await room.presence.leave({ status: 'offline' });
```
</Code>

### Parameters 

The `leave()` method takes the following parameters:

<Table id='LeaveParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| data | Optional | Final presence data to include with the leave event. | <Table id='PresenceData'/> |

</Table>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the user has left the presence set, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Get current presence members 

`presence.get(params?: RealtimePresenceParams): Promise<PresenceMember[]>`

Retrieves the current members present in the chat room.

The room must be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) before calling this method.

<Code>

### Javascript

```
const members = await room.presence.get();

members.forEach(member => {
  console.log(`${member.clientId} is ${member.data?.status}`);
});
```
</Code>

### Parameters 

The `get()` method takes the following parameters:

<Table id='GetParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| params | Optional | Parameters to filter the presence set. | <Table id='RealtimePresenceParams'/> |

</Table>

<Table id='RealtimePresenceParams' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| clientId | Optional | Filters the returned presence members by a specific client ID. | String |
| connectionId | Optional | Filters the returned presence members by a specific connection ID. | String |
| waitForSync | Optional | Whether to wait for a full presence set synchronization before returning results. Default `true`. | Boolean |

</Table>

### Returns 

`Promise<PresenceMember[]>`

Returns a promise. The promise is fulfilled with an array of presence members currently in the room, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Check if a user is present 

`presence.isUserPresent(clientId: string): Promise<boolean>`

Checks whether a specific user is currently present in the chat room.

The room must be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) before calling this method.

<Code>

### Javascript

```
const isAliceHere = await room.presence.isUserPresent('alice-123');
console.log('Alice is present:', isAliceHere);
```
</Code>

### Parameters 

The `isUserPresent()` method takes the following parameters:

<Table id='IsUserPresentParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| clientId | Required | The client ID of the user to check. | String |

</Table>

### Returns 

`Promise<boolean>`

Returns a promise. The promise is fulfilled with `true` if the user is present or `false` otherwise, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Subscribe to presence events 

`presence.subscribe(listener: PresenceListener): Subscription`

Subscribes to all presence events in the chat room. Receive notifications when users enter, leave, or update their presence data.

<Code>

### Javascript

```
import { PresenceEventType } from '@ably/chat';

const { unsubscribe } = room.presence.subscribe((event) => {
  const member = event.member;
  switch (event.type) {
    case PresenceEventType.Enter:
      console.log(`${member.clientId} joined`);
      break;
    case PresenceEventType.Leave:
      console.log(`${member.clientId} left`);
      break;
    case PresenceEventType.Update:
      console.log(`${member.clientId} updated their status`);
      break;
    case PresenceEventType.Present:
      console.log(`${member.clientId} is present`);
      break;
  }
});

// To stop receiving presence events
unsubscribe();
```
</Code>

### Parameters 

The `subscribe()` method takes the following parameters:

<Table id='SubscribeParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Required | Callback function invoked when any presence event occurs. | <Table id='PresenceEvent'/> |

</Table>

<Table id='PresenceEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The type of presence event. | <Table id='PresenceEventType'/> |
| member | The presence member associated with this event. | <Table id='PresenceMember'/> |

</Table>

<Table id='PresenceEventType' >

| Value | Description |
| --- | --- |
| Enter | A user has entered the presence set. The value is `enter`. |
| Leave | A user has left the presence set. The value is `leave`. |
| Update | A user has updated their presence data. The value is `update`. |
| Present | Indicates a user is present (received during initial sync). The value is `present`. |

</Table>

<Table id='PresenceMember' >

| Property | Description | Type |
| --- | --- | --- |
| clientId | The client ID of the present user. | String |
| userClaim | The user claim attached to this presence event by the server. Only present if the user's [JWT](https://ably.com/docs/auth/token.md#jwt) contained a claim for the room. | String or Undefined |
| connectionId | The connection ID of the present user. | String |
| data | The presence data associated with the user. | <Table id='PresenceData'/> or Undefined |
| extras | Additional data included with the presence message. | JsonObject or Undefined |
| encoding | The encoding applied to the presence data, if any. Contains remaining transformations not yet applied to the `data` property. | String or Undefined |
| updatedAt | When this presence state was last updated. | Date |

</Table>

### Returns 

`Subscription`

Returns an object with the following methods:

#### Unsubscribe from presence events 

`unsubscribe(): void`

Call `unsubscribe()` to stop receiving presence events.

## Example

<Code>

### Javascript

```
const room = await chatClient.rooms.get('my-room');

await room.attach();

// Subscribe to presence events
const { unsubscribe } = room.presence.subscribe((event) => {
  const member = event.member;
  console.log(`${event.type}: ${member.clientId}`);
  if (member.data) {
    console.log('Data:', member.data);
  }
});

// Enter the room with custom data
await room.presence.enter({
  status: 'online',
  nickname: 'Alice',
  avatar: 'https://example.com/alice.png'
});

// Get everyone currently in the room
const members = await room.presence.get();
console.log(`${members.length} users in room`);

// Update your status
await room.presence.update({ status: 'away' });

// Check if a specific user is present
const isBobHere = await room.presence.isUserPresent('bob-456');

// Leave when done
await room.presence.leave();
unsubscribe();
```
</Code>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/javascript/chat-client.md): API reference for the ChatClient class in the Ably Chat JavaScript SDK.
- [Connection](https://ably.com/docs/chat/api/javascript/connection.md): API reference for the Connection interface in the Ably Chat JavaScript SDK.
- [Rooms](https://ably.com/docs/chat/api/javascript/rooms.md): API reference for the Rooms interface in the Ably Chat JavaScript SDK.
- [Room](https://ably.com/docs/chat/api/javascript/room.md): API reference for the Room interface in the Ably Chat JavaScript SDK.
- [Messages](https://ably.com/docs/chat/api/javascript/messages.md): API reference for the Messages interface in the Ably Chat JavaScript SDK.
- [Message](https://ably.com/docs/chat/api/javascript/message.md): API reference for the Message interface in the Ably Chat JavaScript SDK.
- [MessageReactions](https://ably.com/docs/chat/api/javascript/message-reactions.md): API reference for the MessageReactions interface in the Ably Chat JavaScript SDK.
- [Occupancy](https://ably.com/docs/chat/api/javascript/occupancy.md): API reference for the Occupancy interface in the Ably Chat JavaScript SDK.
- [Typing](https://ably.com/docs/chat/api/javascript/typing.md): API reference for the Typing interface in the Ably Chat JavaScript SDK.
- [RoomReactions](https://ably.com/docs/chat/api/javascript/room-reactions.md): API reference for the RoomReactions interface in the Ably Chat JavaScript SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
