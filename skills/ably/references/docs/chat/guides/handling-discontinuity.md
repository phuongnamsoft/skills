# Guide: Handle discontinuity in Chat

When a client experiences a period of disconnection longer than the two-minute recovery window, or when Ably signals a loss of message continuity, your application may have missed messages. This is called a *discontinuity*. This guide explains how to detect and recover from discontinuities in Chat applications.

<Aside data-type="note">
If you are using [Pub/Sub](https://ably.com/docs/pub-sub.md) directly, see the [Pub/Sub discontinuity guide](https://ably.com/docs/pub-sub/guides/handling-discontinuity.md) instead. Pub/Sub uses the `resumed` flag rather than the Chat `onDiscontinuity()` handler.
</Aside>

## What causes discontinuity 

Discontinuity occurs when the Ably SDK cannot guarantee that all messages have been delivered to the client. The most common causes are:

- Network disconnection lasting longer than two minutes. Ably preserves [connection state](https://ably.com/docs/connect/states.md#connection-state-recovery) for up to two minutes. Beyond this window, Ably cannot guarantee message continuity.
- Server-initiated continuity loss. Operational events such as cluster rebalancing may cause a partial loss of message continuity, even if the client remained connected.
- Outbound rate limits exceeded. If a connection's outbound message rate exceeds the [per-connection limit](https://ably.com/docs/platform/pricing/limits.md#connection), messages may be dropped, resulting in a loss of continuity.
- Client app backgrounded for an extended period. Mobile apps suspended by the operating system may exceed the two-minute recovery window.

For disconnections shorter than two minutes, the SDK automatically [resumes](https://ably.com/docs/connect/states.md#resume) the connection and replays missed messages without any action from you.

## Detect discontinuity 

The [Chat SDK](https://ably.com/docs/chat.md) provides an `onDiscontinuity()` handler at the room level. This is a Chat-specific mechanism, separate from the Pub/Sub `resumed` flag.

<Aside data-type="important">
Chat is a separate SDK built on top of Pub/Sub. Use the Chat-specific `onDiscontinuity()` handler when working with Chat rooms. Do not use the Pub/Sub `resumed` flag directly on the underlying Pub/Sub channels used by Chat rooms.
</Aside>

Register the handler when setting up your room:

<Code>

### Javascript

```
const { off } = room.onDiscontinuity((reason) => {
  console.log('Discontinuity detected:', reason);
  recoverChatMessages(room);
});

// Clean up when done
off();
```

### React

```
import { useMessages } from '@ably/chat/react';

const MyComponent = () => {
  useMessages({
    onDiscontinuity: (error) => {
      console.log('Discontinuity detected:', error);
      // Trigger recovery, for example re-fetch message history
    },
  });

  return <div>...</div>;
};
```

### Swift

```
let subscription = room.onDiscontinuity()
for await error in subscription {
  print("Discontinuity detected: \(error)")
  // Recover missed messages
}
```

### Kotlin

```
val (off) = room.onDiscontinuity { reason: ErrorInfo ->
  println("Discontinuity detected: $reason")
  // Recover missed messages
}

// Clean up when done
off()
```
</Code>

<Aside data-type="further-reading">
See [handle connection discontinuity](https://ably.com/docs/chat/connect.md#discontinuity) for full details on the Chat `onDiscontinuity()` handler, including cleanup and React hook integration.
</Aside>

## Recover missed messages 

Use [`historyBeforeSubscribe()`](https://ably.com/docs/chat/rooms/history.md#subscribe) to retrieve messages from the point of re-subscription. This is preferred over `messages.history()` for discontinuity recovery because the attachment point changes after a resume, and `historyBeforeSubscribe` guarantees no gap between historical and live messages:

<Code>

### Javascript

```
async function recoverChatMessages(room) {
  const history = await room.messages.historyBeforeSubscribe({ limit: 50 });

  // Refresh your message list with recovered messages
  for (const msg of history.items.reverse()) {
    appendMessageToUI(msg);
  }
}
```
</Code>

<Aside data-type="important">
During a discontinuity, message updates and deletes may have occurred that are not captured by simply appending new messages to the UI. To ensure a consistent state, refresh the entire Chat message list rather than merging new messages into the existing state.
</Aside>

## Best practices 

- Set up the `onDiscontinuity` handler before subscribing to messages. This ensures you detect any continuity loss that occurs during the initial attachment.
- Use `historyBeforeSubscribe()` for recovery. It is designed to work with the Chat discontinuity detection mechanism and guarantees no gap between historical and live messages.
- The `onDiscontinuity` handler fires at the room level, covering messages, presence, reactions, and typing indicators. You do not need to register separate handlers for each Chat feature.
- Decide how to present recovered messages to the user. Options include refreshing the message list, showing a "new messages" indicator, or displaying a notification that messages were recovered.

## Related Topics

- [Livestream chat](https://ably.com/docs/chat/guides/build-livestream.md): Architecting livestream chat with Ably: performance, reliability, and cost at scale. Key decisions, technical depth, and why Ably is the right choice.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
