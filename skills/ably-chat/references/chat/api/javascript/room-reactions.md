# RoomReactions

The `RoomReactions` interface provides methods for sending and receiving ephemeral room-level reactions. These are commonly used for live interactions like floating emojis, applause, or other real-time feedback in chat rooms. Access it via `room.reactions`.

<Code>

#### Javascript

```
const reactions = room.reactions;
```
</Code>

Unlike message reactions, room reactions are not persisted and are only visible to users currently connected to the room.

## Send a room reaction 

`reactions.send(params: SendReactionParams): Promise<void>`

Sends a room-level reaction. Room reactions are ephemeral events that are not associated with specific messages.

The room should be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) to send room reactions. The connection must be in the [`connected`](https://ably.com/docs/chat/api/javascript/connection.md) state.

<Code>

### Javascript

```
await room.reactions.send({ name: '👍' });
```
</Code>

### Parameters 

The `send()` method takes the following parameters:

<Table id='SendParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| params | Required | The reaction parameters. | <Table id='SendReactionParams'/> |

</Table>

<Table id='SendReactionParams' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| name | Required | The name of the reaction, typically an emoji or identifier. | String |
| metadata | Optional | Additional metadata to include with the reaction. | JsonObject |
| headers | Optional | Additional information in Ably message extras, usable for features like referencing external resources. | Headers |

</Table>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the reaction has been sent, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Subscribe to room reactions 

`reactions.subscribe(listener: RoomReactionListener): Subscription`

Subscribes to room-level reaction events. Receives all room reactions sent by any user in the room. This is useful for displaying floating reactions, triggering animations, or showing live audience engagement.

The room should be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) to receive reaction events.

<Code>

### Javascript

```
const { unsubscribe } = room.reactions.subscribe((event) => {
  console.log(`${event.reaction.clientId} reacted with ${event.reaction.name}`);
});

// To stop receiving reactions
unsubscribe();
```
</Code>

### Parameters 

The `subscribe()` method takes the following parameters:

<Table id='SubscribeParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Required | Callback invoked when a room reaction is received. | <Table id='RoomReactionEvent'/> |

</Table>

<Table id='RoomReactionEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The type of the event. Always `Reaction`. | <Table id='RoomReactionEventType'/> |
| reaction | The reaction that was received. | <Table id='RoomReaction'/> |

</Table>

<Table id='RoomReactionEventType' >

| Value | Description |
| --- | --- |
| Reaction | A room-level reaction was received. The value is `reaction`. |

</Table>

<Table id='RoomReaction' >

| Property | Description | Type |
| --- | --- | --- |
| name | The name of the reaction (e.g., an emoji). | String |
| clientId | The client ID of the user who sent the reaction. | String |
| userClaim | The user claim attached to this reaction by the server. Only present if the user's [JWT](https://ably.com/docs/auth/token.md#jwt) contained a claim for the room. | String or Undefined |
| metadata | Additional metadata included with the reaction. Empty object if none provided. | <Table id='RoomReactionMetadata'/> |
| headers | Additional information from Ably message extras. Empty object if none provided. | <Table id='RoomReactionHeaders'/> |
| createdAt | When the reaction was sent. | Date |
| isSelf | Whether the reaction was sent by the current client. | Boolean |

</Table>

<Table id='RoomReactionMetadata' >

| Property | Description | Type |
| --- | --- | --- |
| | Key-value pairs that can be attached to a room reaction for features like animations or styling hints. Keys must be non-empty strings. Values can be any JSON-serializable type. Always present and defaults to an empty object if not provided. | JsonObject |

</Table>

<Table id='RoomReactionHeaders' >

| Property | Description | Type |
| --- | --- | --- |
| | Key-value pairs that can be attached to a room reaction, accessible to integrations such as webhooks, queues, or serverless functions. Keys must be non-empty strings. Always present and defaults to an empty object if not provided. | `Record<string, number \| string \| boolean \| null \| undefined>` |

</Table>


### Returns 

`Subscription`

Returns an object with the following methods:

#### Unsubscribe from room reactions 

`unsubscribe(): void`

Call `unsubscribe()` to stop receiving room reaction events.

## Example

<Code>

### Javascript

```
const room = await chatClient.rooms.get('my-room');
await room.attach();

// Subscribe to room reactions
const { unsubscribe } = room.reactions.subscribe((event) => {
  // Display a floating emoji animation
  showFloatingEmoji(event.reaction.name, event.reaction.clientId);

  console.log(`${event.reaction.clientId} sent ${event.reaction.name}`);

  // Check if it's your own reaction
  if (event.reaction.isSelf) {
    console.log('This was my reaction');
  }
});

// Send reactions when users click reaction buttons
document.querySelectorAll('.reaction-button').forEach(button => {
  button.addEventListener('click', async () => {
    const emoji = button.dataset.emoji;
    await room.reactions.send({ name: emoji });
  });
});

// Send a reaction with metadata
await room.reactions.send({
  name: '🎉',
  metadata: {
    animation: 'confetti',
    color: 'gold'
  }
});

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
- [Typing](https://ably.com/docs/chat/api/javascript/typing.md): API reference for the Typing interface in the Ably Chat JavaScript SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
