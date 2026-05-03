# Typing

The `Typing` interface provides methods for sending and receiving typing indicators in a chat room. Access it via `room.typing`.

<Code>

#### Javascript

```
const typing = room.typing;
```
</Code>

## Properties

The `Typing` interface has the following properties:

<Table id='TypingProperties'>

| Property | Description | Type |
| --- | --- | --- |
| currentTypers | The set of users currently typing in the room, with associated metadata such as user claims. | <Table id='TypingMember'/> |
| current | **Deprecated.** Use `currentTypers` instead. The set of client IDs currently typing. | `Set<string>` |

</Table>

<Table id='TypingMember' >

| Property | Description | Type |
| --- | --- | --- |
| clientId | The client ID of the typing user. | String |
| userClaim | The user claim attached to this typing event by the server. Only present if the user's [JWT](https://ably.com/docs/auth/token.md#jwt) contained a claim for the room. | String or Undefined |

</Table>

## Start typing 

`typing.keystroke(): Promise<void>`

Sends a typing started event to notify other users that the current user is typing.

Events are throttled according to the [`heartbeatThrottleMs`](https://ably.com/docs/chat/api/javascript/rooms.md#get) room option to prevent excessive network traffic. If called within the throttle interval, the operation becomes a no-op. Multiple rapid calls are serialized to maintain consistency.

The room must be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) and the connection must be in the [`connected`](https://ably.com/docs/chat/api/javascript/connection.md) state.

<Code>

### Javascript

```
// Call this when the user starts typing
await room.typing.keystroke();
```
</Code>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the typing event has been sent, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Stop typing 

`typing.stop(): Promise<void>`

Sends a typing stopped event to notify other users that the current user has stopped typing.

If the user is not currently typing, this operation is a no-op. Multiple rapid calls are serialized to maintain consistency.

The room must be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) and the connection must be in the [`connected`](https://ably.com/docs/chat/api/javascript/connection.md) state.

<Code>

### Javascript

```
// Call this when the user stops typing or clears the input
await room.typing.stop();
```
</Code>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the stop event has been sent, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Subscribe to typing events 

`typing.subscribe(listener: TypingListener): Subscription`

Subscribes to typing events from users in the chat room. Receives updates whenever a user starts or stops typing, providing real-time feedback about who is currently composing messages.

The room must be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) to receive typing events.

<Code>

### Javascript

```
const { unsubscribe } = room.typing.subscribe((event) => {
  console.log('Currently typing:', event.currentTypers.map(user => user.clientId));
});

// To stop receiving typing events
unsubscribe();
```
</Code>

### Parameters 

The `subscribe()` method takes the following parameters:

<Table id='SubscribeParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Required | Callback invoked when the typing state changes. | <Table id='TypingSetEvent'/> |

</Table>

<Table id='TypingSetEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The type of the event. Always `SetChanged`. | <Table id='TypingSetEventType'/> |
| currentTypers | The set of users currently typing, with associated metadata such as user claims. | <Table id='TypingMember'/> |
| currentlyTyping | **Deprecated.** Use `currentTypers` instead. The set of client IDs currently typing. | `Set<string>` |
| change | Information about the specific change that triggered this event. | <Table id='TypingSetEvent.change'/> |

</Table>

<Table id='TypingSetEventType' >

| Value | Description |
| --- | --- |
| SetChanged | The set of currently typing users has changed. The value is `typing.set.changed`. |

</Table>

<Table id='TypingSetEvent.change' >

| Property | Description | Type |
| --- | --- | --- |
| clientId | The client ID whose typing state changed. | String |
| type | Whether the user started or stopped typing. | <Table id='TypingEventType'/> |
| userClaim | The user claim attached to this typing event by the server. Only present if the user's [JWT](https://ably.com/docs/auth/token.md#jwt) contained a claim for the room. | String or Undefined |

</Table>

<Table id='TypingEventType' >

| Value | Description |
| --- | --- |
| Started | A user has started typing. The value is `typing.started`. |
| Stopped | A user has stopped typing. The value is `typing.stopped`. |

</Table>

### Returns 

`Subscription`

Returns an object with the following methods:

#### Unsubscribe from typing events 

`unsubscribe(): void`

Call `unsubscribe()` to stop receiving typing events.

## Example

<Code>

### Javascript

```
const room = await chatClient.rooms.get('my-room', {
  typing: {
    heartbeatThrottleMs: 5000 // Throttle typing events to every 5 seconds
  }
});

await room.attach();

// Subscribe to typing events
const { unsubscribe } = room.typing.subscribe((event) => {
  const typingUsers = event.currentTypers;

  if (typingUsers.length === 0) {
    console.log('No one is typing');
  } else if (typingUsers.length === 1) {
    console.log(`${typingUsers[0].clientId} is typing...`);
  } else {
    console.log(`${typingUsers.map(user => user.clientId).join(', ')} are typing...`);
  }
});

// Integrate with an input field
const inputField = document.getElementById('message-input');

inputField.addEventListener('input', async () => {
  if (inputField.value.length > 0) {
    await room.typing.keystroke();
  } else {
    await room.typing.stop();
  }
});

inputField.addEventListener('blur', async () => {
  await room.typing.stop();
});

// Check who is currently typing
console.log('Currently typing:', room.typing.currentTypers);

// Clean up
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
- [Presence](https://ably.com/docs/chat/api/javascript/presence.md): API reference for the Presence interface in the Ably Chat JavaScript SDK.
- [Occupancy](https://ably.com/docs/chat/api/javascript/occupancy.md): API reference for the Occupancy interface in the Ably Chat JavaScript SDK.
- [RoomReactions](https://ably.com/docs/chat/api/javascript/room-reactions.md): API reference for the RoomReactions interface in the Ably Chat JavaScript SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
