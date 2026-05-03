# LiveMap

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

`LiveMap` is a synchronized key/value data structure that stores [primitive values](https://ably.com/docs/liveobjects/concepts/objects.md#primitive-types), such as numbers, strings, booleans, binary data, JSON-serializable objects or arrays and other live [object types](https://ably.com/docs/liveobjects/concepts/objects.md#object-types). It ensures that all updates are correctly applied and synchronized across clients in realtime, automatically resolving conflicts with last-write-wins (LWW) semantics.

<If lang="javascript">

You interact with `LiveMap` through a [PathObject](https://ably.com/docs/liveobjects/concepts/path-object.md) or by obtaining a specific [Instance](https://ably.com/docs/liveobjects/concepts/instance.md).

## Create a map 

Create a `LiveMap` using the `LiveMap.create()` static method and assign it to a path:

<Code>

### Javascript

```
import { LiveMap } from 'ably/liveobjects';

// Create an empty map
await myObject.set('settings', LiveMap.create());

// Create a map with initial data
await myObject.set('user', LiveMap.create({
  name: 'Alice',
  score: 42,
  active: true
}));

// Create nested maps
await myObject.set('config', LiveMap.create({
  theme: LiveMap.create({
    color: 'dark',
    fontSize: 14
  })
}));
```
</Code>

`LiveMap.create()` returns a value type that describes the initial data for a new map. The actual object is created when assigned to a path. Each assignment creates a distinct object with its own unique ID:

<Code>

### Javascript

```
const mapValue = LiveMap.create({ theme: 'dark' });

// Each assignment creates a different object
await myObject.set('map1', mapValue);
await myObject.set('map2', mapValue);

// map1 and map2 are different objects with different IDs
const id1 = myObject.get('map1').instance()?.id();
const id2 = myObject.get('map2').instance()?.id();
console.log(id1 === id2); // false
```
</Code>

## Get map values 

Access a `LiveMap` through a [PathObject](https://ably.com/docs/liveobjects/concepts/path-object.md) for path-based operations, or obtain a specific [Instance](https://ably.com/docs/liveobjects/concepts/instance.md) to work with the underlying object directly. Use the `get()` method to navigate to entries within the map.

What you can do with the result depends on the type of value stored in the entry:

- For entries containing [primitive values](https://ably.com/docs/liveobjects/concepts/objects.md#primitive-types) or [`LiveCounter`](https://ably.com/docs/liveobjects/counter.md) objects, use the `value()` method to get the current value.
- For entries containing nested `LiveMap` objects, use `get()` to continue navigating deeper into the structure.

<Code>

### Javascript

```
const myObject = await channel.object.get();

// PathObject access: path-based operations that resolve at runtime
const theme = myObject.get('settings').get('theme'); // settings holds a LiveMap with a 'theme' key
console.log(theme.value()); // e.g. 'dark'
const visits = myObject.get('visits'); // visits holds a LiveCounter
console.log(visits.value()); // e.g. 5

// Instance access: reference to a specific map object
const settingsInstance = myObject.get('settings').instance();
console.log(settingsInstance?.get('theme')?.value()); // e.g. 'dark' (primitive string)
```
</Code>

<Aside data-type="note">
Calling `value()` on a `PathObject` may return `undefined` if a primitive value or `LiveCounter` instance cannot be found at that path. Calling `value()` on an `Instance` returns `undefined` if the instance is not a primitive or `LiveCounter`. Learn more about reading values on a [`PathObject`](https://ably.com/docs/liveobjects/concepts/path-object.md#read-values) and [`Instance`](https://ably.com/docs/liveobjects/concepts/instance.md#read-values).
</Aside>

## Get compact object 

Get a JavaScript object representation of the map using the `compact()` or `compactJson()` methods:

<Code>

### Javascript

```
// Get a PathObject to a LiveMap stored in 'settings'
const settings = myObject.get('settings');
console.log(settings.compact());
// e.g. { theme: 'dark', fontSize: 14, notifications: true }

// Get the Instance of a LiveMap stored in 'settings'
const settingsInstance = myObject.get('settings').instance();
console.log(settingsInstance?.compact());
// e.g. { theme: 'dark', fontSize: 14, notifications: true }
```
</Code>

<Aside data-type="further-reading">
Learn more about obtaining compact objects on a [`PathObject`](https://ably.com/docs/liveobjects/concepts/path-object.md#get-a-compact-object) or an [`Instance`](https://ably.com/docs/liveobjects/concepts/instance.md#get-a-compact-object).
</Aside>

## Set map values 

Set a value for a key in the map using the `set()` method. You can store primitive values or other live [object types](https://ably.com/docs/liveobjects/concepts/objects.md#object-types):

<Code>

### Javascript

```
// PathObject: set values at path
await myObject.get('settings').set('theme', 'dark');
await myObject.get('settings').set('fontSize', 14);
await myObject.get('settings').set('notifications', true);

// Set a nested map
await myObject.get('settings').set('advanced', LiveMap.create({
  debugMode: false,
  logLevel: 'info'
}));

// Set a counter
await myObject.get('settings').set('visits', LiveCounter.create(0));

// Instance: set values on specific map instance
const settingsInstance = myObject.get('settings').instance();
await settingsInstance?.set('theme', 'dark');
await settingsInstance?.set('fontSize', 14);
```
</Code>

<Aside data-type="note">
A `LiveMap` can store other `LiveMap` or `LiveCounter` objects as values for its keys, enabling you to build a complex, hierarchical channel object. This enables you to represent complex data models in your applications while ensuring realtime synchronization across clients.
</Aside>

## Remove a key 

Remove a key from the map using the `remove()` method:

<Code>

### Javascript

```
// PathObject: remove key at path
await myObject.get('settings').remove('oldSetting');

// Instance: remove key on specific map instance
const settingsInstance = myObject.get('settings').instance();
await settingsInstance?.remove('oldSetting');
```
</Code>

## Get map size 

Get the number of keys in the map using the `size()` method:

<Code>

### Javascript

```
// PathObject: get size at path
const settings = myObject.get('settings');
console.log(settings.size()); // e.g. 5

// Instance: get size of specific map instance
const settingsInstance = myObject.get('settings').instance();
console.log(settingsInstance?.size()); // e.g. 5
```
</Code>

<Aside data-type="note">
Calling `size()` on a `PathObject` may return `undefined` if a `LiveMap` instance cannot be found at that path. Calling `size()` on an `Instance` returns `undefined` if the instance is not a `LiveMap`.
</Aside>

## Enumerate entries 

Iterate over the map's keys, values, or entries. When iterating using a `PathObject`, values are returned as a `PathObject` for the nested path. When iterating using an `Instance`, values are returned as an `Instance` for the entry:

<Code>

### Javascript

```
// PathObject: iterate with PathObject values
const settings = myObject.get('settings');
for (const [key, value] of settings.entries()) {
  console.log(`${key}:`, value.value());
}
for (const key of settings.keys()) {
  console.log('Key:', key);
}
for (const value of settings.values()) {
  console.log('Value:', value.value());
}

// Instance: iterate with Instance values
const settingsInstance = myObject.get('settings').instance();
if (settingsInstance) {
  for (const [key, valueInstance] of settingsInstance.entries()) {
    console.log(`${key}:`, valueInstance.value());
  }
  for (const key of settingsInstance.keys()) {
    console.log('Key:', key);
  }
  for (const value of settingsInstance.values()) {
    console.log('Value:', value.value());
  }
}
```
</Code>

<Aside data-type="note">
These methods don't guarantee entries are returned in insertion order.
</Aside>

## Batch multiple operations 

Group multiple map operations into a single atomic message using the `batch()` method. All operations within the batch are sent as one logical unit which succeed or fail together:

<Code>

### Javascript

```
// PathObject: batch operations on map at path
await myObject.get('settings').batch((ctx) => {
  ctx.set('theme', 'dark');
  ctx.set('fontSize', 14);
  ctx.set('notifications', true);
  ctx.remove('oldSetting');
});

// Instance: batch operations on specific map instance
const settingsInstance = myObject.get('settings').instance();
await settingsInstance?.batch((ctx) => {
  ctx.set('theme', 'dark');
  ctx.set('fontSize', 14);
});
```
</Code>

<Aside data-type="further-reading">
Learn more about [Batch operations](https://ably.com/docs/liveobjects/batch.md).
</Aside>

## Subscribe to updates 

Subscribe to `LiveMap` updates to receive realtime notifications when the map changes.

`PathObject` subscriptions observe a location and automatically track changes even if the `LiveMap` instance at that path is replaced. `Instance` subscriptions track a specific `LiveMap` instance, following it even if it moves in the channel object.

<Aside data-type="further-reading">
Learn more about [`PathObject`](https://ably.com/docs/liveobjects/concepts/path-object.md#subscribe) and [`Instance`](https://ably.com/docs/liveobjects/concepts/instance.md#subscribe) subscriptions.
</Aside>

<Code>

### Javascript

```
// PathObject: observe location - tracks changes even if map instance is replaced
const settings = myObject.get('settings');
const { unsubscribe } = settings.subscribe(() => {
  console.log('Settings:', settings.compact());
});

// Later, stop listening to changes
unsubscribe();

// Instance: track specific map instance - follows it even if moved in object tree
const settingsInstance = myObject.get('settings').instance();
if (settingsInstance) {
  const { unsubscribe } = settingsInstance.subscribe(() => {
    console.log('Settings:', settingsInstance.compact());
  });

  // Later, stop listening to changes
  unsubscribe();
}
```
</Code>

Alternatively, use the `subscribeIterator()` method for an async iterator syntax:

<Code>

### Javascript

```
// PathObject: observe location - tracks changes even if map instance is replaced
const settings = myObject.get('settings');
for await (const _ of settings.subscribeIterator()) {
  console.log('Settings:', settings.compact());

  if (someCondition) {
    break; // Unsubscribes
  }
}

// Instance: track specific map instance - follows it even if moved in object tree
const settingsInstance = myObject.get('settings').instance();
if (settingsInstance) {
  for await (const _ of settingsInstance.subscribeIterator()) {
    console.log('Settings:', settingsInstance.compact());

    if (someCondition) {
      break; // Unsubscribes
    }
  }
}
```
</Code>

</If>

<If lang="swift,java">

## Create LiveMap 

A `LiveMap` instance can be created using the `channel.objects.createMap()` method. It must be stored inside another `LiveMap` object that is reachable from the [root object](https://ably.com/docs/liveobjects/concepts/objects.md#root-object).

`channel.objects.createMap()` is asynchronous, as the client sends the create operation to the Ably system and waits for an acknowledgment of the successful map creation.

<Aside data-type='note'>
Note that you need to first [attach to the channel](https://ably.com/docs/liveobjects/quickstart/javascript.md#step-3) before creating a new `LiveMap` instance, as this operation requires sending a message to the Ably system.
</Aside>

<Code>

### Swift

```
let map = try await channel.objects.createMap()
try await root.set(key: "myMap", value: .liveMap(map))
```

### Java

```
LiveMap map = channel.getObjects().createMap();
root.set("myMap", LiveMapValue.of(map));
```
</Code>

Optionally, you can specify an initial key/value structure when creating the map:

<Code>

### Swift

```
// Pass a Dictionary reflecting the initial state
let map = try await channel.objects.createMap(entries: ["foo": "bar", "baz": 42])
// You can also pass other objects as values for keys
try await channel.objects.createMap(entries: ["nestedMap": .liveMap(map)])
```

### Java

```
// Pass a Map with initial key/value pairs
Map<String, LiveMapValue> entries = Map.of(
    "foo", LiveMapValue.of("bar"),
    "baz", LiveMapValue.of(42)
);
LiveMap map = channel.getObjects().createMap(entries);

// You can also pass other objects as values for keys
Map<String, LiveMapValue> nestedEntries = Map.of(
    "nestedMap", LiveMapValue.of(map)
);
channel.getObjects().createMap(nestedEntries);
```
</Code>

## Get value for a key 

Get the current value for a key in a map using the `LiveMap.get()` method:

<Code>

### Swift

```
let value = try map.get(key: "my-key")
print("Value for my-key: \(String(describing: value))")
```

### Java

```
System.out.println("Value for my-key: " + map.get("my-key").getValue());
```
</Code>

## Subscribe to data updates 

You can subscribe to data updates on a map to receive realtime changes made by you or other clients.

<If lang="swift,java">
<Aside data-type='note'>
`LiveMap` mutation methods send operations to the Ably system and apply changes locally as soon as the operations are acknowledged. When a mutation method returns, the operation has been applied and you can immediately read the updated state. You will also be notified via subscription when the map is updated.
</Aside>
</If>

Subscribe to data updates on a map using the `LiveMap.subscribe()` method:

<Code>

### Swift

```
try map.subscribe { update, _ in
    do {
        print("Map updated: \(try map.entries)")
    } catch {
        // Error handling of map.entries omitted for brevity
    }
    print("Update details: \(update)")
}
```

### Java

```
map.subscribe((mapUpdate) -> {
    System.out.println("Map updated: " + map.entries());
    System.out.println("Update details: " + mapUpdate.getUpdate());
});
```
</Code>

The update object provides details about the change, listing the keys that were changed and indicating whether they were updated (value changed) or removed from the map.

It may also include the client ID of the client that made the change, if the change can be attributed to a specific client. For example, the client ID may be missing if the update was triggered by data resynchronization after a disconnection and the change occurred while the client was offline.

Example structure of an update object when the key `foo` is updated and the key `bar` is removed, made by a client with the ID `my-client`:

<Code>

### Json

```
{
  "update": {
    "foo": "updated",
    "bar": "removed"
  },
  "clientId": "my-client"
}
```
</Code>

### Unsubscribe from data updates 

Use the `unsubscribe()` function returned in the `subscribe()` response to remove a map update listener:

<Code>

#### Swift

```
// Initial subscription
let subscriptionResponse = try map.subscribe { _, _ in
    print("Map updated")
}
// To remove the listener
subscriptionResponse.unsubscribe()
```

#### Java

```
// Initial subscription
ObjectsSubscription subscription = map.subscribe((mapUpdate) ->
    System.out.println("Map updated")
);
// To remove the listener
subscription.unsubscribe();
```
</Code>

<If lang="swift">
To remove a map update listener from _inside_ the listener function, you can call `unsubscribe()` on the subscription response that is passed as the second argument to the listener function:

<Code>

#### Swift

```
try map.subscribe { _, subscriptionResponse in
    // Remove the listener so that this callback
    // no longer gets called
    subscriptionResponse.unsubscribe()
}
```
</Code>
</If>

<If lang="java">
Use the `LiveMap.unsubscribe()` method to deregister a provided listener:

<Code>

#### Java

```
// Initial subscription
LiveMap.Listener listener = (mapUpdate) ->
    System.out.println("Map updated");
map.subscribe(listener);
// To remove the listener
map.unsubscribe(listener);
```
</Code>
</If>

Use the `LiveMap.unsubscribeAll()` method to deregister all map update listeners:

<Code>

#### Swift

```
map.unsubscribeAll();
```

#### Java

```
map.unsubscribeAll();
```
</Code>

## Set keys in a LiveMap 

Set a value for a key in a map by calling <If lang="java">`LiveMap.set()`</If><If lang="swift">`LiveMap.set(key:value:)`</If>. This operation is synchronized across all clients and triggers data subscription callbacks for the map, including on the client making the request.

Keys in a map can contain numbers, strings, booleans, <If lang="java">buffers</If><If lang="swift">`Data`</If>, JSON-serializable objects or arrays and other `LiveMap` and `LiveCounter` objects.

This operation is asynchronous, as the client sends the corresponding update operation to the Ably system and waits for acknowledgment of the successful map key update.

<Code>

### Swift

```
try await map.set(key: "foo", value: "bar")
try await map.set(key: "baz", value: 42)

// Can also set a reference to another object
let counter = try await channel.objects.createCounter()
try await map.set(key: "counter", value: .liveCounter(counter))
```

### Java

```
map.set("foo", LiveMapValue.of("bar"));
map.set("baz", LiveMapValue.of(42));

// Can also set a reference to another object
LiveCounter counter = channel.getObjects().createCounter();
map.set("counter", LiveMapValue.of(counter));
```
</Code>

## Remove a key from a LiveMap 

Remove a key from a map by calling <If lang="java">`LiveMap.remove()`</If><If lang="swift">`LiveMap.remove(key:)`</If>. This operation is synchronized across all clients and triggers data subscription callbacks for the map, including on the client making the request.

This operation is asynchronous, as the client sends the corresponding remove operation to the Ably system and waits for acknowledgment of the successful map key removal.

<Code>

### Swift

```
try await map.remove(key: "foo")
```

### Java

```
map.remove("foo");
```
</Code>

## Get the number of entries in a LiveMap 

Get the number of entries in a map using <If lang="swift">`LiveMap.size`</If><If lang="java">`LiveMap.size()`</If>:

<Code>

### Swift

```
let map = try await channel.objects.createMap(entries: ["foo": "bar", "baz": "qux"])
print(try map.size) // e.g. 2
```

### Java

```
LiveMap map = channel.getObjects().createMap(Map.of(
    "foo", LiveMapValue.of("bar"),
    "baz", LiveMapValue.of("qux")
));
System.out.println(map.size()); // e.g. 2
```
</Code>

## Iterate over key/value pairs 

Iterate over key/value pairs, keys or values using the <If lang="java">`LiveMap.entries()`, `LiveMap.keys()` and `LiveMap.values()` methods</If><If lang="swift">`LiveMap.entries`, `LiveMap.keys` and `LiveMap.values` properties</If> respectively.

<If lang="swift">
These properties are all `Array`-valued. Note that they do not guarantee that entries are returned in insertion order.
</If>
<If lang="java">
These methods return a map iterator for convenient traversal. These methods do not guarantee that entries are returned in insertion order.
</If>

<Code>

### Swift

```
for (key, value) in try map.entries {
    print("Key: \(key), Value: \(value)")
}

for key in try map.keys {
    print("Key: \(key)")
}

for value in try map.values {
    print("Value: \(value)")
}
```

### Java

```
for (Map.Entry<String, LiveMapValue> entry : map.entries()) {
    System.out.println("Key: " + entry.getKey());
    System.out.println("Value: " + entry.getValue().getValue());
}

for (String key : map.keys()) {
    System.out.println("Key: " + key);
}

for (LiveMapValue value : map.values()) {
    System.out.println("Value: " + value.getValue());
}
```
</Code>

## Subscribe to lifecycle events 

Subscribe to lifecycle events on a map using the <If lang="java">`LiveMap.on()`</If><If lang="swift">`LiveMap.on(event:callback:)`</If> method:

<Code>

### Swift

```
map.on(event: .deleted) { _ in
  print("Map has been deleted")
}
```

### Java

```
map.on(ObjectLifecycleEvent.DELETED, (lifecycleEvent) -> {
    System.out.println("Map has been deleted");
});
```
</Code>

Read more about [objects lifecycle events](https://ably.com/docs/liveobjects/lifecycle.md#objects).

### Unsubscribe from lifecycle events 

Use the `off()` function returned in the `on()` response to remove a lifecycle event listener:

<Code>

#### Swift

```
// Initial subscription
let eventResponse = map.on(event: .deleted) { _ in
  print("Map deleted")
}
// To remove the listener
eventResponse.off()
```

#### Java

```
// Initial subscription
ObjectsSubscription subscription = map.on(ObjectLifecycleEvent.DELETED, (lifecycleEvent) ->
    System.out.println("Map deleted")
);
// To remove the listener
subscription.unsubscribe();
```
</Code>

<If lang="java">
Use the `LiveMap.off()` method to deregister a provided lifecycle event listener:

<Code>

#### Java

```
// Initial subscription
ObjectLifecycleChange.Listener listener = (lifecycleEvent) ->
    System.out.println("Map deleted");
map.on(ObjectLifecycleEvent.DELETED, listener);
// To remove the listener
listener.unsubscribe()
// Alternatively, remove the shared listener from all event registrations
map.off(listener);
```
</Code>
</If>

Use the `LiveMap.offAll()` method to deregister all lifecycle event listeners:

<Code>

#### Swift

```
map.offAll()
```

#### Java

```
map.offAll();
```
</Code>

## Create nested structures 

A `LiveMap` can store other `LiveMap` or `LiveCounter` objects as values for its keys, enabling you to build complex, hierarchical object structure. This enables you to represent complex data models in your applications while ensuring realtime synchronization across clients.

<Code>

### Swift

```
// Create a hierarchy of objects using LiveMap
let counter = try await channel.objects.createCounter()
let map = try await channel.objects.createMap(entries: ["nestedCounter": .liveCounter(counter)])
let outerMap = try await channel.objects.createMap(entries: ["nestedMap": .liveMap(map)])
try await root.set(key: "outerMap", value: .liveMap(outerMap))

// resulting structure:
// root (LiveMap)
// └── outerMap (LiveMap)
//     └── nestedMap (LiveMap)
//         └── nestedCounter (LiveCounter)
```

### Java

```
// Create a hierarchy of objects using LiveMap
LiveCounter counter = channel.getObjects().createCounter();
LiveMap map = channel.getObjects().createMap(Map.of(
    "nestedCounter", LiveMapValue.of(counter)
));
LiveMap outerMap = channel.getObjects().createMap(Map.of(
    "nestedMap", LiveMapValue.of(map)
));
root.set("outerMap", LiveMapValue.of(outerMap));

// resulting structure:
// root (LiveMap)
// └── outerMap (LiveMap)
//     └── nestedMap (LiveMap)
//         └── nestedCounter (LiveCounter)
```
</Code>

</If>

## Related Topics

- [LiveCounter](https://ably.com/docs/liveobjects/counter.md): Create, update and receive updates for a numerical counter that synchronizes state across clients in realtime.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
