# Conversation branching

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

The leading AI user experiences today expose more than just a simple linear message history or a conversation; it is possible to fork a conversation; ie to submit a prompt from an earlier time in the chat so that the conversation continues from that point, incorporating prior conversation history as context. It is also possible to re-generate a response to a given prompt, perhaps because the generation by the agent failed on the first attempt. These branching possibilies come in addition to the structure of turns, which can be concurrent and may have been interleaved at the time.

Conversation branching in AI Transport suppose these use-cases by allowing users to edit messages and regenerate responses, creating alternative branches in the conversation. The SDK maintains a tree structure where each branch is a fork - the full history is preserved, and users navigate between branches with sibling navigation.

![Diagram showing session continuity during interruption](https://raw.githubusercontent.com/ably/docs/main/src/images/content/diagrams/ait-session-continuity.png)

## How it works 

The conversation is a tree, not a list; every message is a node with a parent pointer. When a user edits a message or regenerates a response, the SDK creates a new branch rather than overwriting the original.

- `edit()` forks a user message. The original message and its descendants remain intact. A new child is added to the same parent, creating a sibling branch.
- `regenerate()` forks an assistant message. The original response stays in the tree, and a new sibling is created with a fresh turn.

Each fork creates a new branch with `forkOf` and `parent` headers that tell the server where in the tree this branch diverges. The `View` flattens the selected branch into a linear list for rendering.

<Aside data-type='note'>
Without branching, editing a message means discarding everything after it. With a tree structure, nothing is lost. Users can explore alternative responses and switch between them freely.
</Aside>

## Regenerate 

Regenerate creates a sibling of an assistant message and starts a new turn. The original response remains in the tree.

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

The new turn is sent to the server with `forkOf` set to the original assistant message ID and `parent` set to the user message that preceded it. The server generates a new response from that point in the conversation.

## Edit 

Edit replaces a user message and starts a new turn from that point. The original message and all its descendants remain in the tree as a separate branch.

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

The edit creates a new user message as a sibling of the original, then triggers a new turn so the agent responds to the updated message.

## Branch navigation 

When a message has siblings (from edits or regenerations), the view provides methods to navigate between them. This supports a "1 of 3" UI pattern where users browse alternative branches.

<Code>

### Javascript

```
// Check if a message has siblings
const siblings = view.hasSiblings(messageId) // boolean

// Get all sibling message IDs
const siblingIds = view.getSiblings(messageId) // Message[]

// Get the currently selected index
const index = view.getSelectedIndex(messageId) // number

// Switch to a different sibling
view.select(messageId, 2) // select the third sibling
```
</Code>

A typical branch navigation component:

<Code>

### Javascript

```
function BranchNav({ messageId, view }) {
  const siblings = view.getSiblings(messageId)
  const selected = view.getSelectedIndex(messageId)

  if (siblings.length <= 1) return null

  return (
    <div>
      <button onClick={() => view.select(messageId, selected - 1)}
        disabled={selected === 0}>←</button>
      <span>{selected + 1} of {siblings.length}</span>
      <button onClick={() => view.select(messageId, selected + 1)}
        disabled={selected === siblings.length - 1}>→</button>
    </div>
  )
}
```
</Code>

When a user selects a different sibling, the view recalculates the flattened branch. All messages below the selection point update to reflect the chosen branch.

## Split-pane views 

Multiple views can exist over the same conversation tree. Each view has its own branch selection and pagination, so different parts of the UI can show different branches simultaneously.

<Code>

### Javascript

```
const view1 = useCreateView(transport)
const view2 = useCreateView(transport)

// view1 shows branch A, view2 shows branch B
// Both read from the same underlying tree
```
</Code>

This is useful for comparison UIs where a user wants to see two regenerated responses side by side without switching back and forth.

## Server handling 

When the server receives an edit or regenerate request, the request body includes `forkOf` and `parent` fields that describe where the new branch starts. Pass these to `newTurn()`:

<Code>

### Javascript

```
app.post('/chat', async (req, res) => {
  const { messages, turnId, clientId, forkOf, parent } = req.body

  const turn = transport.newTurn({ turnId, clientId, forkOf, parent })
  await turn.start()

  const result = streamText({
    model: anthropic('claude-sonnet-4-20250514'),
    messages,
  })

  const { reason } = await turn.streamResponse(result.toUIMessageStream())
  await turn.end(reason)
})
```
</Code>

The `forkOf` field identifies the message being replaced (the original user message for edit, or the original assistant message for regenerate). The `parent` field identifies where the new branch connects to the existing tree. The server transport uses these to publish messages with the correct tree metadata so all clients maintain a consistent tree structure.

## Related features 

- [Edit and regenerate](https://ably.com/docs/ai-transport/features/edit-and-regenerate.md) - API details for edit and regenerate operations
- [History and replay](https://ably.com/docs/ai-transport/features/history.md) - loading conversation history including all branches
- [Multi-device sessions](https://ably.com/docs/ai-transport/features/multi-device.md) - branch navigation syncs across devices
- [React hooks](https://ably.com/docs/ai-transport/api-reference/react-hooks.md) - reference for `useView`, `useEdit`, `useRegenerate`, and other hooks.
- [Messages and conversation tree](https://ably.com/docs/ai-transport/concepts/messages-and-conversation-tree.md) - how forks create the conversation tree.
- [Get started](https://ably.com/docs/ai-transport/getting-started/vercel-ai-sdk.md) - build your first AI Transport application.

## Related Topics

- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md): Stream AI-generated tokens to clients in realtime using AI Transport, with support for message-per-response and message-per-token patterns.
- [Cancellation](https://ably.com/docs/ai-transport/features/cancellation.md): Cancel AI responses mid-stream with Ably AI Transport. Scoped cancel signals, server-side authorization, and graceful abort handling.
- [Reconnection and recovery](https://ably.com/docs/ai-transport/features/reconnection-and-recovery.md): AI Transport streams survive connection drops automatically. Clients reconnect and resume from where they left off with no lost tokens.
- [Multi-device sessions](https://ably.com/docs/ai-transport/features/multi-device.md): Share AI conversations across tabs, phones, and laptops with Ably AI Transport. All devices see the same session in real time.
- [History and replay](https://ably.com/docs/ai-transport/features/history.md): Load conversation history from Ably channels with AI Transport. Paginated history, gapless continuity, and scroll-back patterns.
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
