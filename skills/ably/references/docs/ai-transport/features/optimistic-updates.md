# Optimistic updates

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

Optimistic updates in AI Transport make user messages appear in the conversation immediately, before the server confirms. The client inserts messages into the tree optimistically, and when the server publishes them to the channel, the transport reconciles automatically using message ID matching.

## How it works 

When a user sends a message, the client inserts it into the conversation tree before the POST request reaches the server. The message appears in the UI instantly, with no waiting for a round trip.

Behind the scenes:

1. The client generates a message ID and inserts the message into the conversation tree.
2. The POST request is sent to the server with the message content and generated ID.
3. The server processes the message and publishes it to the Ably channel.
4. The client receives the published message through its channel subscription.
5. The transport matches the published message to the optimistic insert using the `x-ably-msg-id` header and reconciles them.

After reconciliation, the optimistic message is replaced by the server-confirmed version. From the user's perspective, the message was always there - there's no flash, re-render, or position change.

<Aside data-type='note'>
Without optimistic updates, every user message would wait for a server round trip before appearing. In a real-time conversation, even a few hundred milliseconds of delay makes the UI feel sluggish. Optimistic insertion makes the conversation feel instant.
</Aside>

## Serial promotion 

Optimistic messages don't have an Ably serial number - they exist only in the local tree. When the server publishes the message to the channel, the reconciled message receives a real Ably serial. This is serial promotion.

Serial promotion matters for ordering. Messages in the conversation tree are ordered by their Ably serial. Optimistic messages are placed at the end of the tree until they're promoted. Once promoted, their position is determined by the serial assigned by the Ably channel, which reflects the true order of publication.

## Multi-message chaining 

A single turn can include multiple user messages. When sending more than one message, each is inserted optimistically in sequence:

<Code>

### Javascript

```
await view.edit(messageId, [
  { role: 'user', content: 'Here is my updated question' },
  { role: 'user', content: 'And some additional context' }
])
```
</Code>

Each message in the array is inserted into the tree optimistically. When the server publishes them, they're reconciled individually using their respective message IDs. The order is preserved.

## Error handling 

If the POST request fails, the optimistic message remains in the conversation tree and the transport emits an `error` event. The message is not automatically removed because the send is fire-and-forget - `view.send()` returns immediately with a stream handle, and the POST happens in the background.

<Code>

### Javascript

```
const turn = await view.send([{ role: 'user', content: 'Hello' }])

// Listen for send errors
transport.on('error', (error) => {
  // The POST request failed - the optimistic message is still in the tree
  // Handle the error in your UI (e.g. show a retry option)
  console.error('Send failed:', error.message)
})
```
</Code>

Your application is responsible for handling these errors and deciding whether to notify the user, offer a retry, or take other action.

## Reconciliation details 

The transport uses the `x-ably-msg-id` header to match published messages to optimistic inserts. When the client generates a message, it assigns an ID. The server includes this ID when publishing to the channel. When the client receives the published message through its subscription, it matches the ID and promotes the optimistic message to a confirmed one.

If the client receives a published message that doesn't match any optimistic insert - for example, a message from another client - it's added to the tree normally. The reconciliation logic only applies to messages the current client sent.

## Related features 

- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md) - how the agent's response streams after the user's message
- [Edit and regenerate](https://ably.com/docs/ai-transport/features/edit-and-regenerate.md) - edits use optimistic updates for the revised message
- [Multi-device sessions](https://ably.com/docs/ai-transport/features/multi-device.md) - optimistic messages reconcile across devices
- [Client transport API](https://ably.com/docs/ai-transport/api-reference/client-transport.md) - reference for client transport methods.
- [Transport](https://ably.com/docs/ai-transport/concepts/transport.md) - how messages are encoded and reconciled.
- [Get started](https://ably.com/docs/ai-transport/getting-started/vercel-ai-sdk.md) - build your first AI Transport application.

## Related Topics

- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md): Stream AI-generated tokens to clients in realtime using AI Transport, with support for message-per-response and message-per-token patterns.
- [Cancellation](https://ably.com/docs/ai-transport/features/cancellation.md): Cancel AI responses mid-stream with Ably AI Transport. Scoped cancel signals, server-side authorization, and graceful abort handling.
- [Reconnection and recovery](https://ably.com/docs/ai-transport/features/reconnection-and-recovery.md): AI Transport streams survive connection drops automatically. Clients reconnect and resume from where they left off with no lost tokens.
- [Multi-device sessions](https://ably.com/docs/ai-transport/features/multi-device.md): Share AI conversations across tabs, phones, and laptops with Ably AI Transport. All devices see the same session in real time.
- [History and replay](https://ably.com/docs/ai-transport/features/history.md): Load conversation history from Ably channels with AI Transport. Paginated history, gapless continuity, and scroll-back patterns.
- [Conversation branching](https://ably.com/docs/ai-transport/features/branching.md): Branch conversations with edit and regenerate in Ably AI Transport. Navigate sibling branches and maintain full conversation history.
- [Interruption and barge-in](https://ably.com/docs/ai-transport/features/interruption.md): Let users interrupt AI agents mid-stream with Ably AI Transport. Cancel-then-send and send-alongside patterns for responsive AI interactions.
- [Concurrent turns](https://ably.com/docs/ai-transport/features/concurrent-turns.md): Run multiple AI turns simultaneously with Ably AI Transport. Independent streams, scoped cancellation, and multi-agent support.
- [Edit and regenerate](https://ably.com/docs/ai-transport/features/edit-and-regenerate.md): Edit user messages and regenerate AI responses with Ably AI Transport. Fork conversations and navigate between branches.
- [Tool calling](https://ably.com/docs/ai-transport/features/tool-calling.md): Stream tool invocations and results through Ably AI Transport. Server-executed and client-executed tools with persistent state.
- [Human-in-the-loop](https://ably.com/docs/ai-transport/features/human-in-the-loop.md): Add human approval gates to AI agent workflows with Ably AI Transport. Approve tool executions and provide input across devices.
- [Agent presence](https://ably.com/docs/ai-transport/features/agent-presence.md): Show agent status in your AI application with Ably Presence. Display streaming, thinking, idle, and offline states in real time.
- [Push notifications](https://ably.com/docs/ai-transport/features/push-notifications.md): Notify users when AI agents complete background tasks with Ably Push Notifications. Reach users even when they're offline.
- [Chain of thought](https://ably.com/docs/ai-transport/features/chain-of-thought.md): Stream reasoning and thinking content alongside responses with Ably AI Transport. Display chain-of-thought in real time.
- [Double texting](https://ably.com/docs/ai-transport/features/double-texting.md): Handle users sending multiple messages while the AI is streaming with Ably AI Transport. Queue or run messages concurrently.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
