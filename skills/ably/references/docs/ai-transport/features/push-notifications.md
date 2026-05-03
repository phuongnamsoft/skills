# Push notifications

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

Push notifications let you notify users when an agent completes a long-running task, even if the user has closed the app. This uses Ably's native [Push Notifications](https://ably.com/docs/push.md) alongside AI Transport.

<Aside data-type='note'>
Push notifications are not built into the AI Transport SDK. They use the Ably Push API to deliver notifications to devices that are no longer connected to the session channel.
</Aside>

## The pattern 

The flow works as follows:

1. A user sends a message that triggers a long-running agent task (research, code generation, data analysis).
2. The user closes the app or navigates away.
3. The agent completes the task and publishes the result to the session channel.
4. A push rule on the channel triggers a notification to the user's device.
5. The user taps the notification and returns to the completed conversation.

Because AI Transport persists messages on the Ably channel, the full response is available when the user returns. There is no need to store results separately.

## Set up push rules 

Configure a channel rule in the Ably dashboard to trigger push notifications when the agent publishes a completion event:

<Code>

### Javascript

```
// Server: publish a completion event when the agent finishes
app.post('/api/chat', async (req, res) => {
  const { turnId, clientId, userId, sessionId, messages } = req.body
  const turn = transport.newTurn({ turnId, clientId })

  const result = streamText({
    model: openai('gpt-4o'),
    messages,
    abortSignal: turn.abortSignal,
  })

  await turn.streamResponse(result.toUIMessageStream())
  await turn.end('complete')

  // Publish a push-eligible event on a notification channel
  const notificationChannel = ably.channels.get(`notifications:${userId}`)
  await notificationChannel.publish('agent-complete', {
    title: 'Your agent has finished',
    body: 'Tap to view the response',
    sessionId,
  })
  res.json({ ok: true })
})
```
</Code>

On the client, register the device for push notifications and subscribe to the notification channel:

<Code>

### Javascript

```
// Client: subscribe for push notifications
const notificationChannel = ably.channels.get(`notifications:${userId}`)
await notificationChannel.push.subscribeDevice()
```
</Code>

## Combine with AI Transport sessions 

The notification payload can include the session ID, so the client opens directly to the right conversation. When the user taps the notification, load the session and use [history and replay](https://ably.com/docs/ai-transport/features/history.md) to display the full conversation including the completed response.

## Related features 

- [Push Notifications](https://ably.com/docs/push.md) - the Ably Push API used for device notifications
- [History and replay](https://ably.com/docs/ai-transport/features/history.md) - loading completed responses after reconnecting
- [Reconnection and recovery](https://ably.com/docs/ai-transport/features/reconnection-and-recovery.md) - resuming sessions after disconnection
- [Ably Push](https://ably.com/docs/push.md) - full reference for the Push Notifications API.
- [Sessions](https://ably.com/docs/ai-transport/concepts/sessions.md) - how durable sessions persist while users are offline.
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
- [Chain of thought](https://ably.com/docs/ai-transport/features/chain-of-thought.md): Stream reasoning and thinking content alongside responses with Ably AI Transport. Display chain-of-thought in real time.
- [Double texting](https://ably.com/docs/ai-transport/features/double-texting.md): Handle users sending multiple messages while the AI is streaming with Ably AI Transport. Queue or run messages concurrently.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
