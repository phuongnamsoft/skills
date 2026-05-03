# History and replay

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

History in AI Transport comes from the Ably channel itself. Every message - user prompts, agent responses, lifecycle events - persists on the channel. Clients load history on connect and paginate backward through the conversation. There is no separate database to maintain.

## How it works 

The client transport loads history using `view.loadOlder()` with `untilAttach` for gapless continuity. This ensures no gap between historical messages and live messages arriving through the real-time subscription.

`loadOlder()` returns `Promise<void>` - it expands the view window internally rather than returning a paginated result. The `useView` hook exposes the loaded conversation as `nodes`, along with `hasOlder` and `loadOlder` for pagination:

<Code>

### Javascript

```
const { nodes, hasOlder, loadOlder } = useView({ transport, limit: 30 })

// Load the next page of older messages
if (hasOlder) {
  await loadOlder()
}
```
</Code>

## Minimal code 

The `useView` hook handles history loading on mount:

<Code>

### Javascript

```
const { nodes, hasOlder, loadOlder } = useView({ transport, limit: 30 })
```
</Code>

This loads 30 messages when the component mounts. `nodes` contains the decoded conversation. `hasOlder` indicates whether more history is available. `loadOlder()` fetches the next page.

<Aside data-type='note'>
Without durable sessions, history requires a separate database, sync logic, and consistency guarantees. You need to store every message server-side, expose a pagination API, handle ordering conflicts, and reconcile the database with any in-flight messages. AI Transport eliminates this - the channel is the database.
</Aside>

## Scroll-back pattern 

Load more messages as the user scrolls up. The `useView` hook provides everything needed for infinite scroll:

<Code>

### Javascript

```
const { nodes, hasOlder, loading, loadOlder } = useView({ transport, limit: 30 })

function handleScrollToTop() {
  if (hasOlder && !loading) {
    loadOlder()
  }
}
```
</Code>

`loading` is `true` while a history page is being fetched. Use it to show a spinner at the top of the conversation. When `hasOlder` is `false`, the user has reached the beginning of the conversation.

## History and branching 

History includes branch information. Messages carry `parent` and `forkOf` headers that indicate which conversation branch they belong to. When history is loaded, the conversation tree reconstructs branches from these headers, placing each message on the correct branch.

This means loading history does not just produce a flat list of messages. It rebuilds the full tree structure, including any points where the conversation forked due to edits, regenerations, or explicit branching.

## Related features 

- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md) - how streamed responses are persisted and replayed from history.
- [Reconnection and recovery](https://ably.com/docs/ai-transport/features/reconnection-and-recovery.md) - how history loading fits into reconnection.
- [Conversation branching](https://ably.com/docs/ai-transport/features/branching.md) - how branches are created and navigated.
- [Client transport API](https://ably.com/docs/ai-transport/api-reference/client-transport.md) - reference for `loadOlder` and other client methods.
- [Sessions](https://ably.com/docs/ai-transport/concepts/sessions.md) - how sessions persist conversation history.
- [Get started](https://ably.com/docs/ai-transport/getting-started/vercel-ai-sdk.md) - build your first AI Transport application.

## Related Topics

- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md): Stream AI-generated tokens to clients in realtime using AI Transport, with support for message-per-response and message-per-token patterns.
- [Cancellation](https://ably.com/docs/ai-transport/features/cancellation.md): Cancel AI responses mid-stream with Ably AI Transport. Scoped cancel signals, server-side authorization, and graceful abort handling.
- [Reconnection and recovery](https://ably.com/docs/ai-transport/features/reconnection-and-recovery.md): AI Transport streams survive connection drops automatically. Clients reconnect and resume from where they left off with no lost tokens.
- [Multi-device sessions](https://ably.com/docs/ai-transport/features/multi-device.md): Share AI conversations across tabs, phones, and laptops with Ably AI Transport. All devices see the same session in real time.
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
