# External storage and processing

Ably Chat messages can be extracted into external systems for storage, processing, or analysis. This enables you to implement features like AI assistants, long-term storage and compliance systems.

Chat rooms are built on Ably Pub/Sub channels, allowing you to leverage the full range of Ably's [platform integrations](https://ably.com/docs/platform/integrations.md) to forward messages to external systems.

## Process messages with external systems 

Extract and [process messages](https://ably.com/docs/chat/external-storage-and-processing/data-processing.md) through external systems, then respond back to the chat in realtime.

* **AI-powered assistance**: Process commands through language models and respond with helpful information or perform actions on behalf of users.
* **Notifications**: Detect mentions or keywords and trigger custom notification systems.
* **Command processing**: Handle slash commands that invoke server-side logic.
* **Data analysis**: Perform sentiment analysis or topic detection on chat messages.

## Store messages in your database 

Export chat messages to your own database for [long-term storage](https://ably.com/docs/chat/external-storage-and-processing/data-storage.md) and additional capabilities.

* **Compliance and legal requirements**: Meet data retention policies and regulatory requirements.
* **Analytics and business intelligence**: Build dashboards, train ML models, and analyze sentiment.
* **Enhanced functionality**: Implement features that need chat history, such as full-text search.
* **Single source of truth**: Maintain your database as the canonical source.
* **Long-term storage**: Store data for longer than Ably Chat's maximum retention period (365 days).

## How it works 

When using Ably's [platform integrations](https://ably.com/docs/platform/integrations.md) to extract messages from chat rooms:

1. Configure an integration to match specific chat rooms using channel name filters.
2. Ably forwards matching messages to your external system via webhook, queue, or streaming.
3. Your system decodes and processes the messages based on your business logic.

## Integration types 

Choose the integration type that fits your architecture and scale requirements:

| Type | Best for | Delivery guarantee |
|--------|----------|-------------------|
| [Webhooks](https://ably.com/docs/platform/integrations/webhooks.md) | Serverless functions, simple endpoints | At-least-once with limited retry |
| [Streaming](https://ably.com/docs/platform/integrations/streaming.md) | High-throughput, existing infrastructure | Depends on target system |
| [Ably Queues](https://ably.com/docs/platform/integrations/queues.md) | Ordered processing, fault-tolerant delivery | At-least-once with dead letter queue |

See the [extraction guide](https://ably.com/docs/chat/external-storage-and-processing/data-extraction.md) to learn how to set up integrations for use with chat rooms.

## Related documentation 

* [Chat integrations](https://ably.com/docs/chat/integrations.md) - Technical reference for message structure mapping.
* [Platform integrations](https://ably.com/docs/platform/integrations.md) - Complete integration setup guides.
* [Message structure](https://ably.com/docs/chat/rooms/messages.md#structure) - Chat message format details.
* [Chat history](https://ably.com/docs/chat/rooms/history.md) - Retrieve historical messages via API.

## Related Topics

- [Data extraction](https://ably.com/docs/chat/external-storage-and-processing/data-extraction.md): Extract chat messages from Ably Chat using integrations for external processing, storage, or analysis.
- [Data processing](https://ably.com/docs/chat/external-storage-and-processing/data-processing.md): Process chat messages through external systems to trigger notifications, handle slash commands, analyze sentiment, and more.
- [Data storage](https://ably.com/docs/chat/external-storage-and-processing/data-storage.md): Store chat messages from Ably Chat in your own data store for long-term retention, compliance, and analytics.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
