# Datadog integration

The Ably [Datadog](https://docs.datadoghq.com/integrations/ably/) integration enables you to monitor your application's statistics. Every 60 seconds, Ably streams a comprehensive set of [statistics](https://ably.com/docs/metadata-stats/stats.md#metrics) to the Datadog API.

<Aside data-type="note">
DataDog is available to [Enterprise](https://ably.com/docs/platform/pricing/enterprise.md) packages. A [DataDog Lite](#lite) version is available to [Standard](https://ably.com/docs/platform/pricing/standard.md) and [Pro](https://ably.com/docs/platform/pricing/pro.md) packages.
</Aside>

## Setup the Datadog integration 

To connect Ably with Datadog, authorize the integration through Datadog's [OAuth](https://docs.datadoghq.com/developers/integrations/oauth_for_integrations/) flow. This process requires the `api_keys_write` scope, allowing Ably to push data to your Datadog account.

Once the integration is active, Datadog provides a specific Ably [dashboard](https://docs.datadoghq.com/integrations/ably/), enabling you to monitor key metrics without extra setup.

The following steps setup the Datadog integration:

1. In Datadog, go to **Integrations**, find the **Ably** tile, and click **Install Integration**.
2. Click **Connect Accounts** to start the authorization process. Datadog redirects you to Ably.
3. Log in to your **Ably** account.
4. Select your application from the **Your Apps** page.
5. Navigate to **Integrations**, and select **Connect to Datadog**.
6. Datadog authorization page, authorize Ably using **OAuth** to grant access. The required authorization scope is: `api_keys_write`.
7. After completing authorization, you will be redirected to the **Ably dashboard**, and the process is complete.

## Remove access 

Removing access disconnects Ably from Datadog, stopping data transmission and revoking authorization. Follow the steps remove the Ably and Datadog integration using either platform.

### Remove access using Ably 

* Open your application's integration settings.
* Click **Remove** next to the Datadog integration.
* Ably revokes OAuth credentials and stops metric transmission.

### Remove access using Datadog 

* Remove associated Ably API keys via **Integrations** or **API Keys**.
* Adjust scopes or entirely revoke OAuth tokens if necessary.

## Datadog lite 

Datadog Lite is a lightweight version of the full Datadog integration that sends a reduced set of [statistics](https://ably.com/docs/metadata-stats/stats.md#metrics) to the Datadog API. This integration is designed for use cases where full statistics are not required, such as when you only need to monitor a limited number channels or connections.

DataDog Lite is available to [Pro](https://ably.com/docs/platform/pricing/pro.md) packages. A 30-day trial is also available to [Standard](https://ably.com/docs/platform/pricing/standard.md) packages, which can be enabled by contacting [Ably support](https://ably.com/support).

The following statistics are streamed from Ably to Datadog using the Lite integration:

| Metric Name | Description |
| ----------- | ----------- |
|`messages.all.all.count`|Total number of messages that were successfully sent, summed over all message types and transports.|
|`messages.all.all.billableCount`|Total number of billable messages that were successfully sent, summed over all message types and transports.|
|`messages.all.all.data`|Total message size of all messages that were successfully sent, summed over all message types and transports.|
|`messages.all.all.uncompressedData`|Total uncompressed message size, excluding delta compression.|
|`messages.all.all.failed`|Total number of messages that failed. These are messages which did not succeed for some reason other than Ably explicitly refusing them, such as they were rejected by an external integration target, or a service issue on Ably's side.|
|`messages.all.all.refused`|Total number of messages that were refused by Ably. For example, due to rate limiting, malformed messages, or incorrect client permissions.|
|`messages.all.messages.count`|Total message count, excluding presence and state messages.|
|`messages.all.messages.billableCount`|Total billable message count, excluding presence and state messages.|
|`messages.all.messages.data`|Total message size, excluding presence and state messages.|
|`messages.all.messages.uncompressedData`|Total number of messages that failed. These are messages which did not succeed for some reason other than Ably explicitly refusing them, such as they were rejected by an external integration target, or a service issue on Ably's side.|
|`messages.all.messages.failed`|Total number of messages excluding presence and state messages that failed. These are messages which did not succeed for some reason other than Ably explicitly refusing them, such as they were rejected by an external integration target, or a service issue on Ably's side.|
|`messages.all.messages.refused`|Total number of messages excluding presence and state messages that were refused by Ably. For example, due to rate limiting, malformed messages, or incorrect client permissions.|
|`messages.all.presence.count`|Total presence message count.|
|`messages.all.presence.billableCount`|Total billable presence message count.|
|`messages.all.presence.data`|Total presence message size.|
|`messages.all.presence.uncompressedData`|Total uncompressed presence message size, excluding delta compression.|
|`messages.all.messages.failed`|Total number of presence messages excluding presence and state messages that failed. These are messages which did not succeed for some reason other than Ably explicitly refusing them, such as they were rejected by an external integration target, or a service issue on Ably's side.|
|`messages.all.messages.refused`|Total number of presence messages excluding presence and state messages that were refused by Ably. For example, due to rate limiting, malformed messages, or incorrect client permissions.|
|`messages.inbound.all.all.count`|Total inbound message count, received by Ably from clients.|
|`messages.inbound.all.all.data`|Total inbound message size, received by Ably from clients.|
|`messages.inbound.all.all.uncompressedData`|Total uncompressed inbound message size, excluding delta compression, received by Ably from clients.|
|`messages.inbound.all.all.failed`|Total number of inbound messages that failed. These are messages which did not succeed for some reason other than Ably explicitly refusing them, such as a service issue on Ably's side.|
|`messages.inbound.all.all.refused`|Total number of inbound messages that were refused by Ably. For example, due to rate limiting, malformed messages, or incorrect client permissions.|
|`messages.outbound.all.all.count`|Total outbound message count, sent from Ably to clients.|
|`messages.outbound.all.all.billableCount`|Total billable outbound message count, sent from Ably to clients.|
|`messages.outbound.all.all.data`|Total outbound message size, sent from Ably to clients.|
|`messages.outbound.all.all.uncompressedData`|Total uncompressed outbound message size, excluding delta compression, sent from Ably to clients.|
|`messages.outbound.all.all.failed`|Total number of outbound messages that failed. These are messages which did not succeed for some reason other than Ably explicitly refusing them, such as rejection by an external integration target, or a service issue on Ably's side.|
|`messages.outbound.all.all.refused`|Total number of outbound messages that were refused by Ably. This is generally due to rate limiting.|
|`connections.all.peak`	|Peak connection count.|
|`channels.peak` |Peak active channel count.|
|`push.channelMessages`	|Total number of channel messages published over Ably that contained a push payload. Each of these may have triggered notifications to be sent to a device with a matching registered push subscription.|
|`messages.persisted.messages.count` |Total count of persisted messages, excluding presence and state messages.|
|`messages.persisted.messages.data`	|Total size of persisted messages, excluding presence and state messages.|
|`messages.persisted.messages.uncompressedData`	|Total uncompressed persisted message size, excluding delta compression, and presence and state messages.|
|`messages.persisted.presence.count` |Total count of persisted presence messages.|
|`messages.persisted.presence.data` |Total size of persisted presence messages.|
|`messages.persisted.presence.uncompressedData` |Total uncompressed persisted presence message size, excluding delta compression.|

## Related Topics

- [Overview](https://ably.com/docs/platform/integrations/streaming.md): Outbound streaming integrations enable you to stream data from Ably to an external service for realtime processing.
- [Kafka](https://ably.com/docs/platform/integrations/streaming/kafka.md): Send data to Kafka based on message, channel lifecycle, channel occupancy, and presence events.
- [Kinesis](https://ably.com/docs/platform/integrations/streaming/kinesis.md): Send data to Kinesis based on message, channel lifecycle, channel occupancy, and presence events.
- [AMQP](https://ably.com/docs/platform/integrations/streaming/amqp.md): Send data to AMQP based on message, channel lifecycle, channel occupancy, and presence events.
- [SQS](https://ably.com/docs/platform/integrations/streaming/sqs.md): Send data to SQS based on message, channel lifecycle, channel occupancy, and presence events.
- [Pulsar](https://ably.com/docs/platform/integrations/streaming/pulsar.md): Send data to Pulsar based on message, channel lifecycle, channel occupancy, and presence events.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
