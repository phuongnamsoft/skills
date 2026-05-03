# Reconnection and recovery

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

AI Transport streams survive connection drops automatically. When a client disconnects, Ably handles reconnection. When it comes back, the client resumes from exactly where it left off - no lost tokens, no broken responses, no manual retry logic.

## How it works 

The durable session (Ably channel) persists independently of any single connection. When a client's connection drops:

1. The agent continues streaming tokens to the channel - the stream is not tied to the client's connection.
2. Ably's client SDK automatically reconnects.
3. On reconnection, the client transport uses `untilAttach` to load any messages it missed during the gap.
4. The conversation state is restored seamlessly - the client sees the complete response.

No application code needed. This is built into the transport layer.

<Aside data-type='note'>
With direct HTTP streaming, a connection drop kills the response stream. The LLM may still be generating, but the tokens have nowhere to go. Resuming requires building custom buffering, sequence numbering, and resume handlers from scratch.
</Aside>

## Recovery scenarios 

There are two recovery paths depending on how long the client was disconnected:

When the disconnection is brief, Ably's connection protocol handles it automatically. The client reconnects and the SDK uses `untilAttach` to load any messages published while the client was away. There is no gap - the response resumes exactly where it left off.

When the client has been offline for a longer period (beyond the channel's persistence window for live recovery), it loads the full conversation from channel history on reconnect. The client can paginate through history using `view.loadOlder()` to reconstruct the complete conversation.

## Encoder recovery 

On the server side, the encoder handles transient failures during streaming. If an append operation fails (for example, due to a network blip between the server and Ably), the encoder falls back to a full message update:

1. Append the next token to the message (normal path).
2. If the append fails, send a full update with the accumulated content (recovery path).
3. Continue appending from the recovered state.

This happens automatically inside `turn.streamResponse()`. The accumulated response is never lost, even if individual append operations fail.

## Mid-stream joins 

When a client joins a channel while a response is already streaming, the lifecycle tracker ensures it receives the correct sequence of events. Missing lifecycle events (like the stream start) are synthesized so the client can process the in-progress stream correctly.

This means a client can open a second tab while the agent is mid-response and immediately see the streaming content.

## Load history on reconnect 

The client transport loads conversation history using Ably's `untilAttach` parameter:

<Code>

### Javascript

```
const { nodes, hasOlder, loadOlder } = useView({ transport, limit: 30 })
```
</Code>

`useView` automatically loads history on mount. The `untilAttach` flag ensures no gap between historical messages and live messages - every message is accounted for.

To load older messages beyond the initial window:

<Code>

### Javascript

```
const { nodes, hasOlder, loadOlder } = useView({ transport, limit: 30 })

// hasOlder indicates whether there are more messages to load
if (hasOlder) {
  await loadOlder()
  // The view window expands internally - nodes updates with the older messages
}
```
</Code>

## Related features 

- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md) - what gets recovered.
- [Multi-device sessions](https://ably.com/docs/ai-transport/features/multi-device.md) - reconnection across devices.
- [History and replay](https://ably.com/docs/ai-transport/features/history.md) - loading conversation history.
- [Client transport API](https://ably.com/docs/ai-transport/api-reference/client-transport.md) - reference for client transport connection and recovery methods.
- [Sessions](https://ably.com/docs/ai-transport/concepts/sessions.md) - how durable sessions enable recovery.
- [Get started](https://ably.com/docs/ai-transport/getting-started/vercel-ai-sdk.md) - build your first AI Transport application.

## Related Topics

- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md): Stream AI-generated tokens to clients in realtime using AI Transport, with support for message-per-response and message-per-token patterns.
- [Cancellation](https://ably.com/docs/ai-transport/features/cancellation.md): Cancel AI responses mid-stream with Ably AI Transport. Scoped cancel signals, server-side authorization, and graceful abort handling.
- [Multi-device sessions](https://ably.com/docs/ai-transport/features/multi-device.md): Share AI conversations across tabs, phones, and laptops with Ably AI Transport. All devices see the same session in real time.
- [History and replay](https://ably.com/docs/ai-transport/features/history.md): Load conversation history from Ably channels with AI Transport. Paginated history, gapless continuity, and scroll-back patterns.
- [Conversation branching](https://ably.com/docs/ai-transport/features/branching.md): Branch conversations with edit and regenerate in Ably AI Transport. Navigate sibling branches and maintain full conversation history.
- [Interruption and barge-in](https://ably.com/docs/ai-transport/features/interruption.md): Let users interrupt AI agents mid-stream with Ably AI Transport. Cancel-then-send and send-alongside patterns for responsive AI interactions.
- [Concurrent turns](https://ably.com/docs/ai-transport/features/concurrent-turns.md): Run multiple AI turns simultaneously with Ably AI Transport. Independent streams, scoped cancellation, and multi-agent support.
- [Edit and regenerate](https://ably.com/docs/ai-transport/features/edit-and-regenerate.md): Edit user messages and regenerate AI responses with Ably AI Transport. Fork conversations and navigate between branches.
- [Tool calling](https://ably.com/docs/ai-transport/features/tool-calling.md): Stream tool invocations and results through Ably AI Transport. Server-executed and client-executed tools with persistent state.
- [Human-in-the-loop](https://ably.com/docs/ai-transport/features/human-in-the-loop.md): Add human approval gates to AI agent workflows with Ably AI Transport. Approve tool executions and provide input across devices.
- [Optimistic updates](https://ably.com/docs/ai-transport/features/optimistic-updates.md): User messages appear instantly in Ably AI Transport. Optimistic insertion with automatic reconciliation when the server confirms.
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
