# Interruption and barge-in

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

Interruption lets users send a new message while the agent is still streaming a response. When a user sends a new message, the client transport creates a new turn via an HTTP POST to the server. Because turns are independent, the new turn starts immediately regardless of whether a previous turn is still streaming.

![Diagram showing session continuity during interruption](https://raw.githubusercontent.com/ably/docs/main/src/images/content/diagrams/ait-session-continuity.png)

## How it works 

When the user sends a new message, the client transport posts it to the server, which starts a new turn. The user doesn't need to wait for the current response to finish before sending a new message.

There are two patterns for handling interruption:

| Pattern | Behavior | Use case |
| --- | --- | --- |
| Cancel-then-send | Cancel the current turn, then send a new message | Stop button + new prompt |
| Send-alongside | Send a new message while the current turn continues | Follow-up without waiting |

With cancel-then-send, the active turn is aborted before the new message is dispatched. The agent stops generating, cleans up, and starts a fresh turn. With send-alongside, both turns run concurrently - each with its own stream and cancel handle.

## Cancel-then-send 

Detect whether a turn is active, cancel it, then send a new message. This is the most common interruption pattern - it mimics a user pressing a stop button and immediately re-prompting.

<Code>

### Javascript

```
import { useActiveTurns, useClientTransport, useView } from '@ably/ai-transport/react'

function Chat({ channel, clientId }) {
  const transport = useClientTransport({ channelName: chatId })
  const { nodes, send } = useView({ transport })
  const activeTurns = useActiveTurns({ transport })

  const handleSend = async (text) => {
    // If the agent is streaming, cancel first
    if (activeTurns.size > 0) {
      await transport.cancel()
    }

    await send([{ id: crypto.randomUUID(), role: 'user', parts: [{ type: 'text', text }] }])
  }
}
```
</Code>

`transport.cancel()` publishes a cancel signal on the channel. The server's abort signal fires, the LLM stream stops, and the turn ends with reason `'cancelled'`. The new message is then sent on a clean turn.

## Send-alongside 

Send a new message without cancelling the active turn. Both turns run concurrently - the agent continues streaming the first response while processing the new input.

<Code>

### Javascript

```
const handleSend = async (text) => {
  // Send without cancelling - both turns run concurrently
  await send([{ id: crypto.randomUUID(), role: 'user', parts: [{ type: 'text', text }] }])
}
```
</Code>

Each concurrent turn has its own stream and its own cancel handle. You can cancel them independently:

<Code>

### Javascript

```
// Cancel a specific turn, leave others running
await transport.cancel({ turnId: specificTurnId })
```
</Code>

## Detect active turns 

The `useActiveTurns` hook returns a `Map<clientId, Set<turnId>>` of all currently streaming turns. Use it to check whether the agent is mid-response:

<Code>

### Javascript

```
const activeTurns = useActiveTurns({ transport })

// Check if any turns are streaming
const isStreaming = activeTurns.size > 0

// Check if a specific client has active turns
const agentTurns = activeTurns.get('agent-client-id')
const agentIsStreaming = agentTurns && agentTurns.size > 0
```
</Code>

This is useful for toggling UI between a send button and a stop button, or for disabling input while a cancellation is in progress.

<Aside data-type='note'>
Without a session layer, interruption typically requires building a separate message queue or signaling system. With AI Transport, the session handles turn management - interruption is just a new turn via HTTP POST while the previous turn's stream continues on the channel.
</Aside>

## Related features 

- [Cancellation](https://ably.com/docs/ai-transport/features/cancellation.md) - cancel signals, filters, and server-side abort handling
- [Concurrent turns](https://ably.com/docs/ai-transport/features/concurrent-turns.md) - multiple turns running in parallel
- [Double texting](https://ably.com/docs/ai-transport/features/double-texting.md) - handling multiple user messages in quick succession
- [Client transport API](https://ably.com/docs/ai-transport/api-reference/client-transport.md) - reference for `cancel`, `send`, and other client methods.
- [Sessions](https://ably.com/docs/ai-transport/concepts/sessions.md) - how bidirectional sessions enable interruption.
- [Get started](https://ably.com/docs/ai-transport/getting-started/vercel-ai-sdk.md) - build your first AI Transport application.

## Related Topics

- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md): Stream AI-generated tokens to clients in realtime using AI Transport, with support for message-per-response and message-per-token patterns.
- [Cancellation](https://ably.com/docs/ai-transport/features/cancellation.md): Cancel AI responses mid-stream with Ably AI Transport. Scoped cancel signals, server-side authorization, and graceful abort handling.
- [Reconnection and recovery](https://ably.com/docs/ai-transport/features/reconnection-and-recovery.md): AI Transport streams survive connection drops automatically. Clients reconnect and resume from where they left off with no lost tokens.
- [Multi-device sessions](https://ably.com/docs/ai-transport/features/multi-device.md): Share AI conversations across tabs, phones, and laptops with Ably AI Transport. All devices see the same session in real time.
- [History and replay](https://ably.com/docs/ai-transport/features/history.md): Load conversation history from Ably channels with AI Transport. Paginated history, gapless continuity, and scroll-back patterns.
- [Conversation branching](https://ably.com/docs/ai-transport/features/branching.md): Branch conversations with edit and regenerate in Ably AI Transport. Navigate sibling branches and maintain full conversation history.
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
