# Channel Status

## Types 

The payload of metadata events for channels is the [`ChannelDetails`](#channel-details) type which contains the `channelId` (AKA the [channel's name](https://ably.com/docs/api/realtime-sdk/channels.md#name)) and other static information about the channel, plus a `status` containing a [`ChannelStatus`](#channel-status) instance which contains information about the current state of the channel.

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

- [Constructor](https://ably.com/docs/api/rest-sdk.md): Client Library SDK REST API Reference constructor documentation.
- [Channels](https://ably.com/docs/api/rest-sdk/channels.md): Client Library SDK REST API Reference Channels documentation.
- [Messages](https://ably.com/docs/api/rest-sdk/messages.md): Client Library SDK REST API Reference Message documentation.
- [Presence](https://ably.com/docs/api/rest-sdk/presence.md): Presence events provide clients with information about the status of other clients 'present' on a channel
- [Authentication](https://ably.com/docs/api/rest-sdk/authentication.md): Client Library SDK REST API Reference Authentication documentation.
- [History](https://ably.com/docs/api/rest-sdk/history.md): Client Library SDK REST API Reference History documentation.
- [Push Notifications - Admin](https://ably.com/docs/api/rest-sdk/push-admin.md): Client Library SDK REST API Reference Push documentation.
- [Encryption](https://ably.com/docs/api/rest-sdk/encryption.md): Client Library SDK REST API Reference Crypto documentation.
- [Statistics](https://ably.com/docs/api/rest-sdk/statistics.md): Client Library SDK REST API Reference Statistics documentation.
- [Types](https://ably.com/docs/api/rest-sdk/types.md): Client Library SDK REST API Reference Types documentation.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
