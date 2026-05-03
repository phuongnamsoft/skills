# Messages

The `Messages` interface provides methods for sending, receiving, and managing chat messages in a room. Access it via `room.messages`.

<Code>

#### Javascript

```
const messages = room.messages;
```
</Code>

## Properties

The `Messages` interface has the following properties:

<Table id='MessagesProperties'>

| Property | Description | Type |
| --- | --- | --- |
| reactions | Access to message reactions functionality for adding, removing, and subscribing to reactions on specific messages. | [MessageReactions](https://ably.com/docs/chat/api/javascript/message-reactions.md) |

</Table>

## Subscribe to messages 

`messages.subscribe(listener: MessageListener): MessageSubscriptionResponse`

Subscribe to chat message events in the room. This method allows you to listen for new messages and provides access to historical messages that occurred before the subscription was established.

The room must be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) for the listener to receive new message events.

<Code>

### Javascript

```
const { unsubscribe, historyBeforeSubscribe } = messages.subscribe((event) => {
  console.log('Received message:', event.message.text);
});

// Get messages sent before subscribing
const history = await historyBeforeSubscribe();

// To stop receiving messages
unsubscribe();
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
| message | The message that was received. | [Message](https://ably.com/docs/chat/api/javascript/message.md) |

</Table>

<Table id='ChatMessageEventType' >

| Value | Description |
| --- | --- |
| Created | A new chat message was received. The value is `message.created`. |
| Updated | A chat message was updated. The value is `message.updated`. |
| Deleted | A chat message was deleted. The value is `message.deleted`. |

</Table>

### Returns 

`MessageSubscriptionResponse`

Returns an object with the following methods:

#### Unsubscribe from messages 

`unsubscribe(): void`

Call `unsubscribe()` to stop listening for message events.

#### Get messages from before the subscription started 

`historyBeforeSubscribe(params?: HistoryBeforeSubscribeParams): Promise<PaginatedResult<Message>>`

Get messages sent to the room from before the subscription was established.

##### Parameters 

The `historyBeforeSubscribe()` method takes the following parameters:

<Table id='HistoryBeforeSubscribeParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| params | Optional | Query parameters to filter message retrieval. Messages are returned in order of most recent to oldest. | <Table id='HistoryBeforeSubscribeParams'/> |

</Table>

<Table id='HistoryBeforeSubscribeParams' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| limit | Optional | Maximum number of messages to retrieve. Default: `100`. | Number |
| start | Optional | Start of the time window to query, as a Unix timestamp in milliseconds. | Number |
| end | Optional | End of the time window to query, as a Unix timestamp in milliseconds. | Number |

</Table>

##### Returns 

`Promise<PaginatedResult<Message>>`

Returns a promise. The promise is fulfilled with a [`PaginatedResult`](#PaginatedResult) containing an array of [Message](https://ably.com/docs/chat/api/javascript/message.md) objects, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Send a message 

`messages.send(params: SendMessageParams): Promise<Message>`

Send a message to the chat room. The message will be delivered to all subscribers in real-time.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Javascript

```
const message = await messages.send({
  text: 'Hello, world!'
});

console.log('Message sent with serial:', message.serial);
```
</Code>

### Parameters 

The `send()` method takes the following parameters:

<Table id='SendParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| params | Required | Message parameters containing the text and optional metadata/headers. | <Table id='SendMessageParams'/> |

</Table>

<Table id='SendMessageParams' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| text | Required | The text content of the message. | String |
| metadata | Optional | Extra information attached to the message for features like animations or linking to external resources. | <Table id='MessageMetadata'/> |
| headers | Optional | Additional information in Ably message extras, usable for features like livestream timestamping or message flagging. | <Table id='MessageHeaders'/> |

</Table>

<Table id='MessageMetadata' >

| Property | Description | Type |
| --- | --- | --- |
| | Key-value pairs that can be attached to a message for features like animations, styling hints, or links to external resources. Keys must be non-empty strings. Values can be any JSON-serializable type. Always present on a message, defaults to an empty object if not provided. | `Record<string, any>` |

</Table>

<Table id='MessageHeaders' >

| Property | Description | Type |
| --- | --- | --- |
| | Key-value pairs stored in Ably message extras, accessible to integrations such as webhooks, queues, or serverless functions. Keys must be non-empty strings. Always present on a message, defaults to an empty object if none provided. | `Record<string, number \| string \| boolean \| null \| undefined>` |

</Table>

### Returns 

`Promise<Message>`

Returns a promise. The promise is fulfilled with the sent [Message](https://ably.com/docs/chat/api/javascript/message.md) object, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Get message history 

`messages.history(params: HistoryParams): Promise<PaginatedResult<Message>>`

Get messages that have been previously sent to the chat room. This method retrieves historical messages based on the provided query options, allowing you to paginate through message history, filter by time ranges, and control the order of results.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Javascript

```
const history = await messages.history({
  limit: 50,
  orderBy: OrderBy.NewestFirst
});

