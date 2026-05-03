# useMessages

The `useMessages` hook provides access to message operations within a chat room, including sending, retrieving, updating, and deleting messages, as well as managing message reactions. When a listener is supplied, the hook automatically subscribes to new messages.

<Code>

#### React

```
import { useMessages } from '@ably/chat/react';

const MyComponent = () => {
  const { sendMessage, history } = useMessages({
    listener: (event) => {
      console.log('New message:', event.message.text);
    },
  });

  return <button onClick={() => sendMessage({ text: 'Hello!' }).catch(console.error)}>Send</button>;
};
```
</Code>

This hook must be used within a [`ChatRoomProvider`](https://ably.com/docs/chat/api/react/providers.md#chatRoomProvider).

## Parameters 

The `useMessages` hook accepts an optional configuration object:

<Table id='UseMessagesParams'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Optional | A callback invoked when chat message events occur. | <Table id='MessageListener'/> |
| reactionsListener | Optional | A callback invoked when reaction summaries change for messages in the room. | <Table id='MessageReactionListener'/> |
| rawReactionsListener | Optional | A callback invoked for individual reaction events on messages in the room. | <Table id='MessageRawReactionListener'/> |
| onDiscontinuity | Optional | A callback to detect and respond to discontinuities in the message stream. | [DiscontinuityListener](https://ably.com/docs/chat/api/react/providers.md#discontinuityListener) |
| onRoomStatusChange | Optional | A callback invoked when the room status changes. Removed when the component unmounts. | [RoomStatusChange](https://ably.com/docs/chat/api/react/use-room.md#roomStatusChange) |
| onConnectionStatusChange | Optional | A callback invoked when the connection status changes. Removed when the component unmounts. | [ConnectionStatusChange](https://ably.com/docs/chat/api/react/use-chat-connection.md#connectionStatusChange) |

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
| message | The message that was received. | [Message](#Message) |

</Table>

<Table id='ChatMessageEventType' >

| Value | Description |
| --- | --- |
| Created | A new chat message was received. The value is `message.created`. |
| Updated | A chat message was updated. The value is `message.updated`. |
| Deleted | A chat message was deleted. The value is `message.deleted`. |

</Table>

<Table id='MessageReactionListener' >

| Parameter | Description | Type |
| --- | --- | --- |
| event | The reaction summary event. | <Table id='MessageReactionSummaryEvent'/> |

</Table>

<Table id='MessageReactionSummaryEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The event type. The value is `reaction.summary`. | String |
| messageSerial | The serial of the message. | String |
| reactions | The aggregated reaction counts. | <Table id='MessageReactionSummary'/> |

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

<Table id='MessageRawReactionListener' >

| Parameter | Description | Type |
| --- | --- | --- |
| event | The individual reaction event. | <Table id='MessageReactionRawEvent'/> |

</Table>

<Table id='MessageReactionRawEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The event type. The value is `reaction.create` or `reaction.delete`. | MessageReactionRawEventType |
| timestamp | When the event occurred. | Date |
| reaction | The reaction details. | <Table id='MessageReactionRawEventReaction'/> |

</Table>

<Table id='MessageReactionRawEventReaction' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| messageSerial | Required | The serial of the message. | String |
| type | Required | The counting strategy. | <Table id='MessageReactionType'/> |
| name | Required | The reaction identifier. | String |
| count | Optional | The count for Multiple type reactions. | Number |
| clientId | Required | The client ID who sent the reaction. | String |
| userClaim | Optional | The user claim attached to this reaction by the server. Only present if the user's [JWT](https://ably.com/docs/auth/token.md#jwt) contained a claim for the room. | String or Undefined |

</Table>

<Table id='MessageReactionType' >

| Value | Description |
| --- | --- |
| Unique | One reaction per client per message. A second reaction replaces the first. Similar to iMessage, Facebook Messenger, or WhatsApp. The value is `unique`. |
| Distinct | One reaction of each type per client per message. Multiple different reactions allowed. Similar to Slack. The value is `distinct`. |
| Multiple | Unlimited reactions including repeats. Includes a count for batch reactions. Similar to Medium claps. The value is `multiple`. |

</Table>

## Returns 

The `useMessages` hook returns an object with the following properties:

<Table id='UseMessagesResponse'>

| Property | Description | Type |
| --- | --- | --- |
| sendMessage | Sends a message to the chat room. | [sendMessage()](#send) |
| getMessage | Retrieves a single message by its serial. | [getMessage()](#get) |
| updateMessage | Updates a message's content. | [updateMessage()](#update) |
| deleteMessage | Soft-deletes a message. | [deleteMessage()](#delete) |
| history | Retrieves historical messages with pagination. | [history()](#history) |
| historyBeforeSubscribe | Retrieves messages sent before the subscription was established. Only available when a `listener` is provided. | [historyBeforeSubscribe()](#historyBeforeSubscribe) |
| sendReaction | Sends a reaction to a message. | [sendReaction()](#send-reaction) |
| deleteReaction | Removes a reaction from a message. | [deleteReaction()](#delete-reaction) |
| roomStatus | The current status of the room, kept up to date by the hook. | [RoomStatus](https://ably.com/docs/chat/api/react/use-room.md#roomStatus) |
| roomError | An error object if the room is in an errored state. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |
| connectionStatus | The current connection status, kept up to date by the hook. | [ConnectionStatus](https://ably.com/docs/chat/api/react/use-chat-connection.md#connectionStatus) |
| connectionError | An error object if there is a connection error. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |

</Table>

## Send a message 

`sendMessage(params: SendMessageParams): Promise<Message>`

Send a message to the chat room. The message will be delivered to all subscribers in realtime.

This method uses the Ably Chat REST API and does not require the room to be attached.

### Parameters 

<Table id='SendMessageParameters'>

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

Returns a promise. The promise is fulfilled with the sent [Message](#Message) object, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

## Get a message 

`getMessage(serial: string): Promise<Message>`

Get a specific message by its unique serial identifier.

This method uses the Ably Chat REST API and does not require the room to be attached.

### Parameters 

<Table id='GetMessageParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| serial | Required | The unique serial identifier of the message to retrieve. | String |

</Table>

### Returns 

`Promise<Message>`

Returns a promise. The promise is fulfilled with the [Message](#Message) object matching the given serial, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

## Update a message 

`updateMessage(serial: string, params: UpdateMessageParams, details?: OperationDetails): Promise<Message>`

Update a message in the chat room. This method modifies an existing message's content, metadata, or headers. The update creates a new version of the message while preserving the original serial identifier. Subscribers will receive an update event in realtime.

This method uses the Ably Chat REST API and does not require the room to be attached.

### Parameters 

<Table id='UpdateMessageParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| serial | Required | The unique identifier of the message to update. | String |
| params | Required | The new message content and properties. | <Table id='UpdateMessageParams'/> |
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

Returns a promise. The promise is fulfilled with the updated [Message](#Message) object, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object. The returned message will have its `action` property set to `updated`.

## Delete a message 

`deleteMessage(serial: string, details?: OperationDetails): Promise<Message>`

Delete a message in the chat room. This method performs a "soft delete" on a message, marking it as deleted rather than permanently removing it. The deleted message will still be visible in message history but will be flagged as deleted. Subscribers will receive a deletion event in realtime.

This method uses the Ably Chat REST API and does not require the room to be attached.

### Parameters 

<Table id='DeleteMessageParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| serial | Required | The unique identifier of the message to delete. | String |
| details | Optional | Details to record about the delete action. | <Table id='OperationDetails'/> |

</Table>

### Returns 

`Promise<Message>`

Returns a promise. The promise is fulfilled with the deleted [Message](#Message) object, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object. The returned message will have its `action` property set to `deleted`.

## Get message history 

`history(params: HistoryParams): Promise<PaginatedResult<Message>>`

Get messages that have been previously sent to the chat room. This method retrieves historical messages based on the provided query options, allowing you to paginate through message history, filter by time ranges, and control the order of results.

This method uses the Ably Chat REST API and does not require the room to be attached.

### Parameters 

<Table id='HistoryParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| params | Required | Query parameters to filter and control message retrieval. | <Table id='HistoryParams'/> |

</Table>

<Table id='HistoryParams' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| limit | Optional | Maximum number of messages to retrieve. Default: `100`. | Number |
| orderBy | Optional | Order in which to return results: `oldestFirst` or `newestFirst`. Default: `newestFirst`. | <Table id='OrderBy'/> |
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

Returns a promise. The promise is fulfilled with a [`PaginatedResult`](#PaginatedResult) containing an array of [Message](#Message) objects, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

## Get messages before subscription 

`historyBeforeSubscribe(params?: HistoryBeforeSubscribeParams): Promise<PaginatedResult<Message>>`

Get messages sent to the room up to the point at which the subscription was established. Only available when a `listener` is provided to the hook. Returns `undefined` if no listener was supplied.

### Parameters 

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

### Returns 

`Promise<PaginatedResult<Message>>`

Returns a promise. The promise is fulfilled with a [`PaginatedResult`](#PaginatedResult) containing an array of [Message](#Message) objects, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

## Send a reaction 

`sendReaction(serial: string, params: SendMessageReactionParams): Promise<void>`

Sends a reaction to a specific chat message. The reaction is persisted and contributes to the message's reaction summary.

This method uses the Ably Chat REST API and does not require the room to be attached.

### Parameters 

<Table id='SendReactionParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| serial | Required | The serial of the message to react to. | String |
| params | Required | The reaction parameters. | <Table id='SendMessageReactionParams'/> |

</Table>

<Table id='SendMessageReactionParams' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| name | Required | The reaction identifier, typically an emoji. | String |
| type | Optional | The counting strategy for this reaction. Defaults vary by room configuration. | <Table id='MessageReactionType'/> |
| count | Optional | Number of times to count this reaction. Only applies to `Multiple` type. Defaults to `1`. | Number |

</Table>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the reaction has been sent, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

## Delete a reaction 

`deleteReaction(serial: string, params?: DeleteMessageReactionParams): Promise<void>`

Removes a previously sent reaction from a chat message.

### Parameters 

<Table id='DeleteReactionParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| serial | Required | The serial of the message to remove the reaction from. | String |
| params | Optional | Parameters identifying which reaction to delete. | <Table id='DeleteMessageReactionParams'/> |

</Table>

<Table id='DeleteMessageReactionParams' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| name | Optional | The reaction identifier to delete. Required except for `Unique` type. | String |
| type | Optional | The counting strategy of the reaction to delete. | <Table id='MessageReactionType'/> |

</Table>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the reaction has been deleted, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

## Message 

The `Message` interface represents a single message in a chat room.

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

## PaginatedResult 

A `PaginatedResult` represents a page of results from a paginated query such as `history()` or `historyBeforeSubscribe()`.

<Table id='PaginatedResultProperties'>

| Property | Description | Type |
| --- | --- | --- |
| items | The current page of results. | [Message](#Message)[] |

</Table>

### Check for more pages 

`hasNext(): boolean`

Returns `true` if there are more pages available by calling `next()`.

### Check if last page 

`isLast(): boolean`

Returns `true` if this is the last page of results.

### Get next page 

`next(): Promise<PaginatedResult<Message> | null>`

Returns a promise. The promise is fulfilled with the next page of results, or `null` if there are no more pages, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

### Get first page 

`first(): Promise<PaginatedResult<Message>>`

Returns a promise. The promise is fulfilled with the first page of results, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

### Get current page 

`current(): Promise<PaginatedResult<Message>>`

Returns a promise. The promise is fulfilled with the current page of results, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

## Example

<Code>

### React

```
import { ChatMessageEventType, OrderBy, MessageReactionType } from '@ably/chat';
import { useMessages } from '@ably/chat/react';
import { useState, useCallback } from 'react';

function ChatMessages() {
  const [messages, setMessages] = useState([]);

  const { sendMessage, updateMessage, deleteMessage, history, sendReaction } = useMessages({
    listener: (event) => {
      setMessages((prev) => {
        switch (event.type) {
          case ChatMessageEventType.Created:
            return [...prev, event.message];
          case ChatMessageEventType.Updated:
          case ChatMessageEventType.Deleted:
            return prev.map((msg) =>
              msg.serial === event.message.serial ? msg.with(event) : msg
            );
          default:
            return prev;
        }
      });
    },
    reactionsListener: (event) => {
      setMessages((prev) =>
        prev.map((msg) =>
          msg.serial === event.messageSerial
            ? msg.with(event)
            : msg
        )
      );
    },
  });

  const loadHistory = useCallback(async () => {
    const result = await history({ limit: 50, orderBy: OrderBy.OldestFirst });
    setMessages(result.items);
  }, [history]);

  const handleSend = useCallback(async (text) => {
    await sendMessage({ text });
  }, [sendMessage]);

  const handleReact = useCallback(async (serial, emoji) => {
    await sendReaction(serial, { name: emoji, type: MessageReactionType.Distinct });
  }, [sendReaction]);

  return (
    <div>
      <button onClick={loadHistory}>Load History</button>
      {messages.map((msg) => (
        <div key={msg.serial}>
          <strong>{msg.clientId}</strong>: {msg.text}
          <button onClick={() => handleReact(msg.serial, '👍')}>👍</button>
          <button onClick={() => deleteMessage(msg.serial)}>Delete</button>
        </div>
      ))}
      <button onClick={() => handleSend('Hello!')}>Send</button>
    </div>
  );
}
```
</Code>

## Related Topics

- [Providers](https://ably.com/docs/chat/api/react/providers.md): API reference for the ChatClientProvider and ChatRoomProvider components in the Ably Chat React SDK.
- [useChatClient](https://ably.com/docs/chat/api/react/use-chat-client.md): API reference for the useChatClient hook in the Ably Chat React SDK.
- [useChatConnection](https://ably.com/docs/chat/api/react/use-chat-connection.md): API reference for the useChatConnection hook in the Ably Chat React SDK.
- [useRoom](https://ably.com/docs/chat/api/react/use-room.md): API reference for the useRoom hook in the Ably Chat React SDK.
- [usePresence](https://ably.com/docs/chat/api/react/use-presence.md): API reference for the usePresence hook in the Ably Chat React SDK.
- [usePresenceListener](https://ably.com/docs/chat/api/react/use-presence-listener.md): API reference for the usePresenceListener hook in the Ably Chat React SDK.
- [useOccupancy](https://ably.com/docs/chat/api/react/use-occupancy.md): API reference for the useOccupancy hook in the Ably Chat React SDK.
- [useTyping](https://ably.com/docs/chat/api/react/use-typing.md): API reference for the useTyping hook in the Ably Chat React SDK.
- [useRoomReactions](https://ably.com/docs/chat/api/react/use-room-reactions.md): API reference for the useRoomReactions hook in the Ably Chat React SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
