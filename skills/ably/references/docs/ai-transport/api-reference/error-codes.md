# Error codes

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

AI Transport uses numeric error codes to identify specific failure conditions. Errors are surfaced as `ErrorInfo` objects, which include a `code`, `statusCode`, and `message`. Use the `errorInfoIs` utility to match errors by code.

## Error code reference 

### General errors 

| Code | Name | HTTP status | Description | Recovery |
| --- | --- | --- | --- | --- |
| 40000 | BadRequest | 400 | The request was malformed or missing required fields. | Check the request payload and ensure all required fields are present. |
| 40003 | InvalidArgument | 400 | An argument passed to a transport method was invalid. | Verify the arguments match the expected types and constraints. |

### Transport errors 

| Code | Name | HTTP status | Description | Recovery |
| --- | --- | --- | --- | --- |
| 104000 | EncoderRecoveryFailed | 500 | The encoder failed to recover after a publish error. The turn cannot continue. | End the turn with reason `'error'` and start a new one. The client will see the partial response up to the failure point. |
| 104001 | TransportSubscriptionError | 500 | A channel subscription callback threw unexpectedly. | Check the subscription callback for unhandled exceptions. Inspect the underlying error for details. |
| 104002 | CancelListenerError | 500 | The transport failed to register or process a cancel listener. | The turn may not respond to cancel signals. End the turn manually if needed. |
| 104003 | TurnLifecycleError | 500 | A turn lifecycle event failed to publish. | Check channel permissions and connection state. The turn-start or turn-end message could not be published. |
| 104004 | TransportClosed | 400 | An operation was attempted on a transport that has been closed. | Create a new transport instance. Do not reuse a closed transport. |
| 104005 | TransportSendFailed | 500 | The client transport failed to send a message to the API endpoint. | Check the API endpoint URL, network connectivity, and authentication. Inspect the underlying error for details. |

## errorInfoIs 

Utility function to check if an ErrorInfo matches a specific error code.

<Code>

### Javascript

```
import { errorInfoIs } from '@ably/ai-transport'

function errorInfoIs(errorInfo: Ably.ErrorInfo, error: ErrorCode): boolean
```
</Code>

<Code>

### Javascript

```
transport.on('error', (error) => {
  if (errorInfoIs(error, 104004)) {
    // Transport was closed, create a new one
    reconnect()
  }
})
```
</Code>

## Handle errors 

### Client-side 

Subscribe to transport-level errors using `on('error')`:

<Code>

#### Javascript

```
const transport = createClientTransport({ channel, codec })

transport.on('error', (error) => {
  console.error(`Error ${error.code}: ${error.message}`)
})
```
</Code>

### Server-side 

Handle errors at two levels: the transport level and the turn level.

<Code>

#### Javascript

```
// Transport-level errors
const transport = createServerTransport({
  channel,
  codec,
  onError(error) {
    console.error('Transport error:', error)
  },
})

// Turn-level errors
const turn = transport.newTurn({
  turnId,
  onError(error) {
    console.error('Turn error:', error)
  },
})
```
</Code>

If a turn encounters an error during streaming, end the turn with reason `'error'`:

<Code>

#### Javascript

```
try {
  const { reason } = await turn.streamResponse(llmStream)
  await turn.end(reason)
} catch (error) {
  await turn.end('error')
}
```
</Code>

## Related Topics

- [Overview](https://ably.com/docs/ai-transport/api-reference.md): API reference for Ably AI Transport. Client transport, server transport, React hooks, Vercel integration, codec, and error codes.
- [Client transport](https://ably.com/docs/ai-transport/api-reference/client-transport.md): API reference for the AI Transport client transport. Options, methods, events, and the View interface.
- [Server transport](https://ably.com/docs/ai-transport/api-reference/server-transport.md): API reference for the AI Transport server transport. Turn lifecycle, cancel routing, and configuration.
- [React hooks](https://ably.com/docs/ai-transport/api-reference/react-hooks.md): API reference for AI Transport React hooks. Generic hooks and Vercel-specific hooks for building chat UIs.
- [Vercel integration](https://ably.com/docs/ai-transport/api-reference/vercel.md): API reference for the AI Transport Vercel AI SDK integration. UIMessageCodec, ChatTransport, and pre-bound factories.
- [Codec](https://ably.com/docs/ai-transport/api-reference/codec.md): API reference for the AI Transport codec interface. Build custom codecs to integrate any AI framework.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
