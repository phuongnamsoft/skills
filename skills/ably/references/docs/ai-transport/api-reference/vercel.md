# Vercel integration API

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

The Vercel integration provides a pre-built codec and transport factories for the Vercel AI SDK. It maps Vercel's `UIMessageChunk` events to `UIMessage` objects, so you can use AI Transport with `useChat` without writing a custom codec.

## Entry points 

| Entry point | Import path | Contents |
| --- | --- | --- |
| Vercel | `@ably/ai-transport/vercel` | `UIMessageCodec`, `createClientTransport`, `createServerTransport` |
| Vercel React | `@ably/ai-transport/vercel/react` | `useChatTransport`, `useMessageSync` |

## UIMessageCodec 

A pre-built `Codec<UIMessageChunk, UIMessage>` for the Vercel AI SDK. It handles encoding and decoding of Vercel's message types through Ably channels.

<Code>

### Javascript

```
import { UIMessageCodec } from '@ably/ai-transport/vercel'
```
</Code>

You do not need to use `UIMessageCodec` directly if you use the Vercel-specific transport factories or React hooks, as they bind the codec automatically.

## createClientTransport 

A pre-bound version of the core `createClientTransport` that omits the `codec` option. The codec is set to `UIMessageCodec`.

<Code>

### Javascript

```
import { createClientTransport } from '@ably/ai-transport/vercel'

function createClientTransport(options: VercelClientTransportOptions): ClientTransport
```
</Code>

### VercelClientTransportOptions 

Identical to [ClientTransportOptions](https://ably.com/docs/ai-transport/api-reference/client-transport.md#client-transport-options) but without the `codec` property.

| Property | Required | Type | Description |
| --- | --- | --- | --- |
| channel | required | `Ably.RealtimeChannel` | The Ably channel for the session. |
| clientId | optional | `string` | The client ID for this transport instance. |
| api | optional | `string` | URL of the API endpoint. |
| headers | optional | `Record<string, string>` | Additional HTTP headers. |
| body | optional | `Record<string, unknown>` | Additional request body fields. |
| credentials | optional | `RequestCredentials` | Credentials mode for fetch. |
| fetch | optional | `typeof fetch` | Custom fetch implementation. |
| messages | optional | `UIMessage[]` | Pre-loaded messages for history. |
| logger | optional | `Logger` | Logger instance. |

## createServerTransport 

A pre-bound version of the core `createServerTransport` that omits the `codec` option.

<Code>

### Javascript

```
import { createServerTransport } from '@ably/ai-transport/vercel'

function createServerTransport(options: VercelServerTransportOptions): ServerTransport
```
</Code>

### VercelServerTransportOptions 

Identical to [ServerTransportOptions](https://ably.com/docs/ai-transport/api-reference/server-transport.md#server-transport-options) but without the `codec` property.

| Property | Required | Type | Description |
| --- | --- | --- | --- |
| channel | required | `Ably.RealtimeChannel` | The Ably channel for the session. |
| logger | optional | `Logger` | Logger instance. |
| onError | optional | `(error: ErrorInfo) => void` | Callback for transport-level errors. |

## createChatTransport 

Create a `ChatTransport` from a `ClientTransport`. The `ChatTransport` is the adapter that plugs into Vercel's `useChat` hook.

<Code>

### Javascript

```
import { createChatTransport } from '@ably/ai-transport/vercel'

function createChatTransport(transport: ClientTransport, options?: ChatTransportOptions): ChatTransport
```
</Code>

In most cases you will use the `useChatTransport` hook instead of calling this factory directly.

## useChatTransport 

React hook that creates a `ChatTransport` for use with Vercel's `useChat`. Accepts either a `VercelClientTransportOptions` object (creates a transport internally) or an existing `ClientTransport` instance. Both forms accept an optional second argument for `ChatTransportOptions`.

<Code>

### Javascript

```
import { useChatTransport } from '@ably/ai-transport/vercel/react'

function useChatTransport(options: VercelClientTransportOptions, chatOptions?: ChatTransportOptions): ChatTransport
function useChatTransport(transport: ClientTransport, chatOptions?: ChatTransportOptions): ChatTransport
```
</Code>

When you pass `VercelClientTransportOptions`, the hook creates a `ClientTransport` internally with the codec pre-bound to `UIMessageCodec`. When you pass an existing `ClientTransport`, it wraps that instance as a `ChatTransport` without creating a new transport. Use the second form when you need direct access to the `ClientTransport` for features like active turn tracking, `useMessageSync`, or cancellation.

See the [React hooks reference](https://ably.com/docs/ai-transport/api-reference/react-hooks.md#use-chat-transport) for full usage examples.

## ChatTransportOptions 

Optional second argument to `useChatTransport` and `createChatTransport` for customizing request behavior.

| Property | Required | Type | Description |
| --- | --- | --- | --- |
| prepareSendMessagesRequest | optional | `(context: SendMessagesRequestContext) => { body?: Record<string, unknown>; headers?: Record<string, string> }` | Hook to customize the HTTP POST body and headers before sending to the API. Receives conversation context including history, new messages, and trigger type. |

## Related Topics

- [Overview](https://ably.com/docs/ai-transport/api-reference.md): API reference for Ably AI Transport. Client transport, server transport, React hooks, Vercel integration, codec, and error codes.
- [Client transport](https://ably.com/docs/ai-transport/api-reference/client-transport.md): API reference for the AI Transport client transport. Options, methods, events, and the View interface.
- [Server transport](https://ably.com/docs/ai-transport/api-reference/server-transport.md): API reference for the AI Transport server transport. Turn lifecycle, cancel routing, and configuration.
- [React hooks](https://ably.com/docs/ai-transport/api-reference/react-hooks.md): API reference for AI Transport React hooks. Generic hooks and Vercel-specific hooks for building chat UIs.
- [Codec](https://ably.com/docs/ai-transport/api-reference/codec.md): API reference for the AI Transport codec interface. Build custom codecs to integrate any AI framework.
- [Error codes](https://ably.com/docs/ai-transport/api-reference/error-codes.md): Error codes in Ably AI Transport. Codes, descriptions, HTTP status, and recovery guidance.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
