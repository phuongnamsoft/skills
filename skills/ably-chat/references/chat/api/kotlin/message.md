# Message

The `Message` interface represents a single message in a chat room. Messages are received through the [`messages.subscribe()`](https://ably.com/docs/chat/api/kotlin/messages.md#subscribe) method or retrieved via [`messages.history()`](https://ably.com/docs/chat/api/kotlin/messages.md#history).

## Properties

The `Message` interface has the following properties:

<Table id='MessageProperties'>

| Property | Description | Type |
| --- | --- | --- |
| serial | The unique identifier of the message. | String |
| clientId | The client ID of the user who created the message. | String |
| text | The text content of the message. | String |
| timestamp | The timestamp at which the message was created, in milliseconds since epoch. | Long |
| metadata | Extra information attached to the message for features like animations or linking to external resources. Always set; empty object if no metadata was provided. | <Table id='MessageMetadata'/> |
| headers | Additional information in Ably realtime message extras, usable for features like livestream timestamping or message flagging. Always set; empty map if none provided. | `Map<String, String>` |
| action | The action type indicating if the message was created, updated, or deleted. | <Table id='MessageAction'/> |
| version | Information about the current version of this message. | <Table id='MessageVersion'/> |
| reactions | The reactions summary for this message. | <Table id='MessageReactionSummary'/> |

</Table>

<Table id='MessageMetadata' >

| Property | Description | Type |
| --- | --- | --- |
| | Key-value pairs that can be attached to a message for features like animations, styling hints, or links to external resources. Keys must be non-empty strings. Values can be any JSON-serializable type. Always present on a message, defaults to an empty object if not provided. | `JsonObject` |

</Table>

<Table id='MessageAction' >

| Value | Description |
| --- | --- |
| MessageCreate | The message was newly created. The value is `message.create`. |
| MessageUpdate | The message was updated. The value is `message.update`. |
| MessageDelete | The message was deleted. The value is `message.delete`. |

</Table>

<Table id='MessageVersion' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| serial | Required | The unique identifier for this version. | String |
| timestamp | Required | When this version was created, in milliseconds since epoch. | Long |
| clientId | Optional | The client ID of the user who performed an update or deletion. | String? |
| description | Optional | A description of why this version was created. | String? |
| metadata | Optional | Additional metadata about the operation. | `Map<String, String>?` |

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

## Apply an event to a message 

`Message.with(event: ChatMessageEvent): Message`

Creates a new message instance with a chat message event applied. This is useful for updating a local message state when receiving update or delete events. Returns the same instance if the event would be a no-op (for example, applying an older version).

This is an extension function on the `Message` interface.

<Code>

### Kotlin

```
val updatedMessage = message.with(updateEvent)
```
</Code>

An overload is also available for reaction summary events:

`Message.with(event: MessageReactionSummaryEvent): Message`

<Code>

### Kotlin

```
val updatedMessage = message.with(reactionSummaryEvent)
```
</Code>

### Parameters 

The `with()` method takes the following parameters:

<Table id='WithParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| event | Required | The event to apply to the message. | <Table id='ChatMessageEvent'/> or <Table id='MessageReactionSummaryEvent'/> |

</Table>

<Table id='ChatMessageEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The type of the message event. | <Table id='ChatMessageEventType'/> |
| message | The message that was received. | [Message](https://ably.com/docs/chat/api/kotlin/message.md) |

</Table>

<Table id='ChatMessageEventType' >

| Value | Description |
| --- | --- |
| Created | A new chat message was received. |
| Updated | A chat message was updated. |
| Deleted | A chat message was deleted. |

</Table>

<Table id='MessageReactionSummaryEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The event type. | MessageReactionSummaryEventType |
| messageSerial | The serial of the message. | String |
| reactions | The aggregated reaction counts. | <Table id='MessageReactionSummary'/> |

</Table>

### Returns 

[`Message`](https://ably.com/docs/chat/api/kotlin/message.md)

Returns a new message instance with the event applied, or the same instance if the event would be a no-op.

## Copy a message 

`Message.copy(text: String = this.text, headers: Map<String, String> = this.headers, metadata: JsonObject = this.metadata): Message`

Creates a copy of the message with specified fields replaced. This is an extension function on the `Message` interface.

<Code>

### Kotlin

```
val messageCopy = message.copy(text = "New text")
```
</Code>

### Parameters 

The `copy()` method takes the following parameters:

<Table id='CopyParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| text | Optional | The new text content. Defaults to the current text. | String |
| headers | Optional | The new headers. Defaults to the current headers. | `Map<String, String>` |
| metadata | Optional | The new metadata. Defaults to the current metadata. | `JsonObject` |

</Table>

### Returns 

[`Message`](https://ably.com/docs/chat/api/kotlin/message.md)

Returns a new message instance with the specified fields replaced.

## Example

<Code>

### Kotlin

```
import com.ably.chat.MessageAction

// Subscribe to messages and handle different actions
room.messages.subscribe { event ->
    val message = event.message

    println("Serial: ${message.serial}")
    println("From: ${message.clientId}")
    println("Text: ${message.text}")
    println("Sent at: ${message.timestamp}")
    println("Action: ${message.action}")

    // Check message version for updates or deletions
    if (message.action == MessageAction.MessageUpdate) {
        println("Updated by: ${message.version.clientId}")
        println("Update reason: ${message.version.description}")
    }

    if (message.action == MessageAction.MessageDelete) {
        println("Deleted by: ${message.version.clientId}")
        println("Delete reason: ${message.version.description}")
    }

    // Check reaction summary
    for ((name, summary) in message.reactions.distinct) {
        println("$name: ${summary.total} reactions from ${summary.clientIds.size} clients")
    }
}
```
</Code>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/kotlin/chat-client.md): API reference for the ChatClient interface in the Ably Chat Kotlin SDK.
- [Connection](https://ably.com/docs/chat/api/kotlin/connection.md): API reference for the Connection interface in the Ably Chat Kotlin SDK.
- [Rooms](https://ably.com/docs/chat/api/kotlin/rooms.md): API reference for the Rooms interface in the Ably Chat Kotlin SDK.
- [Room](https://ably.com/docs/chat/api/kotlin/room.md): API reference for the Room interface in the Ably Chat Kotlin SDK.
- [Messages](https://ably.com/docs/chat/api/kotlin/messages.md): API reference for the Messages interface in the Ably Chat Kotlin SDK.
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
