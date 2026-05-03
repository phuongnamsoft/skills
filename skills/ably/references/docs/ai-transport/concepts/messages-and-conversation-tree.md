# Messages and conversation tree

Every conversation in AI Transport is a tree of messages. Each message has a unique identity and a position in the tree. The tree preserves all paths through the conversation, including edits and regenerations, so that no content is ever lost.

## Understand messages 

A message is a discrete unit of content in the conversation: a user's input, an assistant's response, a tool call, a tool result. Each message has a unique identity (its message ID) and a position in the tree defined by parent and fork-of pointers.

A message may arrive on the channel as a single publish or as a sequence of operations that share the same message ID. A streamed assistant response, for example, is initiated with a publish and built up through a series of appends (token deltas) until a final closing append marks it complete. These are not separate messages; they are the incremental delivery of a single message. The message ID is the identity; the channel operations are the mechanism.

Each message carries transport headers (identity, parentage, role, streaming state) and a codec-encoded payload. Messages are ordered by their serial and are immutable once complete.

## Understand the conversation tree 

The tree holds the complete branching history of a conversation. Every message that has ever been part of the [session](https://ably.com/docs/ai-transport/concepts/sessions.md), whether it is currently visible or not, is a node in the tree.

The tree is not a linear list. When you regenerate a response, the new response is a sibling of the old one, not a replacement. When you edit a message, the edited version forks from the same parent as the original. This means the tree preserves all paths through the conversation, not just the currently visible one. No message is ever deleted from the tree by a regeneration or edit; it becomes a sibling on an alternative branch.

### Construct the tree from transport headers 

Each message on the channel carries transport headers that define the tree structure:

- A message ID that uniquely identifies the node.
- A parent pointer that establishes the parent-child relationship.
- An optional fork-of pointer that marks a regeneration or edit.

The tree applies these headers to construct the graph. Messages are ordered by their serial, so the tree's construction is deterministic. The same sequence of messages always produces the same tree.

### Use the tree as the source of truth 

The tree is the single source of truth for conversation state. It is unfiltered: it contains every node on every branch, and it emits events for every mutation regardless of which branch was affected. The tree does not know or care which branch a particular participant is looking at. That is the view's job.

## Understand views 

A view is a linear projection over the tree. It selects one sibling at each branch point and produces the flat sequence of messages that a participant works with: the conversation as it appears in a chat UI, or the message history that an agent sends to an LLM.

The tree contains every branch; the view chooses a path through it. When a conversation has been regenerated three times at a particular point, the tree holds all three responses as siblings. The view selects one of them and presents the conversation as if that response is the only one, while still allowing navigation to the others.

### Maintain independent views per participant 

Each participant can have their own view with independent branch selections. Two clients looking at the same session might be viewing different branches of the same conversation. The tree is shared; the views are independent.

### Manage pagination 

The view manages pagination. Not all messages need to be visible at once. Older messages can be withheld and loaded on demand. The view tracks the boundary between visible and withheld messages and provides the mechanism to expand the window.

### Receive scoped events 

The view emits the same kinds of events as the tree (updates, turn lifecycle), but scoped to visibility. If a mutation affects a branch that the view is not currently showing, the view does not emit an event. This is the filtering that makes views practical for driving UI: a component subscribed to view events only re-renders when something it is displaying changes.

### Interact through a view 

The view is the surface through which participants interact with the conversation. Sending a message, regenerating a response, editing a message, and updating an existing message are all operations on a view. The view knows its current position in the tree (the selected branch, the last visible message) and uses that context to construct the correct parent and fork-of pointers for new operations.

## Read next 

- [Sessions](https://ably.com/docs/ai-transport/concepts/sessions.md): understand the persistent, shared conversation state that the tree belongs to.
- [Turns](https://ably.com/docs/ai-transport/concepts/turns.md): understand how agent work is structured within the session.
- [Edit and regenerate](https://ably.com/docs/ai-transport/features/edit-and-regenerate.md): use branching in practice to fork and navigate conversations.
- [Conversation branching](https://ably.com/docs/ai-transport/features/branching.md): understand how branches are created and navigated.

## Related Topics

- [Sessions](https://ably.com/docs/ai-transport/concepts/sessions.md): Understand sessions in AI Transport: persistent, shared conversation state that exists independently of any participant's connection.
- [Turns](https://ably.com/docs/ai-transport/concepts/turns.md): Understand turns in AI Transport: the logical unit of agent work that structures prompt-response cycles with lifecycle states, cancellation, and execution resilience.
- [Transport](https://ably.com/docs/ai-transport/concepts/transport.md): Understand the transport layer in AI Transport: client transport, agent transport, and the codec that bridges your AI framework to Ably.
- [Authentication](https://ably.com/docs/ai-transport/concepts/authentication.md): Understand how authentication works in Ably AI Transport: Ably token auth for channel access, HTTP headers for server endpoints, and cancel authorization.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
