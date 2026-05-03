# Room

The `Room` interface represents an individual chat room instance. It provides access to all chat features such as messages, presence, reactions, typing indicators, and occupancy. Rooms are the primary way users interact with chat functionality.

## Obtaining a room instance

Use the [`rooms.get()`](https://ably.com/docs/chat/api/kotlin/rooms.md#get) method to obtain a room instance:

<Code>

### Kotlin

```
val room = chatClient.rooms.get("my-room")
```
</Code>

For more information, see the [rooms documentation](https://ably.com/docs/chat/rooms.md).

## Properties

The `Room` interface has the following properties:

<Table id='RoomProperties'>

| Property | Description | Type |
| --- | --- | --- |
| name | The unique identifier of the room. | String |
| messages | The Messages instance for sending and receiving messages. | [Messages](https://ably.com/docs/chat/api/kotlin/messages.md) |
| presence | The Presence instance for tracking online users. | [Presence](https://ably.com/docs/chat/api/kotlin/presence.md) |
| reactions | The RoomReactions instance for room-level reactions. | [RoomReactions](https://ably.com/docs/chat/api/kotlin/room-reactions.md) |
| typing | The Typing instance for typing indicators. | [Typing](https://ably.com/docs/chat/api/kotlin/typing.md) |
| occupancy | The Occupancy instance for tracking user counts. | [Occupancy](https://ably.com/docs/chat/api/kotlin/occupancy.md) |
| status | The current lifecycle status of the room. | <Table id='RoomStatus'/> |
| error | The error information if the room is in a failed state. | [ErrorInfo?](https://ably.com/docs/chat/api/kotlin/chat-client.md#errorinfo) |
| options | The resolved configuration options for this room. | [RoomOptions](https://ably.com/docs/chat/api/kotlin/rooms.md#get) |
| channel | The underlying Ably channel used for the room. Note: this property is experimental and may change in a future release. | RealtimeChannel |

</Table>

<Table id='RoomStatus' >

| Status | Description |
| --- | --- |
| Initialized | The room has been initialized, but no attach has been attempted yet. The value is `initialized`. |
| Attaching | An attach has been initiated by sending a request to Ably. This is a transient status and will be followed by a transition to `Attached`, `Suspended`, or `Failed`. The value is `attaching`. |
| Attached | The room is attached and actively receiving events. In this status, clients can publish and subscribe to messages, and enter the presence set. The value is `attached`. |
| Detaching | A detach has been initiated on the attached room by sending a request to Ably. This is a transient status and will be followed by a transition to `Detached` or `Failed`. The value is `detaching`. |
| Detached | The room has been detached by the client and is no longer receiving events. The value is `detached`. |
| Suspended | The room, having previously been attached, has lost continuity. This typically occurs when the client is disconnected from Ably for more than two minutes. The client will automatically attempt to reattach when connectivity is restored. The value is `suspended`. |
| Failed | An indefinite failure condition. This status is entered if an error is received from Ably, such as an attempt to attach without the necessary access rights. The value is `failed`. |
| Releasing | The room is being released and its resources are being cleaned up. Attempting to use a room in this state may result in undefined behavior. The value is `releasing`. |
| Released | The room has been released and is no longer usable. A new room instance must be obtained to continue using the room. The value is `released`. |

</Table>

## Attach to a room 

`suspend room.attach(): Unit`

Attach to the room to start receiving messages and events. Attaching is required before the client can publish or subscribe to room events.

<Code>

### Kotlin

```
room.attach()
```
</Code>

### Returns 

`Unit`

This is a suspend function. It completes when the room is attached, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

For more information, see [attach to a room](https://ably.com/docs/chat/rooms.md#attach).

## Detach from a room 

`suspend room.detach(): Unit`

Detach from the room to stop receiving messages and events. Existing subscriptions are preserved but will not receive events until the room is re-attached.

<Code>

### Kotlin

```
room.detach()
```
</Code>

### Returns 

`Unit`

This is a suspend function. It completes when the room is detached, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

For more information, see [detach from a room](https://ably.com/docs/chat/rooms.md#detach).

## Subscribe to room status changes 

`room.onStatusChange(listener: RoomStatusListener): Subscription`

Register a listener to receive room status change events. The listener is called whenever the room transitions between lifecycle states.

<Code>

### Kotlin

```
val subscription = room.onStatusChange { change ->
    println("Room status changed to: ${change.current}")
    change.error?.let { error ->
        println("Error: $error")
    }
}

// To remove the listener
subscription.unsubscribe()
```
</Code>

### Parameters 

The `onStatusChange()` method takes the following parameters:

<Table id='OnStatusChangeParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Required | A function that receives status change events. | <Table id='RoomStatusChange'/> |

</Table>

<Table id='RoomStatusChange' >

| Property | Description | Type |
| --- | --- | --- |
| current | The new status of the room. | <Table id='RoomStatus'/> |
| previous | The previous status of the room. | <Table id='RoomStatus'/> |
| error | An error that provides a reason why the room has entered the new status, if applicable. | [ErrorInfo?](https://ably.com/docs/chat/api/kotlin/chat-client.md#errorinfo) |

</Table>

### Returns 

[`Subscription`](https://ably.com/docs/chat/api/kotlin/rooms.md#Subscription)

Returns a `Subscription` object.

#### Deregister the listener 

`subscription.unsubscribe(): Unit`

Call `unsubscribe()` to deregister the room status listener.

## Subscribe to discontinuity events 

`room.onDiscontinuity(listener: DiscontinuityListener): Subscription`

Register a listener to detect connection interruptions and potentially missed events. This is useful for understanding when the client may have missed messages due to connectivity issues.

<Code>

### Kotlin

```
val subscription = room.onDiscontinuity { reason ->
    println("Discontinuity detected: $reason")
    // You may want to re-fetch recent messages here
}

// To remove the listener
subscription.unsubscribe()
```
</Code>

### Parameters 

The `onDiscontinuity()` method takes the following parameters:

<Table id='OnDiscontinuityParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Required | A function that receives discontinuity events. | <Table id='DiscontinuityListener'/> |

</Table>

<Table id='DiscontinuityListener' >

| Parameter | Description | Type |
| --- | --- | --- |
| error | An error providing context about why the discontinuity occurred. | [ErrorInfo](https://ably.com/docs/chat/api/kotlin/chat-client.md#errorinfo) |

</Table>

### Returns 

[`Subscription`](https://ably.com/docs/chat/api/kotlin/rooms.md#Subscription)

Returns a `Subscription` object.

#### Deregister the listener 

`subscription.unsubscribe(): Unit`

Call `unsubscribe()` to deregister the discontinuity listener.

## Collect room status changes as a Flow 

`Room.statusAsFlow(): Flow<RoomStatusChange>`

Returns a Kotlin `Flow` that emits room status changes. This is an extension function on the `Room` interface that provides a reactive alternative to listener-based subscriptions.

<Code>

### Kotlin

```
import kotlinx.coroutines.launch

launch {
    room.statusAsFlow().collect { change ->
        println("Room status: ${change.current}")
    }
}
```
</Code>

### Returns 

`Flow<RoomStatusChange>`

Returns a `Flow` that emits `RoomStatusChange` events. The flow automatically manages the underlying subscription.

## Collect discontinuity events as a Flow 

`Room.discontinuityAsFlow(): Flow<ErrorInfo>`

Returns a Kotlin `Flow` that emits discontinuity events. This is an extension function on the `Discontinuity` interface (which `Room` extends) that provides a reactive alternative to listener-based subscriptions.

<Code>

### Kotlin

```
import kotlinx.coroutines.launch

launch {
    room.discontinuityAsFlow().collect { error ->
        println("Discontinuity detected: $error")
    }
}
```
</Code>

### Returns 

`Flow<ErrorInfo>`

Returns a `Flow` that emits `ErrorInfo` events when discontinuities occur. The flow automatically manages the underlying subscription.

## Example

<Code>

### Kotlin

```
import com.ably.chat.RoomStatus
import com.ably.chat.statusAsFlow
import com.ably.chat.discontinuityAsFlow
import kotlinx.coroutines.launch

val room = chatClient.rooms.get("my-room")

// Attach to start receiving events
room.attach()

// Monitor room status with a listener
val statusSub = room.onStatusChange { change ->
    println("Room status: ${change.current}")
}

// Monitor for discontinuities
val discSub = room.onDiscontinuity { reason ->
    println("Discontinuity detected, consider re-fetching messages")
}

// Or use Flow for reactive collection
launch {
    room.statusAsFlow().collect { change ->
        when (change.current) {
            RoomStatus.Attached -> println("Room attached")
            RoomStatus.Suspended -> println("Room suspended")
            RoomStatus.Failed -> println("Room failed: ${change.error}")
            else -> {}
        }
    }
}

launch {
    room.discontinuityAsFlow().collect { error ->
        println("Discontinuity: $error")
    }
}

// Access room features
val messages = room.messages
val presence = room.presence
val typing = room.typing

// Get the room name
println("Room name: ${room.name}")

// When done, detach and clean up
room.detach()
statusSub.unsubscribe()
discSub.unsubscribe()
```
</Code>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/kotlin/chat-client.md): API reference for the ChatClient interface in the Ably Chat Kotlin SDK.
- [Connection](https://ably.com/docs/chat/api/kotlin/connection.md): API reference for the Connection interface in the Ably Chat Kotlin SDK.
- [Rooms](https://ably.com/docs/chat/api/kotlin/rooms.md): API reference for the Rooms interface in the Ably Chat Kotlin SDK.
- [Messages](https://ably.com/docs/chat/api/kotlin/messages.md): API reference for the Messages interface in the Ably Chat Kotlin SDK.
- [Message](https://ably.com/docs/chat/api/kotlin/message.md): API reference for the Message interface in the Ably Chat Kotlin SDK.
- [MessageReactions](https://ably.com/docs/chat/api/kotlin/message-reactions.md): API reference for the MessageReactions interface in the Ably Chat Kotlin SDK.
- [Presence](https://ably.com/docs/chat/api/kotlin/presence.md): API reference for the Presence interface in the Ably Chat Kotlin SDK.
- [Occupancy](https://ably.com/docs/chat/api/kotlin/occupancy.md): API reference for the Occupancy interface in the Ably Chat Kotlin SDK.
- [Typing](https://ably.com/docs/chat/api/kotlin/typing.md): API reference for the Typing interface in the Ably Chat Kotlin SDK.
- [RoomReactions](https://ably.com/docs/chat/api/kotlin/room-reactions.md): API reference for the RoomReactions interface in the Ably Chat Kotlin SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
