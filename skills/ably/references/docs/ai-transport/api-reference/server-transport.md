# Server transport API

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

The server transport publishes to an Ably channel, manages the turn lifecycle, and routes cancel signals from clients to active turns. It is the server-side counterpart to the [client transport](https://ably.com/docs/ai-transport/api-reference/client-transport.md).

Import from the core entry point:

<Code>

#### Javascript

```
import { createServerTransport } from '@ably/ai-transport'
```
</Code>

Or use the [Vercel entry point](https://ably.com/docs/ai-transport/api-reference/vercel.md) which pre-binds the codec.

## createServerTransport 

Factory function that creates a `ServerTransport` instance.

<Code>

### Javascript

```
function createServerTransport(options: ServerTransportOptions): ServerTransport
```
</Code>

### ServerTransportOptions 

| Property | Required | Type | Description |
| --- | --- | --- | --- |
| channel | required | `Ably.RealtimeChannel` | The Ably channel for the session. |
| codec | required | `Codec<TEvent, TMessage>` | Codec for encoding and decoding messages. See [Codec API](https://ably.com/docs/ai-transport/api-reference/codec.md). |
| logger | optional | `Logger` | Logger instance for debug output. |
| onError | optional | `(error: ErrorInfo) => void` | Callback for transport-level errors. |

## ServerTransport 

The `ServerTransport` object returned by the factory.

### newTurn 

Create a new turn. Returns a `Turn` object for managing the turn lifecycle.

<Code>

#### Javascript

```
function newTurn(options: NewTurnOptions): Turn
```
</Code>

### close 

Close the transport and release resources.

<Code>

#### Javascript

```
function close(): void
```
</Code>

## NewTurnOptions 

| Property | Required | Type | Description |
| --- | --- | --- | --- |
| turnId | required | `string` | Unique identifier for this turn. |
| clientId | optional | `string` | The client that initiated this turn. Used for scoping cancel signals. |
| parent | optional | `string \| null` | The ID of the parent node in the conversation tree. Used for branching. |
| forkOf | optional | `string` | The ID of the node this turn forks from, for edit and regenerate operations. |
| onCancel | optional | `(request: CancelRequest) => Promise<boolean>` | Callback fired when a cancel signal matches this turn. Return `true` to allow cancellation, `false` to reject it. If not provided, all cancels are accepted. |
| onAbort | optional | `(write: (event: TEvent) => Promise<void>) => void \| Promise<void>` | Callback fired when the turn is aborted. Receives a `write` function to publish final events before the abort finalizes. |
| onMessage | optional | `(message: Ably.Message) => void` | Hook called before each Ably message is published in this turn. Mutate the message in place to add custom headers. |
| onError | optional | `(error: ErrorInfo) => void` | Callback for errors during this turn. |
| signal | optional | `AbortSignal` | An external abort signal (typically the HTTP request's `req.signal`) that aborts this turn when fired. This allows platform-level cancellation (request cancellation, serverless function timeout) to stop LLM generation gracefully. |

## Turn 

A `Turn` object manages the lifecycle of a single turn on the server.

### start 

Announce the start of the turn on the channel. Call this before publishing any messages.

<Code>

#### Javascript

```
function start(): Promise<void>
```
</Code>

### addMessages 

Publish messages to the channel. Use this to publish user messages or any discrete messages that are not part of a stream.

<Code>

#### Javascript

```
function addMessages(messages: MessageNode<TMessage>[], options?: { clientId?: string }): Promise<AddMessagesResult>
```
</Code>

### streamResponse 

Pipe a `ReadableStream` of events through the codec and publish them to the channel. Returns when the stream completes, with a reason indicating how it ended.

<Code>

#### Javascript

```
function streamResponse(stream: ReadableStream<TEvent>, options?: StreamResponseOptions): Promise<{ reason: TurnEndReason }>
```
</Code>

The stream is piped through the codec's encoder, which converts events into Ably publish operations. If the turn is cancelled while streaming, the stream is aborted and the returned reason is `'cancelled'`.

### addEvents 

Publish a batch of events to the channel without streaming. Useful for publishing pre-computed events or events from a non-streaming source.

<Code>

#### Javascript

```
function addEvents(nodes: EventsNode<TEvent>[]): Promise<void>
```
</Code>

### end 

End the turn with the given reason. Publishes a turn-end marker to the channel.

<Code>

#### Javascript

```
function end(reason: TurnEndReason): Promise<void>
```
</Code>

### abortSignal 

An `AbortSignal` that fires when the turn is cancelled. Pass this to your LLM call to stop generation when a cancel signal is received.

<Code>

#### Javascript

```
const result = await streamText({
  model: openai('gpt-4o'),
  messages,
  abortSignal: turn.abortSignal,
})
```
</Code>

## CancelRequest 

The object passed to the `onCancel` callback when a cancel signal matches a turn.

| Property | Type | Description |
| --- | --- | --- |
| message | `Ably.InboundMessage` | The raw Ably message that carried the cancel signal. |
| filter | `CancelFilter` | The parsed cancel scope from the message headers. |
| matchedTurnIds | `string[]` | The active turn IDs that would be cancelled if allowed. |
| turnOwners | `Map<string, string>` | Map of turn ID to the owner's client ID for the matched turns. |

## CancelFilter 

| Property | Type | Description |
| --- | --- | --- |
| own | `true` | Cancel all turns started by the requesting client. |
| turnId | `string` | Cancel a specific turn by ID. |
| clientId | `string` | Cancel all turns by a specific client. |
| all | `true` | Cancel all active turns on the channel. |

Only one property should be set per filter. If no filter is provided, the default is `{ own: true }`.

## TurnEndReason 

<Code>

### Javascript

```
type TurnEndReason = 'complete' | 'cancelled' | 'error'
```
</Code>

| Value | Description |
| --- | --- |
| `'complete'` | The turn finished normally. |
| `'cancelled'` | The turn was cancelled by a client signal. |
| `'error'` | The turn ended due to an error. |

## Related Topics

- [Overview](https://ably.com/docs/ai-transport/api-reference.md): API reference for Ably AI Transport. Client transport, server transport, React hooks, Vercel integration, codec, and error codes.
- [Client transport](https://ably.com/docs/ai-transport/api-reference/client-transport.md): API reference for the AI Transport client transport. Options, methods, events, and the View interface.
- [React hooks](https://ably.com/docs/ai-transport/api-reference/react-hooks.md): API reference for AI Transport React hooks. Generic hooks and Vercel-specific hooks for building chat UIs.
- [Vercel integration](https://ably.com/docs/ai-transport/api-reference/vercel.md): API reference for the AI Transport Vercel AI SDK integration. UIMessageCodec, ChatTransport, and pre-bound factories.
- [Codec](https://ably.com/docs/ai-transport/api-reference/codec.md): API reference for the AI Transport codec interface. Build custom codecs to integrate any AI framework.
- [Error codes](https://ably.com/docs/ai-transport/api-reference/error-codes.md): Error codes in Ably AI Transport. Codes, descriptions, HTTP status, and recovery guidance.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
