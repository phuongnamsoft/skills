# MessageReactions

The `MessageReactions` interface provides methods to send, delete, and subscribe to reactions on specific messages. Unlike room reactions, message reactions are persisted and associated with individual chat messages. Access it via `room.messages.reactions`.

<Code>

#### Kotlin

```
val reactions = room.messages.reactions
```
</Code>

Message reactions support three counting strategies:
- **Unique**: One reaction per client per message (like iMessage, WhatsApp)
- **Distinct**: One reaction of each type per client (like Slack)
- **Multiple**: Unlimited reactions including repeats (like Medium claps)

## Send a reaction to a message 

`suspend reactions.send(messageSerial: String, name: String, type: MessageReactionType? = null, count: Int? = null): Unit`

Sends a reaction to a specific chat message. The reaction is persisted and contributes to the message's reaction summary.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Kotlin

```
room.messages.reactions.send(
    messageSerial = "message-serial-123",
    name = "👍"
)
```
</Code>

An extension function overload is also available that accepts a `Message` object directly:

`suspend MessageReactions.send(message: Message, name: String, type: MessageReactionType? = null, count: Int = 1): Unit`

<Code>

### Kotlin

```
room.messages.reactions.send(
    message = message,
    name = "👍"
)
```
</Code>

### Parameters 

The `send()` method takes the following parameters:

<Table id='SendParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| messageSerial | Required | The serial of the message to react to. | String |
| name | Required | The reaction identifier, typically an emoji. | String |
| type | Optional | The counting strategy for this reaction. Defaults vary by room configuration. | <Table id='MessageReactionType'/> |
| count | Optional | Number of times to count this reaction. Only applies to `Multiple` type. | Int |

</Table>

<Table id='MessageReactionType' >

| Value | Description |
| --- | --- |
| Unique | One reaction per client per message. A second reaction replaces the first. Similar to iMessage, Facebook Messenger, or WhatsApp. |
| Distinct | One reaction of each type per client per message. Multiple different reactions allowed. Similar to Slack. |
| Multiple | Unlimited reactions including repeats. Includes a count for batch reactions. Similar to Medium claps. |

</Table>

### Returns 

`Unit`

This is a suspend function. It completes when the reaction has been sent, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

## Delete a reaction from a message 

`suspend reactions.delete(messageSerial: String, name: String? = null, type: MessageReactionType? = null): Unit`

Removes a previously sent reaction from a chat message.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Kotlin

```
room.messages.reactions.delete(
    messageSerial = "message-serial-123",
    name = "👍"
)
```
</Code>

An extension function overload is also available that accepts a `Message` object directly:

`suspend MessageReactions.delete(message: Message, name: String? = null, type: MessageReactionType? = null): Unit`

<Code>

### Kotlin

```
room.messages.reactions.delete(message = message)
```
</Code>

### Parameters 

The `delete()` method takes the following parameters:

<Table id='DeleteParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| messageSerial | Required | The serial of the message to remove the reaction from. | String |
| name | Optional | The reaction identifier to delete. Required except for `Unique` type. | String |
| type | Optional | The counting strategy of the reaction to delete. | <Table id='MessageReactionType'/> |

</Table>

### Returns 

`Unit`

This is a suspend function. It completes when the reaction has been deleted, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

## Subscribe to reaction summaries 

`reactions.subscribe(listener: MessageReactionListener): Subscription`

Subscribes to aggregated reaction count summaries for messages. Receives updates when the total reaction counts change on any message in the room.

