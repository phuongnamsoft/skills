# Guide: Handle discontinuity in Pub/Sub

When a client experiences a period of disconnection longer than the two-minute recovery window, or when Ably signals a loss of message continuity, your application may have missed messages. This is called a *discontinuity*. This guide explains how to detect and recover from discontinuities in Pub/Sub applications.

<Aside data-type="note">
If you are using the [Chat SDK](https://ably.com/docs/chat.md), see the [Chat discontinuity guide](https://ably.com/docs/chat/guides/handling-discontinuity.md) instead. Chat has its own discontinuity handling mechanism.
</Aside>

## What causes discontinuity 

Discontinuity occurs when the Ably SDK cannot guarantee that all messages have been delivered to the client. The most common causes are:

- Network disconnection lasting longer than two minutes. Ably preserves [connection state](https://ably.com/docs/connect/states.md#connection-state-recovery) for up to two minutes. Beyond this window, Ably cannot guarantee message continuity.
- Server-initiated continuity loss. Operational events such as cluster rebalancing may cause a partial loss of message continuity, even if the client remained connected.
- Outbound rate limits exceeded. If a connection's outbound message rate exceeds the [per-connection limit](https://ably.com/docs/platform/pricing/limits.md#connection), messages may be dropped, resulting in a loss of continuity.
- Client app backgrounded for an extended period. Mobile apps suspended by the operating system may exceed the two-minute recovery window.

For disconnections shorter than two minutes, the SDK automatically [resumes](https://ably.com/docs/connect/states.md#resume) the connection and replays missed messages without any action from you.

## Detect discontinuity 

When continuity is lost on a Pub/Sub channel, the client receives an `ATTACHED` or [`UPDATE`](https://ably.com/docs/channels/states.md#update) event with the `resumed` flag set to `false`. This flag is part of the [`ChannelStateChange`](https://ably.com/docs/api/realtime-sdk/types.md#channel-state-change) object.

Register listeners for both `attached` and `update` events to detect all discontinuity scenarios:

<Code>

### Javascript

```
channel.on('attached', (stateChange) => {
  if (!stateChange.resumed) {
    // Continuity was lost - messages may have been missed
    recoverMissedMessages(channel);
  }
});

channel.on('update', (stateChange) => {
  if (!stateChange.resumed) {
    // Mid-session continuity loss
    recoverMissedMessages(channel);
  }
});
```
</Code>

- An `attached` event with `resumed` set to `false` occurs when a channel reattaches after the connection was [suspended](https://ably.com/docs/connect/states.md#connection-state-recovery), for example after a disconnection longer than two minutes.
- An `update` event with `resumed` set to `false` occurs when there is a partial loss of continuity on a channel that remains attached, such as after a partially successful [resume](https://ably.com/docs/connect/states.md#resume).

<Aside data-type="further-reading">
See [channel states](https://ably.com/docs/channels/states.md) for a full description of channel lifecycle events and the `resumed` flag.
</Aside>

## Recover missed messages 

Use [`channel.history()`](https://ably.com/docs/storage-history/history.md#until-attach) with `untilAttach` set to `true` to retrieve messages up to the point of reattachment. The response is paginated, so you may need to iterate through multiple pages. You are responsible for determining how far back to go, for example by using time bounds or checking message serials against the last message you processed:

<Code>

### Javascript

```
async function recoverMissedMessages(channel, lastSeenSerial) {
  let page = await channel.history({ untilAttach: true });

  while (page) {
    for (const msg of page.items) {
      if (msg.serial <= lastSeenSerial) {
        // Reached messages already processed
        return;
      }
      processMessage(msg);
    }

    page = page.hasNext() ? await page.next() : null;
  }
}
```
</Code>

<Aside data-type="note">
The `untilAttach` parameter sets an upper bound on the history query at the point of reattachment. It does not set a lower bound. You must determine how far back to paginate, for example by tracking the serial of the last message you processed before the disconnection.
</Aside>

<Aside data-type="important">
Subscribe to the channel before making a history request with `untilAttach` set to `true`. By default, calling `subscribe()` implicitly attaches the channel (when `attachOnSubscribe` is `true`, which is the default), which populates the serial number used by the `untilAttach` parameter. If you have set `attachOnSubscribe` to `false`, you must explicitly call `channel.attach()` before making the history request.
</Aside>

## Best practices 

- Set up discontinuity handlers before subscribing to messages or attaching to channels. This ensures you detect any continuity loss that occurs during the initial attachment.
- Use `untilAttach: true` with `channel.history()` for recovery. This is designed to work with the `resumed` flag detection mechanism.
- History results may overlap with messages already received via the live subscription. Design your message processing to tolerate duplicates, for example by tracking message IDs or serials.
- Decide how to present recovered messages to the user. Options include silently inserting them into the message list, showing a "new messages" indicator, or displaying a notification that messages were recovered.

## Related Topics

- [Data streaming](https://ably.com/docs/pub-sub/guides/data-streaming.md): Optimize data streaming at scale with Ably: reduce bandwidth with Deltas, manage bursts with server-side batching, ensure freshness with Conflation.
- [Dashboards and visualizations](https://ably.com/docs/pub-sub/guides/dashboards-and-visualizations.md): Architecting realtime dashboards with Ably: from fan engagement at scale to critical monitoring. Key decisions, technical depth, and why Ably is the right choice.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
