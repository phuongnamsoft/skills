# Stats

The stats tab is an interface to monitor your app's performance and usage via the [statistics table](#table) and [statistics chart](#chart).

## Statistics table 

The statistics table provides a summary of your app's messaging and data usage patterns over different time frames, including the previous month, the current month, and more granular insights from the last hour and last minute:

![Your stats table](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/dash/stats-table.png)

The following explains the statistics table metrics:

| Metric | Description |
|--------|-------------|
| Messages (billable) | Total number of messages used. |
| Messages published (REST & Realtime) | Number of messages sent via REST and Realtime. |
| Messages received (Realtime) | Number of messages received. |
| Messages persisted (history) | Number of messages retrieved from history. |
| Messages retrieved (history) | Number of messages retrieved from history. |
| Presence events (REST & Realtime) | Number of presence-related events via REST and Realtime. |
| Webhook / Function | Number of messages transferred through functions and webhooks. |
| Ably Queue | Number of messages transferred through queues. |
| Firehose | Number of messages transferred through Firehose. |
| Push notifications | Number of push notifications sent. |
| Data transferred | Amount of data transferred, in bytes. |
| Peak connections | Highest number of concurrent connections. |
| Peak channels | Highest number of concurrent channels. |

<Aside data-type='note'>
Download or view detailed app statistics for a more granular analysis, enabling deeper dives into specific metrics as needed.
</Aside>

## Statistics chart 

The Stats page also includes a chart that visualizes your app's data over time:

![Your stats chart](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/dash/stats-chart.png)

The following explains how to use the statistics chart:

* **Duration**: Define a specific time range for the statistics you want to view. This enables you to focus on periods of particular interest. For example, set the time range from "2024-06-17 00:00" to "2024-08-06 11:18" to analyze data within that period.
* **Zoom**: Use preset zoom options (1h, 8h, 24h, 7d, 1m, 6m, 1y, all) to adjust the chart's view to different periods, enabling you to analyze data at various granularities.

## Related Topics

- [Overview](https://ably.com/docs/platform/account/app.md):  Manage and monitor your applications on the Ably platform using the Ably dashboard. Create new apps, view existing ones, and configure settings from your browser.
- [API keys](https://ably.com/docs/platform/account/app/api.md): “Manage Ably API keys by creating, updating, setting restrictions, and exploring integration options.”
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
