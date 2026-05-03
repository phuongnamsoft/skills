# Process messages with external systems

Once you have [extracted messages from chat rooms](https://ably.com/docs/chat/external-storage-and-processing/data-extraction.md) using an integration, you can process them through external systems to build features like notifications, slash commands, and sentiment analysis.

## Enable features with metadata 

Clients can include structured [metadata](https://ably.com/docs/chat/rooms/messages.md#structure) when [sending messages](https://ably.com/docs/chat/rooms/messages.md#send) to provide context for your external processing systems. This enables your integration to act on messages based on the intent signaled by the client.

For example, when implementing a notification system, a client might include the target user ID and notification type in the metadata:

<Code>

### Javascript

```
await room.messages.send({
  text: '@john.123 Can you review this?',
  metadata: {
    targetClientId: 'john.123',
    notificationType: 'mention'
  }
});
```
</Code>

Your integration can then extract this information to send a push notification to the mentioned user.

Other patterns metadata enables include:

* Slash commands where clients include command type and parameters in metadata, for example `targetClientId` and `reminderTime` for a `/remind` command. Your integration processes this to schedule reminders, execute actions, or trigger workflows.
* Content categorization where clients tag messages with categories or intents, for example `messageType: 'question'` or `category: 'support'`, to route messages to appropriate handlers or analytics pipelines.
* Sentiment analysis where your integration forwards the message text to an AI service and stores the results for reporting or alerting.

<Aside data-type='important'>
Metadata is set by clients and is not server-validated. Always treat it as untrusted input in your integration code. For sensitive operations, make authorization decisions server-side based on user permissions rather than trusting client-provided flags.
</Aside>


## Understand message data 

Each [decoded message](https://ably.com/docs/chat/external-storage-and-processing/data-extraction.md#decoding) provides the following data for your processing logic:

| Field | Description |
| --- | --- |
| `text` | The message content, typically user input. See [message structure](https://ably.com/docs/chat/rooms/messages.md#structure). |
| `clientId` | Identifies the user who sent the message, useful for attribution and user-specific actions. |
| `serial` | A unique, lexicographically sortable identifier for the message, enabling [global ordering](https://ably.com/docs/chat/rooms/messages.md#global-ordering). |
| `timestamp` | When the message was sent, enabling time-based processing or analytics. |
| `action` | The message type: `message.created`, `message.updated`, `message.deleted`, or `message.summary` for [reactions](#reactions). |
| `metadata` | Client-provided structured data. Can be used to enable features like [replies](https://ably.com/docs/chat/rooms/replies.md) and notifications. |
| `headers` | Key-value pairs typically used for routing and [filtering](https://ably.com/docs/pub-sub/advanced.md#filter-subscribe). |
| `version` | Version information for updates and deletes, including `version.serial` and `version.timestamp`. See [ordering updates and deletes](https://ably.com/docs/chat/rooms/messages.md#ordering-update-delete). |

The room name can be [extracted](https://ably.com/docs/chat/external-storage-and-processing/data-extraction.md#extract-room) from the envelope's `channel` field.

Text, metadata, and headers are all client-provided and should be treated as untrusted input. Use the message's `clientId` to make server-side authorization decisions rather than trusting client-provided metadata flags. All other fields are server-generated and can be trusted for processing logic.

## Route messages for processing 

After decoding messages from the integration envelope, route them based on their content and metadata to call different processing functions:

<Code>

### Javascript

```
function routeMessage(roomName, msg) {
  const metadata = msg.data?.metadata || {};

  if (metadata.command === 'remind') {
    return handleRemindCommand(msg.data?.text, metadata.targetClientId, msg.clientId);
  }

  if (metadata.notificationType === 'mention') {
    return sendMentionNotification(metadata.targetClientId, msg.data?.text, roomName, msg.clientId);
  }

  return processStandardMessage(roomName, msg);
}
```
</Code>

Your external services may have rate limits, processing constraints, or availability issues. Implement retry logic and circuit breakers in your integration code to handle these limitations gracefully. Consider queuing failed requests for retry rather than dropping them.

## Handle message updates and deletes 

When a message is updated or deleted, the integration will receive a new version with `action` set to `message.updated` or `message.deleted`. If you sent a notification for a message that was subsequently deleted, you may want to retract that previous notification.

Use `serial` to identify the original message and `version.serial` to determine whether an [incoming version](https://ably.com/docs/chat/external-storage-and-processing/data-extraction.md#versioning) is newer than what you have already processed.

## Handle message reactions 

Reaction summaries arrive as messages with `action` set to `message.summary`. If your processing needs reaction data, for example analytics on popular reactions or triggering actions when a message reaches a reaction threshold, [extract reaction counts](https://ably.com/docs/chat/external-storage-and-processing/data-extraction.md#reaction) from the annotations payload.


## Related Topics

- [Overview](https://ably.com/docs/chat/external-storage-and-processing.md): Extract, store, and process chat messages from Ably Chat using integrations.
- [Data extraction](https://ably.com/docs/chat/external-storage-and-processing/data-extraction.md): Extract chat messages from Ably Chat using integrations for external processing, storage, or analysis.
- [Data storage](https://ably.com/docs/chat/external-storage-and-processing/data-storage.md): Store chat messages from Ably Chat in your own data store for long-term retention, compliance, and analytics.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
