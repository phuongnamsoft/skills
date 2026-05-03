# Channel Metadata

## Types 

The payload of metadata events for channels is the [`ChannelDetails`](#channel-details) type which contains the `channelId` and other static information about the channel, plus a `status` containing a [`ChannelStatus`](#channel-status) instance which contains information about the current state of the channel.

### ChannelDetails 

`ChannelDetails` is an object returned when requesting or receiving [channel metadata](https://ably.com/docs/metadata-stats/metadata.md). It contains information on the channel itself, along with the current state of the channel in the [ChannelStatus](#channel-status) object.

| Name | Description | Type |
|------|-------------|------|
| channelId | the required name of the channel including any qualifier, if any | `string` |
| region | in events relating to the activity of a channel in a specific region, this optionally identifies the region | `string` |
| isGlobalMaster | in events relating to the activity of a channel in a specific region, this optionally identifies whether or not that region is responsible for global coordination of the channel | `boolean` |
| status | an optional [`ChannelStatus`](#channel-status) instance | [`ChannelStatus`](#channel-status) |

The following is an example of a `ChannelDetails` JSON object:

<Code>

#### Json

```
{
  "channelId": "foo",
  "status": {
    "isActive": true,
    "occupancy": {
      "metrics": {
        "connections": 1,
        "publishers": 1,
        "subscribers": 1,
        "presenceConnections": 1,
        "presenceMembers": 0,
        "presenceSubscribers": 1,
        "objectPublishers": 1,
        "objectSubscribers": 1
      }
    }
  }
}
```
</Code>

### ChannelDetails.ChannelStatus 

`ChannelStatus` is contained within the [`ChannelDetails`](#channel-details) object, and optionally contains an [Occupancy](#occupancy) object.

| Name | Description | Type |
|------|-------------|------|
| isActive | a required boolean value indicating whether the channel that is the subject of the event is active. For events indicating regional activity of a channel this indicates activity in that region, not global activity | `boolean` |
| occupancy | an optional [`Occupancy`](#occupancy) instance indicating the occupancy of the channel. For events indicating regional activity of a channel this indicates activity in that region, not global activity. | [`Occupancy`](#occupancy) |

### ChannelDetails.ChannelStatus.Occupancy 

Occupancy is optionally contained within the [`ChannelStatus`](#channel-status) object, and contains metadata relating to the occupants of the channel. This is usually contained within the `occupancy` attribute of the [`ChannelStatus`](#channel-status) object.

The `occupancy` attribute contains the `metrics` attribute, which contains the following members:

| Name | Description | Type |
|------|-------------|------|
| connections | the number of connections | `integer` |
| publishers | the number of connections attached to the channel that are authorised to publish | `integer` |
| subscribers | the number of connections attached that are authorised to subscribe to messages | `integer` |
| presenceSubscribers | the number of connections that are authorised to subscribe to presence messages | `integer` |
| presenceConnections | the number of connections that are authorised to enter members into the presence channel | `integer` |
| presenceMembers | the number of members currently entered into the presence channel | `integer` |
| objectPublishers | the number of connections that are authorised to publish updates to objects on the channel | `integer` |
| objectSubscribers | the number of connections that are authorised to subscribe to objects on the channel | `integer` |

## Related Topics

- [Constructor](https://ably.com/docs/api/realtime-sdk.md): Realtime Client Library SDK API reference section for the constructor object.
- [Connection](https://ably.com/docs/api/realtime-sdk/connection.md): Realtime Client Library SDK API reference section for the connection object.
- [Channels](https://ably.com/docs/api/realtime-sdk/channels.md): Realtime Client Library SDK API reference section for the channels and channel objects.
- [Messages](https://ably.com/docs/api/realtime-sdk/messages.md): Realtime Client Library SDK API reference section for the message object.
- [Presence](https://ably.com/docs/api/realtime-sdk/presence.md): Realtime Client Library SDK API reference section for the presence object.
- [Authentication](https://ably.com/docs/api/realtime-sdk/authentication.md): Realtime Client Library SDK API reference section for authentication.
- [History](https://ably.com/docs/api/realtime-sdk/history.md): Realtime Client Library SDK API reference section for the history methods.
- [Push Notifications - Admin](https://ably.com/docs/api/realtime-sdk/push-admin.md): Realtime Client Library SDK API reference section for push notifications admin.
- [Push Notifications - Devices](https://ably.com/docs/api/realtime-sdk/push.md): Realtime Client Library SDK API reference section for push notification device subscription.
- [Encryption](https://ably.com/docs/api/realtime-sdk/encryption.md): Realtime Client Library SDK API reference section for the crypto object.
- [Statistics](https://ably.com/docs/api/realtime-sdk/statistics.md): Realtime Client Library SDK API reference section for the stats object.
- [Types](https://ably.com/docs/api/realtime-sdk/types.md): Realtime Client Library SDK API reference section for types.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