console.log('Messages:', history.items);

// Get next page if available
if (history.hasNext()) {
  const nextPage = await history.next();
}
```
</Code>

### Parameters 

The `history()` method takes the following parameters:

<Table id='HistoryParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| params | Required | Query parameters to filter and control message retrieval. | <Table id='HistoryParams'/> |

</Table>

<Table id='HistoryParams' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| limit | Optional | Maximum number of messages to retrieve. Default: `100`. | Number |
| orderBy | Optional | Order in which to return results: `'oldestFirst'` or `'newestFirst'`. Default: `'newestFirst'`. | <Table id='OrderBy'/> |
| start | Optional | Start of the time window to query, as a Unix timestamp in milliseconds. | Number |
| end | Optional | End of the time window to query, as a Unix timestamp in milliseconds. | Number |

</Table>

<Table id='OrderBy' >

| Value | Description |
| --- | --- |
| OldestFirst | Return results starting with the oldest messages. The value is `oldestFirst`. |
| NewestFirst | Return results starting with the newest messages. The value is `newestFirst`. |

</Table>

### Returns 

`Promise<PaginatedResult<Message>>`

Returns a promise. The promise is fulfilled with a [`PaginatedResult`](#PaginatedResult) containing an array of [Message](https://ably.com/docs/chat/api/javascript/message.md) objects, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Get a specific message 

`messages.get(serial: string): Promise<Message>`

Get a specific message by its unique serial identifier.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Javascript

```
const message = await messages.get('01234567890@abcdefghij');
console.log('Message text:', message.text);
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

`Promise<Message>`

