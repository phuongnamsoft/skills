# Chain of thought

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

Chain of thought in AI Transport streams reasoning content alongside the main response text. The codec supports multiple stream types within a single turn - text and reasoning are delivered as separate streams that render independently in the UI.

## How it works 

When an LLM produces reasoning or thinking tokens, the codec multiplexes them alongside text tokens on the same Ably channel. Each stream type is tagged so the client can route reasoning content to one part of the UI and response text to another.

With the Vercel AI SDK integration, reasoning arrives as a separate `reasoning` stream type within the UI message stream:

<Code>

### Javascript

```
// Server: stream a response that includes reasoning
app.post('/api/chat', async (req, res) => {
  const { turnId, clientId, messages } = req.body
  const turn = transport.newTurn({ turnId, clientId })

  const result = streamText({
    model: anthropic('claude-sonnet-4-20250514'),
    messages,
    abortSignal: turn.abortSignal,
  })

  // The codec handles multiplexing text and reasoning streams
  await turn.streamResponse(result.toUIMessageStream())
  await turn.end('complete')
  res.json({ ok: true })
})
```
</Code>

No additional server configuration is needed. If the model produces reasoning tokens, the codec encodes them as a distinct stream within the turn.

## Display reasoning in the UI 

On the client, message nodes include both text and reasoning content. Render them separately to show the agent's thinking process:

<Code>

### Javascript

```
const { nodes } = useView({ transport })

// Each node may contain text parts, reasoning parts, or both
for (const node of nodes) {
  for (const part of node.message.parts) {
    if (part.type === 'reasoning') {
      renderThinkingPanel(part.reasoning)
    } else if (part.type === 'text') {
      renderResponsePanel(part.text)
    }
  }
}
```
</Code>

Both streams update in real time. Users see the reasoning content appear as the model thinks, followed by (or alongside) the response text.

<Aside data-type='note'>
Chain of thought support depends on the model and framework. Not all models produce reasoning tokens, and not all codec integrations surface them as separate stream types. Check your framework guide for details on reasoning support.
</Aside>

## Related features 

- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md) - how text tokens are streamed and accumulated
- [Tool calling](https://ably.com/docs/ai-transport/features/tool-calling.md) - another multi-part stream type within a turn
- [Codec API](https://ably.com/docs/ai-transport/api-reference/codec.md) - reference for the codec that multiplexes reasoning and text streams.
- [Transport](https://ably.com/docs/ai-transport/concepts/transport.md) - how the codec encodes multiple stream types.
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
- [Double texting](https://ably.com/docs/ai-transport/features/double-texting.md): Handle users sending multiple messages while the AI is streaming with Ably AI Transport. Queue or run messages concurrently.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
