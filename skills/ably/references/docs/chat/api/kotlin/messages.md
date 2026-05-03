# Messages

The `Messages` interface provides methods for sending, receiving, and managing chat messages in a room. Access it via `room.messages`.

<Code>

#### Kotlin

```
val messages = room.messages
```
</Code>

## Properties

The `Messages` interface has the following properties:

<Table id='MessagesProperties'>

| Property | Description | Type |
| --- | --- | --- |
| reactions | Access to message reactions functionality for adding, removing, and subscribing to reactions on specific messages. | [MessageReactions](https://ably.com/docs/chat/api/kotlin/message-reactions.md) |

</Table>

## Subscribe to messages 

`messages.subscribe(listener: MessageListener): MessagesSubscription`

Subscribe to chat message events in the room. This method allows you to listen for new messages and provides access to historical messages that occurred before the subscription was established.

The room must be [attached](https://ably.com/docs/chat/api/kotlin/room.md#attach) for the listener to receive new message events.

<Code>

### Kotlin

```
val (unsubscribe, subscription) = room.messages.subscribe { event ->
    println("Received message: ${event.message.text}")
}

// Get messages sent before subscribing
val history = subscription.historyBeforeSubscribe()

// To stop receiving messages
unsubscribe()
```
</Code>

### Parameters 

The `subscribe()` method takes the following parameters:

<Table id='SubscribeParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Required | A callback function invoked when chat message events occur. | <Table id='MessageListener'/> |

</Table>

<Table id='MessageListener' >

| Parameter | Description | Type |
| --- | --- | --- |
| event | The message event that was received. | <Table id='ChatMessageEvent'/> |

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

### Returns 

`MessagesSubscription`

Returns a `MessagesSubscription` that extends [`Subscription`](https://ably.com/docs/chat/api/kotlin/rooms.md#Subscription). It supports destructuring into `(unsubscribe, subscription)`.

#### Unsubscribe from messages 

`subscription.unsubscribe(): Unit`

Call `unsubscribe()` to stop listening for message events.

#### Get messages from before the subscription started 

`suspend subscription.historyBeforeSubscribe(start: Long? = null, end: Long? = null, limit: Int = 100): PaginatedResult<Message>`

Get messages sent to the room from before the subscription was established.

##### Parameters 

The `historyBeforeSubscribe()` method takes the following parameters:

<Table id='HistoryBeforeSubscribeParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| start | Optional | Start of the time window to query, as a Unix timestamp in milliseconds. | Long |
| end | Optional | End of the time window to query, as a Unix timestamp in milliseconds. | Long |
| limit | Optional | Maximum number of messages to retrieve. Default: `100`. | Int |

</Table>

##### Returns 

[`PaginatedResult<Message>`](#PaginatedResult)

This is a suspend function. It returns a [`PaginatedResult`](#PaginatedResult) containing a list of [Message](https://ably.com/docs/chat/api/kotlin/message.md) objects, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

## Send a message 

`suspend messages.send(text: String, metadata: JsonObject? = null, headers: Map<String, String>? = null): Message`

Send a message to the chat room. The message will be delivered to all subscribers in real-time.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Kotlin

```
val message = room.messages.send(text = "Hello, world!")

println("Message sent with serial: ${message.serial}")
```
</Code>

### Parameters 

The `send()` method takes the following parameters:

<Table id='SendParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| text | Required | The text content of the message. | String |
| metadata | Optional | Extra information attached to the message for features like animations or linking to external resources. | `JsonObject` |
| headers | Optional | Additional information in Ably message extras, usable for features like livestream timestamping or message flagging. | `Map<String, String>` |

</Table>

### Returns 

[`Message`](https://ably.com/docs/chat/api/kotlin/message.md)

This is a suspend function. It returns the sent [Message](https://ably.com/docs/chat/api/kotlin/message.md) object, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

## Get message history 

`suspend messages.history(start: Long? = null, end: Long? = null, limit: Int = 100, orderBy: OrderBy = OrderBy.NewestFirst): PaginatedResult<Message>`

Get messages that have been previously sent to the chat room. This method retrieves historical messages based on the provided query options, allowing you to paginate through message history, filter by time ranges, and control the order of results.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Kotlin

```
val history = room.messages.history(
    limit = 50,
    orderBy = OrderBy.NewestFirst
)

println("Messages: ${history.items}")

// Get next page if available
if (history.hasNext()) {
    val nextPage = history.next()
}
```
</Code>

### Parameters 

The `history()` method takes the following parameters:

<Table id='HistoryParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| start | Optional | Start of the time window to query, as a Unix timestamp in milliseconds. | Long |
| end | Optional | End of the time window to query, as a Unix timestamp in milliseconds. | Long |
| limit | Optional | Maximum number of messages to retrieve. Default: `100`. | Int |
| orderBy | Optional | Order in which to return results. Default: `NewestFirst`. | <Table id='OrderBy'/> |

</Table>

<Table id='OrderBy' >

| Value | Description |
| --- | --- |
| OldestFirst | Return results starting with the oldest messages. |
| NewestFirst | Return results starting with the newest messages. |

</Table>

### Returns 

[`PaginatedResult<Message>`](#PaginatedResult)

This is a suspend function. It returns a [`PaginatedResult`](#PaginatedResult) containing a list of [Message](https://ably.com/docs/chat/api/kotlin/message.md) objects, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

## Get a specific message 

`suspend messages.get(serial: String): Message`

Get a specific message by its unique serial identifier.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Kotlin

```
val message = room.messages.get("01234567890@abcdefghij")
println("Message text: ${message.text}")
```
</Code>

### Parameters 

The `get()` method takes the following parameters:

<Table id='GetParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| serial | Required | The unique serial identifier of the message to retrieve. | String |

</Table>

### Returns 

[`Message`](https://ably.com/docs/chat/api/kotlin/message.md)

This is a suspend function. It returns the [Message](https://ably.com/docs/chat/api/kotlin/message.md) object matching the given serial, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

## Update a message 

`suspend messages.update(serial: String, text: String, metadata: JsonObject? = null, headers: Map<String, String>? = null, operationDescription: String? = null, operationMetadata: Map<String, String>? = null): Message`

Update a message in the chat room. This method modifies an existing message's content, metadata, or headers. The update creates a new version of the message while preserving the original serial identifier. Subscribers will receive an update event in real-time.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Kotlin

```
val updatedMessage = room.messages.update(
    serial = message.serial,
    text = "Updated message text",
    operationDescription = "Fixed typo"
)

println("Message updated: ${updatedMessage.version}")
```
</Code>

An extension function overload is also available that accepts a `Message` object directly:

`suspend Messages.update(updatedMessage: Message, operationDescription: String? = null, operationMetadata: Map<String, String>? = null): Message`

<Code>

### Kotlin

```
val updatedMessage = room.messages.update(
    updatedMessage = message.copy(text = "Updated text"),
    operationDescription = "Fixed typo"
)
```
</Code>

### Parameters 

The `update()` method takes the following parameters:

<Table id='UpdateParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| serial | Required | The unique identifier of the message to update. | String |
| text | Required | The new text content of the message. | String |
| metadata | Optional | New metadata for the message. | `JsonObject` |
| headers | Optional | New headers for the message. | `Map<String, String>` |
| operationDescription | Optional | A human-readable description of why the update was performed. | String |
| operationMetadata | Optional | Additional metadata about the operation. Do not use for authoritative information. | `Map<String, String>` |

</Table>

### Returns 

[`Message`](https://ably.com/docs/chat/api/kotlin/message.md)

This is a suspend function. It returns the updated [Message](https://ably.com/docs/chat/api/kotlin/message.md) object, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure. The returned message will have its `action` property set to `MessageUpdate`.

## Delete a message 

`suspend messages.delete(serial: String, operationDescription: String? = null, operationMetadata: Map<String, String>? = null): Message`

Delete a message in the chat room. This method performs a "soft delete" on a message, marking it as deleted rather than permanently removing it. The deleted message will still be visible in message history but will be flagged as deleted. Subscribers will receive a deletion event in real-time.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Kotlin

```
val deletedMessage = room.messages.delete(
    serial = message.serial,
    operationDescription = "Removed inappropriate content"
)

println("Message deleted: ${deletedMessage.action}")
```
</Code>

An extension function overload is also available that accepts a `Message` object directly:

`suspend Messages.delete(message: Message, operationDescription: String? = null, operationMetadata: Map<String, String>? = null): Message`

<Code>

### Kotlin

```
val deletedMessage = room.messages.delete(
    message = message,
    operationDescription = "Removed inappropriate content"
)
```
</Code>

### Parameters 

The `delete()` method takes the following parameters:

<Table id='DeleteParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| serial | Required | The unique identifier of the message to delete. | String |
| operationDescription | Optional | A human-readable description of why the message was deleted. | String |
| operationMetadata | Optional | Additional metadata about the operation. Do not use for authoritative information. | `Map<String, String>` |

</Table>

### Returns 

[`Message`](https://ably.com/docs/chat/api/kotlin/message.md)

This is a suspend function. It returns the deleted [Message](https://ably.com/docs/chat/api/kotlin/message.md) object, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure. The returned message will have its `action` property set to `MessageDelete`.

## Collect messages as a Flow 

`Messages.asFlow(): Flow<ChatMessageEvent>`

Returns a Kotlin `Flow` that emits chat message events. This is an extension function on the `Messages` interface that provides a reactive alternative to listener-based subscriptions.

<Code>

### Kotlin

```
import kotlinx.coroutines.launch

launch {
    room.messages.asFlow().collect { event ->
        println("${event.message.clientId}: ${event.message.text}")
    }
}
```
</Code>

### Returns 

`Flow<ChatMessageEvent>`

Returns a `Flow` that emits `ChatMessageEvent` events. The flow automatically manages the underlying subscription.

## PaginatedResult 

A `PaginatedResult` represents a page of results from a paginated query such as [history()](#history) or [historyBeforeSubscribe()](#historyBeforeSubscribe).

### Properties

<Table id='PaginatedResultProperties'>

| Property | Description | Type |
| --- | --- | --- |
| items | The current page of results. | [`List<Message>`](https://ably.com/docs/chat/api/kotlin/message.md) |

</Table>

### Check for more pages 

`hasNext(): Boolean`

Returns `true` if there are more pages available by calling `next()`.

### Get next page 

`suspend next(): PaginatedResult<Message>`

This is a suspend function. It returns the next page of results, or throws a [`ChatException`](https://ably.com/docs/chat/api/kotlin/chat-client.md#chatexception) on failure.

## Example

<Code>

### Kotlin

```
import com.ably.chat.ChatMessageEventType
import com.ably.chat.OrderBy
import com.ably.chat.asFlow
import kotlinx.coroutines.launch

val room = chatClient.rooms.get("my-room")
room.attach()

// Subscribe to messages
val (unsubscribe, subscription) = room.messages.subscribe { event ->
    val msg = event.message

    when (event.type) {
        ChatMessageEventType.Created ->
            println("${msg.clientId}: ${msg.text}")
        ChatMessageEventType.Updated ->
            println("Message updated: ${msg.text}")
        ChatMessageEventType.Deleted ->
            println("Message deleted: ${msg.serial}")
    }
}

// Or use Flow for reactive collection
launch {
    room.messages.asFlow().collect { event ->
        println("Message event: ${event.type}")
    }
}

// Get recent history
val history = room.messages.history(limit = 10)
history.items.forEach { msg ->
    println("[History] ${msg.clientId}: ${msg.text}")
}

// Send a message
val sent = room.messages.send(text = "Hello everyone!")

// Update the message
room.messages.update(
    serial = sent.serial,
    text = "Hello everyone! (edited)"
)

// Clean up
unsubscribe()
```
</Code>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/kotlin/chat-client.md): API reference for the ChatClient interface in the Ably Chat Kotlin SDK.
- [Connection](https://ably.com/docs/chat/api/kotlin/connection.md): API reference for the Connection interface in the Ably Chat Kotlin SDK.
- [Rooms](https://ably.com/docs/chat/api/kotlin/rooms.md): API reference for the Rooms interface in the Ably Chat Kotlin SDK.
- [Room](https://ably.com/docs/chat/api/kotlin/room.md): API reference for the Room interface in the Ably Chat Kotlin SDK.
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