Returns a promise. The promise is fulfilled with the [Message](https://ably.com/docs/chat/api/javascript/message.md) object matching the given serial, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Update a message 

`messages.update(serial: string, updateParams: UpdateMessageParams, details?: OperationDetails): Promise<Message>`

Update a message in the chat room. This method modifies an existing message's content, metadata, or headers. The update creates a new version of the message while preserving the original serial identifier. Subscribers will receive an update event in real-time.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Javascript

```
const updatedMessage = await messages.update(
  message.serial,
  { text: 'Updated message text' },
  { description: 'Fixed typo' }
);

console.log('Message updated:', updatedMessage.version);
```
</Code>

### Parameters 

The `update()` method takes the following parameters:

<Table id='UpdateParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| serial | Required | The unique identifier of the message to update. | String |
| updateParams | Required | The new message content and properties. | <Table id='UpdateMessageParams'/> |
| details | Optional | Details to record about the update action. | <Table id='OperationDetails'/> |

</Table>

<Table id='UpdateMessageParams' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| text | Required | The new text content of the message. | String |
| metadata | Optional | New metadata for the message. | <Table id='MessageMetadata'/> |
| headers | Optional | New headers for the message. | <Table id='MessageHeaders'/> |

</Table>

<Table id='OperationDetails' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| description | Optional | A human-readable description of why the operation was performed. | String |
| metadata | Optional | Additional metadata about the operation. | <Table id='OperationMetadata'/> |

</Table>

<Table id='OperationMetadata' >

| Property | Description | Type |
| --- | --- | --- |
| | Metadata supplied to a message update or deletion request. Do not use metadata for authoritative information. There is no server-side validation. When reading the metadata, treat it like user input. | `Record<string, string>` |

</Table>

### Returns 

`Promise<Message>`

Returns a promise. The promise is fulfilled with the updated [Message](https://ably.com/docs/chat/api/javascript/message.md) object, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object. The returned message will have its `action` property set to `updated`.

## Delete a message 

`messages.delete(serial: string, details?: OperationDetails): Promise<Message>`

Delete a message in the chat room. This method performs a "soft delete" on a message, marking it as deleted rather than permanently removing it. The deleted message will still be visible in message history but will be flagged as deleted. Subscribers will receive a deletion event in real-time.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Javascript

```
const deletedMessage = await messages.delete(
  message.serial,
  { description: 'Removed inappropriate content' }
);

console.log('Message deleted:', deletedMessage.action);
```
</Code>

### Parameters 

The `delete()` method takes the following parameters:

<Table id='DeleteParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| serial | Required | The unique identifier of the message to delete. | String |
| details | Optional | Details to record about the delete action. | <Table id='OperationDetails'/> |

</Table>

### Returns 

`Promise<Message>`

Returns a promise. The promise is fulfilled with the deleted [Message](https://ably.com/docs/chat/api/javascript/message.md) object, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object. The returned message will have its `action` property set to `deleted`.

## PaginatedResult 

A `PaginatedResult` represents a page of results from a paginated query such as [history()](#history) or [historyBeforeSubscribe()](#historyBeforeSubscribe).

### Properties

<Table id='PaginatedResultProperties'>

| Property | Description | Type |
| --- | --- | --- |
| items | The current page of results. | [`Message[]`](/docs/chat/api/javascript/message) |

</Table>

### Check for more pages 

`hasNext(): boolean`

Returns `true` if there are more pages available by calling `next()`.

### Check if last page 

`isLast(): boolean`

Returns `true` if this is the last page of results.

### Get next page 

`next(): Promise<PaginatedResult<Message> | null>`

Returns a promise. The promise is fulfilled with the next page of results, or `null` if there are no more pages, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

### Get first page 

`first(): Promise<PaginatedResult<Message>>`

Returns a promise. The promise is fulfilled with the first page of results, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

### Get current page 

`current(): Promise<PaginatedResult<Message>>`

Returns a promise. The promise is fulfilled with the current page of results, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Example

<Code>

### Javascript

```
import { ChatMessageEventType, OrderBy } from '@ably/chat';

const room = await chatClient.rooms.get('my-room');
await room.attach();

// Subscribe to messages
const { unsubscribe, historyBeforeSubscribe } = room.messages.subscribe((event) => {
  const msg = event.message;

  switch (event.type) {
    case ChatMessageEventType.Created:
      console.log(`${msg.clientId}: ${msg.text}`);
      break;
    case ChatMessageEventType.Updated:
      console.log(`Message updated: ${msg.text}`);
      break;
    case ChatMessageEventType.Deleted:
      console.log(`Message deleted: ${msg.serial}`);
      break;
  }
});

// Get recent history
const history = await room.messages.history({ limit: 10 });
history.items.forEach(msg => {
  console.log(`[History] ${msg.clientId}: ${msg.text}`);
});

// Send a message
const sent = await room.messages.send({ text: 'Hello everyone!' });

// Update the message
await room.messages.update(sent.serial, { text: 'Hello everyone! (edited)' });

// Clean up
unsubscribe();
```
</Code>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/javascript/chat-client.md): API reference for the ChatClient class in the Ably Chat JavaScript SDK.
- [Connection](https://ably.com/docs/chat/api/javascript/connection.md): API reference for the Connection interface in the Ably Chat JavaScript SDK.
- [Rooms](https://ably.com/docs/chat/api/javascript/rooms.md): API reference for the Rooms interface in the Ably Chat JavaScript SDK.
- [Room](https://ably.com/docs/chat/api/javascript/room.md): API reference for the Room interface in the Ably Chat JavaScript SDK.
- [Message](https://ably.com/docs/chat/api/javascript/message.md): API reference for the Message interface in the Ably Chat JavaScript SDK.
- [MessageReactions](https://ably.com/docs/chat/api/javascript/message-reactions.md): API reference for the MessageReactions interface in the Ably Chat JavaScript SDK.
- [Presence](https://ably.com/docs/chat/api/javascript/presence.md): API reference for the Presence interface in the Ably Chat JavaScript SDK.
- [Occupancy](https://ably.com/docs/chat/api/javascript/occupancy.md): API reference for the Occupancy interface in the Ably Chat JavaScript SDK.
- [Typing](https://ably.com/docs/chat/api/javascript/typing.md): API reference for the Typing interface in the Ably Chat JavaScript SDK.
- [RoomReactions](https://ably.com/docs/chat/api/javascript/room-reactions.md): API reference for the RoomReactions interface in the Ably Chat JavaScript SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
