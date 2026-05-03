# Queues

Ably queues provide a way to consume realtime data using the [AMQP](https://ably.com/docs/platform/integrations/queues.md#consume-amqp) or [STOMP](https://ably.com/docs/platform/integrations/queues.md#consume-stomp) protocols. Find out more about using [Ably queues](https://ably.com/docs/platform/integrations/queues.md#what).

## Manage your Ably queues

The  Ably queues tab enables you to:

* Access a list of all your existing queues.
* Monitor realtime data flow and queue performance.
* Click on any queue to view and adjust its settings, such as TTL, maximum length, and region.

### Provision a new queue

When provisioning a new queue, you'll need to specify several things:

| Field | Description |
| ----- | ----------- |
| **Name** | Choose a unique name for your queue. This will help you identify it within your dashboard and during application development. |
| **Region** | Select the geographic region where the queue will be hosted. This is important for optimizing latency and ensuring data residency aligns with your application's requirements. |
| **TTL (time to Live)** | Set the TTL, which determines how long messages remain in the queue before being automatically deleted if they are not consumed. The default account limit is 60 minutes. You can contact Ably support for assistance if you need a longer TTL. |
| **Max length** | Define the maximum number of messages the queue can hold at any given time. The default limit is 10,000 messages, but you can request an increase if your application requires more capacity. |

### Set up queue rules 

Once you have provisioned a physical queue, you need to set up one or more queue rules to republish messages, presence events or channel events from pub/sub channels into a queue. Queue rules can either be used to publish to internal queues (hosted by Ably) or external external streams or queues (such as Amazon Kinesis and RabbitMQ). Publishing to external streams or queues is part of our [Ably Firehose servers](https://ably.com/docs/platform/integrations/streaming.md).

Ably queue rules are setup in the **Integrations** tab found within your app **dashboard**. Find out more about setting up [queue rules](https://ably.com/docs/platform/integrations/queues.md#setup).

## Related Topics

- [Overview](https://ably.com/docs/platform/account/app.md):  Manage and monitor your applications on the Ably platform using the Ably dashboard. Create new apps, view existing ones, and configure settings from your browser.
- [Stats](https://ably.com/docs/platform/account/app/stats.md): “Monitor and analyze your app's performance with Ably's dashboard. Access realtime stats and trends for optimized management."
- [API keys](https://ably.com/docs/platform/account/app/api.md): “Manage Ably API keys by creating, updating, setting restrictions, and exploring integration options.”
- [Notifications](https://ably.com/docs/platform/account/app/notifications.md): Configure credentials for integrating Ably's push notification services with third-party services, send push notifications from the Ably dashboard, and inspect push notifications .”
- [Dev console](https://ably.com/docs/platform/account/app/console.md): Gain realtime insights into application-wide events, such as connection status changes, channel activity, and event logs.” meta_keywords: “Ably dev console, realtime monitoring, connection status changes, channel activity, event logs
- [Settings](https://ably.com/docs/platform/account/app/settings.md): Manage your Ably application settings including security, billing, authentication, and protocol support to optimize performance and enhance security.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
