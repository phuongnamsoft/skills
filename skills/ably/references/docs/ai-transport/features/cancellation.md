# Cancellation

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

Cancellation of an agent invocation is supported in AI Transport. Cancellation is a turn-level operation. The client publishes a cancel signal on the Ably channel, the server receives it and aborts the matching turns, but the session remains intact, other turns continue, and both sides handle cleanup gracefully. Unlike closing an HTTP connection, cancellation is an explicit signal.

## How it works 

Since sessions are bidirectional, cancel is just a signal on the channel. The client publishes a cancel message with a filter specifying which turns to cancel. The server's transport matches the filter against active turns and fires their abort signals. The LLM stream stops, the turn ends with reason `'cancelled'`, and all subscribers are notified.

<Code>

### Javascript

```
// Client: cancel the current turn
await turn.cancel()

// Server: abort signal fires automatically
const result = streamText({
  abortSignal: turn.abortSignal,  // wired to cancel
})
```
</Code>

<Aside data-type='note'>
With HTTP streaming, cancellation typically means closing the connection - which also kills the session. With AI Transport, cancel and resume are independent operations. You can cancel a turn and immediately send a new message without reconnecting.
</Aside>

## Cancel filters 

Cancel signals are scoped. You control exactly what gets cancelled:

| Filter | Effect | Use case |
| --- | --- | --- |
| `{ own: true }` (default) | Cancel all turns started by this client | Stop button |
| `{ turnId: 'abc' }` | Cancel one specific turn | Cancel a specific generation |
| `{ clientId: 'user-1' }` | Cancel all turns by a specific client | Admin cancellation |
| `{ all: true }` | Cancel all turns on the channel | Emergency stop |

<Code>

### Javascript

```
// Cancel your own turns (default)
await transport.cancel()

// Cancel a specific turn
await transport.cancel({ turnId: activeTurn.turnId })

// Cancel all turns on the channel
await transport.cancel({ all: true })
```
</Code>

## Server-side handling 

### Abort signal 

Every turn has an `abortSignal` that fires when the turn is cancelled. Pass it to your LLM call:

<Code>

#### Javascript

```
const turn = transport.newTurn({ turnId, clientId })
await turn.start()

const result = streamText({
  model: anthropic('claude-sonnet-4-20250514'),
  messages: history,
  abortSignal: turn.abortSignal,
})

const { reason } = await turn.streamResponse(result.toUIMessageStream())
await turn.end(reason)  // reason is 'cancelled' if abort fired
```
</Code>

### Cancel authorization 

The `onCancel` hook lets you authorize or reject cancel requests:

<Code>

#### Javascript

```
const turn = transport.newTurn({
  turnId,
  clientId,
  onCancel: async (request) => {
    // Only allow the turn owner to cancel
    const owner = request.turnOwners.get(request.filter.turnId)
    return owner === request.message.clientId
  },
})
```
</Code>

The `CancelRequest` includes `message` (the raw cancel message with `clientId`), `filter` (parsed scope), `matchedTurnIds`, and `turnOwners` (map of turn ID to owner client ID). Return `false` to reject.

### Abort hook 

The `onAbort` hook runs after the abort signal fires, giving you a chance to publish final events before the stream closes:

<Code>

#### Javascript

```
const turn = transport.newTurn({
  turnId,
  clientId,
  onAbort: async (write) => {
    await write({ type: 'text-delta', textDelta: '\n[Response cancelled]' })
  },
})
```
</Code>

## Cancel on close 

When a client transport closes, it can optionally cancel its own turns:

<Code>

### Javascript

```
await transport.close({ cancel: { own: true } })
```
</Code>

## Related features 

- [Interruption and barge-in](https://ably.com/docs/ai-transport/features/interruption.md) - cancel and immediately send a new message
- [Concurrent turns](https://ably.com/docs/ai-transport/features/concurrent-turns.md) - multiple turns with independent cancel handles
- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md) - what gets cancelled
- [Client transport API](https://ably.com/docs/ai-transport/api-reference/client-transport.md) - reference for `cancel` and other client methods.
- [Turns](https://ably.com/docs/ai-transport/concepts/turns.md) - how turns and cancel signals interact within a session.
- [Get started](https://ably.com/docs/ai-transport/getting-started/vercel-ai-sdk.md) - build your first AI Transport application.

## Related Topics

- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md): Stream AI-generated tokens to clients in realtime using AI Transport, with support for message-per-response and message-per-token patterns.
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
- [Double texting](https://ably.com/docs/ai-transport/features/double-texting.md): Handle users sending multiple messages while the AI is streaming with Ably AI Transport. Queue or run messages concurrently.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
