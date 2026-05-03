# Turns

A turn is a logical unit of agent work, initiated in response to user intent. It encompasses everything that happens in service of that intent: the user's input, the agent's response, any tool calls the agent makes, any intermediate messages required to resolve those tool calls (approvals, tool outputs), the agent's continued work after resolution, and the final completion. A turn may involve multiple participants and multiple exchanges before it finishes.

## Understand turn lifecycle 

A turn has a unique identifier and is bracketed by lifecycle events on the channel. The client initiates a turn and passes the prompt for that turn to the server to query the AI model. The user's input messages are part of the turn, and the turn is visible on the [session](https://ably.com/docs/ai-transport/concepts/sessions.md) from the moment the user expresses intent, not from the moment the agent begins processing. The agent publishes turn-end when the task completes, is cancelled, or fails. The turn ID correlates all activity that belongs to the same task.

A turn progresses through a defined set of states:

- Pending. The turn has been opened but no agent has begun working. The user's input is on the session; the agent has not yet started.
- Active. The agent is working.
- Suspended. The most recent execution has intentionally paused. The agent is waiting for external input (human-in-the-loop approval, tool output) or a durable step handoff. The turn is still open.
- Completed. The task finished successfully.
- Cancelled. The user (or another participant) stopped the turn. This can happen from any state: a pending turn can be cancelled before any agent picks it up, an active turn can be cancelled mid-stream, and a suspended turn can be cancelled while awaiting input.
- Failed. The task could not be completed after exhausting recovery options.

Multiple turns can be active simultaneously on the same session. See [concurrent turns](https://ably.com/docs/ai-transport/features/concurrent-turns.md) for details.

## Cancel a turn 

The turn is the unit of cancellation. When a user hits stop, they are cancelling the turn: all work associated with the current task, across all execution attempts. There is no user-facing cancel operation below the turn.

Internal execution failures (a stream dying, a model call erroring, a serverless timeout) fail the execution attempt, not the turn. The turn remains active and can be retried. See [cancellation](https://ably.com/docs/ai-transport/features/cancellation.md) for details on cancel filters and authorization.

## Trigger a turn 

When the client sends a message, the client transport sends an HTTP POST to your server endpoint. This request carries the user's messages, the conversation history, the turn ID, the channel name, and branching context (parent and fork-of pointers). The server uses this to create a turn, publish the user's messages to the channel, invoke the AI model, and stream the response back through the channel.

The HTTP response returns immediately. The response stream is decoupled from the HTTP request: tokens flow through the Ably channel, not through the HTTP response. This is what allows the stream to survive independently of the client's connection.

Because the server receives the turn ID and channel name from the client, any server process that can reach the channel can handle the request. The agent does not need to maintain state between turns. It creates a server transport, processes the turn, and tears down.

## Read next 

- [Sessions](https://ably.com/docs/ai-transport/concepts/sessions.md): understand the persistent, shared conversation state that turns operate within.
- [Transport](https://ably.com/docs/ai-transport/concepts/transport.md): understand how clients and agents connect to sessions and publish turns.
- [Cancellation](https://ably.com/docs/ai-transport/features/cancellation.md): control who can cancel turns and how cancel signals are routed.
- [Concurrent turns](https://ably.com/docs/ai-transport/features/concurrent-turns.md): handle multiple active turns on the same session.
- [Human-in-the-loop](https://ably.com/docs/ai-transport/features/human-in-the-loop.md): use approval gates that suspend and resume turns.

## Related Topics

- [Sessions](https://ably.com/docs/ai-transport/concepts/sessions.md): Understand sessions in AI Transport: persistent, shared conversation state that exists independently of any participant's connection.
- [Messages and conversation tree](https://ably.com/docs/ai-transport/concepts/messages-and-conversation-tree.md): Understand how AI Transport organises messages into a branching conversation tree, and how views provide each participant with their own linear perspective.
- [Transport](https://ably.com/docs/ai-transport/concepts/transport.md): Understand the transport layer in AI Transport: client transport, agent transport, and the codec that bridges your AI framework to Ably.
- [Authentication](https://ably.com/docs/ai-transport/concepts/authentication.md): Understand how authentication works in Ably AI Transport: Ably token auth for channel access, HTTP headers for server endpoints, and cancel authorization.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
