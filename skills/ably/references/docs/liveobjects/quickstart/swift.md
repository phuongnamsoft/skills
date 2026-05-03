# Getting started: LiveObjects in Swift

<Aside data-type='experimental'>
LiveObjects Swift is currently Experimental. Its features are still in development and subject to rapid change.

**Building with LiveObjects?** Help shape its future by [sharing your use case](https://44qpp.share.hsforms.com/2fZobHQA1ToyRfB9xqZYQmQ).
</Aside>

This guide shows how to integrate Ably LiveObjects into your Swift application.

You will learn how to:

* Create an Ably account and get an API key for authentication.
* Install the Ably Pub/Sub SDK.
* Create a channel with LiveObjects functionality enabled.
* Create, update and subscribe to changes on LiveObjects data structures: [LiveMap](https://ably.com/docs/liveobjects/map.md) and [LiveCounter](https://ably.com/docs/liveobjects/counter.md).

## Authentication 

An [API key](https://ably.com/docs/auth.md#api-keys) is required to authenticate with Ably. API keys are used either to authenticate directly with Ably using [basic authentication](https://ably.com/docs/auth/basic.md), or to generate tokens for untrusted clients using [token authentication](https://ably.com/docs/auth/token.md).

<Aside data-type='important'>
The examples use [basic authentication](https://ably.com/docs/auth/basic.md) to demonstrate features for convenience. In your own applications, basic authentication should never be used on the client-side as it exposes your Ably API key. Instead use [token authentication](https://ably.com/docs/auth/token.md).
</Aside>

[Sign up](https://ably.com/sign-up) for a free account and create your own API key in the [dashboard](https://ably.com/dashboard) or use the [Control API](https://ably.com/docs/platform/account/control-api.md) to create an API key programmatically.

API keys and tokens have a set of [capabilities](https://ably.com/docs/auth/capabilities.md) assigned to them that specify which operations can be performed on which resources. The following capabilities are available for LiveObjects:

* `object-subscribe` - grants clients read access to LiveObjects, allowing them to get the root object and subscribe to updates.
* `object-publish` - grants clients write access to LiveObjects, allowing them to perform mutation operations on objects.

To use LiveObjects, an API key must have at least the `object-subscribe` capability. With only this capability, clients will have read-only access, preventing them from calling mutation methods on LiveObjects.

For the purposes of this guide, make sure your API key includes both `object-subscribe` and `object-publish` [capabilities](https://ably.com/docs/auth/capabilities.md) to allow full read and write access.

## Install Ably Pub/Sub SDK 

LiveObjects is available as part of the Ably Pub/Sub SDK via the dedicated LiveObjects plugin.

### Xcode 

To follow this guide in Xcode, use a new iOS project with the SwiftUI App template. All code can be added directly to your `ContentView.swift` file, inside the `ContentView` struct. Use the `.task` modifier with a `do { … } catch { … }` inside to run the Ably code when the view appears. No additional files or setup are needed. All `print` output will appear in Xcode's debug console (View > Debug Area > Activate Console, or press Cmd+Shift+C).

Install the Ably SDK and the LiveObjects plugin in your Xcode project:

1. Paste `https://github.com/ably/ably-cocoa` in the Swift Packages search box (File → Add Package Dependencies).
2. Add the `Ably` product.
3. Paste `https://github.com/ably/ably-liveobjects-swift-plugin` in the Swift Packages search box.
4. Add the `AblyLiveObjects` product.

Import the SDK and the LiveObjects plugin into your project:

<Code>

#### Swift

```
import Ably
import AblyLiveObjects
```
</Code>

## Instantiate a client 

Instantiate an Ably Realtime client from the Pub/Sub SDK, providing the LiveObjects plugin:

<Code>

### Swift

```
let clientOptions = ARTClientOptions(key: "your-api-key")
clientOptions.plugins = [.liveObjects: AblyLiveObjects.Plugin.self]

let realtimeClient = ARTRealtime(options: clientOptions)
```
</Code>

A [`ClientOptions`](https://ably.com/docs/api/realtime-sdk.md#client-options) object may be passed to the Pub/Sub SDK instance to further customize the connection, however at a minimum you must set an API key and provide the `.liveObjects` plugin so that the client can use LiveObjects functionality.

## Create a channel 

LiveObjects is managed and persisted on [channels](https://ably.com/docs/channels.md). To use LiveObjects, you must first create a channel with the correct [channel mode flags](https://ably.com/docs/channels/options.md#modes):

* `OBJECT_SUBSCRIBE` - required to access objects on a channel.
* `OBJECT_PUBLISH` - required to create and modify objects on a channel.

<Aside data-type='note'>
When you provide an explicit `modes` property for a channel, you override the set of [default modes](https://ably.com/docs/channels/options.md#modes) used for that channel. So, if you're using the channel for anything in addition to LiveObjects, you need to ensure that you also include the other modes required by the features you are using.
</Aside>

<Code>

### Swift

```
let channelOptions = ARTRealtimeChannelOptions()
channelOptions.modes = [.objectPublish, .objectSubscribe]
let channel = realtimeClient.channels.get("my_liveobjects_channel", options: channelOptions)
```
</Code>

Next, you need to [attach to the channel](https://ably.com/docs/channels/states.md). Attaching to a channel starts an initial synchronization sequence where the objects on the channel are sent to the client.

<Code>

### Swift

```
try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
    channel.attach { error in
        if let error {
            continuation.resume(throwing: error)
        } else {
            continuation.resume()
        }
    }
}
```
</Code>

## Get root object 

The [`channel.objects`](https://ably.com/docs/api/realtime-sdk/channels.md#objects) property gives access to the LiveObjects API for a channel.

Use it to get the root object, which is the entry point for accessing and persisting objects on a channel. The root object is a [`LiveMap`](https://ably.com/docs/liveobjects/map.md) instance that always exists on a channel and acts as the top-level node in your object tree. You can get the root object using the `getRoot()` function of LiveObjects:

<Code>

### Swift

```
// The getRoot call returns once the LiveObjects state is synchronized with the Ably system
let root = try await channel.objects.getRoot()
```
</Code>

## Create objects 

You can create new objects using dedicated functions of the LiveObjects API at [`channel.objects`](https://ably.com/docs/api/realtime-sdk/channels.md#objects). To persist them on a channel and share them between clients, you must assign objects to a parent `LiveMap` instance connected to the root object. The root object itself is a `LiveMap` instance, so you can assign objects to the root and start building your object tree from there.

<Aside data-type='note'>
Objects that are not descendants of the root object are "unreachable" and will eventually be garbage collected. Read more in the [objects lifecycle events section](https://ably.com/docs/liveobjects/lifecycle.md#objects-lifecycle).
</Aside>

<Code>

### Swift

```
let visitsCounter = try await channel.objects.createCounter()
let reactionsMap = try await channel.objects.createMap()

try await root.set(key: "visits", value: .liveCounter(visitsCounter))
try await root.set(key: "reactions", value: .liveMap(reactionsMap))
```
</Code>

## Subscribe to updates 

Subscribe to realtime updates to objects on a channel. You will be notified when an object is updated by other clients or by you.

<Code>

### Swift

```
try visitsCounter.subscribe { _, _ in
    do {
        print("Visits counter updated: \(try visitsCounter.value)")
    } catch {
        // Error handling of visitsCounter.value omitted for brevity
    }
}

try reactionsMap.subscribe { _, _ in
    do {
        print("Reactions map updated: \(try reactionsMap.entries)")
    } catch {
        // Error handling of reactionsMap.entries omitted for brevity
    }
}
```
</Code>

## Update objects 

Update objects using mutation methods. All subscribers (including you) will be notified of the changes when you update an object:

<Code>

### Swift

```
try await visitsCounter.increment(amount: 5)
// console: "Visits counter updated: 5.0"
try await visitsCounter.decrement(amount: 2)
// console: "Visits counter updated: 3.0"

try await reactionsMap.set(key: "like", value: 10)
// console: "Reactions map updated: [(key: "like", value: AblyLiveObjects.LiveMapValue.number(10.0))]"
try await reactionsMap.set(key: "love", value: 5)
// console: "Reactions map updated: [(key: "like", value: AblyLiveObjects.LiveMapValue.number(10.0)), (key: "love", value: AblyLiveObjects.LiveMapValue.number(5.0))]"
try await reactionsMap.remove(key: "like")
// console: "Reactions map updated: [(key: "love", value: AblyLiveObjects.LiveMapValue.number(5.0))]"
```
</Code>

<Aside data-type='note'>
Mutation methods (such as `LiveMap.set(key:value:)`, `LiveCounter.increment(amount:)`, etc.) send operations to the Ably system and apply changes locally as soon as the operations are acknowledged. When a mutation method returns, the operation has been applied and you can immediately read the updated state. You will also be notified via subscription when the object is updated.
</Aside>

## Next steps 

This quickstart introduced the basic concepts of LiveObjects and demonstrated how it works. The next steps are to:

* Read more about [LiveCounter](https://ably.com/docs/liveobjects/counter.md) and [LiveMap](https://ably.com/docs/liveobjects/map.md).
* Learn about [Batching Operations](https://ably.com/docs/liveobjects/batch.md).
* Learn about [Objects Lifecycle Events](https://ably.com/docs/liveobjects/lifecycle.md).
* Add [Typings](https://ably.com/docs/liveobjects/typing.md) for your LiveObjects.

## Related Topics

- [JavaScript](https://ably.com/docs/liveobjects/quickstart/javascript.md): A getting started guide to learn the basics of integrating the Ably LiveObjects product into your JavaScript application.
- [Java](https://ably.com/docs/liveobjects/quickstart/java.md): A quickstart guide to learn the basics of integrating the Ably LiveObjects product into your Java application.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
