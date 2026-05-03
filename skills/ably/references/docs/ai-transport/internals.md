# Internals

<Aside data-type='new'>
The AI Transport docs are being actively written and developed. They are available early to explain how AI Transport functions.
</Aside>

The internals section covers the wire protocol, codec architecture, conversation tree structure, and transport patterns that make up AI Transport under the hood. These details are useful if you want to understand how the SDK works, contribute to the project, or build custom codecs.

## Topics 

<Tiles>
{[
  {
    title: 'Wire protocol',
    description: 'The Ably channel wire format: transport headers, lifecycle events, content messages, and message identity.',
    link: '[ably docs ai-transport internals wire-protocol](https://ably.com/docs/ai-transport/internals/wire-protocol.md)',
  },
  {
    title: 'Codec architecture',
    description: 'How the codec bridges domain events to Ably messages. Encoder, decoder, accumulator, and lifecycle tracker internals.',
    link: '[ably docs ai-transport internals codec-architecture](https://ably.com/docs/ai-transport/internals/codec-architecture.md)',
  },
  {
    title: 'Conversation tree',
    description: 'The branching conversation structure. Serial ordering, sibling groups, fork chains, and the flatten algorithm.',
    link: '[ably docs ai-transport internals conversation-tree](https://ably.com/docs/ai-transport/internals/conversation-tree.md)',
  },
  {
    title: 'Transport patterns',
    description: 'Internal transport components: StreamRouter, TurnManager, pipeStream, and cancel routing.',
    link: '[ably docs ai-transport internals transport-patterns](https://ably.com/docs/ai-transport/internals/transport-patterns.md)',
  },
]}
</Tiles>

## Related Topics

- [Wire protocol](https://ably.com/docs/ai-transport/internals/wire-protocol.md): The Ably channel wire format used by AI Transport. Headers, lifecycle events, content messages, and message identity.
- [Codec architecture](https://ably.com/docs/ai-transport/internals/codec-architecture.md): How the AI Transport codec bridges domain events to Ably messages. Encoder, decoder, accumulator, and lifecycle tracker internals.
- [Conversation tree](https://ably.com/docs/ai-transport/internals/conversation-tree.md): How AI Transport maintains a branching conversation structure. Serial ordering, sibling groups, fork chains, and flatten algorithm.
- [Transport patterns](https://ably.com/docs/ai-transport/internals/transport-patterns.md): Internal transport components in AI Transport. StreamRouter, TurnManager, pipeStream, and cancel routing.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
