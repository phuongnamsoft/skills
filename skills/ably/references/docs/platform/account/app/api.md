# API keys

The API keys tab lists all API keys associated with your account and provides information on each key's capabilities and restrictions. You can [create a new API key](#create) and manage an existing one.

<Aside data-type='note'>
Before setting up multiple API keys with different permissions or sharing API keys with untrusted parties, consider using [token authentication](https://ably.com/docs/auth/token.md) instead. Token authentication provides more flexible access control and better security for client-side applications.
</Aside>

## Create a new API key 

The following steps create a new API Key:

* Click **Create a new API key**.
  * Assign a friendly name.
  * Give the new API key a descriptive name (e.g. chat app key) so it is easy to identify later.

To manage an API key: set [capabilities](https://ably.com/docs/auth/capabilities.md), define resource restrictions, use revocable tokens for security, and adjust key settings as needed.

### Capabilities

[Capabilities](https://ably.com/docs/auth/capabilities.md) provide permissions required for managing message flow, user presence, notifications, channel information, and access controls, these depend on what you require the API key to have access to:

| Capability | Description |
| ---------- | ----------- |
| **Publish** | Allow clients to publish messages to channels. |
| **Subscribe** | Allow clients to receive messages and presence state changes. |
| **History** | Allow clients to retrieve message and presence history. |
| **Presence** | Allow clients to register presence on a channel. |
| **Channel metadata** | Allow clients to query channel metadata. |
| **Push admin and push-subscribe** | Allow clients to manage and subscribe to push notifications. |
| **Statistics** | Allow clients to query usage statistics. |
| **Privileged headers** | Allow clients to set privileged headers, such as to skip rules. |

### Set resource restrictions

Set resource restrictions to control access to channels and queues, ranging from unrestricted access to specific, rule-based permissions:

| Restriction | Description |
| ----------- | ----------- |
| None | No restrictions; access any channel or queue. |
| Only channels | Access any channel but not queues. |
| Only queues | Access any queue but not channels. |
| Selected channels and queues | Specify explicit rules for access. |

When specifying selected channels and queues, you can provide a comma-separated list of resources. Each resource can match a single channel (e.g., `channel-name`) or multiple channels using wildcards (e.g., `namespace:*`). Queues use the prefix `[queue]` and meta channels use `[meta]`. See [capabilities documentation](https://ably.com/docs/auth/capabilities.md#wildcards) for detailed wildcard syntax.

<Aside data-type='important'>
A single API key cannot support complex permission combinations, such as publish access on one channel and subscribe access on another. For such requirements, use [token authentication](https://ably.com/docs/auth/token.md) instead.
</Aside>

### Revocable tokens

[Revocable tokens](https://ably.com/docs/auth/revocation.md#revocable-tokens) enhance security by allowing shorter token lifetimes and the ability to revoke tokens issued via the API key.

| Option | Description |
| ------ | ----------- |
| Revocable tokens | Implement security measures by setting shorter token lifetimes and enabling the ability to revoke tokens issued by the API key. |

### Change your API key settings

Click **Settings** on the required API key to change its settings. The same settings apply as when creating a new API key.

## Related Topics

- [Overview](https://ably.com/docs/platform/account/app.md):  Manage and monitor your applications on the Ably platform using the Ably dashboard. Create new apps, view existing ones, and configure settings from your browser.
- [Stats](https://ably.com/docs/platform/account/app/stats.md): “Monitor and analyze your app's performance with Ably's dashboard. Access realtime stats and trends for optimized management."
- [Queues](https://ably.com/docs/platform/account/app/queues.md): Manage and configure Ably queues, monitor realtime data, and optimize performance.”
- [Notifications](https://ably.com/docs/platform/account/app/notifications.md): Configure credentials for integrating Ably's push notification services with third-party services, send push notifications from the Ably dashboard, and inspect push notifications .”
- [Dev console](https://ably.com/docs/platform/account/app/console.md): Gain realtime insights into application-wide events, such as connection status changes, channel activity, and event logs.” meta_keywords: “Ably dev console, realtime monitoring, connection status changes, channel activity, event logs
- [Settings](https://ably.com/docs/platform/account/app/settings.md): Manage your Ably application settings including security, billing, authentication, and protocol support to optimize performance and enhance security.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
