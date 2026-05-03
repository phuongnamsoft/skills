# Transport patterns

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

The transport layer contains several internal components that coordinate between the codec, the Ably channel, and your application code. This page describes the key patterns and what each component is responsible for.

## StreamRouter 

The StreamRouter lives on the client side. It routes inbound Ably channel events to the correct stream, turning a flat subscription into per-turn `ReadableStream` instances.

When the client transport subscribes to a channel, all messages arrive through a single callback. The StreamRouter dispatches each message to the appropriate turn based on the `x-ably-turn-id` header:

1. When the client calls `send()` (during `_internalSend`), the router creates a new `ReadableStream` and its controller for that turn.
2. Content messages are enqueued into the matching stream's controller.
3. When a terminal event arrives (`turn-end`, `abort`, or `error`), the router closes the stream's controller.

This gives each turn an independent stream that can be consumed, cancelled, or abandoned without affecting other turns.

## TurnManager 

The TurnManager lives on the server side. It tracks active turns and manages their lifecycle events.

When the server creates a new turn with `transport.newTurn()`, the TurnManager:

1. Registers the turn with its ID, client ID, and optional fork metadata.
2. Publishes a `turn-start` lifecycle event to the channel.
3. Creates an `AbortController` wired to cancel signals for this turn.
4. Returns a turn handle with `streamResponse()`, `addMessages()`, `end()`, and `abortSignal`.

When the turn ends, the TurnManager publishes a `turn-end` event with the appropriate reason and cleans up internal state. If the turn is cancelled, the abort controller fires before cleanup.

## pipeStream 

The `pipeStream` function connects a `ReadableStream` (from the LLM) to the encoder. It reads from the stream and writes each chunk through the encoder's `appendEvent` method.

The key responsibilities are:

- **Reading**: pulls chunks from the `ReadableStream` as they become available.
- **Encoding**: passes each chunk to the encoder, which publishes it to the channel.
- **Abort handling**: if the turn's abort signal fires, `pipeStream` cancels the reader and calls `encoder.abort()`. This stops the LLM stream and publishes an abort marker to the channel.
- **Completion**: when the stream ends naturally, `pipeStream` calls `encoder.close()` to finalize the message.

<Code>

### Javascript

```
// Simplified pipeStream flow
async function pipeStream(stream, encoder, abortSignal) {
  const reader = stream.getReader()

  abortSignal.addEventListener('abort', () => {
    reader.cancel()
  })

  try {
    while (true) {
      const { done, value } = await reader.read()
      if (done) break
      await encoder.appendEvent(value)
    }
    await encoder.close()
    return 'complete'
  } catch (error) {
    if (abortSignal.aborted) {
      await encoder.abort()
      return 'cancelled'
    }
    throw error
  }
}
```
</Code>

The actual implementation includes retry logic for transient errors and coordinates with the encoder's flush-and-recovery mechanism.

## Cancel routing 

Cancel routing connects client cancel signals to the correct server-side turns. The flow is:

1. The client publishes a `cancel` message to the channel with a filter (for example, `{ own: true }` or `{ turnId: 'abc' }`).
2. The server transport receives the cancel message through its channel subscription.
3. The transport evaluates the filter against all registered turns. For `{ own: true }`, it matches turns where the owner client ID matches the cancel message's client ID.
4. Each matched turn's `onCancel` hook is called if one is registered. If the hook returns `false`, that turn is excluded.
5. For authorized turns, the transport fires their `AbortController`, which triggers `pipeStream` to abort.

Handler isolation ensures that a cancel for one turn does not affect other active turns. Each turn has its own `AbortController`, so aborting one turn leaves others running.

## buildTransportHeaders 

The `buildTransportHeaders` function constructs the `x-ably-*` headers for outbound messages. It is called by the encoder before every publish operation.

The function takes the current turn state (turn ID, client ID, role, fork metadata) and produces a headers object. The codec can add domain headers, and the encoder merges them using the priority rules described in [codec architecture](https://ably.com/docs/ai-transport/internals/codec-architecture.md#header-merging).

<Aside data-type='note'>
Stream-related headers (`x-ably-stream`, `x-ably-stream-id`, `x-ably-status`) are set by the codec-layer encoder, not by `buildTransportHeaders`. The transport layer only sets the headers shown below.
</Aside>

<Code>

### Javascript

```
// Simplified buildTransportHeaders
function buildTransportHeaders(turn, messageOptions) {
  return {
    'x-ably-role': messageOptions.role,
    'x-ably-turn-id': turn.turnId,
    'x-ably-msg-id': messageOptions.msgId,
    ...(turn.clientId && { 'x-ably-turn-client-id': turn.clientId }),
    ...(messageOptions.parent && { 'x-ably-parent': messageOptions.parent }),
    ...(messageOptions.forkOf && { 'x-ably-fork-of': messageOptions.forkOf }),
    ...(messageOptions.amend && { 'x-ably-amend': messageOptions.amend }),
  }
}
```
</Code>

## Related pages 

- [Wire protocol](https://ably.com/docs/ai-transport/internals/wire-protocol.md) - the headers and message format these components produce and consume.
- [Codec architecture](https://ably.com/docs/ai-transport/internals/codec-architecture.md) - the encoder and decoder that `pipeStream` and `StreamRouter` drive.
- [Cancellation](https://ably.com/docs/ai-transport/features/cancellation.md) - the user-facing cancel feature.
- [Token streaming](https://ably.com/docs/ai-transport/features/token-streaming.md) - the feature that `pipeStream` enables.

## Related Topics

- [Overview](https://ably.com/docs/ai-transport/internals.md): Under the hood of Ably AI Transport. Wire protocol, codec architecture, conversation tree, and transport patterns.
- [Wire protocol](https://ably.com/docs/ai-transport/internals/wire-protocol.md): The Ably channel wire format used by AI Transport. Headers, lifecycle events, content messages, and message identity.
- [Codec architecture](https://ably.com/docs/ai-transport/internals/codec-architecture.md): How the AI Transport codec bridges domain events to Ably messages. Encoder, decoder, accumulator, and lifecycle tracker internals.
- [Conversation tree](https://ably.com/docs/ai-transport/internals/conversation-tree.md): How AI Transport maintains a branching conversation structure. Serial ordering, sibling groups, fork chains, and flatten algorithm.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
