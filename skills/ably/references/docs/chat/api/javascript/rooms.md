# Rooms

The `Rooms` interface manages the lifecycle of chat rooms.

Access it via the `rooms` property on a [`ChatClient`](https://ably.com/docs/chat/api/javascript/chat-client.md) instance.

<Code>

#### Javascript

```
const rooms = chatClient.rooms;
```
</Code>

## Create or retrieve a room 

`rooms.get(name: string, options?: RoomOptions): Promise<Room>`

Create or retrieve a [`Room`](https://ably.com/docs/chat/api/javascript/room.md) instance. Optionally provide custom configuration to the room.

Call [`release()`](#release) when the `Room` is no longer needed. If a call to `get()` is made for a room that is currently being released, then the promise will only resolve when the release operation is complete.

If a call to `get()` is made, followed by a subsequent call to `release()` before the promise resolves, then the promise will reject with an error.

<Code>

### Javascript

```
const options = {
  typing: {
    heartbeatThrottleMs: 5000,
  },
  presence: {
    enableEvents: false,
  },
  occupancy: {
    enableEvents: true,
  },
  messages: {
    rawMessageReactions: false,
    defaultMessageReactionType: 'unique',
  },
};

const room = await chatClient.rooms.get('basketball-stream', options);

// When finished with the room
await chatClient.rooms.release('basketball-stream');
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
| messages | Optional | Configuration for message reactions. | <Table id='MessagesOptions'/> |

</Table>

<Table id='TypingOptions' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| heartbeatThrottleMs | Optional | Minimum time in milliseconds between consecutive typing started events. The first call emits immediately; later calls are no-ops until the interval has elapsed. Calling typing.stop resets the interval. Default 10000. | Number |

</Table>

<Table id='PresenceOptions' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| enableEvents | Optional | Whether the client receives presence events from the server. Can be disabled if presence is used but this client does not need the messages. Default true. | Boolean |

</Table>

<Table id='OccupancyOptions' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| enableEvents | Optional | Whether to receive occupancy events. Enabling this increases message volume as the server sends additional updates for occupancy changes. Default false. | Boolean |

</Table>

<Table id='MessagesOptions' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| rawMessageReactions | Optional | Whether to receive raw individual message reactions from the realtime channel. Reaction summaries remain available regardless of this setting. Default false. | Boolean |
| defaultMessageReactionType | Optional | The default message reaction type for sending reactions. Individual types can still be specified via the send method parameter. The default is `Distinct`. | <Table id='MessageReactionType'/> |

</Table>

<Table id='MessageReactionType' >

| Value | Description |
| --- | --- |
| Distinct | Allows at most one reaction of each type per client per message. Duplicates are not counted in the summary. Similar to reactions on Slack. The value is `distinct`. |
| Multiple | Allows any number of reactions, including repeats, counted in the summary. The reaction payload includes a count. Similar to the clap feature on Medium. The value is `multiple`. |
| Unique | Allows at most one reaction per client per message. If a client reacts again, only the second reaction is counted. Similar to reactions on iMessage or WhatsApp. The value is `unique`. |

</Table>

### Returns 

`Promise<Room>`

Returns a promise. The promise is fulfilled with the new or existing [`Room`](https://ably.com/docs/chat/api/javascript/room.md) instance, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object. The promise is also rejected if the room already exists with different options, or if [`release()`](#release) is called before `get()` resolves.

## Release a room 

`rooms.release(name: string): Promise<void>`

Releases a room, freeing its resources and detaching it from Ably.

After release, the room object is no longer usable. To use the room again, call [`get()`](#get) to create a new instance.

<Code>

### Javascript

```
await chatClient.rooms.release('my-room');
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

`Promise<void>`

Returns a promise. The promise is fulfilled when the room is fully released, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Dispose of all rooms 

`rooms.dispose(): Promise<void>`

Releases all rooms, freeing their resources and detaching them from Ably. After calling this method, any existing room objects obtained from this instance are no longer usable.

<Code>

### Javascript

```
// Release all rooms at once
await chatClient.rooms.dispose();
```
</Code>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when all rooms have been released, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/javascript/chat-client.md): API reference for the ChatClient class in the Ably Chat JavaScript SDK.
- [Connection](https://ably.com/docs/chat/api/javascript/connection.md): API reference for the Connection interface in the Ably Chat JavaScript SDK.
- [Room](https://ably.com/docs/chat/api/javascript/room.md): API reference for the Room interface in the Ably Chat JavaScript SDK.
- [Messages](https://ably.com/docs/chat/api/javascript/messages.md): API reference for the Messages interface in the Ably Chat JavaScript SDK.
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
