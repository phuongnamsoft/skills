# React Hooks

Incorporate Spaces into your React application with idiomatic and user-friendly React Hooks.

This package enables you to:

* Interact with Ably [Spaces](https://ably.com/docs/spaces.md) using a React Hook
* Subscribe to [events](https://ably.com/docs/spaces/avatar.md#events) in a space
* Retrieve the [membership](https://ably.com/docs/spaces/space.md) of a space
* Set the [location](https://ably.com/docs/spaces/locations.md) of space members
* Acquire [locks](https://ably.com/docs/spaces/locking.md) on components within a space
* Set the position of [members' cursors](https://ably.com/docs/spaces/cursors.md) in a space

The following hooks are available:

| Hook | Description |
| ---- | ----------- |
| [`useSpace`](#useSpace) | The `useSpace` hook lets you subscribe to the current Space, receive Space state events, and get the current Space instance. |
| [`useMembers`](#useMembers) | The `useMembers` hook is useful in building avatar stacks. Using `useMembers`, you can retrieve space members. |
| [`useLocations`](#useLocations) | The `useLocations` hook lets you subscribe to location events. Location events are emitted whenever a member changes location. |
| [`useLocks`](#useLocks) | The `useLocks` hook lets you subscribe to lock events by registering a listener. Lock events are emitted whenever the lock state transitions into `locked` or `unlocked`. |
| [`useLock`](#useLock) | The `useLock` hook returns the status of a lock and, if it has been acquired, the member holding the lock. |
| [`useCursors`](#useCursors) | The `useCursors` hook allows you to track a member's pointer position updates across an application. |

Spaces hooks are client-side oriented. If you employ server-side rendering, ensure components using these hooks render only on the client-side.

## Install 

<Code>

### Shell

```
npm install ably @ably/spaces
```
</Code>

<Aside data-type='note'>
React version 16.8.0 or above is required.
</Aside>

## Authenticate 

An [API key](https://ably.com/docs/auth.md#api-keys) is required to authenticate with Ably. API keys are used either to authenticate directly with Ably using [basic authentication](https://ably.com/docs/auth/basic.md), or to generate tokens for untrusted clients using [token authentication](https://ably.com/docs/auth/token.md).

[Sign up](https://ably.com/sign-up) to Ably to create an API key in the [dashboard](https://ably.com/dashboard) or use the [Control API](https://ably.com/docs/platform/account/control-api.md) to create an API programmatically.

<Aside data-type='important'>
The examples use [basic authentication](https://ably.com/docs/auth/basic.md) to demonstrate usage for convenience. In your own applications, basic authentication should never be used on the client-side as it exposes your Ably API key. Instead use [token authentication](https://ably.com/docs/auth/token.md).
</Aside>

## Usage 

### Setting up the Spaces Provider 

Use the `SpacesProvider` component to connect to Ably. The `SpacesProvider` should wrap every component that needs to access Spaces.

<Code>

#### React

```
import { Realtime } from "ably";
import Spaces from "@ably/spaces";
import { SpacesProvider, SpaceProvider } from "@ably/spaces/react";

const ably = new Realtime({ key: "your-api-key", clientId: 'clemons' });
const spaces = new Spaces(ably);

root.render(
  <SpacesProvider client={spaces}>
    <SpaceProvider name="my-space">
      <App />
    </SpaceProvider>
  </SpacesProvider>
)
```
</Code>

### useSpace 

The `useSpace` hook enables you to subscribe to the current [Space](https://ably.com/docs/spaces/space.md), receive Space state events, and get the current Space instance.

<Code>

#### React

```
const { space } = useSpace((update) => {
  console.log(update);
});
```
</Code>

### useMembers 

`useMembers` is used to build [avatar stacks](https://ably.com/docs/spaces/avatar.md). It retrieves members of the space, including members that have recently left the space, but have not yet been removed.

<Code>

#### React

```
const { self, others, members } = useMembers();
```
</Code>

- `self` - a member’s own member object
- `others` - an array of member objects for all members other than the member themselves
- `members` - an array of all member objects, including the member themselves

`useMembers` also enables you to subscribe to members entering, leaving, and being removed from the Space (after a timeout), as well as when a member updates their [profile information](https://ably.com/docs/spaces/space.md#update-profile).

<Code>

#### React

```
// Subscribe to all member events in a space
useMembers((memberUpdate) => {
  console.log(memberUpdate);
});

// Subscribe to member enter events only
useMembers('enter', (memberJoined) => {
  console.log(memberJoined);
});

// Subscribe to member leave events only
useMembers('leave', (memberLeft) => {
  console.log(memberLeft);
});

// Subscribe to member remove events only
useMembers('remove', (memberRemoved) => {
  console.log(memberRemoved);
});

// Subscribe to profile updates on members only
useMembers('updateProfile', (memberProfileUpdated) => {
  console.log(memberProfileUpdated);
});

// Subscribe to all updates to members
useMembers('update', (memberUpdate) => {
  console.log(memberUpdate);
});
```
</Code>

### useLocations 

`useLocations` enables you to subscribe to [location](https://ably.com/docs/spaces/locations.md) events. Location events are emitted whenever a member changes location.

<Code>

#### React

```
useLocations((locationUpdate) => {
  console.log(locationUpdate);
});
```
</Code>

`useLocations` also enables you to update the current member location using the `update` method provided by the hook. For example:

<Code>

#### React

```
const { update } = useLocations((locationUpdate) => {
  console.log(locationUpdate);
});
```
</Code>

### useLocks 

`useLocks` enables you to subscribe to [lock](https://ably.com/docs/spaces/locking.md) events by registering a listener. Lock events are emitted whenever a lock transitions into the `locked` or `unlocked` state.

<Code>

#### React

```
useLocks((lockUpdate) => {
  console.log(lockUpdate);
});
```
</Code>

### useLock 

`useLock` returns the status of a [lock](https://ably.com/docs/spaces/locking.md) and, if the lock has been acquired, the member holding that lock.

<Code>

#### React

```
const { status, member } = useLock('my-lock');
```
</Code>

### useCursors 

`useCursors` enables you to track a member's [cursor](https://ably.com/docs/spaces/cursors.md) position and provide a view of all members' cursors within a space. For example:

<Code>

#### React

```
// Subscribe to events published on "mousemove" by all members
const { set } =  useCursors((cursorUpdate) => {
  console.log(cursorUpdate);
});

useEffect(() => {
  // Publish a your cursor position on "mousemove" including optional data
  const eventListener = ({ clientX, clientY }) => {
    set({ position: { x: clientX, y: clientY }, data: { color: 'red' } });
  }

  window.addEventListener('mousemove', eventListener);

  return () => {
    window.removeEventListener('mousemove', eventListener);
  };
});
```
</Code>

If you provide `{ returnCursors: true }` as an option you can retrieve active members' cursors:

<Code>

#### React

```
const { cursors } =  useCursors((cursorUpdate) => {
  console.log(cursorUpdate);
}, { returnCursors: true });
```
</Code>

### Error handling 

[`useSpace`](#useSpace), [`useMembers`](#useMembers), [`useLocks`](#useLocks), and [`useCursors`](#useCursors) return [connection](https://ably.com/docs/connect.md) and [channel](https://ably.com/docs/channels.md) errors you may encounter, so that you can handle them within your components. This may include when a client doesn't have permission to attach to a channel, or if it loses its connection to Ably.

<Code>

#### React

```
const { connectionError, channelError } = useMembers();

if (connectionError) {
  // TODO: handle connection errors
} else if (channelError) {
  // TODO: handle channel errors
} else {
  return <SpacesPoweredComponent />
}
```
</Code>

## Related Topics

- [SDK setup](https://ably.com/docs/spaces/setup.md): Install, authenticate and instantiate the Spaces SDK.
- [Authentication](https://ably.com/docs/spaces/authentication.md): Configure authentication for Spaces applications with the required capabilities.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
