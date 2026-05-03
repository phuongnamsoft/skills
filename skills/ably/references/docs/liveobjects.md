# About LiveObjects

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

Ably LiveObjects provides a serverless, durable, and scalable way to create, update, and synchronize shared state across large numbers of connected clients at any scale.

LiveObjects provides a global, durable, and conflict-free shared data layer built on Ably's [global platform](https://ably.com/docs/platform/architecture.md), so your application state stays perfectly synchronized in realtime without the need to build or manage complex infrastructure yourself.

<Aside data-type='note'>
LiveObjects has the same performance guarantees and scaling potential as [channels](https://ably.com/docs/channels.md).
</Aside>

LiveObjects enables you to store shared data as "objects" on [channels](https://ably.com/docs/channels.md). When an object is updated, changes are automatically propagated to all subscribed clients in realtime, ensuring everyone always sees the latest state.

LiveObjects provides a simple, purpose-built API that handles realtime synchronization, persistence, and convergence behind the scenes. The result is a single logical view of your data - distributed to the edge, updated in real time, and always in sync - no matter how many users are connected or where they are in the world.

## Use cases 

You can use LiveObjects to build all sorts of powerful functionality in your applications that require realtime updates to shared data. It is useful when your application has data that:

* Is shared by multiple users or devices
* Needs to be synchronized in realtime
* Can be updated concurrently from multiple places

Use Ably LiveObjects to build scalable realtime features such as:

* AI Agent state: AI systems that need to surface progress updates, task status, and other live agent state updates to users in realtime
* Voting and polling systems: Platforms that need the ability to count and display votes in realtime, such as audience engagement tools, quizzes, and decision-making applications.
* Collaborative applications: Tools like shared whiteboards or content and product management applications where multiple users edit shared content simultaneously.
* Live leaderboards: Multiplayer games or competition-based applications that require up-to-date rankings and scoreboards.
* Game state: Applications that present dynamic in-game statistics or game state in realtime, such as player health, scores, and inventory changes.
* Shared configuration, settings or controls: Systems where configuration parameters are shared or updated across multiple users or devices.

## Features 

Ably LiveObjects provides the following key features:

* [Object types](#object-types)
* [Composability](#composability)
* [Batch operations](#batch-operations)
* [Inband objects](#inband-objects)
* [Object storage](#object-storage)

### Object types 

LiveObjects provides specialized object types to model your application state. These object types are designed to be conflict-free and eventually consistent, meaning that all operations on them are commutative and converge to the same state across all clients.

#### LiveCounter 

[LiveCounter](https://ably.com/docs/liveobjects/counter.md) is a numerical counter that supports increment and decrement operations. It ensures that all updates are correctly applied and synchronized across users in realtime, preventing inconsistencies when multiple users modify the counter value simultaneously.

#### LiveMap 

[LiveMap](https://ably.com/docs/liveobjects/map.md) is a key/value data structure that synchronizes its state across users in realtime. It enables you to store primitive values, such as numbers, strings, booleans, buffers, JSON-serializable objects or arrays and other LiveObjects types, enabling [composable data structures](#composability).

### Composability 

LiveObjects enables you to build complex, hierarchical data structures through [composability](https://ably.com/docs/liveobjects/concepts/objects.md#composability).

### Batch operations 

[Batch operations](https://ably.com/docs/liveobjects/batch.md) enables multiple operations to be grouped into a single channel message, ensuring atomic application of grouped operations. This prevents partial updates of your data and ensures consistency across all users.

### Inband objects 

[Inband objects](https://ably.com/docs/liveobjects/inband-objects.md) enables clients to subscribe to LiveObjects updates in realtime, even on platforms that don't yet have a native LiveObjects Realtime client implementation.

### Object storage 

LiveObjects [durably stores](https://ably.com/docs/liveobjects/storage.md) all objects on a channel for a configurable retention period between 24 hours and 90 days.

## Pricing 

LiveObjects usage is billed based on [Ably's standard pricing model](https://ably.com/docs/platform/pricing.md). Since LiveObjects is powered by Ably's channel messages, any interaction with LiveObjects - whether sending or receiving operations, maintaining active channels, or keeping connections open through the Realtime LiveObjects API - translates into billable usage. Storage of objects themselves does not incur additional costs; however, there is a [limit](https://ably.com/docs/liveobjects/storage.md) on the size of the channel object.

For details on how using LiveObjects contributes to your billable usage, see [Billing](https://ably.com/docs/liveobjects/concepts/billing.md).

### Realtime API 

When using the realtime client libraries, LiveObjects usage is billed as follows:

* [State synchronization](https://ably.com/docs/liveobjects/concepts/synchronization.md#client-objects): On first attachment to a channel, or during resynchronization after a loss of continuity, the full state of channel objects is streamed to the client as [object messages](https://ably.com/docs/metadata-stats/stats.md#messages). Each object message received is counted as one message. Large objects may be streamed across multiple object messages, each counted individually. Ably streams objects with a [tombstone](https://ably.com/docs/liveobjects/concepts/objects.md#tombstones) to maintain state consistency but these objects are not included in billing counts.
* [Object operations](https://ably.com/docs/liveobjects/concepts/operations.md): Creating or updating an object generates an _operation_, which is sent as an object message on the channel and billed accordingly. For example, if a user increments a counter, one object message is sent. If 10 clients subscribed to object messages receive it, that counts as 11 messages in total. Any client attached to a channel with `object-subscribe` capability is subscribed to all object messages on that channel.
* [Batch operations](https://ably.com/docs/liveobjects/batch.md): Multiple operations grouped into a batch are sent as a single object message and billed as one.

### REST API 

When using the [LiveObjects REST API](https://ably.com/docs/liveobjects/rest-api-usage.md), usage is billed as follows:

* [Fetching objects](https://ably.com/docs/liveobjects/rest-api-usage.md#fetching-objects): You are billed per object returned in the response.
* [Publishing operations](https://ably.com/docs/liveobjects/rest-api-usage.md#publishing-operations): Each published operation is billed as a single message sent. Batch operations are also counted as one message, regardless of the number of operations included.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
