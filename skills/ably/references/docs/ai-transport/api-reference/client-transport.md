# Client transport API

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

The client transport subscribes to an Ably channel, decodes incoming messages through a codec, and builds a conversation tree. It provides views for paginated, branch-aware access to the conversation, and methods for cancellation and turn tracking.

Import from the core entry point:

<Code>

#### Javascript

```
import { createClientTransport } from '@ably/ai-transport'
```
</Code>

Or use the [Vercel entry point](https://ably.com/docs/ai-transport/api-reference/vercel.md) which pre-binds the codec.

## createClientTransport 

Factory function that creates a `ClientTransport` instance.

<Code>

### Javascript

```
function createClientTransport(options: ClientTransportOptions): ClientTransport
```
</Code>

### ClientTransportOptions 

| Property | Required | Type | Description |
| --- | --- | --- | --- |
| channel | required | `Ably.RealtimeChannel` | The Ably channel for the session. |
| codec | required | `Codec<TEvent, TMessage>` | Codec for encoding and decoding messages. See [Codec API](https://ably.com/docs/ai-transport/api-reference/codec.md). |
| clientId | optional | `string` | The client ID for this transport instance. Used for scoping cancel signals and identifying user messages. |
| api | optional | `string` | URL of the API endpoint to send user messages to. Defaults to `"/api/chat"`. |
| headers | optional | `Record<string, string> \| (() => Record<string, string>)` | Additional HTTP headers to include in API requests. Use the function form for dynamic values such as auth tokens. |
| body | optional | `Record<string, unknown> \| (() => Record<string, unknown>)` | Additional fields to merge into the API request body. Use the function form for dynamic values. |
| credentials | optional | `RequestCredentials` | Credentials mode for the fetch request (`'include'`, `'same-origin'`, `'omit'`). |
| fetch | optional | `typeof globalThis.fetch` | Custom fetch implementation. Defaults to `globalThis.fetch`. |
| messages | optional | `TMessage[]` | Initial messages to seed the conversation tree with. Forms a linear chain. |
| logger | optional | `Logger` | Logger instance for debug output. |

## ClientTransport 

The `ClientTransport` object returned by the factory.

### tree 

The underlying conversation tree. The tree contains every message received on the channel, organized into branches.

<Code>

#### Javascript

```
const tree = transport.tree
```
</Code>

### view 

The default `View` for the transport. Created automatically when the transport is instantiated.

<Code>

#### Javascript

```
const view = transport.view
```
</Code>

### createView 

Create an additional `View` of the conversation tree. Each view maintains its own branch selection and pagination state.

<Code>

#### Javascript

```
function createView(): View<TEvent, TMessage>
```
</Code>

Use multiple views when you need different perspectives on the same conversation, for example a main chat panel and a sidebar showing an alternative branch.

### cancel 

Publish a cancel signal on the channel. The optional filter scopes which turns are cancelled.

<Code>

#### Javascript

```
function cancel(filter?: CancelFilter): Promise<void>
```
</Code>

| Filter property | Type | Effect |
| --- | --- | --- |
| own | `true` | Cancel all turns started by this client (default). |
| turnId | `string` | Cancel one specific turn. |
| clientId | `string` | Cancel all turns by a specific client. |
| all | `true` | Cancel all active turns on the channel. |

When called with no argument, `cancel()` defaults to `{ own: true }`.

### waitForTurn 

Wait for active turns matching the given filter to complete. Returns a promise that resolves when all matching turns have ended. Resolves immediately if no matching turns are active. Defaults to `{ own: true }`.

<Code>

#### Javascript

```
function waitForTurn(filter?: CancelFilter): Promise<void>
```
</Code>

### on('error') 

Subscribe to transport-level errors.

<Code>

#### Javascript

```
transport.on('error', (error: ErrorInfo) => {
  console.error('Transport error:', error)
})
```
</Code>

### close 

Close the transport and release resources. Optionally cancel active turns before closing.

<Code>

#### Javascript

```
function close(options?: CloseOptions): Promise<void>
```
</Code>

## View 

A `View` is a paginated, branch-aware projection of the conversation tree. It tracks which branch is selected at each fork point and supports lazy loading of older messages.

### getMessages 

Return the visible domain messages along the selected branch.

<Code>

#### Javascript

```
function getMessages(): TMessage[]
```
</Code>

### flattenNodes 

Return the visible nodes along the selected branch, filtered by the pagination window. Each node wraps the domain message with tree metadata.

<Code>

#### Javascript

```
function flattenNodes(): MessageNode<TMessage>[]
```
</Code>

### hasOlder 

Whether there are older messages that can be loaded or revealed.

<Code>

#### Javascript

```
function hasOlder(): boolean
```
</Code>

### send 

Send one or more user messages and start a new turn. Messages are optimistically inserted into the tree. The parent is auto-computed from the view's selected branch unless overridden in options. Returns an `ActiveTurn` handle for the server's response stream.

<Code>

#### Javascript

```
function send(messages: TMessage | TMessage[], options?: SendOptions): Promise<ActiveTurn<TEvent>>
```
</Code>

### regenerate 

Regenerate an assistant message. Creates a new turn that forks the target message with no new user messages. Automatically computes `forkOf`, `parent`, and truncated `history` from the view's branch.

<Code>

#### Javascript

```
function regenerate(messageId: string, options?: SendOptions): Promise<ActiveTurn<TEvent>>
```
</Code>

### edit 

Edit a user message and regenerate from that point. Creates a new turn that forks the target message with replacement content. Automatically computes `forkOf`, `parent`, and `history` from the view's branch.

<Code>

#### Javascript

```
function edit(messageId: string, newMessages: TMessage | TMessage[], options?: SendOptions): Promise<ActiveTurn<TEvent>>
```
</Code>

### update 

Update an existing message and start a continuation turn. The local tree is updated optimistically, then the events are sent to the server in the POST body. The server publishes them to the channel and streams a continuation response.

<Code>

#### Javascript

```
function update(msgId: string, events: TEvent[], options?: SendOptions): Promise<ActiveTurn<TEvent>>
```
</Code>

### loadOlder 

Load older messages from channel history. Loads from history if the tree does not have enough messages, then advances the pagination window.

<Code>

#### Javascript

```
function loadOlder(limit?: number): Promise<void>
```
</Code>

### select 

Select a sibling at a fork point by index. Updates the view's branch selection. The index is clamped to `[0, siblings.length - 1]`.

<Code>

#### Javascript

```
function select(msgId: string, index: number): void
```
</Code>

### getSelectedIndex 

Get the index of the currently selected sibling at a fork point.

<Code>

#### Javascript

```
function getSelectedIndex(msgId: string): number
```
</Code>

### getSiblings 

Get all messages that are siblings at a given fork point, ordered chronologically by serial.

<Code>

#### Javascript

```
function getSiblings(msgId: string): TMessage[]
```
</Code>

### hasSiblings 

Whether a message has sibling alternatives at its fork point.

<Code>

#### Javascript

```
function hasSiblings(msgId: string): boolean
```
</Code>

### getNode 

Get a node by its message ID, or `undefined` if not found.

<Code>

#### Javascript

```
function getNode(msgId: string): MessageNode<TMessage> | undefined
```
</Code>

### getActiveTurnIds 

Get active turn IDs for turns with visible messages, grouped by client ID.

<Code>

#### Javascript

```
function getActiveTurnIds(): Map<string, Set<string>>
```
</Code>

### on 

Subscribe to view events. Each handler returns an unsubscribe function.

<Code>

#### Javascript

```
// Fired when the visible message list changes (new message, branch switch, window shift)
const unsubscribe = view.on('update', () => { })

// Fired when a raw Ably message arrives for a visible node
view.on('ably-message', (msg: Ably.InboundMessage) => { })

// Fired when a turn starts or ends for a turn with visible messages
view.on('turn', (event: TurnLifecycleEvent) => { })
```
</Code>

### close 

Tear down the view. Unsubscribes from tree events and clears internal state.

<Code>

#### Javascript

```
function close(): void
```
</Code>

## ActiveTurn 

A handle to an active client-side turn, returned by `send()`, `regenerate()`, `edit()`, and `update()`.

| Property | Type | Description |
| --- | --- | --- |
| stream | `ReadableStream<TEvent>` | The decoded event stream for this turn. |
| turnId | `string` | The unique identifier for this turn. |
| cancel | `() => Promise<void>` | Cancel this specific turn. Publishes a cancel message and closes the local stream. |
| optimisticMsgIds | `string[]` | The msg-ids of optimistically inserted user messages, in order. Present when the send included user messages (edit); empty for regeneration. |

## SendOptions 

Per-send options for customizing the HTTP POST and branching metadata.

| Property | Required | Type | Description |
| --- | --- | --- | --- |
| headers | optional | `Record<string, string>` | Additional HTTP headers for this request. |
| body | optional | `Record<string, unknown>` | Additional fields to merge into the request body. |
| forkOf | optional | `string` | The msg-id of the message this send replaces (creates a fork). |
| parent | optional | `string \| null` | The msg-id of the preceding message in the conversation thread. `null` means the message is a root. If omitted, auto-computed from the last message in the view. |

## CloseOptions 

| Property | Type | Description |
| --- | --- | --- |
| cancel | `CancelFilter` | Cancel in-progress turns before closing. Publishes a cancel message to the channel. |

## MessageNode 

A node in the conversation tree, representing a single domain message.

| Property | Type | Description |
| --- | --- | --- |
| kind | `'message'` | Discriminator identifying this as a message node. |
| message | `TMessage` | The domain message. |
| msgId | `string` | The `x-ably-msg-id` of this node. Primary key in the tree. |
| parentId | `string \| undefined` | Parent node's msg-id, or `undefined` for root messages. |
| forkOf | `string \| undefined` | The msg-id this node forks from, or `undefined` if first version. |
| headers | `Record<string, string>` | Full Ably headers for this message. |
| serial | `string \| undefined` | Ably serial for ordering. Absent for optimistic messages. |

## TurnLifecycleEvent 

A structured event describing a turn starting or ending.

<Code>

### Javascript

```
type TurnLifecycleEvent =
  | { type: 'x-ably-turn-start'; turnId: string; clientId: string; parent?: string; forkOf?: string }
  | { type: 'x-ably-turn-end'; turnId: string; clientId: string; reason: TurnEndReason }
```
</Code>

## TurnEndReason 

<Code>

### Javascript

```
type TurnEndReason = 'complete' | 'cancelled' | 'error'
```
</Code>

## CancelFilter 

Filter for cancel operations. At most one field should be set.

| Property | Type | Description |
| --- | --- | --- |
| turnId | `string` | Cancel a specific turn by ID. |
| own | `boolean` | Cancel all turns belonging to the sender's client ID. |
| clientId | `string` | Cancel all turns belonging to a specific client ID. |
| all | `boolean` | Cancel all turns on the channel. |

## Related Topics

- [Overview](https://ably.com/docs/ai-transport/api-reference.md): API reference for Ably AI Transport. Client transport, server transport, React hooks, Vercel integration, codec, and error codes.
- [Server transport](https://ably.com/docs/ai-transport/api-reference/server-transport.md): API reference for the AI Transport server transport. Turn lifecycle, cancel routing, and configuration.
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
