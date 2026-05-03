# Occupancy

The `Occupancy` interface provides methods for tracking the number of users in a chat room. Access it via `room.occupancy`.

<Code>

#### Javascript

```
const occupancy = room.occupancy;
```
</Code>

## Properties

The `Occupancy` interface has the following properties:

<Table id='OccupancyProperties'>

| Property | Description | Type |
| --- | --- | --- |
| current | The latest occupancy data cached from realtime events. Returns `undefined` if no occupancy events have been received yet since room attachment. Requires `enableEvents` to be `true` in the [room's occupancy options](https://ably.com/docs/chat/api/javascript/rooms.md#get). | <Table id='OccupancyData'/> or Undefined |

</Table>

<Table id='OccupancyData' >

| Property | Description | Type |
| --- | --- | --- |
| connections | The number of active connections to the room. | Number |
| presenceMembers | The number of users in the presence set. | Number |

</Table>

## Get current occupancy 

`occupancy.get(): Promise<OccupancyData>`

Fetches the current occupancy of the chat room from the server. Retrieves the latest occupancy metrics, including the number of active connections and presence members.

This method uses the Ably Chat REST API and does not require the room to be attached.

<Code>

### Javascript

```
const data = await room.occupancy.get();
console.log('Connections:', data.connections);
console.log('Presence members:', data.presenceMembers);
```
</Code>

### Returns 

`Promise<OccupancyData>`

Returns a promise. The promise is fulfilled with the current occupancy data, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/javascript/chat-client.md#errorinfo) object.

## Subscribe to occupancy events 

`occupancy.subscribe(listener: OccupancyListener): Subscription`

Subscribes to occupancy updates for the chat room. Receives updates whenever the number of connections or present members in the room changes.

Requires `enableEvents` to be `true` in the [room's occupancy options](https://ably.com/docs/chat/api/javascript/rooms.md#get). The room should be [attached](https://ably.com/docs/chat/api/javascript/room.md#attach) to receive occupancy events.

<Code>

### Javascript

```
const { unsubscribe } = room.occupancy.subscribe((event) => {
  console.log('Connections:', event.occupancy.connections);
  console.log('Presence members:', event.occupancy.presenceMembers);
});

// To stop receiving occupancy updates
unsubscribe();
```
</Code>

### Parameters 

The `subscribe()` method takes the following parameters:

<Table id='SubscribeParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Required | Callback invoked when room occupancy changes. | <Table id='OccupancyEvent'/> |

</Table>

<Table id='OccupancyEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The type of occupancy event. | <Table id='OccupancyEventType'/> |
| occupancy | The current occupancy data. | <Table id='OccupancyData'/> |

</Table>

<Table id='OccupancyEventType' >

| Value | Description |
| --- | --- |
| Updated | The room occupancy has been updated. The value is `occupancy.updated`. |

</Table>

### Returns 

`Subscription`

Returns an object with the following methods:

#### Unsubscribe from occupancy events 

`unsubscribe(): void`

Call `unsubscribe()` to stop receiving occupancy events.

## Example

<Code>

### Javascript

```
const room = await chatClient.rooms.get('my-room', {
  occupancy: {
    enableEvents: true // Required for subscribe() and current property
  }
});

await room.attach();

// Subscribe to occupancy changes
const { unsubscribe } = room.occupancy.subscribe((event) => {
  const { connections, presenceMembers } = event.occupancy;
  console.log(`Room has ${connections} connections and ${presenceMembers} presence members`);

  // Update UI with viewer count
  document.getElementById('viewer-count').textContent = connections;
});

// Fetch occupancy on-demand (works even without enableEvents)
const occupancy = await room.occupancy.get();
console.log(`Initial occupancy: ${occupancy.connections} connections`);

// Access cached occupancy (requires enableEvents)
const cached = room.occupancy.current;
if (cached) {
  console.log('Cached occupancy:', cached.connections);
}

// Clean up
unsubscribe();
```
</Code>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/javascript/chat-client.md): API reference for the ChatClient class in the Ably Chat JavaScript SDK.
- [Connection](https://ably.com/docs/chat/api/javascript/connection.md): API reference for the Connection interface in the Ably Chat JavaScript SDK.
- [Rooms](https://ably.com/docs/chat/api/javascript/rooms.md): API reference for the Rooms interface in the Ably Chat JavaScript SDK.
- [Room](https://ably.com/docs/chat/api/javascript/room.md): API reference for the Room interface in the Ably Chat JavaScript SDK.
- [Messages](https://ably.com/docs/chat/api/javascript/messages.md): API reference for the Messages interface in the Ably Chat JavaScript SDK.
- [Message](https://ably.com/docs/chat/api/javascript/message.md): API reference for the Message interface in the Ably Chat JavaScript SDK.
- [MessageReactions](https://ably.com/docs/chat/api/javascript/message-reactions.md): API reference for the MessageReactions interface in the Ably Chat JavaScript SDK.
- [Presence](https://ably.com/docs/chat/api/javascript/presence.md): API reference for the Presence interface in the Ably Chat JavaScript SDK.
- [Typing](https://ably.com/docs/chat/api/javascript/typing.md): API reference for the Typing interface in the Ably Chat JavaScript SDK.
- [RoomReactions](https://ably.com/docs/chat/api/javascript/room-reactions.md): API reference for the RoomReactions interface in the Ably Chat JavaScript SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
