# Edit and regenerate

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

Edit and regenerate let users revise their input or request a new response. Both operations fork the conversation tree - the original branch is preserved, and a new branch starts from the edit or regeneration point.

## How it works 

When a user edits a message, the SDK creates a new sibling node in the conversation tree. The original message and everything below it remain intact. A new turn is triggered so the agent responds to the revised input.

Regeneration works similarly - it creates a sibling of an assistant message and starts a new turn from the same parent. The original response stays in the tree, and a fresh response streams alongside it as an alternative.

Both operations send `forkOf` and `parent` headers to the server, telling it where the new branch diverges from the existing tree. The server uses these to build history up to the fork point, so the LLM sees only the messages leading to the new branch.

<Aside data-type='note'>
Edit and regenerate never delete messages. Every version of every message is preserved in the conversation tree. Users navigate between versions using [branch navigation](https://ably.com/docs/ai-transport/features/branching.md#branch-navigation).
</Aside>

## Edit a message 

Edit replaces a user message with new content and triggers a fresh turn from that point. The original message and all its descendants remain in the tree as a separate branch.

<Code>

### Javascript

```
// Using the view directly
await view.edit(messageId, [
  { role: 'user', content: 'Updated question here' }
])

// Using the React hook
const edit = useEdit(view)

await edit(messageId, [
  { role: 'user', content: 'Updated question here' }
])
```
</Code>

The edit creates a new user message as a sibling of the original, then sends a turn request to the server. The server receives the new message along with `forkOf` (the original message ID) and `parent` (the message before the edited one). It builds conversation history up to the parent, appends the new content, and streams a response.

You can send multiple messages in a single edit:

<Code>

### Javascript

```
await view.edit(messageId, [
  { role: 'user', content: 'First part of my revised input' },
  { role: 'user', content: 'Second part with additional context' }
])
```
</Code>

## Regenerate a response 

Regenerate creates a sibling of an assistant message and starts a new turn. The original response stays in the tree - the user can switch between the original and regenerated responses.

<Code>

### Javascript

```
// Using the view directly
await view.regenerate(messageId)

// Using the React hook
const regenerate = useRegenerate(view)

await regenerate(messageId)
```
</Code>

The new turn is sent to the server with `forkOf` set to the original assistant message ID and `parent` set to the user message that preceded it. The server generates a new response from that point in the conversation, and the response streams to all connected clients.

## How forks create siblings 

Each edit or regeneration adds a sibling node in the tree. Siblings share the same parent but represent alternative paths. The view flattens the selected path into a linear list for rendering.

For example, if a user edits their second message twice, the tree has three sibling branches from that point. Each branch has its own assistant response and any subsequent messages. The view shows whichever branch is currently selected.

<Code>

### Javascript

```
// Check how many alternatives exist at a message
const siblings = view.getSiblings(messageId) // Message[]
const selected = view.getSelectedIndex(messageId) // number

// Navigate to a different version
view.select(messageId, selected + 1)
```
</Code>

## Server handling 

The server receives `forkOf` and `parent` in the request body. Pass them to `newTurn()` so the transport publishes messages with the correct tree metadata:

<Code>

### Javascript

```
app.post('/chat', async (req, res) => {
  const { messages, turnId, clientId, forkOf, parent } = req.body

  const turn = transport.newTurn({ turnId, clientId, forkOf, parent })
  await turn.start()

  // messages is auto-truncated to the fork point
  const result = streamText({
    model: anthropic('claude-sonnet-4-20250514'),
    messages,
    abortSignal: turn.abortSignal,
  })

  const { reason } = await turn.streamResponse(result.toUIMessageStream())
  await turn.end(reason)
})
```
</Code>

The `messages` array in the request body contains the conversation history truncated to the fork point, with the new user message appended. The client handles this truncation automatically - the server receives exactly the history the LLM needs.

## Related features 

- [Conversation branching](https://ably.com/docs/ai-transport/features/branching.md) - tree structure, branch navigation, and split-pane views
- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md) - how regenerated responses stream to clients
- [Multi-device sessions](https://ably.com/docs/ai-transport/features/multi-device.md) - edits and regenerations sync across devices
- [React hooks](https://ably.com/docs/ai-transport/api-reference/react-hooks.md) - reference for `useEdit`, `useRegenerate`, and other hooks.
- [Messages and conversation tree](https://ably.com/docs/ai-transport/concepts/messages-and-conversation-tree.md) - how forks create new branches in the conversation tree.
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
