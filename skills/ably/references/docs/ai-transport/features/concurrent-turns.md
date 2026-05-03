# Concurrent turns

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

Concurrent turns allow multiple request-response cycles to be active simultaneously on the same session. Each turn has its own stream, cancel handle, and lifecycle. Cancel one turn without affecting others. This enables interruption patterns, multi-user sessions, and multi-agent architectures.

## How it works 

Turns are multiplexed on the Ably channel via `turnId`. Every message published during a turn - text deltas, tool calls, lifecycle events - is tagged with a header identifying its turn. The client transport inspects these headers and routes each message to the correct turn's stream.

<Code>

### Javascript

```
// Client sends two messages without waiting for the first to finish
const turn1 = await view.send([{ id: crypto.randomUUID(), role: 'user', parts: [{ type: 'text', text: 'Summarize the report' }] }])
const turn2 = await view.send([{ id: crypto.randomUUID(), role: 'user', parts: [{ type: 'text', text: 'What are the key risks?' }] }])

// Each turn has its own stream
for await (const chunk of turn1.stream) {
  renderToPanel('summary', chunk)
}

for await (const chunk of turn2.stream) {
  renderToPanel('risks', chunk)
}
```
</Code>

On the server, each turn is handled independently. The server transport creates a separate turn object per request, each with its own abort signal and lifecycle:

<Code>

### Javascript

```
// Server: each incoming turn is independent
app.post('/api/chat', async (req, res) => {
  const { turnId, clientId, messages } = req.body
  const turn = transport.newTurn({ turnId, clientId })

  await turn.start()

  const result = streamText({
    model: anthropic('claude-sonnet-4-20250514'),
    messages,
    abortSignal: turn.abortSignal,
  })

  await turn.streamResponse(result.toUIMessageStream())
  await turn.end('complete')
  res.json({ ok: true })
})
```
</Code>

<Aside data-type='note'>
With HTTP streaming, each request occupies a dedicated connection. Running two turns means two open connections. With AI Transport, all turns share a single Ably channel - no extra connections, no fan-out complexity.
</Aside>

## Track active turns 

`useActiveTurns` returns a map of which clients have which turns in progress. Use it to show per-client streaming indicators:

<Code>

### Javascript

```
const activeTurns = useActiveTurns({ transport })
// Map<clientId, Set<turnId>>

// Show a spinner next to each client that's streaming
for (const [clientId, turnIds] of activeTurns) {
  console.log(`${clientId} has ${turnIds.size} active turn(s)`)
}

// Check if a specific agent is busy
const isAgentStreaming = activeTurns.has('agent-1')
```
</Code>

The map updates in real time across all connected clients. When a turn starts or ends anywhere on the channel, every subscriber's `useActiveTurns` reflects the change immediately.

## Scoped cancellation 

Cancel one turn without affecting others by passing a `turnId` filter:

<Code>

### Javascript

```
// Cancel a specific turn
await transport.cancel({ turnId: turn1.turnId })

// turn2 continues streaming
```
</Code>

The default cancel behavior (`{ own: true }`) cancels all of your active turns. For concurrent turns, scoped cancellation is essential - it lets you stop one generation while others keep running.

| Filter | Effect |
| --- | --- |
| `{ turnId }` | Cancel one specific turn |
| `{ own: true }` | Cancel all turns started by this client |
| `{ clientId }` | Cancel all turns by a specific client |
| `{ all: true }` | Cancel every active turn on the channel |

