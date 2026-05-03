# MessageReactions

The `MessageReactions` interface provides methods to send, delete, and subscribe to reactions on specific messages. Unlike room reactions, message reactions are persisted and associated with individual chat messages. Access it via `room.messages.reactions`.

<Code>

#### Javascript

```
const reactions = room.messages.reactions;
```
</Code>

Message reactions support three counting strategies:
- **Unique**: One reaction per client per message (like iMessage, WhatsApp)
- **Distinct**: One reaction of each type per client (like Slack)
- **Multiple**: Unlimited reactions including repeats (like Medium claps)

## Send a reaction to a message 

`reactions.send(messageSerial: string, params: SendMessageReactionParams): Promise<void>`

Sends a reaction to a specific chat message. The reaction is persisted and contributes to the message's reaction summary.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Javascript

```
await room.messages.reactions.send('message-serial-123', {
  name: '👍'
});
```
</Code>

### Parameters 

The `send()` method takes the following parameters:

<Table id='SendParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| messageSerial | Required | The serial of the message to react to. | String |
| params | Required | The reaction parameters. | <Table id='SendMessageReactionParams'/> |

</Table>

<Table id='SendMessageReactionParams' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| name | Required | The reaction identifier, typically an emoji. | String |
| type | Optional | The counting strategy for this reaction. Defaults vary by room configuration. | <Table id='MessageReactionType'/> |
| count | Optional | Number of times to count this reaction. Only applies to `Multiple` type. Defaults to `1`. | Number |

</Table>

<Table id='MessageReactionType' >

| Value | Description |
| --- | --- |
| Unique | One reaction per client per message. A second reaction replaces the first. Similar to iMessage, Facebook Messenger, or WhatsApp. The value is `unique`. |
| Distinct | One reaction of each type per client per message. Multiple different reactions allowed. Similar to Slack. The value is `distinct`. |
| Multiple | Unlimited reactions including repeats. Includes a count for batch reactions. Similar to Medium claps. The value is `multiple`. |

</Table>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the reaction has been sent, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Delete a reaction from a message 

`reactions.delete(messageSerial: string, params?: DeleteMessageReactionParams): Promise<void>`

Removes a previously sent reaction from a chat message.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Javascript

```
await room.messages.reactions.delete('message-serial-123', {
  name: '👍'
});
```
</Code>

### Parameters 

The `delete()` method takes the following parameters:

<Table id='DeleteParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| messageSerial | Required | The serial of the message to remove the reaction from. | String |
| params | Optional | Parameters specifying which reaction to delete. | <Table id='DeleteMessageReactionParams'/> |

</Table>

<Table id='DeleteMessageReactionParams' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| name | Optional | The reaction identifier to delete. Required except for `Unique` type. | String |
| type | Optional | The counting strategy of the reaction to delete. | <Table id='MessageReactionType'/> |

</Table>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the reaction has been deleted, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Subscribe to reaction summaries 

`reactions.subscribe(listener: MessageReactionListener): Subscription`

Subscribes to aggregated reaction count summaries for messages. Receives updates when the total reaction counts change on any message in the room.

The room must be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) to receive reaction summary events.

<Code>

### Javascript

```
const { unsubscribe } = room.messages.reactions.subscribe((event) => {
  console.log('Message:', event.messageSerial);
  console.log('Reactions:', event.reactions);
});

// To stop receiving reaction summaries
unsubscribe();
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
| type | The event type. | <Table id='MessageReactionSummaryEventType'/> |
| messageSerial | The serial of the message. | String |
| reactions | The aggregated reaction counts. | <Table id='MessageReactionSummary'/> |

</Table>

<Table id='MessageReactionSummaryEventType' >

| Value | Description |
| --- | --- |
| Summary | A reaction summary update was received. The value is `reaction.summary`. |

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

### Returns 

`Subscription`

Returns an object with the following methods:

#### Unsubscribe from reaction summaries 

`unsubscribe(): void`

Call `unsubscribe()` to stop receiving reaction summary events.

## Subscribe to individual reaction events 

`reactions.subscribeRaw(listener: MessageRawReactionListener): Subscription`

Subscribes to individual reaction events, receiving notifications each time a user adds or removes a reaction. This provides more granular updates than the summary subscription.

The room must be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) to receive raw reaction events. Raw message reactions must also be enabled when [creating the room](https://ably.com/docs/chat/api/javascript/rooms.md#get) by setting `rawMessageReactions: true` in the `MessagesOptions`.

<Aside data-type='note'>
Raw reactions are not suitable for the purpose of displaying message reaction counts as their effect on the reactions summary depends on the previous reactions.
</Aside>

<Code>

### Javascript

```
const { unsubscribe } = room.messages.reactions.subscribeRaw((event) => {
  if (event.type === 'reaction.create') {
    console.log(`${event.reaction.clientId} reacted with ${event.reaction.name}`);
  } else if (event.type === 'reaction.delete') {
    console.log(`${event.reaction.clientId} removed ${event.reaction.name}`);
  }
});

