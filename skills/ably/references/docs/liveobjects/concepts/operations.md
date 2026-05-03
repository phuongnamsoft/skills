# Operations

<If lang="javascript">
  <Aside data-type='note'>
  **Building with LiveObjects?** Help shape its future by [sharing your use case](https://44qpp.share.hsforms.com/2fZobHQA1ToyRfB9xqZYQmQ).
  </Aside>
</If>
<If lang="swift">
  <Aside data-type='experimental'>
  LiveObjects Swift is currently Experimental. Its features are still in development and subject to rapid change.

  **Building with LiveObjects?** Help shape its future by [sharing your use case](https://44qpp.share.hsforms.com/2fZobHQA1ToyRfB9xqZYQmQ).
  </Aside>
</If>
<If lang="java">
  <Aside data-type='experimental'>
  LiveObjects Java is currently Experimental. Its features are still in development and subject to rapid change.

  **Building with LiveObjects?** Help shape its future by [sharing your use case](https://44qpp.share.hsforms.com/2fZobHQA1ToyRfB9xqZYQmQ).
  </Aside>
</If>

LiveObjects operations define how object data is updated and synchronized across multiple clients.

When you create or update an object, the change is expressed as an _operation_ that is sent as an [object message](https://ably.com/docs/metadata-stats/stats.md#messages) on the channel. The operation is then applied to the object instance on all clients that are subscribed to the channel.

This document explains the key concepts you need to know when working with operations.

<Aside data-type='usp'>
Exactly-once delivery

Ably's platform guarantees [idempotent publishing](https://ably.com/docs/platform/architecture/idempotency.md), ensuring that each operation is applied exactly once across all subscribers — even if the publishing client retries due to network issues.
</Aside>

## Operation types 

Each object type supports specific operations that modify the object's data.

### LiveMap operations 

[LiveMap](https://ably.com/docs/liveobjects/map.md) supports the following operations:

* `set`: Set a value for a key
* `remove`: Remove a key and its value

The value of an entry in a `LiveMap` instance can be a [primitive type](https://ably.com/docs/liveobjects/concepts/objects.md#primitive-types) or a [reference](https://ably.com/docs/liveobjects/concepts/objects.md#composability) to another object.

<Code>

#### Javascript

```
await myObject.get('user').set('username', 'alice');
await myObject.get('user').remove('status');
```

#### Swift

```
// Set a value for a key
try await map.set(key: "username", value: "alice")

// Remove a key
try await map.remove(key: "username")
```

#### Java

```
// Set a value for a key
map.set("username", LiveMapValue.of("alice"));

// Remove a key
map.remove("username");
```
</Code>

### LiveCounter operations 

[LiveCounter](https://ably.com/docs/liveobjects/counter.md) supports the following operations:

* `increment`: Increment the counter by a specified amount
* `decrement`: Decrement the counter by a specified amount

The amount is a double-precision floating-point number, which is the same as underlying type of a [LiveCounter](https://ably.com/docs/liveobjects/concepts/objects.md#livecounter) value.

<Aside data-type='note'>
The `decrement` operation is just syntactic sugar for `increment` with a negative amount.
</Aside>

<Code>

#### Javascript

```
await myObject.get('visits').increment(5);
await myObject.get('score').decrement(2);
```

#### Swift

```
// Increment counter by 5
try await counter.increment(amount: 5)

// Decrement counter by 2
try await counter.decrement(amount: 2)
```

#### Java

```
// Increment counter by 5
counter.increment(5);

// Decrement counter by 2
counter.decrement(2);
```
</Code>

### Create operations 

Create operations are used to instantiate new objects of a given type.

<If lang="javascript">
Use `LiveMap.create()` and `LiveCounter.create()` to create new objects. These methods create special value types that can be assigned directly to paths:

<Code>

#### Javascript

```
// Create and assign a map with initial values
await myObject.set('user', LiveMap.create({
  username: 'alice',
  status: 'online'
}));

// Create and assign a counter with initial value
await myObject.set('score', LiveCounter.create(100));

// Create nested structures
await myObject.set('profile', LiveMap.create({
  name: 'Alice',
  score: LiveCounter.create(0),
  settings: LiveMap.create({
    theme: 'dark',
    notifications: true
  })
}));
```
</Code>

When a create operation is processed, an [object ID](https://ably.com/docs/liveobjects/concepts/objects.md#object-ids) is automatically generated for the new object instance.

<Aside data-type='note'>
Objects created with `LiveMap.create()` and `LiveCounter.create()` are automatically [reachable](https://ably.com/docs/liveobjects/concepts/objects.md#reachability) when you assign them to a path. You don't need to worry about [orphaned objects](https://ably.com/docs/liveobjects/lifecycle.md#objects-deleted) unless you explicitly remove them from the tree and you have retained an `Instance` for the now-unreachable object.
</Aside>
</If>

<If lang="swift,java">
A create operation can optionally specify an initial value for the object.

<Code>

#### Swift

```
// Create a map with initial values
let userMap = try await channel.objects.createMap(entries: [
    "username": "alice",
    "status": "online",
])

// Create a counter with initial value
let scoreCounter = try await channel.objects.createCounter(count: 100)
```

#### Java

```
// Create a map with initial values
Map<String, LiveMapValue> entries = Map.of(
    "username", LiveMapValue.of("alice"),
    "status", LiveMapValue.of("online")
);
LiveMap userMap = channel.getObjects().createMap(entries);

// Create a counter with initial value
LiveCounter scoreCounter = channel.getObjects().createCounter(100);
```
</Code>

When a create operation is processed, an [object ID](https://ably.com/docs/liveobjects/concepts/objects.md#object-ids) for the new object instance is automatically generated for the object.

<Aside data-type='important'>
Newly created objects are not automatically [reachable](https://ably.com/docs/liveobjects/concepts/objects.md#reachability) from the <If lang="javascript">channel object</If><If lang="swift,java">root object</If>. You must explicitly add them to the object tree to prevent garbage collection.
</Aside>
</If>

## Object IDs 

Every operation is expressed relative to a specific object instance, identified by its [object ID](https://ably.com/docs/liveobjects/concepts/objects.md#object-ids), which determines which object the operation is applied to.

<If lang="javascript">
When using a `PathObject`, the specific object instance at the given path is evaluated at the time a method is called that updates the object. The client library will then publish an operation targeting the resolved object.
</If>

When using a client library object IDs are handled automatically, allowing you work directly with object references:

<Code>

### Javascript

```
// The published operation targets the object ID of the object at 'user'
await myObject.get('user').set('username', 'alice');

// Get the specific instance and its ID
const userInstance = myObject.get('user').instance();
if (userInstance) {
  console.log('Object ID:', userInstance.id());
  await userInstance.set('username', 'alice');
}
```

### Swift

```
// The published operation targets the object ID of the `userMap` object instance
try await userMap.set(key: "username", "alice")
```

### Java

```
// The published operation targets the object ID of the `userMap` object instance
userMap.set("username", LiveMapValue.of("alice"));
```
</Code>

<If lang="swift,java">
Therefore it is important that you obtain an up-to-date object instance before performing operations on an object. For example, you can [subscribe](https://ably.com/docs/liveobjects/map.md#subscribe-data) to a `LiveMap` instance to ensure you always have an up-to-date reference to any child objects in the map:

<Code>

{ /* We can't map the JS example directly because Swift concurrency prevents us from mutating local variables in the way that the JS example does, so I tried to show how we might need to handle this scenario in a real-world app where things are isolated to the main actor. But it's long and ugly. */ }
### Swift

```
struct MyView: View {
    var root: any LiveMap
    @State private var myCounter: (any LiveCounter)?

    var body: some View {
        Button("Increment the counter") {
            Task {
                try await myCounter?.increment(amount: 1)
            }
        }.onAppear {
            do {
                myCounter = try root.get(key: "myCounter")?.liveCounterValue

                // We keep a reference to the latest value that the root map
                // stores at the "myCounter" key, to ensure that upon tapping
                // the button, we increment the correct counter.

                try root.subscribe { _, _ in
                    MainActor.assumeIsolated {
                        do {
                            myCounter = try root.get(key: "myCounter")?.liveCounterValue
                        } catch {
                            // Error handling of root.get(key:) omitted for brevity
                        }
                    }
                }
            } catch {
                // Error handling of root.get(key:) omitted for brevity
            }
        }
    }
}
```

### Java

```
LiveMap root = channel.getObjects().getRoot();

// Keep a reference to the counter object
LiveCounter myCounter = root.get("myCounter").asLiveCounter();

// Subscribe to root changes to keep counter reference up-to-date
root.subscribe((mapUpdate) -> {
    if (mapUpdate.getUpdate().containsKey("myCounter")) {
        myCounter = root.get("myCounter").asLiveCounter();
    }
});

// Before incrementing, ensure we have an up-to-date object reference if
// the counter instance at the 'myCounter' key in the root map changes
myCounter.increment(1);
```
</Code>
</If>

In the [REST API](https://ably.com/docs/liveobjects/rest-api-usage.md#updating-objects-by-id), the relationship between operations and object IDs is made explicit:

<Code>

### Shell

```
curl -X POST https://main.realtime.ably.net/channels/my-channel/objects \
 -u "your-api-key"
 -H "Content-Type: application/json" \
 --data \
'{
  "operation": "MAP_SET",
  "objectId": "root",
  "data": {"key": "username", "value": {"string": "alice"}}
}'
```
</Code>

<If lang="javascript">

## Batch operations 

[Batch operations](https://ably.com/docs/liveobjects/batch.md) can be used to batch a set of operations together:

* Multiple operations are grouped into a single atomic unit
* All operations in the batch either succeed together or fail together
* Operations in a batch are sent as a single message
* No operations from other clients can be interleaved within a batch

## Object message properties 

Each operation is carried by an `ObjectMessage`, which is surfaced in [subscriptions](https://ably.com/docs/liveobjects/concepts/path-object.md#subscribe) and provides metadata about the operation and who performed it.

### ObjectMessage 

The following are the properties of an `ObjectMessage`:

| Property | Description |
|----------|-------------|
| **id** | Unique ID assigned by Ably to this object message |
| **clientId** | The [ID of the client](https://ably.com/docs/auth/identified-clients.md) that published this operation |
| **connectionId** | The ID of the connection used to publish this operation |
| **timestamp** | The timestamp of when the object message was received by Ably, as milliseconds since the Unix epoch |
| **channel** | The name of the channel the object message was published to |
| **operation** | An [`ObjectOperation`](#object-operation) describing the operation that was applied |
| **serial** | An opaque string that uniquely identifies this object message |
| **serialTimestamp** | A timestamp derived from the `serial` field |
| **siteCode** | An opaque string that uniquely identifies the Ably site the object message was published to |
| **extras** | A JSON object of arbitrary key-value pairs that may contain metadata, and/or ancillary payloads. Valid payloads include `headers` |

### ObjectOperation 

The `operation` field of an `ObjectMessage` contains an `ObjectOperation` with the following properties:

| Property | Description |
|----------|-------------|
| **action** | The operation action. One of: `'map.create'`, `'map.set'`, `'map.remove'`, `'counter.create'`, `'counter.inc'`, or `'object.delete'` |
| **objectId** | The ID of the object the operation was applied to |
| **mapCreate** | Present for `'map.create'` operations. Defines the initial value of the map object with `semantics` (conflict-resolution strategy, one of: `'lww'`) and `entries` (initial key-value pairs, where each value is an [`ObjectsMapEntry`](#objects-map-entry)) |
| **mapSet** | Present for `'map.set'` operations. Contains `key` (the key that was set) and `value` (an [`ObjectData`](#object-data) representing the value assigned to the key) |
| **mapRemove** | Present for `'map.remove'` operations. Contains `key` (the key that was removed) |
| **counterCreate** | Present for `'counter.create'` operations. Defines the initial value of the counter object with `count` (initial counter value) |
| **counterInc** | Present for `'counter.inc'` operations. Contains `number` (the value added to the counter) |
| **objectDelete** | Present for `'object.delete'` operations. Empty object with no operation-specific data |

#### ObjectsMapEntry 

An `ObjectsMapEntry` describes a value at a specific key in a map object. It has the following properties:

| Property | Description |
|----------|-------------|
| **tombstone** | Indicates whether the map entry has been removed |
| **timeserial** | The `serial` value of the last operation applied to the map entry |
| **serialTimestamp** | A timestamp derived from the `timeserial` field. Present only if `tombstone` is `true` |
| **data** | An [`ObjectData`](#object-data) representing the value associated with this map entry |

#### ObjectData 

An `ObjectData` object represents a value assigned to a map key. It is used as the `value` in `mapSet` operations and as the `data` in each [`ObjectsMapEntry`](#objects-map-entry) within `mapCreate.entries`. Exactly one property is set, indicating the type of data:

| Property | Description |
|----------|-------------|
| **objectId** | A reference to another object (such as a `LiveMap` or `LiveCounter`) by its object ID |
| **boolean** | A boolean leaf value |
| **bytes** | A binary leaf value (`ArrayBuffer` in browser environments, or `Buffer` in Node.js) |
| **number** | A numeric leaf value |
| **string** | A string leaf value |
| **json** | A parsed JSON object or array leaf value |

</If>

## Related Topics

- [Objects](https://ably.com/docs/liveobjects/concepts/objects.md): Learn how data is represented as objects in Ably LiveObjects
- [PathObject](https://ably.com/docs/liveobjects/concepts/path-object.md): Learn about PathObject, a path-based API for accessing and manipulating LiveObjects data structures
- [Instance](https://ably.com/docs/liveobjects/concepts/instance.md): Learn about Instance, a reference to a specific LiveObject instance for direct manipulation
- [Synchronization](https://ably.com/docs/liveobjects/concepts/synchronization.md): Learn how data is synchronized between clients.
- [Billing](https://ably.com/docs/liveobjects/concepts/billing.md): Understand how LiveObjects operations contribute to your Ably usage and billing.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
