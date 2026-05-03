# Rooms

Use the `ably rooms` command group to interact with Ably Chat rooms. These commands enable you to manage rooms, send and subscribe to messages, monitor occupancy, manage presence, send reactions, and work with typing indicators.

## Room management 

Use the following command to list active [Chat rooms](https://ably.com/docs/chat/rooms.md). Rooms are logical containers that organize users and messages, each backed by a Pub/Sub channel:

| Command | Description |
| ------- | ----------- |
| [`ably rooms list`](https://ably.com/docs/cli/rooms/list.md) | List active chat rooms. |

## Manage messages 

Use the following commands to send, receive, update, and delete [messages](https://ably.com/docs/chat/rooms/messages.md) in chat rooms. Messages are [persisted for 30 days](https://ably.com/docs/chat/rooms/history.md) by default, enabling history retrieval and message operations:

| Command | Description |
| ------- | ----------- |
| [`ably rooms messages send`](https://ably.com/docs/cli/rooms/messages/send.md) | Send a message to a chat room. |
| [`ably rooms messages subscribe`](https://ably.com/docs/cli/rooms/messages/subscribe.md) | Subscribe to messages in one or more chat rooms. |
| [`ably rooms messages history`](https://ably.com/docs/cli/rooms/messages/history.md) | Get historical messages from a chat room. |
| [`ably rooms messages update`](https://ably.com/docs/cli/rooms/messages/update.md) | Update a message in a chat room. |
| [`ably rooms messages delete`](https://ably.com/docs/cli/rooms/messages/delete.md) | Delete a message in a chat room. |

## Manage message reactions 

Use the following commands to manage reactions on individual chat messages. [Message reactions](https://ably.com/docs/chat/rooms/message-reactions.md) are tied to specific messages, unlike [room-level reactions](https://ably.com/docs/chat/rooms/reactions.md) which respond to overall room activity:

| Command | Description |
| ------- | ----------- |
| [`ably rooms messages reactions send`](https://ably.com/docs/cli/rooms/messages/reactions/send.md) | Send a reaction to a message. |
| [`ably rooms messages reactions subscribe`](https://ably.com/docs/cli/rooms/messages/reactions/subscribe.md) | Subscribe to message reactions. |
| [`ably rooms messages reactions remove`](https://ably.com/docs/cli/rooms/messages/reactions/remove.md) | Remove a reaction from a message. |

## Room presence 

Use the following commands to manage [presence](https://ably.com/docs/chat/rooms/presence.md) in chat rooms. Presence enables users to indicate when they are online or offline and track who is currently in the room:

| Command | Description |
| ------- | ----------- |
| [`ably rooms presence enter`](https://ably.com/docs/cli/rooms/presence/enter.md) | Enter presence in a chat room. |
| [`ably rooms presence get`](https://ably.com/docs/cli/rooms/presence/get.md) | Get current presence members in a chat room. |
| [`ably rooms presence subscribe`](https://ably.com/docs/cli/rooms/presence/subscribe.md) | Subscribe to presence events in a chat room. |

## Room reactions 

Use the following commands to manage room-level [reactions](https://ably.com/docs/chat/rooms/reactions.md) in chat rooms. Room reactions are ephemeral and capture real-time sentiment about overall room activity, such as a livestream:

| Command | Description |
| ------- | ----------- |
| [`ably rooms reactions send`](https://ably.com/docs/cli/rooms/reactions/send.md) | Send a reaction in a chat room. |
| [`ably rooms reactions subscribe`](https://ably.com/docs/cli/rooms/reactions/subscribe.md) | Subscribe to reactions in a chat room. |

## Room typing 

Use the following commands to manage [typing indicators](https://ably.com/docs/chat/rooms/typing.md) in chat rooms. Typing indicators display which users are currently composing messages in a room:

| Command | Description |
| ------- | ----------- |
| [`ably rooms typing keystroke`](https://ably.com/docs/cli/rooms/typing/keystroke.md) | Send a typing indicator in a chat room. |
| [`ably rooms typing subscribe`](https://ably.com/docs/cli/rooms/typing/subscribe.md) | Subscribe to typing indicators in a chat room. |

## Room occupancy 

Use the following commands to monitor [occupancy](https://ably.com/docs/chat/rooms/occupancy.md) in chat rooms. Occupancy tracks the number of users currently connected to a room and must be explicitly enabled:

| Command | Description |
| ------- | ----------- |
| [`ably rooms occupancy get`](https://ably.com/docs/cli/rooms/occupancy/get.md) | Get current occupancy metrics for a room. |
| [`ably rooms occupancy subscribe`](https://ably.com/docs/cli/rooms/occupancy/subscribe.md) | Subscribe to real-time occupancy metrics. |

## See also

* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
