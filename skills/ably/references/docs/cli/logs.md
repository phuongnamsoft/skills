# Logs

Use the `ably logs` command group to stream and retrieve logs from Ably. These commands enable you to subscribe to live logs, retrieve log history, and monitor channel lifecycle, connection lifecycle, and push notification events.

## Application logs 

Use the following commands to subscribe to live application logs and retrieve log history:

| Command | Description |
| ------- | ----------- |
| [`ably logs subscribe`](https://ably.com/docs/cli/logs/subscribe.md) | Subscribe to live app logs. |
| [`ably logs history`](https://ably.com/docs/cli/logs/history.md) | Retrieve application log history. |

## Channel lifecycle 

Use the following command to stream [channel lifecycle](https://ably.com/docs/metadata-stats/metadata.md) events from the `[meta]channel.lifecycle` metachannel. Channel lifecycle events indicate when channels become active or inactive:

| Command | Description |
| ------- | ----------- |
| [`ably logs channel-lifecycle subscribe`](https://ably.com/docs/cli/logs/channel-lifecycle/subscribe.md) | Subscribe to channel lifecycle events. |

## Connection lifecycle 

Use the following commands to stream and retrieve [connection lifecycle](https://ably.com/docs/metadata-stats/metadata/subscribe.md) logs. Connection lifecycle events are published to the `[meta]connection.lifecycle` metachannel when clients connect to and disconnect from Ably:

| Command | Description |
| ------- | ----------- |
| [`ably logs connection-lifecycle subscribe`](https://ably.com/docs/cli/logs/connection-lifecycle/subscribe.md) | Subscribe to live connection lifecycle logs. |
| [`ably logs connection-lifecycle history`](https://ably.com/docs/cli/logs/connection-lifecycle/history.md) | Retrieve connection lifecycle log history. |

## Push notifications 

Use the following commands to stream and retrieve [push notification](https://ably.com/docs/push.md) logs. Push notification logs track delivery events for messages sent via APNs, FCM, and web push:

| Command | Description |
| ------- | ----------- |
| [`ably logs push subscribe`](https://ably.com/docs/cli/logs/push/subscribe.md) | Subscribe to push notification logs. |
| [`ably logs push history`](https://ably.com/docs/cli/logs/push/history.md) | Retrieve push notification log history. |

## See also

* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
