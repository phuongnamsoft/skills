# Channels

Use the `ably channels` command group to interact with Ably Pub/Sub channels. These commands enable you to publish and subscribe to messages, manage presence, monitor occupancy, and work with annotations.

## Message publishing and subscribing 

Use the following commands to [publish and subscribe](https://ably.com/docs/channels.md) to messages on channels, retrieve [message history](https://ably.com/docs/storage-history/history.md), and perform message operations:

| Command | Description |
| ------- | ----------- |
| [`ably channels subscribe`](https://ably.com/docs/cli/channels/subscribe.md) | Subscribe to messages on one or more channels. |
| [`ably channels publish`](https://ably.com/docs/cli/channels/publish.md) | Publish a message to a channel. |
| [`ably channels batch-publish`](https://ably.com/docs/cli/channels/batch-publish.md) | Publish a message to multiple channels at once. |
| [`ably channels history`](https://ably.com/docs/cli/channels/history.md) | Retrieve message history for a channel. |
| [`ably channels append`](https://ably.com/docs/cli/channels/append.md) | Append data to a message on a channel. |
| [`ably channels update`](https://ably.com/docs/cli/channels/update.md) | Update a message on a channel. |
| [`ably channels delete`](https://ably.com/docs/cli/channels/delete.md) | Delete a message on a channel. |

## Message annotations 

Use the following commands to manage [annotations](https://ably.com/docs/messages/annotations.md) on channel messages. Annotations enable you to append metadata such as reactions, tags, moderation flags, and read receipts to existing messages:

| Command | Description |
| ------- | ----------- |
| [`ably channels annotations publish`](https://ably.com/docs/cli/channels/annotations/publish.md) | Publish an annotation on a channel message. |
| [`ably channels annotations subscribe`](https://ably.com/docs/cli/channels/annotations/subscribe.md) | Subscribe to annotations on a channel. |
| [`ably channels annotations get`](https://ably.com/docs/cli/channels/annotations/get.md) | Get annotations for a channel message. |
| [`ably channels annotations delete`](https://ably.com/docs/cli/channels/annotations/delete.md) | Delete an annotation from a channel message. |

## Presence 

Use the following commands to manage [presence](https://ably.com/docs/presence-occupancy/presence.md) on channels. Presence enables clients to be aware of other members who are currently active on a channel:

| Command | Description |
| ------- | ----------- |
| [`ably channels presence enter`](https://ably.com/docs/cli/channels/presence/enter.md) | Enter presence member on a channel. |
| [`ably channels presence get`](https://ably.com/docs/cli/channels/presence/get.md) | Get current presence members on a channel. |
| [`ably channels presence subscribe`](https://ably.com/docs/cli/channels/presence/subscribe.md) | Subscribe to presence member events on a channel. |

## Channel occupancy 

Use the following commands to monitor [occupancy](https://ably.com/docs/presence-occupancy/occupancy.md) on channels. Occupancy provides high-level metrics about the number of clients attached to a channel without requiring presence:

| Command | Description |
| ------- | ----------- |
| [`ably channels occupancy get`](https://ably.com/docs/cli/channels/occupancy/get.md) | Get current occupancy for a channel. |
| [`ably channels occupancy subscribe`](https://ably.com/docs/cli/channels/occupancy/subscribe.md) | Subscribe to occupancy updates on a channel. |

## Channels management 

Use the following commands to list active channels and inspect channel details in the Ably dashboard:

| Command | Description |
| ------- | ----------- |
| [`ably channels list`](https://ably.com/docs/cli/channels/list.md) | List active channels. |
| [`ably channels inspect`](https://ably.com/docs/cli/channels/inspect.md) | Open the Ably dashboard to inspect a channel. |

## See also

* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
