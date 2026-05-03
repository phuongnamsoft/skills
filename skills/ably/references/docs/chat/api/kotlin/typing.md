# Typing

The `Typing` interface provides methods for sending and receiving typing indicators in a chat room. Access it via `room.typing`.

<Code>

#### Kotlin

```
val typing = room.typing
```
</Code>

## Properties

The `Typing` interface has the following properties:

<Table id='TypingProperties'>

| Property | Description | Type |
| --- | --- | --- |
| current | The current set of client IDs who are typing in the room. | `Set<String>` |

</Table>

## Start typing 

`suspend typing.keystroke(): Unit`

Sends a typing started event to notify other users that the current user is typing.

Events are throttled according to the [`heartbeatThrottle`](https://ably.com/docs/chat/api/kotlin/rooms.md#get) room option to prevent excessive network traffic. If called within the throttle interval, the operation becomes a no-op. Multiple rapid calls are serialized to maintain consistency.

The room must be [attached](https://ably.com/docs/chat/api/kotlin/room.md#attach) and the connection must be in the [`Connected`](https://ably.com/docs/chat/api/kotlin/connection.md) state.

<Code>

### Kotlin

```
// Call this when the user starts typing
room.typing.keystroke()
```
</Code>

### Returns 

`Unit`

This is a suspend function. It completes when the typing event has been sent, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

## Stop typing 

`suspend typing.stop(): Unit`

Sends a typing stopped event to notify other users that the current user has stopped typing.

If the user is not currently typing, this operation is a no-op. Multiple rapid calls are serialized to maintain consistency.

The room must be [attached](https://ably.com/docs/chat/api/kotlin/room.md#attach) and the connection must be in the [`Connected`](https://ably.com/docs/chat/api/kotlin/connection.md) state.

<Code>

### Kotlin

```
// Call this when the user stops typing or clears the input
room.typing.stop()
```
</Code>

### Returns 

`Unit`

This is a suspend function. It completes when the stop event has been sent, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

## Subscribe to typing events 

`typing.subscribe(listener: TypingListener): Subscription`

Subscribes to typing events from users in the chat room. Receives updates whenever a user starts or stops typing, providing real-time feedback about who is currently composing messages.

The room must be [attached](https://ably.com/docs/chat/api/kotlin/room.md#attach) to receive typing events.

<Code>

### Kotlin

```
val subscription = room.typing.subscribe { event ->
    println("Currently typing: ${event.currentlyTyping}")
}

// To stop receiving typing events
subscription.unsubscribe()
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
| type | The type of the event. | TypingSetEventType |
| currentlyTyping | Set of client IDs currently typing in the room. | `Set<String>` |
| change | Information about the specific change that triggered this event. | <Table id='TypingChange'/> |

</Table>

<Table id='TypingChange' >

| Property | Description | Type |
| --- | --- | --- |
| clientId | The client ID whose typing state changed. | String |
| type | Whether the user started or stopped typing. | <Table id='TypingEventType'/> |

</Table>

<Table id='TypingEventType' >

| Value | Description |
| --- | --- |
| Started | A user has started typing. |
| Stopped | A user has stopped typing. |

</Table>

### Returns 

[`Subscription`](https://ably.com/docs/chat/api/kotlin/rooms.md#Subscription)

Returns a `Subscription` object.

#### Unsubscribe from typing events 

`subscription.unsubscribe(): Unit`

Call `unsubscribe()` to stop receiving typing events.

## Collect typing events as a Flow 

`Typing.asFlow(): Flow<TypingSetEvent>`

Returns a Kotlin `Flow` that emits typing events. This is an extension function on the `Typing` interface that provides a reactive alternative to listener-based subscriptions.

<Code>

### Kotlin

```
import kotlinx.coroutines.launch

launch {
    room.typing.asFlow().collect { event ->
        println("Currently typing: ${event.currentlyTyping}")
    }
}
```
</Code>

### Returns 

`Flow<TypingSetEvent>`

Returns a `Flow` that emits `TypingSetEvent` events. The flow automatically manages the underlying subscription.

## Example

<Code>

### Kotlin

```
import com.ably.chat.asFlow
import kotlinx.coroutines.launch
import kotlin.time.Duration.Companion.seconds

val room = chatClient.rooms.get("my-room") {
    typing {
        heartbeatThrottle = 5.seconds // Throttle typing events to every 5 seconds
    }
}

room.attach()

// Subscribe to typing events with a listener
val subscription = room.typing.subscribe { event ->
    val typingUsers = event.currentlyTyping

    when {
        typingUsers.isEmpty() -> println("No one is typing")
        typingUsers.size == 1 -> println("${typingUsers.first()} is typing...")
        else -> println("${typingUsers.joinToString(", ")} are typing...")
    }
}

// Or use Flow for reactive collection
launch {
    room.typing.asFlow().collect { event ->
        println("Typing users: ${event.currentlyTyping}")
    }
}

// Notify that the current user is typing
room.typing.keystroke()

// Notify that the current user has stopped typing
room.typing.stop()

// Check who is currently typing
println("Currently typing: ${room.typing.current}")

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
- [RoomReactions](https://ably.com/docs/chat/api/kotlin/room-reactions.md): API reference for the RoomReactions interface in the Ably Chat Kotlin SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
