# Room

The `Room` interface represents an individual chat room instance. It provides access to all chat features such as messages, presence, reactions, typing indicators, and occupancy. Rooms are the primary way users interact with chat functionality.

## Obtaining a room instance

Use the [`rooms.get()`](https://ably.com/docs/chat/api/javascript/rooms.md#get) method to obtain a room instance:

<Code>

### Javascript

```
const room = await chatClient.rooms.get('my-room');
```
</Code>

For more information, see the [rooms documentation](https://ably.com/docs/chat/rooms.md).

## Properties

The `Room` interface has the following properties:

<Table id='RoomProperties'>

| Property | Description | Type |
| --- | --- | --- |
| name | The unique identifier of the room. | String |
| messages | The Messages instance for sending and receiving messages. | [Messages](https://ably.com/docs/chat/api/javascript/messages.md) |
| presence | The Presence instance for tracking online users. | [Presence](https://ably.com/docs/chat/api/javascript/presence.md) |
| reactions | The RoomReactions instance for room-level reactions. | [RoomReactions](https://ably.com/docs/chat/api/javascript/room-reactions.md) |
| typing | The Typing instance for typing indicators. | [Typing](https://ably.com/docs/chat/api/javascript/typing.md) |
| occupancy | The Occupancy instance for tracking user counts. | [Occupancy](https://ably.com/docs/chat/api/javascript/occupancy.md) |
| status | The current lifecycle status of the room. | <Table id='RoomStatus'/> |
| error | The error information if the room is in a failed state. | [ErrorInfo](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) or Undefined |
| channel | Direct access to the underlying Ably RealtimeChannel. | Ably.RealtimeChannel |

</Table>

<Table id='RoomStatus' >

| Status | Description |
| --- | --- |
| Initializing | The library is currently initializing the room. This is a temporary state used in React prior to the room being resolved. The value is `initializing`. |
| Initialized | The room has been initialized, but no attach has been attempted yet. The value is `initialized`. |
| Attaching | An attach has been initiated by sending a request to Ably. This is a transient status and will be followed by a transition to `Attached`, `Suspended`, or `Failed`. The value is `attaching`. |
| Attached | The room is attached and actively receiving events. In this status, clients can publish and subscribe to messages, and enter the presence set. The value is `attached`. |
| Detaching | A detach has been initiated on the attached room by sending a request to Ably. This is a transient status and will be followed by a transition to `Detached` or `Failed`. The value is `detaching`. |
| Detached | The room has been detached by the client and is no longer receiving events. The value is `detached`. |
| Suspended | The room, having previously been attached, has lost continuity. This typically occurs when the client is disconnected from Ably for more than two minutes. The client will automatically attempt to reattach when connectivity is restored. The value is `suspended`. |
| Failed | An indefinite failure condition. This status is entered if an error is received from Ably, such as an attempt to attach without the necessary access rights. The value is `failed`. |
| Releasing | The room is being released and its resources are being cleaned up. Attempting to use a room in this state may result in undefined behavior. The value is `releasing`. |
| Released | The room has been released and is no longer usable. A new room instance must be obtained to continue using the room. The value is `released`. |

</Table>

## Attach to a room 

`room.attach(): Promise<void>`

Attach to the room to start receiving messages and events. Attaching is required before the client can publish or subscribe to room events.

<Code>

### Javascript

```
await room.attach();
```
</Code>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the room is attached, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

For more information, see [attach to a room](https://ably.com/docs/chat/rooms.md#attach).

## Detach from a room 

`room.detach(): Promise<void>`

Detach from the room to stop receiving messages and events. Existing subscriptions are preserved but will not receive events until the room is re-attached.

<Code>

### Javascript

```
await room.detach();
```
</Code>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the room is detached, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

For more information, see [detach from a room](https://ably.com/docs/chat/rooms.md#detach).

## Get room options 

`room.options(): RoomOptions`

Returns a deep copy of the room configuration options.

<Code>

### Javascript

```
const options = room.options();
console.log(options.typing?.heartbeatThrottleMs);
```
</Code>

### Returns 

`RoomOptions`

Returns a deep copy of the room's configuration options.

<Table id='RoomOptions'>

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

## Subscribe to room status changes 

`room.onStatusChange(listener: RoomStatusListener): StatusSubscription`

Register a listener to receive room status change events. The listener is called whenever the room transitions between lifecycle states.

<Code>

### Javascript

```
const { off } = room.onStatusChange((change) => {
  console.log(`Room status changed to: ${change.current}`);
  if (change.error) {
    console.error('Error:', change.error);
  }
});

// To remove the listener
off();
```
</Code>

### Parameters 

The `onStatusChange()` method takes the following parameters:

<Table id='OnStatusChangeParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Required | A function that receives status change events. | <Table id='RoomStatusChange'/> |

</Table>

<Table id='RoomStatusChange' >

| Property | Description | Type |
| --- | --- | --- |
| current | The new status of the room. | <Table id='RoomStatus'/> |
| previous | The previous status of the room. | <Table id='RoomStatus'/> |
| error | An error that provides a reason why the room has entered the new status, if applicable. | [ErrorInfo](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) or Undefined |

</Table>

### Returns 

`StatusSubscription`

Returns an object with the following methods:

#### Deregister the listener 

`off(): void`

Call `off()` to deregister the room status listener.

## Subscribe to discontinuity events 

`room.onDiscontinuity(handler: DiscontinuityListener): StatusSubscription`

Register a listener to detect connection interruptions and potentially missed events. This is useful for understanding when the client may have missed messages due to connectivity issues.

<Code>

### Javascript

```
const { off } = room.onDiscontinuity((reason) => {
  console.log('Discontinuity detected:', reason);
  // You may want to re-fetch recent messages here
});

// To remove the listener
off();
```
</Code>

### Parameters 

The `onDiscontinuity()` method takes the following parameters:

<Table id='OnDiscontinuityParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| handler | Required | A function that receives discontinuity events. | <Table id='DiscontinuityListener'/> |

</Table>

<Table id='DiscontinuityListener' >

| Parameter | Description | Type |
| --- | --- | --- |
| error | An error providing context about why the discontinuity occurred. | [ErrorInfo](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) |

</Table>

### Returns 

`StatusSubscription`

Returns an object with the following methods:

#### Deregister the listener 

`off(): void`

Call `off()` to deregister the discontinuity listener.

## Example

<Code>

### Javascript

```
const room = await chatClient.rooms.get('my-room');

// Attach to start receiving events
await room.attach();

// Monitor room status
const { off: offStatus } = room.onStatusChange((change) => {
  console.log(`Room status: ${change.current}`);
});

// Monitor for discontinuities
const { off: offDiscontinuity } = room.onDiscontinuity((reason) => {
  console.log('Discontinuity detected, consider re-fetching messages');
});

// Access room features
const messages = room.messages;
const presence = room.presence;
const typing = room.typing;

// Get the room name
console.log('Room name:', room.name);

// When done, detach and clean up
await room.detach();
offStatus();
offDiscontinuity();
```
</Code>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/javascript/chat-client.md): API reference for the ChatClient class in the Ably Chat JavaScript SDK.
- [Connection](https://ably.com/docs/chat/api/javascript/connection.md): API reference for the Connection interface in the Ably Chat JavaScript SDK.
- [Rooms](https://ably.com/docs/chat/api/javascript/rooms.md): API reference for the Rooms interface in the Ably Chat JavaScript SDK.
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
