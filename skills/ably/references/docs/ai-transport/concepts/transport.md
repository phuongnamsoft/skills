# Transport

The transport layer handles communication between participants and the [session](https://ably.com/docs/ai-transport/concepts/sessions.md). There are two transports: the client transport for client applications, and the agent transport for agent processes. A pluggable codec bridges your AI framework's event types to Ably messages, so the transport works with any framework without modification.

## Understand the client transport 

The client transport is how a client application connects to a session. It is a long-lived object that subscribes to the channel, materialises the session into a [tree](https://ably.com/docs/ai-transport/concepts/messages-and-conversation-tree.md), and provides one or more [views](https://ably.com/docs/ai-transport/concepts/messages-and-conversation-tree.md#views) for the application to work with.

The client transport owns the read path: decoding incoming channel messages, applying them to the tree, and emitting scoped events through views so the application knows when visible state has changed. It also owns the client's side of the write path: when the application sends a message, the transport publishes turn-start and the user's input messages to the channel, then sends a [poke](https://ably.com/docs/ai-transport/concepts/turns.md#poke) to the agent endpoint to trigger an execution. The channel publish and the poke are decoupled: the turn is established on the session before the agent is triggered, and the poke can be deferred or retried independently. Cancellation is a channel publish: the transport sends a cancel signal targeting a turn, and the agent receives it through its own channel subscription.

The client transport is also responsible for connection resilience. It monitors channel continuity, detects if messages were lost during a disconnection, and ensures the session state remains consistent after reconnection.

A client transport is not the session. It is one participant's connection to the session. Multiple clients can be connected to the same session simultaneously, each with their own views and branch selections, all sharing the same underlying conversation state on the channel.

## Understand the agent transport 

The agent transport is how an agent connects to a session for a single execution attempt within a [turn](https://ably.com/docs/ai-transport/concepts/turns.md). It is typically short-lived: created when the agent receives a poke, used for the duration of that execution, then disposed.

The agent transport handles the write path for the agent's contribution: piping model output through the codec encoder to the channel, publishing turn-end when the task completes, and listening for cancel signals that target the active turn. When the agent receives a poke, it uses the transport to hydrate the session from the channel (or from an external store), locate the message the poke references, and begin its work.

Because the agent is stateless between execution attempts, the agent transport does not maintain long-lived subscriptions or accumulated state. Each execution hydrates what it needs, does its work, publishes its output, and tears down. If the turn spans multiple executions (human-in-the-loop, retry after failure), each execution creates its own agent transport against the same session. The session on the channel is what provides continuity, not the transport.

## Understand the codec 

The codec is the translation layer between domain-specific message models and Ably's native message primitives. It defines how events in the application's domain (text deltas, tool calls, finish signals, or whatever the domain model requires) are encoded into Ably messages for transmission over the channel, and how incoming Ably messages are decoded back into domain events and accumulated into domain messages.

The codec is an interface, not an implementation. The generic layer of the SDK knows nothing about what the events or messages look like. It operates entirely through the codec contract. A Vercel AI SDK codec translates `UIMessageChunk` events into Ably messages and assembles them into `UIMessage` objects. A different codec could do the same for a different framework, or for a custom domain model.

The codec has three responsibilities:

- The encoder takes domain events and produces Ably message operations: publishes for discrete messages, append sequences for streamed content.
- The decoder takes incoming Ably messages and produces domain events, handling the reconstruction of streaming state from Ably's message lifecycle (create, append, update).
- The accumulator takes a sequence of decoded events and assembles them into complete domain messages, tracking which messages are still being streamed and which are complete.

The codec also determines what constitutes a terminal event: the event that signals a stream is finished. This is domain-specific knowledge (a `finish` chunk in the Vercel model, for example) that the generic transport layer needs in order to close streams at the right time.

The codec is the boundary between transport concerns and application domain concerns. Everything below the codec (headers, serials, channel operations, tree structure) is generic. Everything above (the shape of events, the structure of messages, what a tool call or text delta means) is domain-specific.

## Choose an entry point 

| Entry point | Import path | Use when |
| --- | --- | --- |
| Core | `@ably/ai-transport` | Building with a custom codec or non-React client |
| React | `@ably/ai-transport/react` | Building a React UI with any codec |
| Vercel | `@ably/ai-transport/vercel` | Server-side Vercel AI SDK integration |
| Vercel React | `@ably/ai-transport/vercel/react` | Client-side Vercel AI SDK with `useChat` |

The Vercel AI SDK has the deepest integration. The `@ably/ai-transport/vercel/react` entry point provides `useChatTransport`, which wraps the core transport for direct use with Vercel's `useChat` hook. Other frameworks use the core entry point with a custom or framework-specific codec.

## Read next 

- [Authentication](https://ably.com/docs/ai-transport/concepts/authentication.md): configure authentication for AI Transport sessions.
- [Sessions](https://ably.com/docs/ai-transport/concepts/sessions.md): understand the persistent conversation state that transports connect to.
- [Getting started with Vercel AI SDK](https://ably.com/docs/ai-transport/getting-started/vercel-ai-sdk.md): build your first AI Transport application.
- [Getting started with the Core SDK](https://ably.com/docs/ai-transport/getting-started/core-sdk.md): build with AI Transport without a framework wrapper.
- [Codec API reference](https://ably.com/docs/ai-transport/api-reference/codec.md): the full codec interface specification.

## Related Topics

- [Sessions](https://ably.com/docs/ai-transport/concepts/sessions.md): Understand sessions in AI Transport: persistent, shared conversation state that exists independently of any participant's connection.
- [Messages and conversation tree](https://ably.com/docs/ai-transport/concepts/messages-and-conversation-tree.md): Understand how AI Transport organises messages into a branching conversation tree, and how views provide each participant with their own linear perspective.
- [Turns](https://ably.com/docs/ai-transport/concepts/turns.md): Understand turns in AI Transport: the logical unit of agent work that structures prompt-response cycles with lifecycle states, cancellation, and execution resilience.
- [Authentication](https://ably.com/docs/ai-transport/concepts/authentication.md): Understand how authentication works in Ably AI Transport: Ably token auth for channel access, HTTP headers for server endpoints, and cancel authorization.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
