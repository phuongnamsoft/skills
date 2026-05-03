# Rooms

The `Rooms` interface manages the lifecycle of chat rooms.

Access it via the `rooms` property on a [`ChatClient`](https://ably.com/docs/chat/api/kotlin/chat-client.md) instance.

<Code>

#### Kotlin

```
val rooms = chatClient.rooms
```
</Code>

## Create or retrieve a room 

`suspend rooms.get(roomName: String, initOptions: MutableRoomOptions.() -> Unit): Room`

Create or retrieve a [`Room`](https://ably.com/docs/chat/api/kotlin/room.md) instance. Optionally provide custom configuration to the room using a DSL builder.

Call [`release()`](#release) when the `Room` is no longer needed. If a call to `get()` is made for a room that is currently being released, then it will only return when the release operation is complete.

If a call to `get()` is made, followed by a subsequent call to `release()` before it returns, then an error is thrown.

<Code>

### Kotlin

```
val room = chatClient.rooms.get("basketball-stream") {
    typing {
        heartbeatThrottle = 5.seconds
    }
    presence {
        enableEvents = false
    }
    occupancy {
        enableEvents = true
    }
    messages {
        rawMessageReactions = false
        defaultMessageReactionType = MessageReactionType.Unique
    }
}

// When finished with the room
chatClient.rooms.release("basketball-stream")
```
</Code>

### Parameters 

The `get()` method takes the following parameters:

<Table id='GetParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| name | Required | The unique identifier of the room. | String |
| options | Optional | Configuration for the room features. | <Table id='RoomOptions'/> |

</Table>

<Table id='RoomOptions' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| typing | Optional | Configuration for typing indicators. | <Table id='TypingOptions'/> |
| presence | Optional | Configuration for presence events. | <Table id='PresenceOptions'/> |
| occupancy | Optional | Configuration for occupancy events. | <Table id='OccupancyOptions'/> |
| messages | Optional | Configuration for messages. | <Table id='MessagesOptions'/> |
| reactions | Optional | Configuration for room reactions. | RoomReactionsOptions |

</Table>

<Table id='TypingOptions' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| heartbeatThrottle | Optional | Minimum time between consecutive typing started events. The first call emits immediately; later calls are no-ops until the interval has elapsed. Calling `typing.stop()` resets the interval. Default 10 seconds. | `Duration` |

</Table>

<Table id='PresenceOptions' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| enableEvents | Optional | Whether the client receives presence events from the server. Can be disabled if presence is used but this client does not need the messages. Default `true`. | Boolean |

</Table>

<Table id='OccupancyOptions' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| enableEvents | Optional | Whether to receive occupancy events. Enabling this increases message volume as the server sends additional updates for occupancy changes. Default `false`. | Boolean |

</Table>

<Table id='MessagesOptions' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| rawMessageReactions | Optional | Whether to receive raw individual message reactions from the realtime channel. Reaction summaries remain available regardless of this setting. Default `false`. | Boolean |
| defaultMessageReactionType | Optional | The default message reaction type for sending reactions. Individual types can still be specified via the send method parameter. The default is `Distinct`. | <Table id='MessageReactionType'/> |

</Table>

<Table id='MessageReactionType' >

| Value | Description |
| --- | --- |
| Distinct | Allows at most one reaction of each type per client per message. Duplicates are not counted in the summary. Similar to reactions on Slack. |
| Multiple | Allows any number of reactions, including repeats, counted in the summary. The reaction payload includes a count. Similar to the clap feature on Medium. |
| Unique | Allows at most one reaction per client per message. If a client reacts again, only the second reaction is counted. Similar to reactions on iMessage or WhatsApp. |

</Table>

### Returns 

[`Room`](https://ably.com/docs/chat/api/kotlin/room.md)

This is a suspend function. It returns the new or existing [`Room`](https://ably.com/docs/chat/api/kotlin/room.md) instance, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception). It also throws if the room already exists with different options, or if [`release()`](#release) is called before `get()` returns.

## Release a room 

`suspend rooms.release(name: String): Unit`

Releases a room, freeing its resources and detaching it from Ably.

After release, the room object is no longer usable. To use the room again, call [`get()`](#get) to create a new instance.

<Code>

### Kotlin

```
chatClient.rooms.release("my-room")
```
</Code>

### Parameters 

The `release()` method takes the following parameters:

<Table id='ReleaseParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| name | Required | The unique identifier of the room to release. | String |

</Table>

### Returns 

`Unit`

This is a suspend function. It completes when the room is fully released, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

## Subscription 

A `Subscription` is a functional interface returned by `subscribe()` and `onStatusChange()` methods throughout the SDK. It provides a single method to deregister the listener.

<Table id='SubscriptionProperties'>

| Method | Description | Return type |
| --- | --- | --- |
| unsubscribe() | Deregisters the listener. | Unit |

</Table>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/kotlin/chat-client.md): API reference for the ChatClient interface in the Ably Chat Kotlin SDK.
- [Connection](https://ably.com/docs/chat/api/kotlin/connection.md): API reference for the Connection interface in the Ably Chat Kotlin SDK.
- [Room](https://ably.com/docs/chat/api/kotlin/room.md): API reference for the Room interface in the Ably Chat Kotlin SDK.
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
