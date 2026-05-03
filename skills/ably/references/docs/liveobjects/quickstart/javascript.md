# Getting started: LiveObjects in JavaScript

<Aside data-type='note'>
**Building with LiveObjects?** Help shape its future by [sharing your use case](https://44qpp.share.hsforms.com/2fZobHQA1ToyRfB9xqZYQmQ).
</Aside>

This guide shows how to integrate Ably LiveObjects into your JavaScript / TypeScript application.

You will learn how to:

* Create an Ably account and get an API key for authentication.
* Install the Ably Pub/Sub SDK.
* Create a channel with LiveObjects functionality enabled.
* Use the [PathObject API](https://ably.com/docs/liveobjects/concepts/path-object.md) to access objects on a channel.
* Create, update and subscribe to changes on LiveObjects data structures: [LiveMap](https://ably.com/docs/liveobjects/map.md) and [LiveCounter](https://ably.com/docs/liveobjects/counter.md).

## Authentication 

An [API key](https://ably.com/docs/auth.md#api-keys) is required to authenticate with Ably. API keys are used either to authenticate directly with Ably using [basic authentication](https://ably.com/docs/auth/basic.md), or to generate tokens for untrusted clients using [token authentication](https://ably.com/docs/auth/token.md).

<Aside data-type='important'>
The examples use [basic authentication](https://ably.com/docs/auth/basic.md) to demonstrate features for convenience. In your own applications, basic authentication should never be used on the client-side as it exposes your Ably API key. Instead use [token authentication](https://ably.com/docs/auth/token.md).
</Aside>

[Sign up](https://ably.com/sign-up) for a free account and create your own API key in the [dashboard](https://ably.com/dashboard) or use the [Control API](https://ably.com/docs/platform/account/control-api.md) to create an API key programmatically.

API keys and tokens have a set of [capabilities](https://ably.com/docs/auth/capabilities.md) assigned to them that specify which operations can be performed on which resources. The following capabilities are available for LiveObjects:

* `object-subscribe` - grants clients read access to LiveObjects, allowing them to get the channel object and subscribe to updates.
* `object-publish` - grants clients write access to LiveObjects, allowing them to perform mutation operations on objects.

To use LiveObjects, an API key must have at least the `object-subscribe` capability. With only this capability, clients will have read-only access, preventing them from calling mutation methods on LiveObjects.

For the purposes of this guide, make sure your API key includes both `object-subscribe` and `object-publish` [capabilities](https://ably.com/docs/auth/capabilities.md) to allow full read and write access.

## Install Ably Pub/Sub SDK 

LiveObjects is available as part of the Ably Pub/Sub SDK via the dedicated Objects plugin.

### NPM 

Install the Ably Pub/Sub SDK as an [NPM module](https://www.npmjs.com/package/ably):

<Code>

#### Shell

```
npm install ably
```
</Code>

Import the SDK and the Objects plugin into your project:

<Code>

#### Javascript

```
import * as Ably from 'ably';
import { LiveObjects, LiveMap, LiveCounter } from 'ably/liveobjects';
```
</Code>

### CDN 

Reference the Ably Pub/Sub SDK and the Objects plugin within your HTML file:

<Code>

#### Javascript

```
<script src="https://cdn.ably.com/lib/ably.min-2.js"></script>
<script src="https://cdn.ably.com/lib/objects.umd.min-2.js"></script>
<script>
  // Objects plugin is available on the `AblyObjectsPlugin` global property
  const Objects = window.AblyObjectsPlugin;
  // LiveMap and LiveCounter are also available on `AblyObjectsPlugin`
  const { LiveMap, LiveCounter } = window.AblyObjectsPlugin;
</script>
```
</Code>

## Instantiate a client 

Instantiate an Ably Realtime client from the Pub/Sub SDK, providing the Objects plugin:

<Code>

### Javascript

```
const realtimeClient = new Ably.Realtime({ key: 'your-api-key', plugins: { LiveObjects } });
```
</Code>

A [`ClientOptions`](https://ably.com/docs/api/realtime-sdk.md#client-options) object may be passed to the Pub/Sub SDK instance to further customize the connection, however at a minimum you must set an API key and provide an `Objects` plugin so that the client can use LiveObjects functionality.

## Create a channel 

LiveObjects is managed and persisted on [channels](https://ably.com/docs/channels.md). To use LiveObjects, you must first create a channel with the correct [channel mode flags](https://ably.com/docs/channels/options.md#modes):

* `OBJECT_SUBSCRIBE` - required to access objects on a channel.
* `OBJECT_PUBLISH` - required to create and modify objects on a channel.

<Aside data-type='note'>
When you provide an explicit `modes` property for a channel, you override the set of [default modes](https://ably.com/docs/channels/options.md#modes) used for that channel. So, if you're using the channel for anything in addition to LiveObjects, you need to ensure that you also include the other modes required by the features you are using.
</Aside>

<Code>

### Javascript

```
const channelOptions = { modes: ['OBJECT_SUBSCRIBE', 'OBJECT_PUBLISH'] };
const channel = realtimeClient.channels.get('my_liveobjects_channel', channelOptions);
```
</Code>

## Get the channel object 

The [`channel.object`](https://ably.com/docs/api/realtime-sdk/channels.md#object) property gives access to the LiveObjects API for a channel.

Use `channel.object.get()` to obtain a [`PathObject`](https://ably.com/docs/liveobjects/concepts/path-object.md) that represents the channel object. The channel object is a [`LiveMap`](https://ably.com/docs/liveobjects/map.md) that always exists on a channel and acts as the top-level entry point for accessing and persisting objects. A `PathObject` provides a path-based API for accessing and manipulating the object hierarchy. The method returns a promise that resolves once the LiveObjects state is synchronized with the Ably system:

<Code>

### Javascript

```
// Returns a PathObject to the channel object
// The promise resolves once synchronized with Ably
const myObject = await channel.object.get();
```
</Code>

<Aside data-type='note'>
Calling `channel.object.get()` implicitly attaches to the channel if it's not already attached. You don't need to manually call `channel.attach()` before getting the object.
</Aside>

## Create and assign objects 

You can create and assign objects using the `LiveMap.create()` and `LiveCounter.create()` static methods. These methods create value types that can be assigned to paths in the object hierarchy:

<Code>

### Javascript

```
// Create and assign a counter in one operation
await myObject.set('visits', LiveCounter.create(0));

// Create and assign a map with initial data
await myObject.set('reactions', LiveMap.create({
  likes: 0,
  hearts: 0
}));

const visitsCounter = myObject.get('visits');
const reactionsMap = myObject.get('reactions');
```
</Code>

<Aside data-type='note'>
You can create deeply nested structures in a single operation by nesting `LiveMap.create()` and `LiveCounter.create()` calls.
</Aside>

## Subscribe to updates 

Subscribe to realtime updates using the `subscribe()` method on a `PathObject`. You will be notified when the object at that path is updated by other clients or by you:

<Code>

### Javascript

```
// Subscribe to counter updates
visitsCounter.subscribe(({ object }) => {
  console.log('Visits counter updated:', object.value());
});

// Subscribe to map updates
reactionsMap.subscribe(({ object }) => {
  console.log('Reactions map updated:', [...reactionsMap.entries()]);
});
```
</Code>

The subscription callback receives an event object with:
- `object`: A `PathObject` representing the path at which there was an object change
- `message`: The `ObjectMessage` that carried the operation that led to the change

## Update objects 

Update objects using mutation methods on `PathObject`. All subscribers (including you) will be notified of the changes:

<Code>

### Javascript

```
// Update counter
await visitsCounter.increment(5);
// console: "Visits counter updated: 5"

await visitsCounter.decrement(2);
// console: "Visits counter updated: 3"

// Update map
await reactionsMap.set('likes', 10);
// console: "Reactions map updated: [['likes',10]]"

await reactionsMap.set('hearts', 5);
// console: "Reactions map updated: [['likes',10],['hearts',5]]"

await reactionsMap.remove('likes');
// console: "Reactions map updated: [['hearts',5]]"
```
</Code>

<Aside data-type='note'>
Mutation methods send operations to the Ably system and apply changes locally as soon as the operations are acknowledged. When a mutation method's promise resolves, the operation has been applied and you can immediately read the updated state. You will also be notified via subscription when the object is updated.
</Aside>

## Next steps 

This quickstart introduced the basic concepts of LiveObjects and demonstrated how the path-based API works. The next steps are to:

* Learn about the [PathObject](https://ably.com/docs/liveobjects/concepts/path-object.md) and [Instance](https://ably.com/docs/liveobjects/concepts/instance.md) APIs.
* Read more about [LiveCounter](https://ably.com/docs/liveobjects/counter.md) and [LiveMap](https://ably.com/docs/liveobjects/map.md).
* Learn about [Batching Operations](https://ably.com/docs/liveobjects/batch.md).
* Learn about [Objects Lifecycle Events](https://ably.com/docs/liveobjects/lifecycle.md).
* Add [Typings](https://ably.com/docs/liveobjects/typing.md) for your LiveObjects.

## Related Topics

- [Swift](https://ably.com/docs/liveobjects/quickstart/swift.md): A quickstart guide to learn the basics of integrating the Ably LiveObjects product into your Swift application.
- [Java](https://ably.com/docs/liveobjects/quickstart/java.md): A quickstart guide to learn the basics of integrating the Ably LiveObjects product into your Java application.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
