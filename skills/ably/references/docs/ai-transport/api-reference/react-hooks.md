# React hooks

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

AI Transport provides React hooks for building chat UIs. Generic hooks are available from `@ably/ai-transport/react` and work with any codec. Vercel-specific hooks are available from `@ably/ai-transport/vercel/react`.

## Generic hooks 

Import from the React entry point:

<Code>

### Javascript

```
import {
  useClientTransport,
  useView,
  useCreateView,
  useSend,
  useEdit,
  useRegenerate,
  useTree,
  useActiveTurns,
  useAblyMessages,
} from '@ably/ai-transport/react'
```
</Code>

### useClientTransport 

Access a `ClientTransport` from the nearest `TransportProvider`. The transport is created by the provider, not by this hook. When `channelName` is omitted, the innermost `TransportProvider` in the tree is used.

<Code>

#### Javascript

```
function useClientTransport(options?: {
  channelName?: string,
  skip?: boolean
}): ClientTransport
```
</Code>

| Property | Type | Description |
| --- | --- | --- |
| channelName | `string` | The channel name passed to the enclosing `TransportProvider`. Omit to use the nearest provider. |
| skip | `boolean` | When `true`, return a stub transport that throws on any access. Useful when auth is not yet resolved. |

See [TransportProvider](https://ably.com/docs/ai-transport/api-reference/react-hooks.md#transport-provider) for setting up the provider.

### useView 

Subscribe to a view and return the visible node list with pagination, navigation, and write operations. Pass `transport` to use a transport's default view, or `view` to subscribe to a specific view directly. When both are omitted, defaults to the nearest `TransportProvider`'s transport. Returns a `ViewHandle` that re-renders the component when the view updates.

<Code>

#### Javascript

```
function useView(options?: {
  transport?: ClientTransport | null,
  view?: View | null,
  limit?: number,
  skip?: boolean
}): ViewHandle
```
</Code>

| Property | Type | Description |
| --- | --- | --- |
| transport | `ClientTransport \| null` | Client transport whose default view to subscribe to. Defaults to the nearest provider when omitted. |
| view | `View \| null` | A specific view to subscribe to directly. Takes priority over `transport`. |
| limit | `number` | Maximum number of older messages to load per page. When provided, auto-loads the first page on mount. |
| skip | `boolean` | When `true`, skip all subscriptions and return an empty handle. |

#### ViewHandle 

| Property | Type | Description |
| --- | --- | --- |
| messages | `TMessage[]` | The visible domain messages along the selected branch. |
| nodes | `MessageNode<TMessage>[]` | Visible conversation nodes along the selected branch. |
| send | `(messages: TMessage \| TMessage[], options?: SendOptions) => Promise<ActiveTurn<TEvent>>` | Send a user message or array of messages. |
| regenerate | `(messageId: string, options?: SendOptions) => Promise<ActiveTurn<TEvent>>` | Regenerate an assistant message, using this view's branch for history. |
| edit | `(messageId: string, newMessages: TMessage \| TMessage[], options?: SendOptions) => Promise<ActiveTurn<TEvent>>` | Edit a user message, forking from this view's branch. |
| update | `(msgId: string, events: TEvent[], options?: SendOptions) => Promise<ActiveTurn<TEvent>>` | Amend an existing message and start a continuation turn. |
| hasOlder | `boolean` | Whether older messages are available. |
| loadOlder | `() => Promise<void>` | Load older messages from history. |
| loading | `boolean` | Whether a page load is currently in progress. |
| getSiblings | `(msgId: string) => TMessage[]` | Get all sibling messages at a fork point. |
| hasSiblings | `(msgId: string) => boolean` | Whether a message has sibling alternatives. |
| getSelectedIndex | `(msgId: string) => number` | Index of the currently selected sibling at a fork point. |
| select | `(msgId: string, index: number) => void` | Select a sibling at a fork point by index. Triggers a view update with the new branch. |
| getNode | `(msgId: string) => MessageNode<TMessage> \| undefined` | Get a node by message ID, or undefined if not found. |

### useCreateView 

Create an additional view of the conversation tree. Returns a `ViewHandle` with the same interface as `useView`.

<Code>

#### Javascript

```
function useCreateView(options?: {
  transport?: ClientTransport | null,
  limit?: number,
  skip?: boolean
}): ViewHandle
```
</Code>

### useSend 

Return a stable `send` callback bound to the given view. Useful when you only need to send messages without subscribing to the full view.

<Code>

#### Javascript

```
function useSend(view: View): (messages: TMessage[], options?: SendOptions) => Promise<ActiveTurn<TEvent>>
```
</Code>

### useEdit 

Return a stable `edit` callback bound to the given view.

<Code>

#### Javascript

```
function useEdit(view: View): (messageId: string, newMessages: TMessage | TMessage[], options?: SendOptions) => Promise<ActiveTurn<TEvent>>
```
</Code>

### useRegenerate 

Return a stable `regenerate` callback bound to the given view.

<Code>

#### Javascript

```
function useRegenerate(view: View): (messageId: string, options?: SendOptions) => Promise<ActiveTurn<TEvent>>
```
</Code>

### useTree 

Provide stable structural query callbacks backed by the transport's conversation tree. These are thin `useCallback` wrappers around the tree. The hook does not re-render on tree changes; use `useView` for reactive updates.

<Code>

#### Javascript

```
function useTree(options?: {
  transport?: ClientTransport
}): TreeHandle
```
</Code>

#### TreeHandle 

| Property | Type | Description |
| --- | --- | --- |
| getSiblings | `(msgId: string) => TMessage[]` | Get all sibling messages at a fork point. |
| hasSiblings | `(msgId: string) => boolean` | Whether a message has sibling alternatives. |
| getNode | `(msgId: string) => MessageNode<TMessage> \| undefined` | Get a node by message ID, or undefined if not found. |

### useActiveTurns 

Subscribe to active turns on the channel. Returns a reactive `Map` keyed by client ID, where each value is a `Set` of turn IDs for that client. Re-renders when turns start or end.

<Code>

#### Javascript

```
function useActiveTurns(options?: {
  transport?: ClientTransport | null
}): Map<string, Set<string>>
```
</Code>

Use `.size` to check if any turns are active, `.has(clientId)` to check a specific client, and `.get(clientId)` to retrieve the set of turn IDs for a client. See [concurrent turns](https://ably.com/docs/ai-transport/features/concurrent-turns.md) for usage examples.

### useAblyMessages 

Subscribe to raw Ably messages on the transport's channel. Useful for building custom message handling outside the view abstraction.

<Code>

#### Javascript

```
function useAblyMessages(options?: {
  transport?: ClientTransport,
  skip?: boolean
}): Ably.InboundMessage[]
```
</Code>

## Vercel hooks 

Import from the Vercel React entry point:

<Code>

### Javascript

```
import { useChatTransport, useMessageSync } from '@ably/ai-transport/vercel/react'
```
</Code>

### useChatTransport 

Create a `ChatTransport` for use with Vercel's `useChat` hook. Accepts either a `VercelClientTransportOptions` object or an existing `ClientTransport` instance. Both forms accept an optional second argument for `ChatTransportOptions`.

<Code>

#### Javascript

```
function useChatTransport(options: VercelClientTransportOptions, chatOptions?: ChatTransportOptions): ChatTransport
function useChatTransport(transport: ClientTransport, chatOptions?: ChatTransportOptions): ChatTransport
```
</Code>

When you pass `VercelClientTransportOptions`, the hook creates a new `ClientTransport` internally with the codec pre-bound to `UIMessageCodec`. When you pass an existing `ClientTransport`, it wraps that instance as a `ChatTransport` without creating a new transport.

**Using an existing ClientTransport (recommended when you also need `useView`, `useActiveTurns`, or `useMessageSync`):**

<Code>

#### Javascript

```
const transport = useClientTransport({ channelName: chatId })
const chatTransport = useChatTransport(transport)
const { messages } = useChat({ transport: chatTransport })
```
</Code>

See [ChatTransportOptions](https://ably.com/docs/ai-transport/api-reference/vercel.md#chat-transport-options) for available options.

### useMessageSync 

Wire transport message updates into Vercel's `useChat` message state. Subscribes to the transport view's `update` event and replaces messages with the view's authoritative message list. Use this when you need Vercel's message array to reflect messages from other devices or browser tabs.

<Code>

#### Javascript

```
function useMessageSync(
  transport: ClientTransport | null | undefined,
  setMessages: (updater: (prev: UIMessage[]) => UIMessage[]) => void
): void
```
</Code>

<Code>

#### Javascript

```
const transport = useClientTransport({ channelName: chatId })
const chatTransport = useChatTransport(transport)
const { messages, setMessages } = useChat({ transport: chatTransport })
useMessageSync(transport, setMessages)
// messages now includes messages from all devices
```
</Code>

## Related Topics

- [Overview](https://ably.com/docs/ai-transport/api-reference.md): API reference for Ably AI Transport. Client transport, server transport, React hooks, Vercel integration, codec, and error codes.
- [Client transport](https://ably.com/docs/ai-transport/api-reference/client-transport.md): API reference for the AI Transport client transport. Options, methods, events, and the View interface.
- [Server transport](https://ably.com/docs/ai-transport/api-reference/server-transport.md): API reference for the AI Transport server transport. Turn lifecycle, cancel routing, and configuration.
- [Vercel integration](https://ably.com/docs/ai-transport/api-reference/vercel.md): API reference for the AI Transport Vercel AI SDK integration. UIMessageCodec, ChatTransport, and pre-bound factories.
- [Codec](https://ably.com/docs/ai-transport/api-reference/codec.md): API reference for the AI Transport codec interface. Build custom codecs to integrate any AI framework.
- [Error codes](https://ably.com/docs/ai-transport/api-reference/error-codes.md): Error codes in Ably AI Transport. Codes, descriptions, HTTP status, and recovery guidance.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
