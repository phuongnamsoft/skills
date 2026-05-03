# Occupancy

Occupancy provides high level metrics about the clients attached to a channel. This includes the number of [connections](https://ably.com/docs/connect.md) currently attached to a channel, and the number of connections attached that are permitted to publish and subscribe to the channel.

## Occupancy metric categories 

The following are the metric categories that occupancy reports:

| Metric | Description |
|--------|-------------|
| **connections** | The number of connections |
| **publishers** | The number of connections that are authorized to publish |
| **subscribers** | The number of connections that are authorized to subscribe to messages |
| **presenceSubscribers** | The number of connections that are authorized to subscribe to presence messages |
| **presenceConnections** | The number of connections that are authorized to enter members into the presence channel |
| **presenceMembers** | The number of members currently entered into the presence channel |
| **objectPublishers** | The number of connections that are authorized to publish updates to objects on the channel |
| **objectSubscribers** | The number of connections that are authorized to subscribe to objects on the channel |

## Occupancy payload structure 

Details of a channel's occupancy are returned in the `metrics` property of a payload.

If occupancy is returned as a `[meta]occupancy` event when subscribing to a channel using the [occupancy channel option](https://ably.com/docs/channels/options.md#occupancy), then `metrics` is part of the `data` property. The following is an example of a `[meta]occupancy` event:

<Code>

### Json

```
{
  name: '[meta]occupancy',
  id: 'V12G5ABc_M:0:0',
  timestamp: 1612286351217,
  clientId: undefined,
  connectionId: undefined,
  connectionKey: undefined,
  data: {
    metrics: {
      connections: 1,
      publishers: 1,
      subscribers: 1,
      presenceConnections: 1,
      presenceMembers: 0,
      presenceSubscribers: 1,
      objectPublishers: 1,
      objectSubscribers: 1
    }
  },
  encoding: null,
  extras: undefined,
  size: undefined
}
```
</Code>

If occupancy is returned as part of a [REST request](https://ably.com/docs/metadata-stats/metadata/rest.md), then `metrics` are within a [`ChannelDetails`](https://ably.com/docs/api/realtime-sdk/channel-metadata.md#channel-details) object. The following is an example of a `ChannelDetails` object:

<Code>

### Json

```
{
  data: {
    metrics: {
      connections: 1,
    }
  },
}
```
</Code>

## Retrieve channel occupancy 

Occupancy can be retrieved in the following ways:

* In realtime, by subscribing to a channel with the [`occupancy` channel option](#realtime-occupancy)
* For a single channel using a [REST request](#one-off-requests)
* [Enumerating all active channels](#one-off-requests) in an app
* Configure a [`channel.occupancy` rule source](#integrations) to send occupancy events to an external target, such as AWS Lambda or a webhook

<Aside type="note">
Occupancy updates are also included in events published to the [`[meta]channel.lifecycle` metachannel](/docs/metadata-stats/metadata/subscribe). However, these lifecycle events are only published when channels are opened or closed.
</Aside>

### Realtime occupancy updates 

The [`occupancy` channel option](https://ably.com/docs/channels/options.md#occupancy) enables a client to subscribe to occupancy events related to a channel. Events are delivered to the client as messages on the channel.

### One off occupancy requests 

Occupancy can be queried via REST in the following ways:

* Query a [single channel](https://ably.com/docs/metadata-stats/metadata/rest.md#single) to return its `ChannelDetails`, including its occupancy
* [Enumerate](https://ably.com/docs/metadata-stats/metadata/rest.md#enumerate) a list of active channels in an app, including the occupancy of each

### Integrations 

[Integration rules](https://ably.com/docs/platform/integrations.md) can be configured with `channel.occupancy` set as a rule source. Occupancy events that occur on the selected channels will be pushed to external targets, such as AWS Lambda, or custom webhook endpoints.

## Related Topics

- [Overview](https://ably.com/docs/presence-occupancy.md): Presence and occupancy provide information about clients attached to channels. This includes metrics about the attached clients, and details of the individual members attached to the channel.
- [Presence](https://ably.com/docs/presence-occupancy/presence.md): Presence enables clients to be aware of the other clients present on a channel.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
