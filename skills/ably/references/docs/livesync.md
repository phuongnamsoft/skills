# About LiveSync

LiveSync is a powerful realtime data synchronization product designed to facilitate broadcasting realtime updates from backend databases to application clients at scale. LiveSync ensures that data updates are propagated reliably, and in order, to all connected clients in realtime.

LiveSync can be used in applications where your database is the source of truth for the application state, and that state needs to be reflected in realtime to client applications. LiveSync enables this data synchronisation while maintaining data integrity and low latency.

![What is LiveSync](https://raw.githubusercontent.com/ably/docs/main/src/images/content/diagrams/what-is-livesync.png)

By using Ably Pub/Sub [channels](https://ably.com/solutions/channels) and [SDKs](https://ably.com/docs/sdks.md), clients subscribing to messages published by a LiveSync database connector benefit from features like [connection-recovery](https://ably.com/docs/connect/states.md), [exactly-once delivery](https://ably.com/docs/platform/architecture.md) and [ordering guarantees](https://faqs.ably.com/reliable-message-ordering-for-connected-clients) out of the box. Ably's platform guarantees and [four pillars of dependability](https://ably.com/four-pillars-of-dependability) apply by default.

## Channel-based broadcasting 

Ably's [pub/sub channels](https://ably.com/docs/channels.md) are the mechanism used by LiveSync for synchronizing data updates across clients. When a message is published on a channel by the database connector, it is immediately broadcast to all subscribers of that channel.

## Hosted database connectors 

Take advantage of the Ably hosted database connectors to automatically publish changes from your database as messages on Ably channels. The hosted database connectors support controlling which events are routed to which channels, and using Ably's [Auth](https://ably.com/docs/auth.md) and [Capabilities](https://ably.com/docs/auth/capabilities.md) you can control which channels a client is allowed to access.

Ably provides hosted connectors for:
* [Postgres](https://ably.com/docs/livesync/postgres.md)
* [MongoDB](https://ably.com/docs/livesync/mongodb.md)

## Use cases 

LiveSync can benefit a wide range of applications where it's important to broadcast database changes in realtime to keep clients in sync, including: Customer Relationship Management (CRM) applications, customer support applications, productivity or task management applications, online auctions, collaborative form editing, e-commerce systems, chat conversations, multiplayer turn-based games and realtime newsfeeds.

<Aside data-type='usp'>
No missed updates

LiveSync clients benefit from Ably's [connection recovery and exactly-once delivery](https://ably.com/docs/platform/architecture/idempotency.md#connection-recovery-and-exactly-once-delivery), so if a subscriber briefly disconnects, they automatically catch up on any database changes they missed without duplicates or gaps.
</Aside>

## Pricing 

LiveSync [pricing](https://ably.com/pricing) is mainly based on message consumption (alongside concurrent connections and concurrent channels). This means that each update published from the database connector to Ably channels is counted as a single message. The message is received by every client subscribed to that channel, each of which counts as one additional message. If, for example, one update is published by the database connector and there are three clients subscribed, that one update will result in four messages in total.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
