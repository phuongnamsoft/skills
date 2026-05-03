# Codec API

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

The codec is the bridge between your AI framework and Ably messages. It defines how domain events (such as LLM tokens) are encoded into Ably publish operations and decoded back into events on the client. Implement the `Codec` interface to integrate any AI framework with AI Transport.

The SDK ships `UIMessageCodec` for the Vercel AI SDK. For other frameworks, implement a custom codec as described below.

## Codec interface 

<Code>

### Javascript

```
interface Codec<TEvent, TMessage> {
  createEncoder(channel: ChannelWriter, options?: EncoderOptions): StreamEncoder<TEvent, TMessage>
  createDecoder(): StreamDecoder<TEvent, TMessage>
  createAccumulator(): MessageAccumulator<TEvent, TMessage>
  isTerminal(event: TEvent): boolean
}
```
</Code>

| Method | Description |
| --- | --- |
| createEncoder | Create an encoder that converts events into Ably publish operations. |
| createDecoder | Create a decoder that converts Ably messages back into events. |
| createAccumulator | Create an accumulator that builds complete messages from events. |
| isTerminal | Return `true` if the event ends a stream (finish, error, abort). |

The two type parameters are:

- `TEvent`: the event type your AI framework produces (for example, a token chunk or tool call delta).
- `TMessage`: the complete message type your UI consumes (for example, a full chat message).

## StreamEncoder 

The `StreamEncoder` converts a stream of events into Ably publish operations. It is created by the server transport for each turn.

<Code>

### Javascript

```
interface StreamEncoder<TEvent, TMessage> {
  appendEvent(event: TEvent, options?: WriteOptions): Promise<void>
  writeMessages(messages: TMessage[], options?: WriteOptions): Promise<void>
  writeEvent(event: TEvent, options?: WriteOptions): Promise<void>
  abort(reason?: string): Promise<void>
  close(): Promise<void>
}
```
</Code>

| Method | Description |
| --- | --- |
| appendEvent | Encode and publish a single event as an append to the current message on the channel. |
| writeMessages | Encode and publish one or more complete messages. Used for user messages and other discrete messages. |
| writeEvent | Encode and publish a single event as a standalone message. |
| abort | Signal that the stream was aborted. Publishes an abort marker. Accepts an optional reason string. |
| close | Signal that the stream is complete. Publishes a close marker and releases resources. |

## DiscreteEncoder 

A simplified encoder for publishing complete messages without streaming. Used internally for `addMessages` and `addEvents`.

<Code>

### Javascript

```
interface DiscreteEncoder<TEvent, TMessage> {
  writeMessages(messages: TMessage[], options?: WriteOptions): Promise<Ably.PublishResult>
  writeEvent(event: TEvent, options?: WriteOptions): Promise<Ably.PublishResult>
}
```
</Code>

## StreamDecoder 

The `StreamDecoder` converts inbound Ably messages back into domain events. It is created by the client transport when subscribing to a channel.

<Code>

### Javascript

```
interface StreamDecoder<TEvent, TMessage> {
  decode(message: Ably.InboundMessage): DecoderOutput<TEvent, TMessage>[]
}
```
</Code>

| Method | Description |
| --- | --- |
| decode | Decode an Ably message into zero or more domain outputs. Returns an empty array if the message is not relevant (for example, a control message handled by the transport). |

## MessageAccumulator 

The `MessageAccumulator` builds complete messages from a stream of events. The client transport uses it to reconstruct messages from history and to maintain the current message state during streaming.

<Code>

### Javascript

```
interface MessageAccumulator<TEvent, TMessage> {
  processOutputs(outputs: DecoderOutput<TEvent, TMessage>[]): void
  updateMessage(message: TMessage): void
  seedMessages(messages: { messageId: string; message: TMessage }[]): void
  completeSeeded(messageId: string): void
  messages: TMessage[]
  completedMessages: TMessage[]
  hasActiveStream: boolean
}
```
</Code>

| Property / Method | Type | Description |
| --- | --- | --- |
| processOutputs | `(outputs: DecoderOutput<TEvent, TMessage>[]) => void` | Process a batch of decoder outputs and update the internal state. |
| messages | `TMessage[]` | All messages including the in-progress message being streamed. |
| completedMessages | `TMessage[]` | Only messages that are fully complete (stream has ended). |
| hasActiveStream | `boolean` | Whether the accumulator has an in-progress stream. |

## ChannelWriter 

The `ChannelWriter` interface is passed to the encoder by the transport. It provides methods for publishing to the Ably channel.

