# Live cursors

The live cursors feature enables you to track the cursors of members within a space in realtime.

Cursor events are emitted whenever a member moves their mouse within a space. In order to optimize the efficiency and frequency of updates, cursor position events are automatically batched. The batching interval may be customized in order to further optimize for increased performance versus the number of events published.

Live cursor updates are not available as part of the [space state](https://ably.com/docs/spaces/space.md#subscribe) and must be subscribed to using [`space.cursors.subscribe()`](#subscribe).

<Aside data-type='important'>
Live cursors are a great way of providing contextual awareness as to what members are looking at within an application. However, too many cursors moving across a page can often be a distraction rather than an enhancement. As such, Ably recommends a maximum of 20 members simultaneously streaming their cursors in a space at any one time for an optimal end-user experience.
</Aside>

## Set cursor position 

Set the position of a member's cursor using the [`set()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Cursors.html#set) method. A position must contain an X-axis value and a Y-axis value to set the cursor position on a 2D plane. Calling `set()` will emit a cursor event so that other members are informed of the cursor movement in realtime.

A member must have been [entered](https://ably.com/docs/spaces/space.md#enter) into the space to set their cursor position.

The `set()` method takes the following parameters:

| Parameter | Description | Type |
| --------- | ----------- | ---- |
| position.x | The position of the member's cursor on the X-axis. | Number |
| position.y | The position of the member's cursor on the Y-axis. | Number |
| data | An optional arbitrary JSON-serializable object containing additional information about the cursor, such as a color. | Object |

<Aside data-type='note'>
The `data` parameter can be used to stream additional information related to a cursor's movement, such as:

* The color that other members should display a cursor as.
* The ID of an element that a user may be dragging for drag and drop functionality.
* Details of any cursor annotations.

Be aware that as live cursor updates are batched it is not advisable to publish data unrelated to cursor position in the `data` parameter. Use a [pub/sub channel](https://ably.com/docs/channels.md) instead.
</Aside>

The following is an example of a member setting their cursor position by adding an event listener to obtain their cursor coordinates and then publishing their position using the `set()` method:

<Code>

### Javascript

```
window.addEventListener('mousemove', ({ clientX, clientY }) => {
  space.cursors.set({ position: { x: clientX, y: clientY }, data: { color: 'red' } });
});
```
</Code>

## Subscribe to cursor events 

Subscribe to cursor events by registering a listener. Cursor events are emitted whenever a member moves their cursor by calling `set()`. Use the [`subscribe()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Cursors.html#subscribe) method on the `cursors` object of a space to receive updates.

<Aside data-type='note'>
The rate at which cursor events are published is controlled by the `outboundBatchInterval` property set in the [cursor options](#options) of a space.
</Aside>

The following is an example of subscribing to cursor events:

<Code>

### Javascript

```
space.cursors.subscribe('update', (cursorUpdate) => {
  console.log(cursorUpdate);
});
```
</Code>

The following is an example payload of a cursor event. Cursor events are uniquely identifiable by the `connectionId` of a cursor.

<Code>

### Json

```
{
  "hd9743gjDc": {
    "connectionId": "hd9743gjDc",
    "clientId": "clemons#142",
    "position": {
      "x": 864,
      "y": 32
    },
    "data": {
      "color": "red"
    }
  }
}
```
</Code>

The following are the properties of a cursor event payload:

| Property | Description | Type |
| -------- | ----------- | ---- |
| connectionId | The unique identifier of the member's [connection](https://ably.com/docs/connect.md). | String |
| clientId | The [client identifier](https://ably.com/docs/auth/identified-clients.md) for the member. | String |
| position | An object containing the position of a member's cursor. | Object |
| position.x | The position of the member's cursor on the X-axis. | Number |
| position.y | The position of the member's cursor on the Y-axis. | Number |
| data | An optional arbitrary JSON-serializable object containing additional information about the cursor. | Object |

### Unsubscribe from cursor events 

Unsubscribe from cursor events to remove previously registered listeners.

The following is an example of removing a listener for cursor update events:

<Code>

#### Javascript

```
space.cursors.unsubscribe(`update`, listener);
```
</Code>

Or remove all listeners:

<Code>

#### Javascript

```
space.cursors.unsubscribe();
```
</Code>

## Cursor options 

Cursor options are set when creating or retrieving a `Space` instance. They are used to control the behavior of live cursors.

### outboundBatchInterval 

The `outboundBatchInterval` is the interval at which a batch of cursor positions are published, in milliseconds, for each client. This interval increases as the number of members in a space grows, adjusting based on groups of 100 members.

The default value is 25ms which is optimal for the majority of use cases. If you wish to optimize the interval further, then decreasing the value will improve performance by further 'smoothing' the movement of cursors at the cost of increasing the number of events sent. Be aware that at a certain point the rate at which a browser is able to render the changes will impact optimizations.

### paginationLimit 

The volume of messages sent can be high when using live cursors. Because of this, the last known position of every members' cursor is obtained from [history](https://ably.com/docs/storage-history/history.md). The `paginationLimit` is the number of pages that should be searched to find the last position of each cursor. The default is 5.

## Retrieve cursors 

Cursor positions can be retrieved in one-off calls. These are local calls that retrieve the latest position of cursors retained in memory by the SDK.

The following is an example of retrieving a member's own cursor position:

<Code>

### Javascript

```
const myCursor = await space.cursors.getSelf();
```
</Code>

The following is an example payload returned by [`space.cursors.getSelf()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Cursors.html#getSelf):

<Code>

### Json

```
{
  “clientId”: “DzOBJqgGXzyUBb816Oa6i”,
  “connectionId”: “__UJBKZchX”,
  "position": {
    "x": 864,
    "y": 32
  }
}
```
</Code>

The following is an example of retrieving the cursor positions for all members other than the member themselves:

<Code>

### Javascript

```
const othersCursors = await space.cursors.getOthers();
```
</Code>

The following is an example payload returned by [`space.cursors.getOthers()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Cursors.html#getOthers):

<Code>

### Json

```
{
  "3ej3q7yZZz": {
      "clientId": "yyXidHatpP3hJpMpXZi8W",
      "connectionId": "3ej3q7yZZz",
      "position": {
        "x": 12,
        "y": 3
      }
  },
  "Z7CA3-1vlR": {
      "clientId": "b18mj5B5hm-govdFEYRyb",
      "connectionId": "Z7CA3-1vlR",
      "position": {
        "x": 502,
        "y": 43
      }
  }
}
```
</Code>

The following is an example of retrieving the cursor positions for all members, including the member themselves. `getAll()` is useful for retrieving the initial position of members' cursors.

<Code>

### Javascript

```
const allCursors = await space.cursors.getAll();
```
</Code>

The following is an example payload returned by [`space.cursors.getAll()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Cursors.html#getAll):

<Code>

### Json

```
{
  "3ej3q7yZZz": {
      "clientId": "yyXidHatpP3hJpMpXZi8W",
      "connectionId": "3ej3q7yZZz",
      "position": {
        "x": 12,
        "y": 3
      }
  },
  "Z7CA3-1vlR": {
      "clientId": "b18mj5B5hm-govdFEYRyb",
      "connectionId": "Z7CA3-1vlR",
      "position": {
        "x": 502,
        "y": 43
      }
  },
  "__UJBKZchX": {
      “clientId”: “DzOBJqgGXzyUBb816Oa6i”,
      “connectionId”: “__UJBKZchX”,
      "position": {
        "x": 864,
        "y": 32
      }
  }
}
```
</Code>

## Example usage 

The following is an example of the steps involved in implementing live cursors.

<Aside data-type='note'>
There is also an [interactive example](https://examples.ably.dev/live-cursors) demonstrating the functionality of live cursors and a [demo slideshow application](https://space.ably.dev/) available that highlights all the features of the Spaces SDK.
</Aside>

<Code>

### Javascript

```
import Spaces from '@ably/spaces';
import { Realtime } from 'ably';

// Import your custom logic for handling live cursors
import { renderCursor } from '/src/own-logic';

// Create an Ably client
const client = new Realtime({ authUrl: '<authEndpoint>', clientId: '<clientId>' });

// Initialize the Spaces SDK using the Ably client
const spaces = new Spaces(client);

// Create a new space
const space = await spaces.get('board-presentation');

// Enter the space to become a member, passing a nickname
await space.enter({ name: 'Helmut' });

// Listen for cursor updates from members
space.cursors.subscribe('update', async (cursorUpdate) => {
  // Use getAll() and filter by the member that moved their cursor to only update the position of that member's cursor
  const members = await space.members.getAll();
  const member = members.find((member) => member.connectionId === cursorUpdate.connectionId);
  renderCursor(cursorUpdate, member);
});

// Publish the member's cursor position
window.addEventListener('mousemove', ({ clientX, clientY }) => {
  space.cursors.set({ position: { x: clientX, y: clientY } });
});
```
</Code>

## Live cursor foundations 

The Spaces SDK is built upon existing Ably functionality available in Ably's Core SDKs. Understanding which core features are used to provide the abstractions in the Spaces SDK enables you to manage space state and build additional functionality into your application.

Live cursors build upon the functionality of the Ably Pub/Sub [presence](https://ably.com/docs/presence-occupancy/presence.md) feature.

Due to the high frequency at which updates are streamed for cursor movements, live cursors utilizes its own [channel](https://ably.com/docs/channels.md). The other features of the Spaces SDK, such as avatar stacks, member locations and component locking all share a single channel. For this same reason, cursor position updates are not included in the [space state](https://ably.com/docs/spaces/space.md) and may only be subscribed to on the `cursors` namespace.

<Aside data-type='usp'>
Built for high-frequency updates

Live cursors can generate a high volume of events as multiple members move simultaneously. Ably's infrastructure maintains [50% capacity headroom](https://ably.com/docs/platform/architecture/infrastructure-operations.md#resource-implications), absorbing these bursts without degradation or pre-provisioning.
</Aside>

The channel is only created when a member calls `space.cursors.set()`. The live cursors channel object can be accessed through `space.cursors.channel`. To monitor the [underlying state of the cursors channel](https://ably.com/docs/channels/states.md), the channel object can be accessed through `space.cursors.channel`.

## Related Topics

- [Space](https://ably.com/docs/spaces/space.md): A space is a virtual area of your application in which realtime collaboration between users can take place.
- [Avatar stack](https://ably.com/docs/spaces/avatar.md): Avatar stacks display the online status of members in a space.
- [Member location](https://ably.com/docs/spaces/locations.md): Member location displays where users are within a space.
- [Component locking](https://ably.com/docs/spaces/locking.md): Component locking enables members to lock UI components before editing them to reduce the chances of conflicting changes being made.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