See [Cancellation](https://ably.com/docs/ai-transport/features/cancellation.md) for the full cancel API including server-side authorization and abort hooks.

## Wait for turns 

`transport.waitForTurn()` returns a promise that resolves when matching turns complete. Use it to coordinate work that depends on a turn finishing:

<Code>

### Javascript

```
// Wait for a specific turn to finish
await transport.waitForTurn({ turnId: turn1.turnId })

// Wait for all of your own turns to finish
await transport.waitForTurn({ own: true })

// Wait for all turns on the channel to complete
await transport.waitForTurn({ all: true })
```
</Code>

This is useful when you need to sequence operations - for example, sending a follow-up message only after the first response is complete, or disabling a submit button until all pending turns resolve.

## Use cases 

### Interruption 

Cancel the current turn and immediately start a new one. Both turns exist briefly on the channel - the old turn winding down while the new turn starts streaming:

<Code>

#### Javascript

```
// User hits send while the agent is still responding
await transport.cancel({ own: true })
const newTurn = await view.send([{ id: crypto.randomUUID(), role: 'user', parts: [{ type: 'text', text: 'Actually, focus on the budget instead' }] }])
```
</Code>

See [Interruption and barge-in](https://ably.com/docs/ai-transport/features/interruption.md) for the full pattern.

### Multi-user sessions 

Two users prompting the same session simultaneously. Each user's turn is independent - both see each other's prompts and responses in real time:

<Code>

#### Javascript

```
// User A sends a message
const turnA = await viewA.send([{ id: crypto.randomUUID(), role: 'user', parts: [{ type: 'text', text: 'What does section 3 mean?' }] }])

// User B sends a message at the same time
const turnB = await viewB.send([{ id: crypto.randomUUID(), role: 'user', parts: [{ type: 'text', text: 'Summarize section 5' }] }])

// Both turns stream concurrently on the shared channel
```
</Code>

### Multi-agent 

An orchestrator dispatches work to multiple sub-agents, each streaming its response concurrently on the same channel:

<Code>

#### Javascript

```
// Server: orchestrator fans out to sub-agents
app.post('/api/chat', async (req, res) => {
  const { messages } = req.body
  const researchTurn = transport.newTurn({ turnId: 'research', clientId: 'researcher' })
  const analysisTurn = transport.newTurn({ turnId: 'analysis', clientId: 'analyst' })

  // Both sub-agents stream concurrently
  await Promise.all([
    runResearchAgent(researchTurn, messages),
    runAnalysisAgent(analysisTurn, messages),
  ])
  res.json({ ok: true })
})
```
</Code>

The client sees both agent responses arriving in parallel, each tagged with its own turn ID and client ID.

## Related features 

- [Cancellation](https://ably.com/docs/ai-transport/features/cancellation.md) - scoped cancel signals and server-side abort handling
- [Interruption and barge-in](https://ably.com/docs/ai-transport/features/interruption.md) - cancel and immediately send a new message
- [Multi-device sessions](https://ably.com/docs/ai-transport/features/multi-device.md) - concurrent turns across devices
- [Client transport API](https://ably.com/docs/ai-transport/api-reference/client-transport.md) - reference for `waitForTurn` and other client methods.
- [Turns](https://ably.com/docs/ai-transport/concepts/turns.md) - how turns are multiplexed on a session.
- [Get started](https://ably.com/docs/ai-transport/getting-started/vercel-ai-sdk.md) - build your first AI Transport application.

## Related Topics

- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md): Stream AI-generated tokens to clients in realtime using AI Transport, with support for message-per-response and message-per-token patterns.
- [Cancellation](https://ably.com/docs/ai-transport/features/cancellation.md): Cancel AI responses mid-stream with Ably AI Transport. Scoped cancel signals, server-side authorization, and graceful abort handling.
- [Reconnection and recovery](https://ably.com/docs/ai-transport/features/reconnection-and-recovery.md): AI Transport streams survive connection drops automatically. Clients reconnect and resume from where they left off with no lost tokens.
- [Multi-device sessions](https://ably.com/docs/ai-transport/features/multi-device.md): Share AI conversations across tabs, phones, and laptops with Ably AI Transport. All devices see the same session in real time.
- [History and replay](https://ably.com/docs/ai-transport/features/history.md): Load conversation history from Ably channels with AI Transport. Paginated history, gapless continuity, and scroll-back patterns.
- [Conversation branching](https://ably.com/docs/ai-transport/features/branching.md): Branch conversations with edit and regenerate in Ably AI Transport. Navigate sibling branches and maintain full conversation history.
- [Interruption and barge-in](https://ably.com/docs/ai-transport/features/interruption.md): Let users interrupt AI agents mid-stream with Ably AI Transport. Cancel-then-send and send-alongside patterns for responsive AI interactions.
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
