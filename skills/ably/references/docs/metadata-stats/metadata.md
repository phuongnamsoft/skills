# Metadata overview

Metadata provides insight into activity within an app. This activity is related to things such as connections, channels and API requests.

Metadata can be used to check if there are any subscribers on a channel before publishing to it. By monitoring [channel lifecycle events](https://ably.com/docs/metadata-stats/metadata/subscribe.md#channel-lifecycle) publishers can know when a channel is opened, becomes active, or is no longer active. This can indicate when the last subscriber has left a channel.

Metadata can also be used to monitor the usage of Ably services for an app. [Sampled connection and requests](https://ably.com/docs/metadata-stats/metadata/subscribe.md#sample) enable statistics to be compiled, and have arbitrary data processing and aggregation performed against them This can provide insight into client population and client activity.

Metadata is returned at the following levels:

* [App-level](#app) data such as the lifecycle of all channels across an app
* [Channel-level](#channel) data such as the occupancy of an individual channel

## App-level metadata 

App-level metadata returns information about a resource across a whole app, such as all connections or all channels.

Examples of app-level metadata include [metachannels](#metachannels) and enumerating all active channels [via REST](#rest).

## Channel-level metadata 

Channel-level metadata returns information about a single channel, such as its [`ChannelDetails`](https://ably.com/docs/api/realtime-sdk/channel-metadata.md#channel-details). This includes information about a channel's occupancy.

Examples of channel-level metadata include the [occupancy channel option](#option) and querying a channel [via REST](#rest).

## Retrieve metadata 

Metadata can be retrieved by:

* Subscribing to [metachannels](#metachannels) to receive metadata events in realtime
* Querying metadata [via REST](#rest) requests
* Using a [channel option](#option) to subscribe to occupancy events
* Using occupancy events as an [integration source](#integrations)

### Subscribe to metachannels 

[Metachannels](https://ably.com/docs/metadata-stats/metadata/subscribe.md) are a special namespace of channels, prefixed with `[meta]`, that provide app-level metadata. An example, is `[meta]channel.lifecycle` which publishes events relating to channels being opened and closed across an app. A further example is `[meta]stats:minute` which publishes app statistics every minute.

<Aside data-type='note'>
Be aware that whilst metachannels publish app-level metadata, some of the events that they publish contain channel-level metadata. An example of this are `[meta]channel.lifecycle` events, which include a [`ChannelDetails`](https://ably.com/docs/api/realtime-sdk/channel-metadata.md#channel-details) object.
</Aside>

### Request via REST 

Metadata can be queried using [REST requests](https://ably.com/docs/metadata-stats/metadata/rest.md) to return channel-level metadata for a single channel, or enumerate through all active channels in an app.

Be aware that this REST API is intended for occasional queries. If you require realtime updates Ably recommends using [metachannels](#metachannels) or an [occupancy channel option](#option) rather than polling.

### Channel option 

The occupancy [channel option](https://ably.com/docs/channels/options.md#occupancy) provides metrics about the clients attached to a channel, such as the number of connections and the number of clients subscribed to the channel. The occupancy channel option returns channel-level metadata as it can be enabled on a channel-by-channel basis.

### Integrations 

[Integrations](https://ably.com/docs/platform/integrations/webhooks.md#sources) can utilize channel occupancy events as a source.

## Related Topics

- [Metadata subscriptions](https://ably.com/docs/metadata-stats/metadata/subscribe.md): Retrieve metadata updates in realtime by subscribing to metachannels.
- [Metadata REST requests](https://ably.com/docs/metadata-stats/metadata/rest.md): Retrieve metadata about single channels, or enumerate through all active channels via REST requests.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
