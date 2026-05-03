# Component locking

The component locking feature enables members to optimistically lock stateful UI components before editing them. This reduces the chances of conflicting changes being made to the same component by different members. A component could be a cell in a spreadsheet that a member is updating, or an input field on a form they're filling in.

Once a lock has been acquired by a member, the component that it relates to can be updated in the UI to visually indicate to other members that it is locked and which member has the lock. The component can then be updated once the editing member has released the lock to indicate that it is now unlocked.

Each lock is identified by a unique string ID, and only a single member may hold a lock with a given string at any one time. A lock will exist in one of three [states](#states) and may only transition between states in specific circumstances.

<Aside data-type='important'>
Optimistic locking means that there is a chance that two members may begin editing the same UI component before it is confirmed which member holds the lock. On average, the time taken to reconcile which member holds a lock is in the hundreds of milliseconds. Your application needs to handle the member that successfully obtained the lock, as well as the member that had their request invalidated.
</Aside>

## Lock states 

Component locking is handled entirely client-side. Members may begin to optimistically edit a component as soon as they call [`acquire()`](#acquire) on the lock identifier related to it. Alternatively, you could wait until they receive a `locked` event and display a spinning symbol in the UI until this is received. In either case, a subsequent `unlocked` event may invalidate that member's lock request if another member acquired it earlier. The time for confirmation of whether a lock request was successful or rejected is, on average, in the hundreds of milliseconds. However, your code should handle all possible lock state transitions.

A lock will be in one of the following states:

| State | Description |
| ----- | ----------- |
| `pending` | A member has requested a lock by calling [`acquire()`](#acquire). |
| `locked` | The lock is confirmed to be held by the requesting member. |
| `unlocked` | The lock is confirmed to not be locked by the requesting member, or has been [released](#release) by a member previously holding the lock. |

The following lock state transitions may occur:

* None → `pending`: a member calls [`acquire()`](#acquire) to request a lock.
* `pending` → `locked`: the requesting member holds the lock.
* `pending` → `unlocked`: the requesting member does not hold the lock, since another member already holds it.
* `locked` → `unlocked`: the lock was either explicitly [released](#release) by the member, or their request was invalidated by a concurrent request which took precedence.
* `unlocked` → `locked`: the requesting member reacquired a lock they previously held.

Only transitions that result in a `locked` or `unlocked` status will emit a lock event that members can [`subscribe()`](#subscribe) to.

<Aside data-type='usp'>
Resilient lock state.

Ably automatically [recovers connections](https://ably.com/docs/platform/architecture/idempotency.md#connection-recovery-and-exactly-once-delivery) when clients briefly disconnect, so members retain their locks without requiring re-acquisition.
</Aside>

## Acquire a lock 

Use the [`acquire()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Locks.html#acquire) method to attempt to acquire a lock with a given unique ID. Additional `attributes` may be passed when trying to acquire a lock that can contain a set of arbitrary key-value pairs. An example of using `attributes` is to store the component ID the lock relates to so that it can be easily updated in the UI with a visual indication of its lock status.

A member must have been [entered](https://ably.com/docs/spaces/space.md#enter) into the space to acquire a lock.

The following is an example of attempting to acquire a lock:

<Code>

### Javascript

```
const acquireLock = await space.locks.acquire(id);
```
</Code>

The following is an example of passing a set of `attributes` when trying to acquire a lock:

<Code>

### Javascript

```
const attributes = { component: 'cell-d3' };
const acquireLock = await space.locks.acquire(id, { attributes });
```
</Code>

The following is an example payload returned by `space.locks.acquire()`. The promise will resolve to a lock request with the `pending` status:

<Code>

### Json

```
{
  "id": "s2-d14",
  "status": "pending",
  "timestamp": 1247525689781,
  "attributes": {
    "componentId": "cell-d14"
  }
}
```
</Code>

Once a member requests a lock by calling `acquire()`, the lock is temporarily in the [pending state](#states). An event will be emitted based on whether the lock request was successful (a status of `locked`) or invalidated (a status of `unlocked`). This can be [subscribed](#subscribe) to in order for the client to know whether their lock request was successful or not.

## Release a lock 

Use the [`release()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Locks.html#release) method to explicitly release a lock once a member has finished editing the related component. For example, the `release()` method can be called once a user clicks outside of the component, such as clicking on another cell within a spreadsheet. Any UI indications that the previous cell was locked can then be cleared.

The following is an example of releasing a lock:

<Code>

### Javascript

```
await space.locks.release(id);
```
</Code>

Releasing a lock will emit a lock event with a [lock status](#states) of `unlocked`.

<Aside data-type='note'>
When a member [leaves](https://ably.com/docs/spaces/space.md#leave) a space, their locks are automatically released.
</Aside>

## Subscribe to lock events 

Subscribe to lock events by registering a listener. Lock events are emitted whenever the [lock state](#states) transitions into `locked` or `unlocked`. Use the [`subscribe()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Locks.html#subscribe) method on the `locks` namespace of the space to receive updates.

All lock events are `update` events. When a lock event is received, UI components can be updated to add and remove visual indications of which member is locking them, as well as enabling and disabling the ability for other members to edit them.

The following is an example of subscribing to lock events:

<Code>

### Javascript

```
space.locks.subscribe('update', (lock) => {
  console.log(lock);
});
```
</Code>

The following is an example payload of a lock event:

<Code>

### Json

```
{
  "id": "s2-d14",
  "status": "unlocked",
  "timestamp": 1247525689781,
  "attributes": {
    "componentId": "cell-d14"
  },
  "reason": {
    "message": "lock is currently locked",
    "code": 101003,
    "statusCode": 400
  },
  "member": {
    "clientId": "smango",
    "connectionId": "hs343gjsdc",
    "isConnected": true,
    "profileData": {
      "username": "Saiorse Mango"
    },
    "location": {
      "slide": "sheet-2",
      "component": "d-14"
    },
    "lastEvent": {
      "name": "update",
      "timestamp": 1247525689781
    }
  }
}
```
</Code>

The following are the properties of a lock event payload:

| Property | Description | Type |
| -------- | ----------- | ---- |
| id | The unique ID of the lock request. | String |
| status | The lock [status](#states) of the event. Will be one of `locked`, `unlocked`, or `pending`. | String |
| timestamp| The timestamp of the lock event. | Number |
| attributes | The optional attributes of the lock, such as the ID of the component it relates to. | Object |
| reason | If set, gives the reason for `status`. Successful lock requests do not set a `reason`. | ErrorInfo |
| member.clientId| The [client identifier](https://ably.com/docs/auth/identified-clients.md) for the member. | String |
| member.connectionId| The unique identifier of the member's [connection](https://ably.com/docs/connect.md). | String |
| member.isConnected | Whether the member is connected to Ably or not. | Boolean |
| member.lastEvent.name| The most recent event emitted by the member. Will be one of `enter`, `update`, `present`, or `leave`. | String |
| member.lastEvent.timestamp | The timestamp of the most recently emitted event.| Number |
| member.profileData | The optional [profile data](https://ably.com/docs/spaces/avatar.md#profile-data) associated with the member. | Object |

The following are the error codes that are returned in the `reason` property:

| Error code | Description |
| ---------- | ----------- |
| 101002 | There is an existing lock request in the `pending` or `locked` state. Nested locks are not supported, so the previous request must be handled before a new lock is requested. |
| 101003 | The lock is currently in the `locked` state, and the `pending` request did not invalidate the status. |
| 101004 | The lock request invalidated an existing lock in the `locked` state. |

### Unsubscribe from lock events 

Unsubscribe from lock events to remove previously registered listeners.

The following is an example of removing a listener for lock update events:

<Code>

#### Javascript

```
space.locks.unsubscribe('update', listener);
```
</Code>

Or remove all listeners:

<Code>

#### Javascript

```
space.locks.unsubscribe();
```
</Code>

## Query lock status 

Use the [`get()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Locks.html#get) method to query whether a lock is currently locked, and by which member if it is. The lock is identifiable by its unique string ID.

The following is an example of checking whether a lock identifier is currently locked:

<Code>

### Javascript

```
const isLocked = space.locks.get(id) !== undefined;
```
</Code>

The following is an example of checking which member holds the lock:

<Code>

### Javascript

```
const { member } = space.locks.get(id);
```
</Code>

The following is an example of viewing the attributes assigned to the lock by the member holding it:

<Code>

### Javascript

```
const lock = space.locks.get(id);
const attributeValue = lock.attributes.get(key);
```
</Code>

If the lock is not currently held by a member, `get()` will return `undefined`. Otherwise, it will return the most recent lock event for the lock.

## Retrieve locks 

Locks can also be retrieved in one-off calls. These are local calls and retrieve the locks retained in memory by the SDK.

The following is an example of retrieving a member's own currently held locks:

<Code>

### Javascript

```
const myLocks = await space.locks.getSelf();
```
</Code>

The following is an example payload returned by [`space.locks.getSelf()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Locks.html#getSelf)

<Code>

### Json

```
{
  "id": "s1-c2",
  "status": "locked",
  "timestamp": 1247525627533,
  "member": {
    "clientId": "amint#5",
    "connectionId": "hg35a4fgjAs",
    "isConnected": true,
    "lastEvent": {
      "name": "update",
      "timestamp": 173459567340
    },
    "location": null,
    "profileData": {
      "username": "Arit Mint",
      "avatar": "https://slides-internal.com/users/amint.png"
    }
  }
}
```
</Code>

The following is an example of retrieving the locks held by all members other than the member themselves:

<Code>

### Javascript

```
const othersLocks = await space.locks.getOthers();
```
</Code>

The following is an example payload returned by [`space.locks.getOthers()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Locks.html#getOthers)

<Code>

### Json

```
[
  {
    "id": "s1-c2",
    "status": "locked",
    "timestamp": 1247525627533,
    "member": {
      "clientId": "dlime#1",
      "connectionId": "s43524ffaAs",
      "isConnected": true,
      "lastEvent": {
        "name": "update",
        "timestamp": 173459567340
      },
      "location": null,
      "profileData": {
        "username": "Dalia Lime",
        "avatar": "https://slides-internal.com/users/dlime.png"
      }
    }
  },
  {
    "id": "s3-c4",
    "status": "locked",
    "timestamp": 1247115627423,
    "member": {
      "clientId": "torange#1",
      "connectionId": "tt7233ghUa",
      "isConnected": true,
      "lastEvent": {
        "name": "update",
        "timestamp": 167759566354
      },
      "location": null,
      "profileData": {
        "username": "Tara Orange",
        "avatar": "https://slides-internal.com/users/torange.png"
      }
    }
  }
]
```
</Code>

The following is an example of retrieving an array of all currently held locks in a space:

<Code>

### Javascript

```
const allLocks = await space.locks.getAll();
```
</Code>

The following is an example payload returned by [`space.locks.getAll()`](https://sdk.ably.com/builds/ably/spaces/main/typedoc/classes/Locks.html#getAll)

<Code>

### Json

```
[
  {
    "id": "s1-c2",
    "status": "locked",
    "timestamp": 1247525627533,
    "member": {
      "clientId": "amint#5",
      "connectionId": "hg35a4fgjAs",
      "isConnected": true,
      "lastEvent": {
        "name": "update",
        "timestamp": 173459567340
      },
      "location": null,
      "profileData": {
        "username": "Arit Mint",
        "avatar": "https://slides-internal.com/users/amint.png"
      }
    }
  },
  {
    "id": "s3-c4",
    "status": "locked",
    "timestamp": 1247115627423,
    "member": {
      "clientId": "torange#1",
      "connectionId": "tt7233ghUa",
      "isConnected": true,
      "lastEvent": {
        "name": "update",
        "timestamp": 167759566354
      },
      "location": null,
      "profileData": {
        "username": "Tara Orange",
        "avatar": "https://slides-internal.com/users/torange.png"
      }
    }
  }
]
```
</Code>

## Example usage 

The following is an example of the steps involved in implementing component locking.

<Aside data-type='note'>
There is also an [interactive example](https://examples.ably.dev/component-locking) demonstrating the functionality of component locking and a [demo slideshow application](https://space.ably.dev/) available that highlights all the features of the Spaces SDK.
</Aside>

<Code>

### Javascript

```
import Spaces from '@ably/spaces';
import { Realtime } from 'ably';

// Import your custom logic for handling lock updates
import updateLocks from '/src/own-logic';

// Create an Ably client
const client = new Realtime({ authUrl: '<authEndpoint>', clientId: '<clientId>' });

// Initialize the Spaces SDK using the Ably client
const spaces = new Spaces(client);

// Create a new space
const space = await spaces.get('accounts-sheet');

// Enter the space to become a member, passing a nickname
await space.enter({ name: 'Luigi' });

// Check if a UI component is locked
const isLocked = space.locks.get('s2-d4');

// Request to acquire a lock on the UI component if it isn't already locked
if (!isLocked) {
  await space.locks.acquire('s2-d4', {'sheet': '2', 'cellId': 'd4'});
}

// Listen to lock event updates
space.locks.subscribe('update', async (lock) => {
  const self = await space.members.getSelf();
  // Check if a member holds the lock for a component and enable them to edit it if they do
  if (lock.status === LockStatus.LOCKED && self.connectionId === lock.member.connectionId) {
    const location = {
      sheet: lock.attributes.get('sheet'),
      cellId: lock.attributes.get('cellId'),
    };
    enableLocationEditing({ location });
  }
});
```
</Code>

## Related Topics

- [Space](https://ably.com/docs/spaces/space.md): A space is a virtual area of your application in which realtime collaboration between users can take place.
- [Avatar stack](https://ably.com/docs/spaces/avatar.md): Avatar stacks display the online status of members in a space.
- [Member location](https://ably.com/docs/spaces/locations.md): Member location displays where users are within a space.
- [Live cursors](https://ably.com/docs/spaces/cursors.md): Track the positions of cursors within a space.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
