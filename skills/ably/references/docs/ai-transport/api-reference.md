# API reference

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

This reference covers every public API surface in the `@ably/ai-transport` package. The SDK is organized into four entry points so you only import what you need.

## API surfaces 

| Surface | Description | Reference |
| --- | --- | --- |
| Client transport | Subscribe to turns, build conversation views, cancel and control from the client | [Client transport](https://ably.com/docs/ai-transport/api-reference/client-transport.md) |
| Server transport | Manage turn lifecycle, stream responses, handle cancellation on the server | [Server transport](https://ably.com/docs/ai-transport/api-reference/server-transport.md) |
| React hooks | Declarative hooks for building chat UIs with any codec | [React hooks](https://ably.com/docs/ai-transport/api-reference/react-hooks.md) |
| Vercel integration | Pre-built codec and factories for the Vercel AI SDK | [Vercel integration](https://ably.com/docs/ai-transport/api-reference/vercel.md) |
| Codec | Interface for bridging any AI framework to Ably messages | [Codec](https://ably.com/docs/ai-transport/api-reference/codec.md) |
| Error codes | Enumerated error codes with recovery guidance | [Error codes](https://ably.com/docs/ai-transport/api-reference/error-codes.md) |

## Entry points 

| Entry point | Import path | Contents |
| --- | --- | --- |
| Core | `@ably/ai-transport` | `createClientTransport`, `createServerTransport`, codec interfaces |
| React | `@ably/ai-transport/react` | Generic React hooks (`useClientTransport`, `useView`, etc.) |
| Vercel | `@ably/ai-transport/vercel` | `UIMessageCodec`, Vercel-specific transport factories |
| Vercel React | `@ably/ai-transport/vercel/react` | `useChatTransport`, `useMessageSync` |

<Aside data-type='note'>
The Vercel entry points re-export the core transport factories with the codec pre-bound. If you use `@ably/ai-transport/vercel`, you do not need to import from `@ably/ai-transport` separately.
</Aside>

## Related Topics

- [Client transport](https://ably.com/docs/ai-transport/api-reference/client-transport.md): API reference for the AI Transport client transport. Options, methods, events, and the View interface.
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
