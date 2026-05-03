# Space

A space is a virtual area of your application in which realtime collaboration between users can take place. You can have any number of virtual spaces within an application, with a single space being anything from a web page, a sheet within a spreadsheet, an individual slide in a slideshow, or the entire slideshow itself.

The following features can be implemented within a space:

* [Avatar stack](https://ably.com/docs/spaces/avatar.md)
* [Member location](https://ably.com/docs/spaces/locations.md)
* [Live cursors](https://ably.com/docs/spaces/cursors.md)
* [Component locking](https://ably.com/docs/spaces/locking.md)

The `space` namespace consists of a state object that represents the realtime status of all members in a given virtual space. This includes a list of which members are currently online or have recently left and each member's location within the application. The position of members' cursors are excluded from the space state due to their high frequency of updates. The UI components that members have locked are also excluded from the space state.

Space state can be [subscribed](#subscribe) to in the `space` namespace. Alternatively, subscription listeners can be registered for individual features, such as avatar stack events and member location updates. These individual subscription listeners are intended to provide flexibility when implementing collaborative features. Individual listeners are client-side filtered events, so irrespective of whether you choose to subscribe to the space state or individual listeners, each event only counts as a single message.

To subscribe to any events in a space, you first need to create or retrieve a space.

## Create or retrieve a space 

A `space` object is a reference to a single space and is uniquely identified by its unicode string name. A space is created, or an existing space is retrieved from the `spaces` collection using the [`get()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/default.html#get) method.

The following restrictions apply to space names:

* Avoid starting names with `[` or `:`
* Ensure names aren't empty
* Exclude whitespace and wildcards, such as `*`
* Use the correct case, whether it be uppercase or lowercase

The following is an example of creating a space:

<Code>

### Javascript

```
const space = await spaces.get('board-presentation');
```
</Code>

If a name is not specified when creating or retrieving a space, the request will fail with the error code `10100`.

## Enter a space 

Entering a space will register a client as a member and emit an [`enter`](https://ably.com/docs/spaces/locations.md#subscribe) event to all subscribers. Use the [`enter()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Space.html#enter) method to enter a space.

Being entered into a space is required for members to:

* Update their [profile data](#update-profile).
* Set their [location](https://ably.com/docs/spaces/locations.md).
* Set their [cursor position](https://ably.com/docs/spaces/cursors.md).

The following is an example of entering a space:

<Code>

### Javascript

```
await space.enter();
```
</Code>

If a member has not entered a space and attempts an operation that requires them to be entered then the request will fail with the error code `101001`.

### Leave a space 

Leaving a space will emit a [`leave`](https://ably.com/docs/spaces/locations.md#subscribe) event to all subscribers.

The following is an example of explicitly leaving a space:

<Code>

#### Javascript

```
await space.leave();
```
</Code>

Members will implicitly leave a space after 15 seconds if they abruptly disconnect. If experiencing network disruption, and they reconnect within 15 seconds, then they will remain part of the space and no `leave` event will be emitted.

## Profile data 

Profile data can be set when [entering](#enter) a space. It is optional data that can be used to associate information with a member, such as a preferred username, or profile picture that can be subsequently displayed in their avatar. Profile data can be any arbitrary JSON-serializable object.

Profile data is returned in the payload of all space events.

The following is an example of setting profile data when entering a space:

<Code>

### Javascript

```
await space.enter({
  username: 'Claire Oranges',
  avatar: 'https://slides-internal.com/users/coranges.png',
});
```
</Code>

### Update profile data 

Profile data can be updated at any point after entering a space by calling [`updateProfileData()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Space.html#updateProfileData). This will emit an `updateProfile` event. If a client hasn't yet entered the space, `updateProfileData()` will instead [enter the space](#enter), with the profile data, and emit an `enter` event.

The following is an example of updating profile data:

<Code>

#### Javascript

```
space.updateProfileData({
  username: 'Claire Lemons',
  avatar: 'https://slides-internal.com/users/clemons.png',
});
```
</Code>

A function can be passed to `updateProfileData()` in order to update a field based on the existing profile data:

<Code>

#### Javascript

```
space.updateProfileData(currentProfile => {
  return { ...currentProfile, username: 'Clara Lemons' }
});
```
</Code>

## Subscribe to space state 

Subscribe to space state updates by registering a listener. Use the [`subscribe()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Space.html#subscribe) method on the `space` object to receive updates.

The following events will trigger a space event:

* A member enters the space
* A member leaves the space
* A member is removed from the space state [after the offlineTimeout period](#options) has elapsed
* A member updates their profile data
* A member sets a new location

Space state contains a single object called `members`. Any events that trigger a change in space state will always return the current state of the space as an array of `member` objects.

<Aside data-type='note'>
[Avatar stacks](https://ably.com/docs/spaces/avatar.md) and [member location](https://ably.com/docs/spaces/locations.md) events can be subscribed to on their individual namespaces; `space.members` and `space.locations`. These events are filtered versions of space state events. Only a single [message](https://ably.com/docs/messages.md) is published per event by Ably, irrespective of whether you register listeners for space state or individual namespaces. If you register listeners for both, it is still only a single message.

The key difference between subscribing to space state or to individual feature events is that space state events return the current state of the space as an array of all members in each event payload. Individual member and location event payloads only include the relevant data for the member that triggered the event.
</Aside>

The following is an example of subscribing to space events:

<Code>

### Javascript

```
space.subscribe('update', (spaceState) => {
  console.log(spaceState.members);
});
```
</Code>

The following is an example payload of a space event.

<Code>

### Json

```
[
    {
        "clientId": "clemons#142",
        "connectionId": "hd9743gjDc",
        "isConnected": false,
        "lastEvent": {
          "name": "leave",
          "timestamp": 1677595689759
        },
        "location": null,
        "profileData": {
          "username": "Claire Lemons",
          "avatar": "https://slides-internal.com/users/clemons.png"
        }
    },
    {
        "clientId": "amint#5",
        "connectionId": "hg35a4fgjAs",
        "isConnected": true,
          "lastEvent": {
          "name": "enter",
        "timestamp": 173459567340
        },
        "location": null,
        "profileData": {
          "username": "Arit Mint",
          "avatar": "https://slides-internal.com/users/amint.png"
        }
    },
    ...
]
```
</Code>

The following are the properties of an individual `member` within a space event payload:

| Property | Description | Type |
| -------- | ----------- | ---- |
| clientId | The [client identifier](https://ably.com/docs/auth/identified-clients.md) for the member. | String |
| connectionId | The unique identifier of the member's [connection](https://ably.com/docs/connect.md). | String |
| isConnected | Whether the member is connected to Ably or not. | Boolean |
| profileData | The optional [profile data](#profile-data) associated with the member. | Object |
| location | The current [location](https://ably.com/docs/spaces/locations.md) of the member. | Object |
| lastEvent.name | The most recent event emitted by the member. | String |
| lastEvent.timestamp | The timestamp of the most recently emitted event. | Number |

### Unsubscribe from space events 

Unsubscribe from space events to remove previously registered listeners.

The following is an example of removing a listener:

<Code>

#### Javascript

```
space.unsubscribe('update', listener);
```
</Code>

## Retrieve space state 

The current state of the space can be retrieved in a one-off call. This will return an array of all `member` objects currently in the space. This is a local call and retrieves the membership of the space retained in memory by the SDK.

The following is an example of retrieving the current space state. Ths includes members that have recently left the space, but have not yet been removed:

<Code>

### Javascript

```
const spaceState = await space.getState();
```
</Code>

## Advanced properties 

The following sections are only relevant if you want to further customize a space, or understand more about the Spaces SDK. They aren't required to get up and running with the basics.

### Space options 

An additional set of optional properties may be passed when [creating or retrieving](#create) a space to customize the behavior of different features.

The following properties can be customized:

| Property | Description | Type |
| -------- | ----------- | ---- |
| offlineTimeout   | Number of milliseconds after a member loses connection or closes their browser window to wait before they are removed from the member list. The default is 120,000ms (2 minutes). | Number |
| cursors          | A [cursor options](https://ably.com/docs/spaces/cursors.md#options) object for customizing live cursor behavior. | Object |
| cursors.outboundBatchInterval | The interval, in milliseconds, at which a batch of cursor positions are published. This is multiplied by the number of members in a space, minus 1. The default value is 100ms. | Number |
| cursors.paginationLimit | The number of pages searched from history for the last published cursor position. The default is 5. | Number |

The following is an example of customizing the space options when calling `spaces.get()`:

<Code>

#### Javascript

```
const space = await spaces.get('board-presentation', {
	offlineTimeout: 180_000,
	cursors: { paginationLimit: 10 }
});
```
</Code>

### Space foundations 

The Spaces SDK is built upon existing Ably functionality available in Ably's Core SDKs. Understanding which core features are used to provide the abstractions in the Spaces SDK enables you to manage space state and build additional functionality into your application.

A space is created as an Ably [channel](https://ably.com/docs/channels.md). Members [attach](https://ably.com/docs/channels/states.md#attach) to the channel and join its [presence set](https://ably.com/docs/presence-occupancy/presence.md) when they [enter](#enter) the space. Avatar stacks, member locations, and component locking are all handled on this channel.

To manage the state of the space, you can monitor the [state of the underlying channel](https://ably.com/docs/channels/states.md). The channel object can be accessed through `space.channel`.

The following is an example of registering a listener to wait for a channel to become attached:

<Code>

#### Javascript

```
space.channel.on('attached', (stateChange) => {
  console.log(stateChange)
});
```
</Code>

<Aside data-type='note'>
Due to the high frequency at which updates are streamed for cursor movements, live cursors utilize their own [channel](https://ably.com/docs/channels.md).
</Aside>

## Related Topics

- [Avatar stack](https://ably.com/docs/spaces/avatar.md): Avatar stacks display the online status of members in a space.
- [Member location](https://ably.com/docs/spaces/locations.md): Member location displays where users are within a space.
- [Live cursors](https://ably.com/docs/spaces/cursors.md): Track the positions of cursors within a space.
- [Component locking](https://ably.com/docs/spaces/locking.md): Component locking enables members to lock UI components before editing them to reduce the chances of conflicting changes being made.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
