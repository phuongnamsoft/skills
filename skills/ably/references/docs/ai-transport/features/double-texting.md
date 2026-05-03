# Double texting

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

Double texting is when a user sends a new message while the agent is still streaming a response. AI Transport supports this through [concurrent turns](https://ably.com/docs/ai-transport/features/concurrent-turns.md) - the new message starts a new turn that runs alongside the existing one.

## Default behavior 

By default, sending a message while the agent is streaming starts a new concurrent turn. Both the existing response and the new turn run in parallel:

<Code>

### Javascript

```
// User sends a message
await send([{ id: crypto.randomUUID(), role: 'user', parts: [{ type: 'text', text: 'Explain quantum computing' }] }])

// Agent starts streaming a response...

// User sends another message before the response finishes
await send([{ id: crypto.randomUUID(), role: 'user', parts: [{ type: 'text', text: 'Also, what is superposition?' }] }])

// Both turns stream concurrently
```
</Code>

Each turn has its own stream and cancel handle. The conversation tree contains both exchanges.

## Queue-while-streaming 

If you want to prevent concurrent turns and instead queue messages, detect active turns and show a queued indicator in the UI:

<Code>

### Javascript

```
const activeTurns = useActiveTurns({ transport })

const handleSend = async (text) => {
  if (activeTurns.size > 0) {
    // Show a queued indicator in the UI
    addToQueue(text)
    return
  }

  await send([{ id: crypto.randomUUID(), role: 'user', parts: [{ type: 'text', text }] }])
}

// When the active turn finishes, send the next queued message
useEffect(() => {
  if (activeTurns.size === 0 && queue.length > 0) {
    const next = queue.shift()
    send([{ id: crypto.randomUUID(), role: 'user', parts: [{ type: 'text', text: next }] }])
  }
}, [activeTurns.size])
```
</Code>

This gives users feedback that their message was received and will be processed next, without interrupting the current response.

## Cancel-then-send 

An alternative is to cancel the current turn before sending the new message. This is the [interruption](https://ably.com/docs/ai-transport/features/interruption.md) pattern:

<Code>

### Javascript

```
const handleSend = async (text) => {
  if (activeTurns.size > 0) {
    await transport.cancel()
  }

  await send([{ id: crypto.randomUUID(), role: 'user', parts: [{ type: 'text', text }] }])
}
```
</Code>

The current response stops, and the new message starts a fresh turn. This works well when the user's new message supersedes the previous one.

## Choose a pattern 

| Pattern | Behavior | Best for |
| --- | --- | --- |
| Concurrent (default) | Both turns run in parallel | Multi-topic conversations, research tasks |
| Queue-while-streaming | New message waits for current turn to finish | Sequential conversations, chatbots |
| Cancel-then-send | Current turn is aborted, new turn starts | Corrections, redirections |

The right pattern depends on your application. Concurrent turns work well for exploratory conversations. Queuing is better for sequential interactions where order matters. Cancel-then-send is best when the new message replaces the previous one.

## Related features 

- [Concurrent turns](https://ably.com/docs/ai-transport/features/concurrent-turns.md) - the underlying mechanism for parallel turns
- [Interruption and barge-in](https://ably.com/docs/ai-transport/features/interruption.md) - the cancel-then-send pattern in detail
- [Cancellation](https://ably.com/docs/ai-transport/features/cancellation.md) - cancel signals and scoped cancellation
- [Client transport API](https://ably.com/docs/ai-transport/api-reference/client-transport.md) - reference for `send`, `cancel`, and other client methods.
- [Turns](https://ably.com/docs/ai-transport/concepts/turns.md) - how concurrent turns are managed within a session.
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
- [Optimistic updates](https://ably.com/docs/ai-transport/features/optimistic-updates.md): User messages appear instantly in Ably AI Transport. Optimistic insertion with automatic reconciliation when the server confirms.
- [Agent presence](https://ably.com/docs/ai-transport/features/agent-presence.md): Show agent status in your AI application with Ably Presence. Display streaming, thinking, idle, and offline states in real time.
- [Push notifications](https://ably.com/docs/ai-transport/features/push-notifications.md): Notify users when AI agents complete background tasks with Ably Push Notifications. Reach users even when they're offline.
- [Chain of thought](https://ably.com/docs/ai-transport/features/chain-of-thought.md): Stream reasoning and thinking content alongside responses with Ably AI Transport. Display chain-of-thought in real time.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
