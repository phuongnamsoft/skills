# Integrations overview

Ably integrations enable you to send your data from Ably to an external service or push data into Ably from an external service.

## Inbound integrations 

Inbound integrations are where one of your external systems is sending data into Ably.

* [Inbound webhooks](https://ably.com/docs/platform/integrations/inbound/webhooks.md) enable you to configure an endpoint for generated requests to be picked up by Ably and published to a channel.
* The [Kafka connector](https://ably.com/docs/platform/integrations/inbound/kafka-connector.md) enables you to send data from one or more Kafka topics into Ably channels.

## Outbound webhooks 

[Outbound webhooks](https://ably.com/docs/platform/integrations/webhooks.md) enable you to push data to an external system from within Ably. These events that happen within Ably include messages being published to a channel, presence events being emitted, and changes in the channel occupancy and activity.

The following pre-built webhooks can be configured:

* [AWS Lambda functions](https://ably.com/docs/platform/integrations/webhooks/lambda.md)
* [Google Cloud functions](https://ably.com/docs/platform/integrations/webhooks/gcp-function.md)
* [Zapier](https://ably.com/docs/platform/integrations/webhooks/zapier.md)
* [Cloudflare Workers](https://ably.com/docs/platform/integrations/webhooks/cloudflare.md)
* [IFTTT](https://ably.com/docs/platform/integrations/webhooks/ifttt.md)
* [Datadog](https://ably.com/docs/platform/integrations/streaming/datadog.md)

## Outbound streaming 

[Outbound streaming](https://ably.com/docs/platform/integrations/streaming.md) involves streaming a constant flow of data from Ably to other streaming or queuing services. This is useful for integrating Ably with large-scale, event-driven architectures or data pipelines.

The following pre-built services can be configured:

* [Kafka](https://ably.com/docs/platform/integrations/streaming/kafka.md)
* [AWS Kinesis](https://ably.com/docs/platform/integrations/streaming/kinesis.md)
* [AMQP](https://ably.com/docs/platform/integrations/streaming/amqp.md)
* [AWS SQS](https://ably.com/docs/platform/integrations/streaming/sqs.md)
* [Apache Pulsar](https://ably.com/docs/platform/integrations/streaming/pulsar.md)

## Message queues 

[Message queues](https://ably.com/docs/platform/integrations/queues.md) enable asynchronous communication between a queueing pattern. Producers (Ably channels) publish messages to a queue, and consumers retrieve them in a first-in, first-out order.

Whilst pub-sub channels broadcast messages to all subscribers, queues distribute work among consumers. Both patterns serve different use cases. For example, pub/sub is ideal for many users to receive realtime updates, while queues handle tasks like triggering emails efficiently.

## Skip integrations 

Privileged users can [skip integrations](https://ably.com/docs/platform/integrations/skip-integrations.md) on a per-message basis, providing greater control and flexibility when publishing messages to a channel.

## Related Topics

- [Message Queues](https://ably.com/docs/platform/integrations/queues.md): Ably queues provide a queueing mechanism to integrate Ably with your external service.
- [Skip integrations](https://ably.com/docs/platform/integrations/skip-integrations.md): Learn how to skip integrations on a per-message basis, including examples for skipping all or specific integration rules.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
