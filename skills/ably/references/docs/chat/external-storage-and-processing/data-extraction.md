# Extract messages via integrations

Extract chat messages from Ably Chat rooms to external systems using Ably's integration capabilities. This enables you to process, store, or analyze messages outside of Ably Chat while maintaining realtime message delivery to chat participants.

Chat rooms are built on Ably Pub/Sub channels, allowing you to leverage the full range of Ably's [platform integrations](https://ably.com/docs/platform/integrations.md) to forward messages to external systems.

## Integration types 

Ably provides three primary types of integration for extracting chat messages:

* [Webhooks](#webhooks) forward messages to [HTTP endpoints](https://ably.com/docs/platform/integrations/webhooks/generic.md), [AWS Lambda](https://ably.com/docs/platform/integrations/webhooks/lambda.md), [Google Cloud Functions](https://ably.com/docs/platform/integrations/webhooks/gcp-function.md), and [Cloudflare Workers](https://ably.com/docs/platform/integrations/webhooks/cloudflare.md).
* [Streaming](#streaming) sends messages to external systems like [Kafka](https://ably.com/docs/platform/integrations/streaming/kafka.md), [Kinesis](https://ably.com/docs/platform/integrations/streaming/kinesis.md), [SQS](https://ably.com/docs/platform/integrations/streaming/sqs.md), [AMQP](https://ably.com/docs/platform/integrations/streaming/amqp.md), or [Pulsar](https://ably.com/docs/platform/integrations/streaming/pulsar.md).
* [Queues](#queues) route messages to [Ably-managed queues](https://ably.com/docs/platform/integrations/queues.md) for consumption by your services.

Each type offers different trade-offs in terms of simplicity, reliability, and infrastructure requirements.

## Filtering rooms 

Integrations can be configured to match and forward messages from specific chat rooms based on channel name patterns. This enables you to configure any number of integrations for different use cases and apply them to relevant rooms.

### Channel names and room names 

Chat rooms are underpinned by Ably Pub/Sub channels with a `::$chat` suffix added to form the full channel name. When using the Chat SDK to create or get a room, this is done automatically - you don't need to include the suffix yourself.

Integration filters match against the full channel name, but you don't need to include the `::$chat` suffix in your filter pattern.

<Code>

#### Javascript

```
// Get a chat room - the room name becomes the channel name with ::$chat suffix
const supportRoom = await chatClient.rooms.get('chat:support');
// Underlying channel: chat:support::$chat

// Messages sent to these rooms will trigger an integration
// if your channel filter is: ^chat:support.*
await supportRoom.messages.send({ text: 'Need help' });

// Messages sent to other channel patterns will NOT trigger the integration
const generalRoom = await chatClient.rooms.get('chat:general');
// Underlying channel: chat:general::$chat
await generalRoom.messages.send({ text: 'Hi' }); // Won't trigger if filter is ^chat:support.*
```
</Code>

### Setting up filters 

When configuring an integration in your Ably dashboard, set the channel filter to a regular expression that matches the room names you want to target. For example, `^support:.*` matches all rooms starting with `support:`. Set the event type to `channel.message` to forward chat messages and exclude presence events. Enable enveloped messages to receive full message metadata including `serial`, `version`, and `headers`.

#### Namespace best practices 

Group related chat rooms under a common namespace using colon-separated prefixes. This enables you to efficiently filter and route messages to different integrations based on their purpose.

For example:
- `gamechat:<room-id>` for game chat rooms.
- `support:<ticket-id>` for support conversations.
- `team:<team-id>` for team collaboration.

If new channels are created in a namespace, they will automatically be included without needing to update the filter.

### Example filter configuration

<Code>

#### Javascript

```
// Room name: support:ticket-123
// Filter pattern: ^support:.*
// Result: Messages from support:ticket-123 will be forwarded
const supportRoom = await chatClient.rooms.get('support:ticket-123');
await supportRoom.messages.send({ text: 'Help needed' }); // Will trigger integration
```
</Code>

## Decoding messages 

Messages received through integrations are encoded as Ably Pub/Sub messages and need to be decoded into Chat messages. The Ably Pub/Sub JavaScript SDK exposes [functions](#decode-data) you can use to handle this, or you can see the page on [chat integrations](https://ably.com/docs/chat/integrations.md) for more details on how to manually decode messages.

By default, these messages are sent in an envelope containing additional structured metadata, such as the channel name, app ID, and integration ID.

### Understanding enveloped messages 

With enveloping enabled (recommended), messages arrive wrapped in useful metadata:

<Code>

#### Javascript

```
{
  "source": "channel.message",
  "appId": "your-app-id",
  "channel": "support:ticket-123::$chat",
  "ruleId": "integration-rule-id",
  "messages": [
    {
      "id": "unique-message-id",
      "clientId": "user-123",
      "name": "chat.message",
      "timestamp": 1234567890,
      "serial": "01765820788939-000@108wgxjJwBwuAB37648671:000",
      "action": 0,
      "version": {
        "serial": "01765820788939-000@108wgxjJwBwuAB37648671:000",
        "timestamp": 1234567890
      },
      "data": {
        "text": "Message content",
        "metadata": {}
      },
      "extras": {
        "headers": {}
      }
    }
  ]
}
```
</Code>

### Extracting the room name 

The enveloped payload contains the underlying channel name from which the contained messages originated. To get the corresponding room name, remove the `::$chat` suffix from the string value of the `channel` field:

<Code>

#### Javascript

```
function extractRoomName(channelName) {
  // channelName: "support:ticket-123::$chat"
  return channelName.replace('::$chat', ''); // Returns: "support:ticket-123"
}
```
</Code>

This room name can then be used to interact with the Chat SDK as needed.

### Decoding message data 

You can use the Ably Pub/Sub JavaScript SDK to decode messages from the envelope:

<Code>

#### Javascript

```
const Ably = require('ably');

function decodeMessages(envelopeData) {
  const decodedMessages = Ably.Realtime.Message.fromEncodedArray(envelopeData.messages);

  return decodedMessages.map(msg => ({
    serial: msg.serial,
    text: msg.data?.text,
    metadata: msg.data?.metadata || {},
    headers: msg.extras?.headers || {},
    clientId: msg.clientId,
    timestamp: msg.timestamp,
    action: msg.action,
    versionSerial: msg.version?.serial || msg.serial
    versionTimestamp: msg.version?.timestamp || msg.timestamp
  }));
}
```
</Code>

## Using metadata and headers 

Metadata and headers enable you to control how messages are processed by external systems and add context for integration logic.

### Metadata

Message [`metadata`](https://ably.com/docs/chat/rooms/messages.md#structure) is set by the client when sending a message. Use metadata for storing JSON-serializable structured data relevant to your application logic.

For example, if triggering some notification process from a particular client, you might include user or intent information in the metadata:

<Code>

#### Javascript

```
// Client sends message with metadata
await room.messages.send({
  text: '@john.123 Hey, how are you?',
  metadata: {
    targetClientId: 'User123',
    type: 'mention',
    location: 'London',
    language: 'en',
  }
});
```
</Code>

<Aside data-type='important'>
Metadata is not server-validated. Always treat it as untrusted user input in your integration code.
</Aside>

### Headers

Message [`headers`](https://ably.com/docs/chat/rooms/messages.md#structure) can be set by the client when sending a message, similar to metadata. However, they are more typically used for [filtering](https://ably.com/docs/pub-sub/advanced.md#filter-subscribe) subscriptions and routing for integrations.

For example, you might include headers to indicate the type of processing required by your integration:

<Code>

#### Javascript

```
// Client sends message with headers
await room.messages.send({
  text: '@john.123 Hey, how are you?',
  metadata: {
    targetClientId: 'john.123',
    type: 'mention',
    location: 'London',
    timestamp: Date.now()
  }
}, {
  extras: {
    headers: {
      'x-intent': 'notification',
      'x-priority': 'high'
    }
  }
});
```
</Code>

#### Adding headers at the integration level

When configuring an integration in your Ably dashboard, you can specify headers to be added when the integration triggers. This allows you to attach additional metadata to messages only when they match your integration criteria.

These integration-level headers are added after the client publishes the message, so they appear in the enveloped message received by your integration endpoint but not in the original message stored in chat history. They will also not be visible to other chat clients.

<Aside data-type='important'>
Carefully validate and sanitize all data in your integration code before using it for business logic or security decisions.
</Aside>

## Message ordering and versioning 

Chat message `serial` and `version.serial` fields are [globally unique and lexicographically sortable](https://ably.com/docs/chat/rooms/messages.md#global-ordering) strings that enable you to correctly order chat messages even when they arrive out of sequence. Together with the `action` field, these properties allow you to handle message creation, updates, deletions, and reaction summaries in the correct order.

* `serial` is the unique identifier for the original message and remains constant across all versions.
* `version.serial` identifies a specific message version and is only populated for updated or deleted messages.
* `action` indicates the message type: `message.created`, `message.updated`, `message.deleted`, or `message.summary` for [reactions](#reactions).

When receiving messages through integrations, `version.serial` will only be present if the message has been updated or deleted. Messages with `action` set to `message.created` or `message.summary` do not have `version.serial` populated.

### Determining message order 

Use `serial` and `version.serial` fields to determine the [correct order of messages](https://ably.com/docs/chat/rooms/messages.md#ordering-update-delete) and apply updates or deletions appropriately.

To compare different messages, compare their `serial` fields to determine which was sent first. A lexicographically higher `serial` value indicates a newer message. When both messages share the same `serial` (indicating different versions of the same message), compare their `version.serial` values instead. A lexicographically higher `version.serial` indicates a more recent update or delete operation.

### Handling out-of-order delivery

Messages may arrive out of order due to network conditions, retry logic, or when consuming from multiple integration sources. To handle this correctly, compare the incoming message against what you have stored and only process it if it is newer:

<Code>

#### Javascript

```
function shouldProcessMessage(incoming, stored) {
  // If this is a new message we haven't seen before, always process it
  if (!stored) return true;

  // Same message (matching serial) - check if this is a newer version
  if (incoming.serial === stored.serial) {
    // Only process if the incoming version is newer than what we have
    return incoming.version?.serial > stored.version?.serial;
  }

  // Different message entirely - process it
  return true;
}
```
</Code>

This approach ensures you always maintain the most recent version of each message, regardless of delivery order.

### Handling message reactions 

[Message reactions](https://ably.com/docs/chat/rooms/message-reaction.md) are delivered as separate events with `action` set to `message.summary`. These events contain aggregated reaction counts in the `annotations` field, which you can use to update stored reaction totals:

<Code>

#### Javascript

```
// Example message.summary payload
{
  "action": "message.summary",
  "serial": "original-message-serial",
  "annotations": {
    "summary": {
      "reaction:unique.v1": {
        "👍": { "count": 5 },
        "❤️": { "count": 3 }
      }
    }
  }
}

## Using webhooks <a id="webhooks"/>

[Outbound webhooks](https://ably.com/docs/platform/integrations/webhooks.md) enable you to forward messages to HTTP endpoints or serverless functions.

Webhooks are the simplest integration type to implement, requiring no additional infrastructure beyond your webhook endpoint or serverless function. They provide automatic retry handling with configurable retry windows, and messages can be batched together to reduce invocation overhead.

### Setup

[Configure a webhook](https://ably.com/docs/platform/integrations/webhooks.md) integration in your Ably dashboard pointing to your endpoint. Supported webhooks include generic HTTP endpoints, AWS Lambda, Google Cloud Functions, and Cloudflare Workers.

### Considerations

Messages may arrive out of order, so use `serial` and `version.serial` to sort them correctly. Webhooks provide at-least-once delivery, meaning you should handle potential duplicates using message serials. Messages may be dropped if retries exceed the retry window.

Retry behavior varies by platform. For example, AWS Lambda automatically retries failed invocations up to two times with delays of 1 minute, then 2 minutes. Use the [`[meta]log` channel](#monitoring-performance) to detect failures.

## Using streaming <a id="streaming"/>

[Outbound streaming](https://ably.com/docs/platform/integrations/streaming.md) enables you to stream a constant flow of chat messages to external streaming or queueing services.

Streaming integrations enable you to leverage your existing streaming infrastructure with full control over retention and processing, providing massive scale capabilities for high-volume message flows.

### Setup

Configure [streaming](https://ably.com/docs/platform/integrations/streaming.md) to your target system in the Ably dashboard. Supported integrations include Kafka, Kinesis, SQS, AMQP, and Pulsar.

### Considerations

You manage and maintain the streaming infrastructure yourself, which means higher operational overhead compared to webhooks. Messages may be lost if the target system is unavailable, as there is no built-in retry mechanism on Ably's side. Ensure your streaming infrastructure is provisioned for the expected message volume.

### Example consumer

The following example shows consuming chat messages from Kafka. The same pattern applies for other streaming targets - decode the envelope and process the messages:

<Code>
```javascript
const { Kafka } = require('kafkajs');

async function consumeFromKafka() {
  const consumer = kafka.consumer({ groupId: 'chat-processor' });
  await consumer.connect();
  await consumer.subscribe({ topic: 'ably-chat-messages' });

  await consumer.run({
    eachMessage: async ({ message }) => {
      const envelope = JSON.parse(message.value);
      const roomName = extractRoomName(envelope.channel);
      const decoded = decodeMessages(envelope);

      await processMessages(roomName, decoded);
    }
  });
}
```
</Code>

## Using queues <a id="queues"/>

[Ably Queues](https://ably.com/docs/platform/integrations/queues.md) are traditional message queues that enable you to consume, process, or store chat messages from your servers.

Ably Queues provide fault-tolerant message delivery with at-least-once delivery guarantees. Messages persist during consumer downtime up to queue limits, and a dead letter queue automatically captures dropped messages for monitoring and recovery.

### Setup

Configure an [Ably queue](https://ably.com/docs/platform/integrations/queues.md) integration in your dashboard:

1. [Provision a queue](https://ably.com/docs/platform/integrations/queues.md#provision) with your desired region, TTL, and max length settings.
2. [Create a queue integration](https://ably.com/docs/platform/integrations/queues.md#config) to route chat messages to the queue.
3. Consume messages using [AMQP](https://ably.com/docs/platform/integrations/queues.md#amqp) or [STOMP](https://ably.com/docs/platform/integrations/queues.md#stomp) protocols.

### Considerations

The default maximum queue size is 10,000 messages, so monitor queue length during peak times to avoid reaching capacity. Messages expire after 60 minutes (the default and maximum TTL) if not consumed. A dead letter queue is automatically provisioned and you should always consume from it to monitor for dropped or expired messages.

Multi-tenanted queues support up to 200 messages per second per account. For higher volumes, consider [dedicated queues or streaming](https://ably.com/docs/platform/integrations/queues.md#scalability). Messages maintain order per channel with a single consumer, but multiple consumers or multi-channel messages may affect ordering.

### Example queue consumer (AMQP)

<Code>

#### Javascript

```
const amqp = require('amqplib');

// Queue name format: APPID:queue-name
const queueName = 'your-app-id:chat-messages';
// Avoid hardcoding credentials in production
const url = 'amqps://APPID.KEYID:SECRET@us-east-1-a-queue.ably.io/shared';

amqp.connect(url, (err, conn) => {
  if (err) { return console.error(err); }

  conn.createChannel((err, ch) => {
    if (err) { return console.error(err); }

    // Subscribe to the queue
    ch.consume(queueName, (item) => {
      const envelope = JSON.parse(item.content);
      const roomName = envelope.channel.replace('::$chat', '');

      // Decode messages using Ably SDK
      const messages = Ably.Realtime.Message.fromEncodedArray(envelope.messages);

      messages.forEach(async (message) => {
        await processMessage(roomName, message);
      });

      // Acknowledge message to remove from queue
      ch.ack(item);
    });
  });
});
```
</Code>

### Monitor the dead letter queue <a id="dead-letter-queue"/>

Ably automatically provisions a [dead letter queue](https://ably.com/docs/platform/integrations/queues.md#deadletter) when you create a queue. Messages are moved to the dead letter queue when they:

* Are rejected by consumers (`basic.reject` or `basic.nack` with `requeue=false`).
* Exceed their TTL and expire.
* Cause the queue to reach maximum capacity (oldest messages dropped).

The dead letter queue name follows the format `APPID:deadletter` and can be consumed using AMQP or STOMP, the same as any other queue.

<Aside data-type='note'>
  Only one dead letter queue exists per Ably application, shared across all queues.
</Aside>

## Monitoring integration performance <a id="monitoring-performance"/>

Monitor the health and performance of your integrations in realtime using Ably's [metachannels](https://ably.com/docs/metadata-stats/metadata/subscribe.md). Metachannels provide app-level metadata about integrations, statistics, and errors.

### Monitor integration errors <a id="monitor-errors"/>

The [`[meta]log` channel](/docs/metadata-stats/metadata/subscribe#log) publishes error events from integrations in realtime. This enables you to detect and respond to integration failures as they occur.

Subscribe to the `[meta]log` channel to receive error events:

<Code>

#### Javascript

```
const Ably = require('ably');
const client = new Ably.Realtime({ key: 'your-api-key' });

const metaLogChannel = client.channels.get('[meta]log');

await metaLogChannel.subscribe((message) => {
  if (message.data.error) {
    alertOperationsTeam(message.data);
  }
});
```
</Code>

Integration error logs will contain a `tag` field as part of the `data` payload, indicating the integration type - for example, `reactor.generic.http` for webhooks. This allows you to filter and categorize errors by integration type.

<Aside data-type='note'>
The `[meta]log` channel only publishes errors that cannot be directly reported to clients. For example, webhook delivery failures or queue publishing errors.
</Aside>

### Monitor app statistics <a id="monitor-stats"/>

The [`[meta]stats:minute` channel](/docs/metadata-stats/metadata/subscribe#stats) publishes [app-level statistics](https://ably.com/docs/metadata-stats/stats.md) every minute. Use these statistics to monitor integration throughput, message volumes, and resource usage.

Subscribe to receive statistics updates:

<Code>

#### Javascript

```
const statsChannel = client.channels.get('[meta]stats:minute');

await statsChannel.subscribe('update', (event) => {
  const stats = event.data.entries;

  // Monitor integration-specific metrics
  console.log('Integration stats:', {
    webhooks: stats['messages.outbound.webhook.messages.count'] || 0,
    queues: stats['messages.outbound.sharedQueue.messages.count'] || 0,
    // Add other metrics as needed
  });

  // Alert on anomalies
  if (stats['messages.outbound.webhook.all.failed'] > threshold) {
    alertOnWebhookFailures(stats);
  }
});
```
</Code>

Use the [rewind channel option](https://ably.com/docs/channels/options/rewind.md) to retrieve the most recent statistics immediately:

<Code>

#### Javascript

```
// Get the last statistics event plus subscribe to future updates
const statsChannel = client.channels.get('[meta]stats:minute', {
  params: { rewind: '1' }
});

statsChannel.subscribe('update', (event) => {
  console.log('Stats:', event.data.entries);
});
```
</Code>

### Integration monitoring best practices 

Subscribe to both the [`[meta]log`](/docs/metadata-stats/metadata/subscribe#log) channel for error detection and [`[meta]stats:minute`](/docs/metadata-stats/metadata/subscribe#stats) for performance monitoring. Set up automated alerts for integration failures or throughput anomalies, and store statistics over time to identify patterns and capacity planning needs.

You can use the statistics entries to monitor specific integration types such as webhooks, queues, and streaming independently. Use the `requestId` from error events to correlate with your own system logs.

## Related Topics

- [Overview](https://ably.com/docs/chat/external-storage-and-processing.md): Extract, store, and process chat messages from Ably Chat using integrations.
- [Data processing](https://ably.com/docs/chat/external-storage-and-processing/data-processing.md): Process chat messages through external systems to trigger notifications, handle slash commands, analyze sentiment, and more.
- [Data storage](https://ably.com/docs/chat/external-storage-and-processing/data-storage.md): Store chat messages from Ably Chat in your own data store for long-term retention, compliance, and analytics.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