The room must be [attached](https://ably.com/docs/chat/api/kotlin/room.md#attach) to receive reaction summary events.

<Code>

### Kotlin

```
val subscription = room.messages.reactions.subscribe { event ->
    println("Message: ${event.messageSerial}")
    println("Reactions: ${event.reactions}")
}

// To stop receiving reaction summaries
subscription.unsubscribe()
```
</Code>

### Parameters 

The `subscribe()` method takes the following parameters:

<Table id='SubscribeParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Required | Callback invoked when reaction summaries change. | <Table id='MessageReactionSummaryEvent'/> |

</Table>

<Table id='MessageReactionSummaryEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The event type. | MessageReactionSummaryEventType |
| messageSerial | The serial of the message. | String |
| reactions | The aggregated reaction counts. | <Table id='MessageReactionSummary'/> |

</Table>

<Table id='MessageReactionSummary' >

| Property | Description | Type |
| --- | --- | --- |
| unique | Reactions counted with the "unique" strategy (one per client per message). Maps reaction name to summary. | `Map<String,` <Table id='SummaryClientIdList'/>`>` |
| distinct | Reactions counted with the "distinct" strategy (one of each type per client). Maps reaction name to summary. | `Map<String,` <Table id='SummaryClientIdList'/>`>` |
| multiple | Reactions counted with the "multiple" strategy (unlimited per client). Maps reaction name to summary. | `Map<String,` <Table id='SummaryClientIdCounts'/>`>` |

</Table>

<Table id='SummaryClientIdList' >

| Property | Description | Type |
| --- | --- | --- |
| total | The total number of clients who have reacted with this name. | Int |
| clientIds | A list of the client IDs of all clients who have reacted with this name. | `List<String>` |
| clipped | Whether the client IDs list has been truncated. | Boolean |

</Table>

<Table id='SummaryClientIdCounts' >

| Property | Description | Type |
| --- | --- | --- |
| total | The total count of reactions with this name across all clients. | Int |
| clientIds | A map of client ID to the count each client has contributed. | `Map<String, Int>` |
| totalClientIds | The total number of distinct clients. | Int |
| totalUnidentified | The total count from unidentified clients not included in `clientIds`. | Int |
| clipped | Whether the client IDs map has been truncated. | Boolean |

</Table>

### Returns 

[`Subscription`](https://ably.com/docs/chat/api/kotlin/rooms.md#Subscription)

Returns a `Subscription` object.

#### Unsubscribe from reaction summaries 

`subscription.unsubscribe(): Unit`

Call `unsubscribe()` to stop receiving reaction summary events.

## Subscribe to individual reaction events 

`reactions.subscribeRaw(listener: MessageRawReactionListener): Subscription`

Subscribes to individual reaction events, receiving notifications each time a user adds or removes a reaction. This provides more granular updates than the summary subscription.

The room must be [attached](https://ably.com/docs/chat/api/kotlin/room.md#attach) to receive raw reaction events. Raw message reactions must also be enabled when [creating the room](https://ably.com/docs/chat/api/kotlin/rooms.md#get) by setting `rawMessageReactions = true` in the messages options.

<Aside data-type='note'>
Raw reactions are not suitable for the purpose of displaying message reaction counts as their effect on the reactions summary depends on the previous reactions.
</Aside>

<Code>

### Kotlin

```
val subscription = room.messages.reactions.subscribeRaw { event ->
    when (event.type) {
        MessageReactionEventType.Create ->
            println("${event.reaction.clientId} reacted with ${event.reaction.name}")
        MessageReactionEventType.Delete ->
            println("${event.reaction.clientId} removed ${event.reaction.name}")
    }
}

// To stop receiving raw events
subscription.unsubscribe()
```
</Code>

### Parameters 

The `subscribeRaw()` method takes the following parameters:

<Table id='SubscribeRawParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Required | Callback invoked for each individual reaction event. | <Table id='MessageReactionRawEvent'/> |

</Table>

<Table id='MessageReactionRawEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The event type. | <Table id='MessageReactionEventType'/> |
| timestamp | When the event occurred, in milliseconds since epoch. | Long |
| reaction | The reaction details. | <Table id='MessageReaction'/> |

</Table>

<Table id='MessageReactionEventType' >

| Value | Description |
| --- | --- |
| Create | A reaction was added. |
| Delete | A reaction was removed. |

</Table>

<Table id='MessageReaction' >

| Property | Description | Type |
| --- | --- | --- |
| messageSerial | The serial of the message. | String |
| type | The counting strategy. | <Table id='MessageReactionType'/> |
| name | The reaction identifier. | String |
| count | The count for Multiple type reactions. | Int? |
| clientId | The client ID who sent the reaction. | String |

</Table>

### Returns 

[`Subscription`](https://ably.com/docs/chat/api/kotlin/rooms.md#Subscription)

Returns a `Subscription` object.

#### Unsubscribe from raw reaction events 

`subscription.unsubscribe(): Unit`

Call `unsubscribe()` to stop receiving raw reaction events.

## Get reactions for a specific client 

`suspend reactions.clientReactions(messageSerial: String, clientId: String? = null): MessageReactionSummary`

Retrieves the reaction data for a specific client on a message. If no client ID is provided, returns reactions for the current user.

<Code>

### Kotlin

```
// Get current user's reactions on a message
val myReactions = room.messages.reactions.clientReactions("message-serial-123")

// Get another user's reactions
val theirReactions = room.messages.reactions.clientReactions("message-serial-123", "user-456")
```
</Code>

### Parameters 

The `clientReactions()` method takes the following parameters:

<Table id='ClientReactionsParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| messageSerial | Required | The serial of the message to get reactions for. | String |
| clientId | Optional | The client ID to get reactions for. Defaults to the current user. | String |

</Table>

### Returns 

`MessageReactionSummary`

This is a suspend function. It returns the reaction data for the specified client, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

## Collect reaction summaries as a Flow 

`MessageReactions.asFlow(): Flow<MessageReactionSummaryEvent>`

Returns a Kotlin `Flow` that emits reaction summary events. This is an extension function on the `MessageReactions` interface that provides a reactive alternative to listener-based subscriptions.

<Code>

### Kotlin

```
import kotlinx.coroutines.launch

launch {
    room.messages.reactions.asFlow().collect { event ->
        println("Message ${event.messageSerial} reactions updated")
    }
}
```
</Code>

### Returns 

`Flow<MessageReactionSummaryEvent>`

Returns a `Flow` that emits `MessageReactionSummaryEvent` events. The flow automatically manages the underlying subscription.

## Example

<Code>

### Kotlin

```
import com.ably.chat.MessageReactionType
import com.ably.chat.MessageReactionEventType
import com.ably.chat.asFlow
import kotlinx.coroutines.launch

val room = chatClient.rooms.get("my-room") {
    messages {
        rawMessageReactions = true
    }
}
room.attach()

// Subscribe to reaction summaries
val summarySub = room.messages.reactions.subscribe { event ->
    val reactions = event.reactions

    // Update UI with reaction counts
    for ((name, summary) in reactions.distinct) {
        println("$name: ${summary.total} reactions from ${summary.clientIds.size} clients")
    }
}

// Subscribe to individual reaction events for animations
val rawSub = room.messages.reactions.subscribeRaw { event ->
    if (event.type == MessageReactionEventType.Create) {
        println("${event.reaction.clientId} reacted with ${event.reaction.name}")
    }
}

// Or use Flow for reactive collection
launch {
    room.messages.reactions.asFlow().collect { event ->
        println("Reactions updated for ${event.messageSerial}")
    }
}

// Send a distinct reaction (Slack-style)
room.messages.reactions.send(
    messageSerial = "message-serial-123",
    name = "👍",
    type = MessageReactionType.Distinct
)

// Send multiple reactions (Medium-style claps)
room.messages.reactions.send(
    messageSerial = "message-serial-456",
    name = "👏",
    type = MessageReactionType.Multiple,
    count = 5
)

// Remove a reaction
room.messages.reactions.delete(
    messageSerial = "message-serial-123",
    name = "👍"
)

// Check what reactions I've sent on a message
val myReactions = room.messages.reactions.clientReactions("message-serial-123")
println("My reactions: $myReactions")

// Clean up
summarySub.unsubscribe()
rawSub.unsubscribe()
```
</Code>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/kotlin/chat-client.md): API reference for the ChatClient interface in the Ably Chat Kotlin SDK.
- [Connection](https://ably.com/docs/chat/api/kotlin/connection.md): API reference for the Connection interface in the Ably Chat Kotlin SDK.
- [Rooms](https://ably.com/docs/chat/api/kotlin/rooms.md): API reference for the Rooms interface in the Ably Chat Kotlin SDK.
- [Room](https://ably.com/docs/chat/api/kotlin/room.md): API reference for the Room interface in the Ably Chat Kotlin SDK.
- [Messages](https://ably.com/docs/chat/api/kotlin/messages.md): API reference for the Messages interface in the Ably Chat Kotlin SDK.
- [Message](https://ably.com/docs/chat/api/kotlin/message.md): API reference for the Message interface in the Ably Chat Kotlin SDK.
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
