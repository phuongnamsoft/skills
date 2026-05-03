# Message

The `Message` interface represents a single message in a chat room. Messages are received through the [`messages.subscribe()`](https://ably.com/docs/chat/api/javascript/messages.md#subscribe) method or retrieved via [`messages.history()`](https://ably.com/docs/chat/api/javascript/messages.md#history).

## Properties

The `Message` interface has the following properties:

<Table id='MessageProperties'>

| Property | Description | Type |
| --- | --- | --- |
| serial | The unique identifier of the message. | String |
| clientId | The client ID of the user who created the message. | String |
| userClaim | The user claim attached to this message by the server. Only present if the publishing user's [JWT](https://ably.com/docs/auth/token.md#jwt) contained a claim for the room in which this message was published. | String or Undefined |
| text | The text content of the message. | String |
| timestamp | The timestamp at which the message was created. | Date |
| metadata | Extra information attached to the message for features like animations or linking to external resources. Always set; empty object if no metadata was provided. | <Table id='MessageMetadata'/> |
| headers | Additional information in Ably realtime message extras, usable for features like livestream timestamping or message flagging. Always set; empty object if none provided. | <Table id='MessageHeaders'/> |
| action | The action type indicating if the message was created, updated, or deleted. | <Table id='ChatMessageAction'/> |
| version | Information about the current version of this message. | <Table id='MessageVersion'/> |
| reactions | The reactions summary for this message. | <Table id='MessageReactionSummary'/> |

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

<Table id='ChatMessageAction' >

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
| timestamp | Required | When this version was created. | Date |
| clientId | Optional | The client ID of the user who performed an update or deletion. | String or Undefined |
| description | Optional | A description of why this version was created. | String or Undefined |
| metadata | Optional | Additional metadata about the operation. | <Table id='OperationMetadata'/> or Undefined |

</Table>

<Table id='OperationMetadata' >

| Property | Description | Type |
| --- | --- | --- |
| | Metadata supplied to a message update or deletion request. Do not use metadata for authoritative information. There is no server-side validation. When reading the metadata, treat it like user input. | `Record<string, string>` |

</Table>

<Table id='MessageReactionSummary' >

| Property | Description | Type |
| --- | --- | --- |
| unique | Reactions counted with the "unique" strategy (one per client per message). Maps reaction name to summary. | <Table id='SummaryClientIdList'/> |
| distinct | Reactions counted with the "distinct" strategy (one of each type per client). Maps reaction name to summary. | <Table id='SummaryClientIdList'/> |
| multiple | Reactions counted with the "multiple" strategy (unlimited per client). Maps reaction name to summary. | <Table id='SummaryClientIdCounts'/> |

</Table>

<Table id='SummaryClientIdList' >

| Property | Description | Type |
| --- | --- | --- |
| total | The total number of clients who have reacted with this name. | Number |
| clientIds | A list of the client IDs of all clients who have reacted with this name. | String[] |
| clipped | Whether the list of client IDs has been clipped due to exceeding the maximum allowed. | Boolean |

</Table>

<Table id='SummaryClientIdCounts' >

| Property | Description | Type |
| --- | --- | --- |
| total | The total count of reactions with this name across all clients. | Number |
| clientIds | A map of client ID to the count each client has contributed. | `Record<string, number>` |
| totalClientIds | The total number of distinct client IDs in the map. Equal to the length of `clientIds` if `clipped` is `false`. | Number |
| totalUnidentified | The total count from unidentified clients not included in `clientIds`. | Number |
| clipped | Whether the list of client IDs has been clipped due to exceeding the maximum allowed. | Boolean |

</Table>

## Apply an event to a message 

`message.with(event: ChatMessageEvent | Message | MessageReactionSummaryEvent): Message`

Creates a new message instance with an event applied. This is useful for updating a local message state when receiving update or delete events. Returns the same instance if the event would be a no-op (e.g., applying an older version).

<Code>

### Javascript

```
const updatedMessage = message.with(updateEvent);
```
</Code>

### Parameters 

The `with()` method takes the following parameters:

<Table id='WithParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| event | Required | The event to apply to the message. | [Message](https://ably.com/docs/chat/api/javascript/message.md) or <Table id='ChatMessageEvent'/> or <Table id='MessageReactionSummaryEvent'/> |

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

<Table id='MessageReactionSummaryEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The event type. | <Table id='MessageReactionSummaryEventType'/> |
| messageSerial | The serial of the message. | String |
| reactions | The aggregated reaction counts. | <Table id='MessageReactionSummary'/> |

</Table>

<Table id='MessageReactionSummaryEventType' >

| Value | Description |
| --- | --- |
| Summary | A reaction summary update was received. The value is `reaction.summary`. |

</Table>

### Returns 

`Message`

Returns a new message instance with the event applied, or the same instance if the event would be a no-op.

## Copy a message 

`message.copy(params?: MessageCopyParams): Message`

Creates a copy of the message with specified fields replaced.

<Code>

### Javascript

```
const messageCopy = message.copy({ text: 'New text' });
```
</Code>

### Parameters 

The `copy()` method takes the following parameters:

<Table id='CopyParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| params | Optional | The fields to replace in the copy. | <Table id='MessageCopyParams'/> |

</Table>

<Table id='MessageCopyParams' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| text | Optional | The new text content. | String |
| metadata | Optional | The new metadata. | <Table id='MessageMetadata'/> |
| headers | Optional | The new headers. | <Table id='MessageHeaders'/> |

</Table>

### Returns 

`Message`

Returns a new message instance with the specified fields replaced.

## Example

<Code>

### Javascript

```
import { ChatMessageAction } from '@ably/chat';

// Subscribe to messages and handle different actions
room.messages.subscribe((event) => {
  const message = event.message;

  console.log('Serial:', message.serial);
  console.log('From:', message.clientId);
  console.log('Text:', message.text);
  console.log('Sent at:', message.timestamp);
  console.log('Action:', message.action);

  // Check if message has metadata
  if (Object.keys(message.metadata).length > 0) {
    console.log('Metadata:', message.metadata);
  }

  // Check message version for updates or deletions
  if (message.action === ChatMessageAction.MessageUpdate) {
    console.log('Updated by:', message.version.clientId);
    console.log('Update reason:', message.version.description);
  }

  if (message.action === ChatMessageAction.MessageDelete) {
    console.log('Deleted by:', message.version.clientId);
    console.log('Delete reason:', message.version.description);
  }

  // Check reaction summary
  for (const [name, summary] of Object.entries(message.reactions.distinct)) {
    console.log(`${name}: ${summary.total} reactions from ${summary.clientIds.length} clients`);
  }
});
```
</Code>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/javascript/chat-client.md): API reference for the ChatClient class in the Ably Chat JavaScript SDK.
- [Connection](https://ably.com/docs/chat/api/javascript/connection.md): API reference for the Connection interface in the Ably Chat JavaScript SDK.
- [Rooms](https://ably.com/docs/chat/api/javascript/rooms.md): API reference for the Rooms interface in the Ably Chat JavaScript SDK.
- [Room](https://ably.com/docs/chat/api/javascript/room.md): API reference for the Room interface in the Ably Chat JavaScript SDK.
- [Messages](https://ably.com/docs/chat/api/javascript/messages.md): API reference for the Messages interface in the Ably Chat JavaScript SDK.
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
