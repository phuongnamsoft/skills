# Message Storage

Ably stores all messages for two minutes by default. This can be increased up to a year, or longer, depending on your account package. It is also possible to persist the last message sent to a channel for a year. Ably [integrations](https://ably.com/docs/platform/integrations.md) can also be used to send messages outside of Ably for long-term storage.

## Default message storage - two minutes 

The default message storage of two minutes enables clients that briefly disconnect from Ably to [automatically retrieve](https://ably.com/docs/connect/states.md) any messages they may have missed. These messages can also be retrieved using the [history](https://ably.com/docs/storage-history/history.md) feature, and this applies to both regular messages and [presence messages](https://ably.com/docs/presence-occupancy/presence.md).

The following diagram illustrates the default persistence of messages:

![Default Persistence](https://raw.githubusercontent.com/ably/docs/main/src/images/content/diagrams/history-default.png)

## Persist all messages 

If you need to retain messages for longer than the default two minutes you can enable persisted history by setting a [rule](https://ably.com/docs/channels.md#rules). When persisted history is enabled for a channel any messages will be stored on disk. Note that this does not apply to [object messages](https://ably.com/docs/liveobjects.md).

The time that messages will be stored for depends on your account package:

| Package | Minimum | Maximum |
|---------|---------|---------|
| Free | 24 hours | 24 hours |
| Standard | 72 hours | 30 days |
| Pro | 72 hours | 365 days |
| Enterprise | 72 hours | Custom |

There is a cost associated with storing messages for longer than the minimum time period. [Contact us](https://ably.com/support) to discuss enabling long term storage.

<Aside data-type='usp'>
Redundant multi-datacenter storage.

Every message is redundantly stored across [multiple isolated datacenters](https://ably.com/docs/platform/architecture/fault-tolerance.md#core-layer) within your region before acknowledgment, preventing data loss.
</Aside>

### Message deletion 

Ably does not currently provide an API to delete persisted messages from the history. Once messages are stored with persisted history enabled, they remain for the entire configured storage period. If you need to delete specific messages from history, [contact us](https://ably.com/support) to discuss requirements.

Messages can be retrieved using the [history](https://ably.com/docs/storage-history/history.md) feature. This is illustrated in the following diagram:

![Persist All Messages](https://raw.githubusercontent.com/ably/docs/main/src/images/content/diagrams/history-persist-all-messages.png)

Note that every message that is persisted to, or retrieved from, disk counts as an extra message towards your monthly quota. For example, with persistence enabled a published message counts as two messages for your monthly quota. If the message is then retrieved another message will be deducted.

## Persist last message - 365 days 

You can persist just the last message sent to a channel for one year by setting a [rule](https://ably.com/docs/channels.md#rules). Note that this does not apply to [presence messages](https://ably.com/docs/presence-occupancy/presence.md) or [object messages](https://ably.com/docs/liveobjects.md).

Messages persisted for a year can be retrieved using the [rewind channel option](https://ably.com/docs/channels/options/rewind.md), or from the REST history API using [certain parameters](https://ably.com/docs/storage-history/history.md#channel-parameters).

The following diagram illustrates persisting the last message sent on a channel:

![Persist Last Message](https://raw.githubusercontent.com/ably/docs/main/src/images/content/diagrams/history-persist-last-message.png)

## Store messages outside of Ably 

[Integrations](https://ably.com/docs/platform/integrations.md) provide the ability to store your messages outside of Ably, for example in your own database or data warehouse.

Set up an integration rule to send messages to your own systems using [webhooks](https://ably.com/docs/platform/integrations/webhooks.md) or [serverless functions](https://ably.com/docs/platform/integrations/webhooks.md). Integration rules can additionally filter which messages sent to a channel should trigger these events.

## Related Topics

- [Message history](https://ably.com/docs/storage-history/history.md): Learn about accessing message history with the history and rewind features

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
