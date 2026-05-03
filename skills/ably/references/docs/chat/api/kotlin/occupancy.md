# Occupancy

The `Occupancy` interface provides methods for tracking the number of users in a chat room. Access it via `room.occupancy`.

<Code>

#### Kotlin

```
val occupancy = room.occupancy
```
</Code>

## Properties

The `Occupancy` interface has the following properties:

<Table id='OccupancyProperties'>

| Property | Description | Type |
| --- | --- | --- |
| current | The latest occupancy data cached from realtime events. Requires `enableEvents` to be `true` in the [room's occupancy options](https://ably.com/docs/chat/api/kotlin/rooms.md#get). | <Table id='OccupancyData'/>? |

</Table>

<Table id='OccupancyData' >

| Property | Description | Type |
| --- | --- | --- |
| connections | The number of active connections to the room. | Int |
| presenceMembers | The number of users in the presence set. | Int |

</Table>

## Get current occupancy 

`suspend occupancy.get(): OccupancyData`

Fetches the current occupancy of the chat room from the server. Retrieves the latest occupancy metrics, including the number of active connections and presence members.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Kotlin

```
val data = room.occupancy.get()
println("Connections: ${data.connections}")
println("Presence members: ${data.presenceMembers}")
```
</Code>

### Returns 

`OccupancyData`

This is a suspend function. It returns the current occupancy data, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

## Subscribe to occupancy events 

`occupancy.subscribe(listener: OccupancyListener): Subscription`

Subscribes to occupancy updates for the chat room. Receives updates whenever the number of connections or present members in the room changes.

Requires `enableEvents` to be `true` in the [room's occupancy options](https://ably.com/docs/chat/api/kotlin/rooms.md#get). The room should be [attached](https://ably.com/docs/chat/api/kotlin/room.md#attach) to receive occupancy events.

<Code>

### Kotlin

```
val subscription = room.occupancy.subscribe { event ->
    println("Connections: ${event.occupancy.connections}")
    println("Presence members: ${event.occupancy.presenceMembers}")
}

// To stop receiving occupancy updates
subscription.unsubscribe()
```
</Code>

### Parameters 

The `subscribe()` method takes the following parameters:

<Table id='SubscribeParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Required | Callback invoked when room occupancy changes. | <Table id='OccupancyEvent'/> |

</Table>

<Table id='OccupancyEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The type of occupancy event. | OccupancyEventType |
| occupancy | The current occupancy data. | <Table id='OccupancyData'/> |

</Table>

### Returns 

[`Subscription`](https://ably.com/docs/chat/api/kotlin/rooms.md#Subscription)

Returns a `Subscription` object.

#### Unsubscribe from occupancy events 

`subscription.unsubscribe(): Unit`

Call `unsubscribe()` to stop receiving occupancy events.

## Collect occupancy events as a Flow 

`Occupancy.asFlow(): Flow<OccupancyEvent>`

Returns a Kotlin `Flow` that emits occupancy events. This is an extension function on the `Occupancy` interface that provides a reactive alternative to listener-based subscriptions.

<Code>

### Kotlin

```
import kotlinx.coroutines.launch

launch {
    room.occupancy.asFlow().collect { event ->
        println("Connections: ${event.occupancy.connections}")
    }
}
```
</Code>

### Returns 

`Flow<OccupancyEvent>`

Returns a `Flow` that emits `OccupancyEvent` events. The flow automatically manages the underlying subscription.

## Example

<Code>

### Kotlin

```
import com.ably.chat.asFlow
import kotlinx.coroutines.launch

val room = chatClient.rooms.get("my-room") {
    occupancy {
        enableEvents = true // Required for subscribe() and current property
    }
}

room.attach()

// Subscribe to occupancy changes with a listener
val subscription = room.occupancy.subscribe { event ->
    val connections = event.occupancy.connections
    val presenceMembers = event.occupancy.presenceMembers
    println("Room has $connections connections and $presenceMembers presence members")
}

// Or use Flow for reactive collection
launch {
    room.occupancy.asFlow().collect { event ->
        println("Occupancy updated: ${event.occupancy.connections} connections")
    }
}

// Fetch occupancy on-demand (works even without enableEvents)
val occupancy = room.occupancy.get()
println("Initial occupancy: ${occupancy.connections} connections")

// Access cached occupancy (requires enableEvents)
val cached = room.occupancy.current
cached?.let {
    println("Cached occupancy: ${it.connections}")
}

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
- [Typing](https://ably.com/docs/chat/api/kotlin/typing.md): API reference for the Typing interface in the Ably Chat Kotlin SDK.
- [RoomReactions](https://ably.com/docs/chat/api/kotlin/room-reactions.md): API reference for the RoomReactions interface in the Ably Chat Kotlin SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