// To stop receiving raw events
unsubscribe();
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

### Returns 

`Subscription`

Returns an object with the following methods:

#### Unsubscribe from raw reaction events 

`unsubscribe(): void`

Call `unsubscribe()` to stop receiving raw reaction events.

## Get reactions for a specific client 

`reactions.clientReactions(messageSerial: string, clientId?: string): Promise<MessageReactionSummary>`

Retrieves the reaction data for a specific client on a message. If no client ID is provided, returns reactions for the current user.

<Code>

### Javascript

```
// Get current user's reactions on a message
const myReactions = await room.messages.reactions.clientReactions('message-serial-123');

// Get another user's reactions
const theirReactions = await room.messages.reactions.clientReactions('message-serial-123', 'user-456');
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

`Promise<MessageReactionSummary>`

Returns a promise. The promise is fulfilled with the reaction data for the specified client, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Example

<Code>

### Javascript

```
import { MessageReactionType, MessageReactionRawEventType } from '@ably/chat';

const room = await chatClient.rooms.get('my-room', {
  messages: { rawMessageReactions: true }
});
await room.attach();

// Subscribe to reaction summaries
const { unsubscribe: unsubscribeSummary } = room.messages.reactions.subscribe((event) => {
  const { messageSerial, reactions } = event;

  // Update UI with reaction counts
  for (const [name, summary] of Object.entries(reactions.distinct)) {
    console.log(`${name}: ${summary.total} reactions from ${summary.clientIds.length} clients`);
  }
});

// Subscribe to individual reaction events for animations
const { unsubscribe: unsubscribeRaw } = room.messages.reactions.subscribeRaw((event) => {
  if (event.type === MessageReactionRawEventType.Create) {
    // Show reaction animation
    showReactionAnimation(event.reaction.name, event.reaction.clientId);
  }
});

// Send a distinct reaction (Slack-style)
await room.messages.reactions.send('message-serial-123', {
  name: '👍',
  type: MessageReactionType.Distinct
});

// Send multiple reactions (Medium-style claps)
await room.messages.reactions.send('message-serial-456', {
  name: '👏',
  type: MessageReactionType.Multiple,
  count: 5
});

// Remove a reaction
await room.messages.reactions.delete('message-serial-123', {
  name: '👍'
});

// Check what reactions I've sent on a message
const myReactions = await room.messages.reactions.clientReactions('message-serial-123');
console.log('My reactions:', myReactions);

// Clean up
unsubscribeSummary();
unsubscribeRaw();
```
</Code>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/javascript/chat-client.md): API reference for the ChatClient class in the Ably Chat JavaScript SDK.
- [Connection](https://ably.com/docs/chat/api/javascript/connection.md): API reference for the Connection interface in the Ably Chat JavaScript SDK.
- [Rooms](https://ably.com/docs/chat/api/javascript/rooms.md): API reference for the Rooms interface in the Ably Chat JavaScript SDK.
- [Room](https://ably.com/docs/chat/api/javascript/room.md): API reference for the Room interface in the Ably Chat JavaScript SDK.
- [Messages](https://ably.com/docs/chat/api/javascript/messages.md): API reference for the Messages interface in the Ably Chat JavaScript SDK.
- [Message](https://ably.com/docs/chat/api/javascript/message.md): API reference for the Message interface in the Ably Chat JavaScript SDK.
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
