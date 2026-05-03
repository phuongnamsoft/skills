# RoomReactions

The `RoomReactions` interface provides methods for sending and receiving ephemeral room-level reactions. These are commonly used for live interactions like floating emojis, applause, or other real-time feedback in chat rooms. Access it via `room.reactions`.

<Code>

#### Kotlin

```
val reactions = room.reactions
```
</Code>

Unlike message reactions, room reactions are not persisted and are only visible to users currently connected to the room.

## Send a room reaction 

`suspend reactions.send(name: String, metadata: JsonObject? = null, headers: Map<String, String>? = null): Unit`

Sends a room-level reaction. Room reactions are ephemeral events that are not associated with specific messages.

The room should be [attached](https://ably.com/docs/chat/api/kotlin/room.md#attach) to send room reactions. The connection must be in the [`Connected`](https://ably.com/docs/chat/api/kotlin/connection.md) state.

<Code>

### Kotlin

```
room.reactions.send(name = "👍")
```
</Code>

### Parameters 

The `send()` method takes the following parameters:

<Table id='SendParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| name | Required | The name of the reaction, typically an emoji or identifier. | String |
| metadata | Optional | Additional metadata to include with the reaction. | `JsonObject?` |
| headers | Optional | Additional information in Ably message extras, usable for features like referencing external resources. | `Map<String, String>?` |

</Table>

### Returns 

`Unit`

This is a suspend function. It completes when the reaction has been sent, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

## Subscribe to room reactions 

`reactions.subscribe(listener: RoomReactionListener): Subscription`

Subscribes to room-level reaction events. Receives all room reactions sent by any user in the room. This is useful for displaying floating reactions, triggering animations, or showing live audience engagement.

The room should be [attached](https://ably.com/docs/chat/api/kotlin/room.md#attach) to receive reaction events.

<Code>

### Kotlin

```
val subscription = room.reactions.subscribe { event ->
    println("${event.reaction.clientId} reacted with ${event.reaction.name}")
}

// To stop receiving reactions
subscription.unsubscribe()
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
| type | The type of the event. | RoomReactionEventType |
| reaction | The reaction that was received. | <Table id='RoomReaction'/> |

</Table>

<Table id='RoomReaction' >

| Property | Description | Type |
| --- | --- | --- |
| name | The name of the reaction (for example, an emoji). | String |
| clientId | The client ID of the user who sent the reaction. | String |
| metadata | Additional metadata included with the reaction. Empty object if none provided. | `JsonObject` |
| headers | Additional information from Ably message extras. Empty map if none provided. | `Map<String, String>` |
| createdAt | When the reaction was sent, in milliseconds since epoch. | Long |
| isSelf | Whether the reaction was sent by the current client. | Boolean |

</Table>

### Returns 

[`Subscription`](https://ably.com/docs/chat/api/kotlin/rooms.md#Subscription)

Returns a `Subscription` object.

#### Unsubscribe from room reactions 

`subscription.unsubscribe(): Unit`

Call `unsubscribe()` to stop receiving room reaction events.

## Collect room reactions as a Flow 

`RoomReactions.asFlow(): Flow<RoomReactionEvent>`

Returns a Kotlin `Flow` that emits room reaction events. This is an extension function on the `RoomReactions` interface that provides a reactive alternative to listener-based subscriptions.

<Code>

### Kotlin

```
import kotlinx.coroutines.launch

launch {
    room.reactions.asFlow().collect { event ->
        println("${event.reaction.clientId} reacted with ${event.reaction.name}")
    }
}
```
</Code>

### Returns 

`Flow<RoomReactionEvent>`

Returns a `Flow` that emits `RoomReactionEvent` events. The flow automatically manages the underlying subscription.

## Example

<Code>

### Kotlin

```
import com.ably.chat.asFlow
import com.ably.chat.json.jsonObject
import kotlinx.coroutines.launch

val room = chatClient.rooms.get("my-room")
room.attach()

// Subscribe to room reactions with a listener
val subscription = room.reactions.subscribe { event ->
    println("${event.reaction.clientId} sent ${event.reaction.name}")

    // Check if it's your own reaction
    if (event.reaction.isSelf) {
        println("This was my reaction")
    }
}

// Or use Flow for reactive collection
launch {
    room.reactions.asFlow().collect { event ->
        println("Reaction: ${event.reaction.name}")
    }
}

// Send a simple reaction
room.reactions.send(name = "🎉")

// Send a reaction with metadata
room.reactions.send(
    name = "🎉",
    metadata = jsonObject {
        put("animation", "confetti")
        put("color", "gold")
    }
)

// Clean up
subscription.unsubscribe()
```
</Code>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/kotlin/chat-client.md): API reference for the ChatClient interface in the Ably Chat Kotlin SDK.
- [Connection](https://ably.com/docs/chat/api/kotlin/connection.md): API reference for the Connection interface in the Ably Chat Kotlin SDK.
- [Rooms](https://ably.com/docs/chat/api/kotlin/rooms.md): API reference for the Rooms interface in the Ably Chat Kotlin SDK.
- [Room](https://ably.com/docs/chat/api/kotlin/room.md): API reference for the Room interface in the Ably Chat Kotlin SDK.
- [Messages](https://ably.com/docs/chat/api/kotlin/messages.md): API reference for the Messages interface in the Ably Chat Kotlin SDK.
- [Message](https://ably.com/docs/chat/api/kotlin/message.md): API reference for the Message interface in the Ably Chat Kotlin SDK.
- [MessageReactions](https://ably.com/docs/chat/api/kotlin/message-reactions.md): API reference for the MessageReactions interface in the Ably Chat Kotlin SDK.
- [Presence](https://ably.com/docs/chat/api/kotlin/presence.md): API reference for the Presence interface in the Ably Chat Kotlin SDK.
- [Occupancy](https://ably.com/docs/chat/api/kotlin/occupancy.md): API reference for the Occupancy interface in the Ably Chat Kotlin SDK.
- [Typing](https://ably.com/docs/chat/api/kotlin/typing.md): API reference for the Typing interface in the Ably Chat Kotlin SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
