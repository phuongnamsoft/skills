# Object storage

## Default object storage 

Ably durably stores all objects on a channel for a configurable retention period between 24 hours and 90 days, defaulting to 90 days. If the data is not updated within the retention period, it automatically expires. After expiry, the channel is reset to its initial state and only includes an empty <If lang="javascript">[channel object](https://ably.com/docs/liveobjects/concepts/objects.md#channel-object)</If><If lang="swift,java">[root object](https://ably.com/docs/liveobjects/concepts/objects.md#root-object)</If>.

<Aside data-type='note'>
If you need a retention period longer than 90 days, please [get in touch](https://ably.com/support) with your requirements.
</Aside>

## Store objects outside of Ably 

You can store your objects outside of Ably by obtaining the channel objects via the [REST API](https://ably.com/docs/liveobjects/rest-api-usage.md#fetching-objects) and storing them in your own database. This is useful if you want to keep a permanent record of the objects on a channel or if you want to perform analytics on the data.

In order to receive notifications when the objects on a channel are updated, use [inband objects](https://ably.com/docs/liveobjects/inband-objects.md) to receive updates as regular channel messages.

<Aside data-type='note'>
If you're interested in exporting objects to your own systems using [integration rules](https://ably.com/docs/platform/integrations/webhooks.md), please [get in touch](https://ably.com/support) with your requirements.
</Aside>

## Operation storage 

When you update an object, the change is expressed as an [operation](https://ably.com/docs/liveobjects/concepts/operations.md). Ably sends this as an [object message](https://ably.com/docs/metadata-stats/stats.md#messages) on the channel. Like all messages, Ably stores object messages for two minutes by default.

This means that if a client disconnects from Ably for a short period of time, it can automatically retrieve any operations it may have missed when it reconnects. If a client disconnects for longer than two minutes, Ably sends the client the latest state of the objects on the channel (which are durably stored) when it reconnects, ensuring the client remains fully synchronized.

Operations themselves are not included in the [history](https://ably.com/docs/storage-history/history.md) or [rewind](https://ably.com/docs/channels/options/rewind.md) backlog of a channel. Instead, you should interact with objects directly via the client library.

<Aside data-type='usp'>
Two-tier recovery

Short disconnections (under two minutes) are resolved by replaying missed operations via [automatic connection recovery](https://ably.com/docs/platform/architecture/connection-recovery.md), while longer disconnections trigger a full resync from durable storage. Either way, clients always converge to the correct state automatically.
</Aside>

## Object size limit 

All objects on a channel share an aggregate size limit, which defaults to 6.5 MB. This is the combined size of every `LiveMap` and `LiveCounter` on the channel. There is no limit on the number of individual objects. When calculating the aggregate size, Ably excludes any object or map entry with a [tombstone](https://ably.com/docs/liveobjects/concepts/objects.md#tombstones), as well as any [unreachable](https://ably.com/docs/liveobjects/concepts/objects.md#reachability) objects.

<Aside data-type='note'>
If you're interested in storing a larger amount of data on a channel, please [get in touch](https://ably.com/support) with your requirements.
</Aside>

### Operation size 

Operations are limited by the message size limit of 64 KiB. This means that you cannot initialize an object with data larger than 64 KiB in a single operation. However, an object can grow beyond this size through incremental updates, for example by using a series of `set` operations on a `LiveMap`.

### Size calculation 

A `LiveCounter` is a double-precision floating-point number and has a size of 8 bytes.

The size of a `LiveMap` object is calculated as the sum of the length of all keys plus the size of all values where:

* `string` values are the length of the string
* `number` values are 8 bytes
* `boolean` values are 1 byte
* `bytes` values are the length of the byte array
* JSON-serializable object or array values are equal to the length of their corresponding JSON strings

For more information, see [limits](https://ably.com/docs/platform/pricing/limits.md).

## Related Topics

- [Batch operations](https://ably.com/docs/liveobjects/batch.md): Group multiple objects operations into a single channel message to apply grouped operations atomically and improve performance.
- [Lifecycle events](https://ably.com/docs/liveobjects/lifecycle.md): Understand lifecycle events for Objects, LiveMap and LiveCounter to track synchronization events and object deletions.
- [Typing](https://ably.com/docs/liveobjects/typing.md): Type objects on a channel for type safety and code autocompletion.
- [Inband objects](https://ably.com/docs/liveobjects/inband-objects.md): Subscribe to LiveObjects updates from Pub/Sub SDKs.
- [Using the REST SDK](https://ably.com/docs/liveobjects/rest-sdk-usage.md): Learn how to work with Ably LiveObjects using the REST SDK
- [Using the REST API](https://ably.com/docs/liveobjects/rest-api-usage.md): Learn how to work with Ably LiveObjects using the REST API

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