<Code>

### Javascript

```
interface ChannelWriter {
  publish(message: Ably.Message | Ably.Message[], options?: Ably.PublishOptions): Promise<Ably.PublishResult>
  appendMessage(message: Ably.Message, operation?: Ably.MessageOperation, options?: Ably.PublishOptions): Promise<Ably.UpdateDeleteResult>
  updateMessage(message: Ably.Message, operation?: Ably.MessageOperation, options?: Ably.PublishOptions): Promise<Ably.UpdateDeleteResult>
}
```
</Code>

| Method | Description |
| --- | --- |
| publish | Publish one or more discrete messages to the channel. |
| appendMessage | Append data to an existing message identified by its serial (used for token-by-token streaming). |
| updateMessage | Replace the data of an existing message identified by its serial. |

## Factory helpers 

The SDK provides factory helpers to simplify building encoder and decoder implementations.

### createEncoderCore 

Create a base encoder with common publish logic already implemented. Extend it with your framework-specific encoding.

<Code>

#### Javascript

```
import { createEncoderCore } from '@ably/ai-transport'

function createEncoderCore(writer: ChannelWriter, options?: EncoderCoreOptions): EncoderCore
```
</Code>

### createDecoderCore 

Create a base decoder with common message parsing already implemented. Extend it with your framework-specific decoding.

<Code>

#### Javascript

```
import { createDecoderCore } from '@ably/ai-transport'

function createDecoderCore<TEvent, TMessage>(hooks: DecoderCoreHooks<TEvent, TMessage>, options?: DecoderCoreOptions): DecoderCore<TEvent, TMessage>
```
</Code>

## Write a custom codec 

To integrate a framework that is not Vercel AI SDK, implement the four parts of the `Codec` interface:

1. **Encoder.** Map your framework's stream events to Ably publish operations. Use `appendMessage` for token-by-token streaming, `publish` for discrete events, and `updateMessage` for in-place updates.

2. **Decoder.** Parse inbound Ably messages back into your event type. Handle the message name conventions used by your encoder.

3. **Accumulator.** Maintain a list of messages, appending tokens to the current message as events arrive and finalizing when a terminal event is processed.

4. **Terminal detection.** Return `true` from `isTerminal` for events that signal the end of a stream, such as a finish reason, an error, or an abort.

<Code>

### Javascript

```
const myCodec: Codec<MyEvent, MyMessage> = {
  createEncoder(channel) {
    return {
      async appendEvent(event) {
        await channel.appendMessage({ name: event.messageId, data: event.token })
      },
      async writeMessages(messages) {
        for (const msg of messages) {
          await channel.publish({ name: 'message', data: msg })
        }
      },
      async writeEvent(event) {
        await channel.publish({ name: 'event', data: event })
      },
      async abort() {
        await channel.publish({ name: 'abort', data: {} })
      },
      async close() {
        await channel.publish({ name: 'close', data: {} })
      },
    }
  },
  createDecoder() {
    return {
      decode(message) {
        // Parse Ably message into your event type
        return message.data as MyEvent
      },
    }
  },
  createAccumulator() {
    // Return an accumulator that builds messages from events
  },
  isTerminal(event) {
    return event.type === 'finish' || event.type === 'error'
  },
}
```
</Code>

See the [codec architecture internals](https://ably.com/docs/ai-transport/internals/codec-architecture.md) for a deeper look at how the transport uses each codec method.

## Related Topics

- [Overview](https://ably.com/docs/ai-transport/api-reference.md): API reference for Ably AI Transport. Client transport, server transport, React hooks, Vercel integration, codec, and error codes.
- [Client transport](https://ably.com/docs/ai-transport/api-reference/client-transport.md): API reference for the AI Transport client transport. Options, methods, events, and the View interface.
- [Server transport](https://ably.com/docs/ai-transport/api-reference/server-transport.md): API reference for the AI Transport server transport. Turn lifecycle, cancel routing, and configuration.
- [React hooks](https://ably.com/docs/ai-transport/api-reference/react-hooks.md): API reference for AI Transport React hooks. Generic hooks and Vercel-specific hooks for building chat UIs.
- [Vercel integration](https://ably.com/docs/ai-transport/api-reference/vercel.md): API reference for the AI Transport Vercel AI SDK integration. UIMessageCodec, ChatTransport, and pre-bound factories.
- [Error codes](https://ably.com/docs/ai-transport/api-reference/error-codes.md): Error codes in Ably AI Transport. Codes, descriptions, HTTP status, and recovery guidance.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
