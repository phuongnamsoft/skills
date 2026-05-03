# Dev console

The dev console tab provides realtime insights into application-wide events, such as connection status changes and channel activity. These features enable you to:

* Observe changes in connection status across the application.
* View activity on specific channels, including message traffic and channel events.
* Examine event logs to troubleshoot your application.

## Application-wide events interface

The application-wide events interface allows you to monitor your application's health and activity in realtime.

The following explains the realtime monitoring tools in the application-wide events interface:

| Field | Description |
| ----- | ----------- |
| **API key** | The API key to access and view events within the app. |
| **Average application-wide events per second (p/s)** | This metric shows the average number of events occurring per second across your application. For example, if the current rate is 0, no active events are being processed. |
| **Event log table** | The event log table displays a record of events related to the current client's connection status. This table can be used to debug potential issues in your application. |

## Message auditing and logging 

The dev console displays messages in realtime for debugging and testing purposes, but does not provide persistent message auditing or logging capabilities. Ably does not currently offer native functionality to view historical messages filtered by specific channels or client IDs for auditing purposes.

If you need to audit or log messages by channel or client ID, implement this functionality on the application side. Consider using:

- [Webhooks](https://ably.com/docs/platform/integrations/webhooks.md) to send message events to your logging system
- [Message queues](https://ably.com/docs/platform/integrations/queues.md) to process and store message data
- Client-side logging in your application code

For native message auditing features, [contact support](mailto:support@ably.com) to discuss requirements.

## Channels

The following is a step-by-step instructions for connecting to a channel, publishing messages.

### Connect to a channel

The following explains how to connect to a channel:

| Step | Action |
| ---- | ------ |
| **Enter a channel name** | In the channel name field, choose a name (e.g get-started). |
| **Attach to channel** | Click the **attach to channel** button. This connects you to the **get-started** channel, enabling you to start publishing or subscribing to messages. |
| **Monitor channel status** | The interface will display the channel status as **pending** and then **attached** once connected, confirming that the channel is ready for interaction.|

### Publish a message

The following explains how to publish a message:

| Step | Action |
| ---- | ------ |
| **Message data** | In the **message data** field, type a message (e.g. example). |
| **Publish message** | Click the **publish message** button to send the message to the **get-started** channel. |
| **View the message** | If you have a subscriber , it will receive and display the message in the console. |

The following explains how to interact with presence:

| Step | Action |
| ---- | ------ |
| **Client ID** | Enter a unique client ID to simulate joining the presence of the channel. |
| **Enter presence** | Click **enter presence** to indicate that this client is now in the channel. |
| **Monitor presence** | The interface will list all clients in the channel under **presence members**. |

### Control the channel

The following explains how to control the channel in the dev console:

| Step | Action |
| ---- | ------ |
| **Detach** | Click **detach** to disconnect from the channel. |
| **Pause** | Use **pause** to temporarily stop receiving messages. |
| **Clear** | Click **clear** to clear the channel data or logs from the interface. |

## Related Topics

- [Overview](https://ably.com/docs/platform/account/app.md):  Manage and monitor your applications on the Ably platform using the Ably dashboard. Create new apps, view existing ones, and configure settings from your browser.
- [Stats](https://ably.com/docs/platform/account/app/stats.md): “Monitor and analyze your app's performance with Ably's dashboard. Access realtime stats and trends for optimized management."
- [API keys](https://ably.com/docs/platform/account/app/api.md): “Manage Ably API keys by creating, updating, setting restrictions, and exploring integration options.”
- [Queues](https://ably.com/docs/platform/account/app/queues.md): Manage and configure Ably queues, monitor realtime data, and optimize performance.”
- [Notifications](https://ably.com/docs/platform/account/app/notifications.md): Configure credentials for integrating Ably's push notification services with third-party services, send push notifications from the Ably dashboard, and inspect push notifications .”
- [Settings](https://ably.com/docs/platform/account/app/settings.md): Manage your Ably application settings including security, billing, authentication, and protocol support to optimize performance and enhance security.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
