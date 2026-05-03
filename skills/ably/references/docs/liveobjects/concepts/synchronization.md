# Synchronization

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

LiveObjects provides a powerful synchronization mechanism to ensure that all clients see the same data. This document explains how synchronization works in LiveObjects.

## Channel objects 

Ably maintains the authoritative state of all objects on each channel across its distributed infrastructure.

Each object instance is identified by a unique [object ID](https://ably.com/docs/liveobjects/concepts/objects.md#object-ids). The channel holds the complete up-to-date data of all objects on the channel.

Ably stores the object data durably such that the data is available even after the channel becomes inactive. The data is stored in multiple regional datacenters and across multiple availability zones. This ensures that the data is available even if there is disruption in one or more datacenters.

When a channel first becomes active in a region, the channel loads the object data from durable storage into memory to facilitate low-latency operation processing.

## Client objects 

While Ably maintains the source of truth on the channel, each connected client keeps a local representation of the objects on the channel.

When the client first attaches to the channel, the state of the channel objects is streamed to the client. Large objects, such as maps with many entries, may be delivered across multiple messages during synchronization. [Lifecycle events](https://ably.com/docs/liveobjects/lifecycle.md#synchronization) allow your application to be notified when the local state is being synchronized with the Ably service.

<If lang="javascript">
<Aside data-type='note'>
Calling [`channel.object.get()`](https://ably.com/docs/liveobjects/concepts/objects.md#channel-object) implicitly attaches to the channel and waits for synchronization.
</Aside>
</If>

All object operations published to the channel are broadcast to subscribed clients, which apply the operations to their local client objects when they are received. This allows clients to maintain a consistent view of the channel objects in a bandwidth-efficient way, since only the operations (rather than the updated objects themselves) are sent over the client's connection.

<If lang="javascript">
<Aside data-type='note'>
When a client publishes an operation, the operation is applied to its local objects as soon as the operation is acknowledged by the Ably system. This means that when a mutation method's promise resolves, the operation has already been applied and you can immediately read the updated state.
</Aside>
</If>
<If lang="swift,java">
<Aside data-type='note'>
When a client publishes an operation, the operation is applied to its local objects as soon as the operation is acknowledged by the Ably system. This means that when a mutation method returns, the operation has already been applied and you can immediately read the updated state.
</Aside>
</If>

If there is a loss of continuity on the channel for any reason, such as the client becoming disconnected for more than two minutes and entering the [suspended state](https://ably.com/docs/connect/states.md#connection-states), the client objects will automatically be resynchronized when it reconnects.

## Related Topics

- [Objects](https://ably.com/docs/liveobjects/concepts/objects.md): Learn how data is represented as objects in Ably LiveObjects
- [PathObject](https://ably.com/docs/liveobjects/concepts/path-object.md): Learn about PathObject, a path-based API for accessing and manipulating LiveObjects data structures
- [Instance](https://ably.com/docs/liveobjects/concepts/instance.md): Learn about Instance, a reference to a specific LiveObject instance for direct manipulation
- [Operations](https://ably.com/docs/liveobjects/concepts/operations.md): Learn how objects are updated by operations in Ably LiveObjects.
- [Billing](https://ably.com/docs/liveobjects/concepts/billing.md): Understand how LiveObjects operations contribute to your Ably usage and billing.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
