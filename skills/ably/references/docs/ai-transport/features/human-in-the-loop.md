# Human-in-the-loop

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

Human-in-the-loop in AI Transport uses the tool calling primitives to create approval gates. The agent requests approval, the turn pauses, and any connected client can approve or reject. Because the session is durable, the approval request reaches the user even after reconnecting or switching devices.

## How it works 

The pattern builds on [tool calling](https://ably.com/docs/ai-transport/features/tool-calling.md). The agent defines a tool that requires human approval. When the LLM invokes that tool, the turn ends with a pending tool call. The client presents the approval request to the user. When the user approves or rejects, the client submits the result via `view.update()`, which triggers a continuation turn.

The flow:

1. The agent streams a response that includes a tool call requiring approval.
2. The turn ends. The pending tool call is published to the channel.
3. Any connected client sees the pending approval and presents it to the user.
4. The user approves or rejects. The client calls `view.update()` with the result.
5. A continuation turn starts. The agent receives the approval result and proceeds.

<Aside data-type='note'>
Because the approval request is an Ably message on the channel, it persists in history. If the user is offline when the agent requests approval, they see the request when they reconnect. If they switch devices, the request appears on the new device. No polling or push infrastructure is needed.
</Aside>

## Define an approval tool 

On the server, define a tool without an `execute` function. The tool's description tells the LLM when to request approval:

<Code>

### Javascript

```
const result = streamText({
  model: anthropic('claude-sonnet-4-20250514'),
  messages: conversationHistory,
  tools: {
    requestApproval: {
      description: 'Request user approval before executing a sensitive action',
      inputSchema: z.object({
        action: z.string().describe('Description of the action to approve'),
        details: z.string().describe('Additional context for the user'),
      }),
      // No execute function - requires client-side approval
    },
    // Other tools that the agent can use after approval
    executeTransfer: {
      description: 'Execute a bank transfer',
      inputSchema: z.object({ amount: z.number(), recipient: z.string() }),
      execute: async ({ amount, recipient }) => {
        return await processTransfer(amount, recipient)
      },
    },
  },
  abortSignal: turn.abortSignal,
})

const { reason } = await turn.streamResponse(result.toUIMessageStream())
await turn.end(reason)
```
</Code>

When the LLM decides an action needs approval, it invokes `requestApproval`. The turn ends with the tool call pending.

## Handle approval on the client 

On the client, detect pending approval requests and present them to the user:

<Code>

### Javascript

```
const { nodes } = useView({ transport })

// Find the node containing a pending approval request
const pendingNode = nodes
  .find(n => n.message.parts?.some(p =>
    p.type === 'dynamic-tool' &&
    p.toolName === 'requestApproval' &&
    p.state === 'input-available'
  ))

const pendingApproval = pendingNode?.message.parts
  ?.find(p => p.type === 'dynamic-tool' && p.state === 'input-available')

if (pendingNode && pendingApproval) {
  const { action, details } = pendingApproval.args

  // Render an approval UI
  // First argument to view.update() is the Ably message ID of the node containing the tool invocation
  return (
    <ApprovalDialog
      action={action}
      details={details}
      onApprove={() =>
        view.update(pendingNode.id, [{
          type: 'tool-output-available',
          toolCallId: pendingApproval.toolCallId,
          output: { approved: true },
        }])
      }
      onReject={() =>
        view.update(pendingNode.id, [{
          type: 'tool-output-available',
          toolCallId: pendingApproval.toolCallId,
          output: { approved: false, reason: 'User declined' },
        }])
      }
    />
  )
}
```
</Code>

When the user approves, `view.update()` submits the result and triggers a continuation turn. The agent receives `{ approved: true }` as the tool result and proceeds with the action. If the user rejects, the agent receives the rejection and can adjust its behavior.

## Multi-device approval 

Because the session is a shared Ably channel, the approval request is visible on every connected device. Any device can submit the approval - the first response wins.

A user might start a conversation on their laptop, step away, and approve the request on their phone. The agent doesn't know or care which device approved it. The continuation turn starts as soon as any client submits the result.

<Code>

### Javascript

```
// Device A (laptop) - sees the approval request
// Device B (phone) - also sees the same approval request
// Either device can call view.update() to approve or reject
```
</Code>

This is particularly useful for asynchronous workflows where the agent works on a task, hits a point requiring human judgment, and the user responds whenever they're available - from whichever device is convenient.

## Durable approval requests 

Approval requests survive disconnections. If the user is offline when the agent requests approval, the pending tool call persists in the channel history. When the user reconnects, the view loads the conversation including the pending request, and the approval UI appears.

The agent's turn has already ended, so there's no connection or timeout to worry about. The continuation turn starts only when the user submits their response - minutes, hours, or days later.

## Related features 

- [Tool calling](https://ably.com/docs/ai-transport/features/tool-calling.md) - the underlying mechanism for human-in-the-loop
- [Multi-device sessions](https://ably.com/docs/ai-transport/features/multi-device.md) - approval from any connected device
- [Reconnection and recovery](https://ably.com/docs/ai-transport/features/reconnection-and-recovery.md) - approval requests survive disconnections
- [History and replay](https://ably.com/docs/ai-transport/features/history.md) - pending approvals persist in history
- [Client transport API](https://ably.com/docs/ai-transport/api-reference/client-transport.md) - reference for `view.update` and other client methods.
- [Turns](https://ably.com/docs/ai-transport/concepts/turns.md) - how approval pauses and resumes turns.
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
