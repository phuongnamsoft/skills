# Member location

The member location feature enables you to track where members are within a space, to see which part of your application they're interacting with. A location could be the form field they have selected, the cell they're currently editing in a spreadsheet, or the slide they're viewing within a slide deck. Multiple members can be present in the same location.

Member locations are used to visually display which component other members currently have selected, or are currently active on. Events are emitted whenever a member sets their location, such as when they click on a new cell, or slide. Events are received by members subscribed to location events and the UI component can be highlighted with the active member's profile data to visually display their location.

## Set member location 

Use the [`set()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Locations.html#set) method to emit a location event in realtime when a member changes their location. This will be received by all location subscribers to inform them of the location change. A `location` can be any JSON-serializable object, such as a slide number or element ID.

A member must have been [entered](https://ably.com/docs/spaces/space.md#enter) into the space to set their location.

The `set()` method is commonly combined with [`addEventListener()`](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener) or a React [synthetic event](https://react.dev/learn/responding-to-events#adding-event-handlers), such as `onClick` or `onHover`.

The following is an example of a member setting their location to a specific slide number, and element on that slide:

<Code>

### Javascript

```
await space.locations.set({ slide: '3', component: 'slide-title' });
```
</Code>

## Subscribe to location events 

Subscribe to location events by registering a listener. Location events are emitted whenever a member changes location by calling [`set()`](#set). Use the [`subscribe()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Locations.html#subscribe) method on the `locations` namespace of the space to receive updates.

All location changes are `update` events. When a location update is received, clear the highlight from the UI component of the member's `previousLocation` and add it to `currentLocation`.

<Aside data-type='note'>
A location update is also emitted when a member is [removed](https://ably.com/docs/spaces/avatar.md#events) from a space. The member's `currentLocation` will be `null` for these events so that any UI component highlighting can be cleared.
</Aside>

The following is an example of subscribing to location events:

<Code>

### Javascript

```
space.locations.subscribe('update', (locationUpdate) => {
  console.log(locationUpdate);
});
```
</Code>

The following is an example payload of a location event. Information about location is returned in `currentLocation` and `previousLocation`:

<Code>

### Json

```
{
  "member": {
    "clientId": "clemons#142",
    "connectionId": "hd9743gjDc",
    "isConnected": true,
    "profileData": {
      "username": "Claire Lemons",
      "avatar": "https://slides-internal.com/users/clemons.png"
    },
    "location": {
      "slide": "3",
      "component": "slide-title"
    },
    "lastEvent": {
      "name": "update",
      "timestamp": 1972395669758
    }
  },
  "previousLocation": {
    "slide": "2",
    "component": null
  },
  "currentLocation": {
    "slide": "3",
    "component": "slide-title"
  }
}
```
</Code>

The following are the properties of a location event payload:

| Property | Description | Type |
| -------- | ----------- | ---- |
| member.clientId| The [client identifier](https://ably.com/docs/auth/identified-clients.md) for the member. | String |
| member.connectionId| The unique identifier of the member's [connection](https://ably.com/docs/connect.md). | String |
| member.isConnected | Whether the member is connected to Ably or not.| Boolean |
| member.lastEvent.name| The most recent event emitted by the member. Will be one of `enter`, `update`, `present`, or `leave`. | String |
| member.lastEvent.timestamp | The timestamp of the most recently emitted event.| Number |
| member.profileData | The optional [profile data](https://ably.com/docs/spaces/avatar.md#profile-data) associated with the member. | Object |
| previousLocation | The previous location of the member. | Object |
| currentLocation| The new location of the member.| Object |

<Aside data-type='further-reading'>
Member location subscription listeners only trigger on events related to members' locations. Each event only contains the payload of the member that triggered it. Alternatively, [space state](https://ably.com/docs/spaces/space.md) can be subscribed to which returns an array of all members with their latest state every time any event is triggered.
</Aside>

### Unsubscribe from location events 

Unsubscribe from location events to remove previously registered listeners.

The following is an example of removing a listener for location update events:

<Code>

#### Javascript

```
space.locations.unsubscribe('update', listener);
```
</Code>

Or remove all listeners:

<Code>

#### Javascript

```
space.locations.unsubscribe();
```
</Code>

## Retrieve member locations 

Member locations can also be retrieved in one-off calls. These are local calls and retrieve the location of members retained in memory by the SDK.

<Aside data-type='usp'>
Instant location awareness.

Ably delivers location updates with a [global median latency of 37ms](https://ably.com/docs/platform/architecture/latency.md), ensuring members see each other's location changes nearly instantaneously for a seamless collaborative experience.
</Aside>

The following is an example of retrieving a member's own location:

<Code>

### Javascript

```
const myLocation = await space.locations.getSelf();
```
</Code>

The following is an example payload returned by [`space.locations.getSelf()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Locations.html#getSelf). It will return the properties of the member's location:

<Code>

### Json

```
{
  "slide": "3",
  "component": "slide-title"
}
```
</Code>

The following is an example of retrieving the location objects of all members other than the member themselves:

<Code>

### Javascript

```
const othersLocations = await space.locations.getOthers();
```
</Code>

The following is an example payload returned by [`space.locations.getOthers()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Locations.html#getOthers). It will return the properties of all member's location by their `connectionId`:

<Code>

### Json

```
{
  "xG6H3lnrCn": {
      "slide": "1",
      "component": "textBox-1"
  },
  "el29SVLktW": {
      "slide": "1",
      "component": "image-2"
  }
}
```
</Code>

The following is an example of retrieving the location objects of all members, including the member themselves:

<Code>

### Javascript

```
const allLocations = await space.locations.getAll();
```
</Code>

The following is an example payload returned by [`space.locations.getAll()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Locations.html#getAll). It will return the properties of all member's location by their `connectionId`:

<Code>

### Json

```
{
  "xG6H3lnrCn": {
      "slide": "1",
      "component": "textBox-1"
  },
  "el29SVLktW": {
      "slide": "1",
      "component": "image-2"
  },
  "dieF3291kT": {
      "slide": "3",
      "component": "slide-title"
  }
}
```
</Code>

## Example usage 

The following is an example of the steps involved in implementing member locations.

<Aside data-type='note'>
There is also an [interactive example](https://examples.ably.dev/member-location) demonstrating the functionality of member locations and a [demo slideshow application](https://space.ably.dev/) available that highlights all the features of the Spaces SDK.
</Aside>

<Code>

### Javascript

```
import Spaces from '@ably/spaces';
import { Realtime } from 'ably';

// Import your custom logic for handling member location updates
import updateLocations from '/src/own-logic';

// Create an Ably client
const client = new Realtime({ authUrl: '<authEndpoint>', clientId: '<clientId>' });

// Initialize the Spaces SDK using the Ably client
const spaces = new Spaces(client);

// Create a new space
const space = await spaces.get('board-presentation');

// Enter the space to become a member, passing a nickname
await space.enter({ name: 'Amelie' });

// Listen to member location updates
space.locations.subscribe('update', ({ member, currentLocation, previousLocation }) => {
  // Update the UI to reflect member locations when receiving an update by adding a highlight to their currentLocation and removing the one from their previousLocation
  updateLocations(member, currentLocation, previousLocation);
});

// Publish the member's location
await space.locations.set({ slide: 0, elementId: 'title' });
```
</Code>

## Member location foundations 

The Spaces SDK is built upon existing Ably functionality available in Ably's Core SDKs. Understanding which core features are used to provide the abstractions in the Spaces SDK enables you to manage space state and build additional functionality into your application.

Member locations build upon the functionality of the Ably Pub/Sub [presence](https://ably.com/docs/presence-occupancy/presence.md) feature. Members are entered into the presence set when they [enter the space](https://ably.com/docs/spaces/space.md#enter).

## Related Topics

- [Space](https://ably.com/docs/spaces/space.md): A space is a virtual area of your application in which realtime collaboration between users can take place.
- [Avatar stack](https://ably.com/docs/spaces/avatar.md): Avatar stacks display the online status of members in a space.
- [Live cursors](https://ably.com/docs/spaces/cursors.md): Track the positions of cursors within a space.
- [Component locking](https://ably.com/docs/spaces/locking.md): Component locking enables members to lock UI components before editing them to reduce the chances of conflicting changes being made.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
