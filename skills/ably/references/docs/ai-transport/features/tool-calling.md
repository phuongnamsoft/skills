# Tool calling

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

Tool calling in AI Transport supports both server-executed and client-executed tools. Tool invocations and results are published to the channel, so all clients see tool activity in real time and tool state persists in history.

## How it works 

When the LLM invokes a tool, the invocation is streamed through the channel like any other turn event. Clients see tool calls appear as they're generated. If the tool runs on the server, the result is streamed back in the same turn. If the tool runs on the client, the turn ends and a continuation turn starts after the client submits the result.

Tool state - invocations, arguments, and results - is part of the channel's message history. Late joiners and reconnecting clients see the full tool activity, not just final text.

## Server-executed tools 

Server-executed tools are the default path. The AI SDK handles tool execution automatically during the LLM stream. Tool invocations and results are encoded by the codec and published to the channel as part of the turn.

<Code>

### Javascript

```
const result = streamText({
  model: anthropic('claude-sonnet-4-20250514'),
  messages: conversationHistory,
  tools: {
    getWeather: {
      description: 'Get current weather for a location',
      inputSchema: z.object({ city: z.string() }),
      execute: async ({ city }) => {
        const data = await fetchWeather(city)
        return { temperature: data.temp, conditions: data.conditions }
      },
    },
  },
  abortSignal: turn.abortSignal,
})

const { reason } = await turn.streamResponse(result.toUIMessageStream())
await turn.end(reason)
```
</Code>

Clients see the tool invocation as it streams, then the result, then the LLM's follow-up text - all within a single turn.

## Client-executed tools 

Client-executed tools require a round trip between the server and client. The LLM requests a tool call, the turn ends, the client executes the tool locally and submits the result, and a continuation turn starts.

On the server, define the tool without an `execute` function. When the LLM invokes it, the stream ends with a tool call that the client must fulfill:

<Code>

### Javascript

```
const result = streamText({
  model: anthropic('claude-sonnet-4-20250514'),
  messages: conversationHistory,
  tools: {
    getUserLocation: {
      description: 'Get the user\'s current location',
      inputSchema: z.object({}),
      // No execute function - the client handles this
    },
  },
  abortSignal: turn.abortSignal,
})

const { reason } = await turn.streamResponse(result.toUIMessageStream())
await turn.end(reason)
```
</Code>

On the client, detect the pending tool call and submit the result using `view.update()`. The first parameter is the Ably message ID of the node containing the tool invocation, not the tool call ID:

<Code>

### Javascript

```
const { nodes } = useView({ transport })

// Find the node with a pending tool invocation
const pendingNode = nodes
  .find(n => n.message.parts?.some(p => p.type === 'dynamic-tool' && p.state === 'input-available'))

if (pendingNode) {
  // Execute the tool locally and submit the result
  const location = await navigator.geolocation.getCurrentPosition()

  const toolCall = pendingNode.message.parts
    .find(p => p.type === 'dynamic-tool' && p.state === 'input-available')

  // First argument is the Ably message ID of the node containing the tool invocation
  await view.update(pendingNode.id, [{
    type: 'tool-output-available',
    toolCallId: toolCall.toolCallId,
    output: { lat: location.coords.latitude, lng: location.coords.longitude },
  }])
}
```
</Code>

Calling `view.update()` submits the tool result to the server and triggers a continuation turn. The server receives the result, includes it in the conversation history, and the LLM generates a response that incorporates the tool output.

## Cross-turn events with EventsNode 

The `addEvents()` method delivers events to an existing assistant message. A common use is delivering tool results to a message that contains a pending tool call. You target the message by its Ably message ID:

<Code>

### Javascript

```
// Deliver a tool result to an existing assistant message
const assistantMsgId = pendingNode.id
const toolCallId = pendingToolCall.toolCallId

await turn.addEvents(assistantMsgId, [
  {
    type: 'tool-output-available',
    toolCallId,
    output: { temperature: 22, conditions: 'sunny' },
  },
])
```
</Code>

Events published through `addEvents()` update the target message in the view. Because they target an existing message by its ID, late joiners and reconnecting clients see the correct state when the conversation is replayed from history.

## History persistence 

Tool invocations and results are part of the channel's message history. When a client reconnects or a late joiner loads the conversation, tool activity is replayed along with text messages. The view reconstructs tool state so the UI shows the correct tool status - whether a tool is pending, complete, or failed.

This means tool-heavy conversations work correctly across disconnections and device switches. A user who starts a tool-assisted workflow on their laptop can continue it on their phone without losing context.

## Related features 

- [Human-in-the-loop](https://ably.com/docs/ai-transport/features/human-in-the-loop.md) - approval gates built on tool calling
- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md) - how tool events are streamed
- [History and replay](https://ably.com/docs/ai-transport/features/history.md) - loading past tool activity from history
- [Multi-device sessions](https://ably.com/docs/ai-transport/features/multi-device.md) - tool state syncs across devices
- [Server transport API](https://ably.com/docs/ai-transport/api-reference/server-transport.md) - reference for `addEvents` and other server methods.
- [Turns](https://ably.com/docs/ai-transport/concepts/turns.md) - how tool calls fit into the turn lifecycle.
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
