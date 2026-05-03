# Push

Use the `ably push` command group to manage push notifications. These commands enable you to publish notifications, manage channel subscriptions, configure push services, and manage device registrations.

## Publish notifications 

Use the following commands to deliver [push notifications](https://ably.com/docs/push.md) to devices, clients, or channels without requiring an active connection:

| Command | Description |
| ------- | ----------- |
| [`ably push publish`](https://ably.com/docs/cli/push/publish.md) | Publish a push notification to a device, client, or channel. |
| [`ably push batch-publish`](https://ably.com/docs/cli/push/batch-publish.md) | Publish push notifications to multiple recipients in a batch. |

## Manage push channels 

Use the following commands to manage push notification [channel subscriptions](https://ably.com/docs/push.md). Channel-based push uses a Pub/Sub model to broadcast notifications to all subscribed devices on a channel:

| Command | Description |
| ------- | ----------- |
| [`ably push channels list`](https://ably.com/docs/cli/push/channels/list.md) | List push channel subscriptions. |
| [`ably push channels list-channels`](https://ably.com/docs/cli/push/channels/list-channels.md) | List channels with push subscriptions. |
| [`ably push channels save`](https://ably.com/docs/cli/push/channels/save.md) | Subscribe a device or client to push notifications on a channel. |
| [`ably push channels remove`](https://ably.com/docs/cli/push/channels/remove.md) | Remove a push channel subscription. |
| [`ably push channels remove-where`](https://ably.com/docs/cli/push/channels/remove-where.md) | Remove push channel subscriptions matching filter criteria. |

## Manage push configuration 

Use the following commands to configure push notification services for your app. These commands manage [APNs and FCM](https://ably.com/docs/push.md) credentials:

| Command | Description |
| ------- | ----------- |
| [`ably push config show`](https://ably.com/docs/cli/push/config/show.md) | Show push notification configuration for an app. |
| [`ably push config set-apns`](https://ably.com/docs/cli/push/config/set-apns.md) | Configure APNs push notifications for an app. |
| [`ably push config set-fcm`](https://ably.com/docs/cli/push/config/set-fcm.md) | Configure FCM push notifications for an app. |
| [`ably push config clear-apns`](https://ably.com/docs/cli/push/config/clear-apns.md) | Clear APNs push notification configuration for an app. |
| [`ably push config clear-fcm`](https://ably.com/docs/cli/push/config/clear-fcm.md) | Clear FCM push notification configuration for an app. |

## Manage device registrations 

Use the following commands to manage push notification [device registrations](https://ably.com/docs/push.md). Device registrations track which devices are registered to receive push notifications:

| Command | Description |
| ------- | ----------- |
| [`ably push devices list`](https://ably.com/docs/cli/push/devices/list.md) | List push device registrations. |
| [`ably push devices get`](https://ably.com/docs/cli/push/devices/get.md) | Get details of a push device registration. |
| [`ably push devices save`](https://ably.com/docs/cli/push/devices/save.md) | Register or update a push device. |
| [`ably push devices remove`](https://ably.com/docs/cli/push/devices/remove.md) | Remove a push device registration. |
| [`ably push devices remove-where`](https://ably.com/docs/cli/push/devices/remove-where.md) | Remove push device registrations matching filter criteria. |

## See also

* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
