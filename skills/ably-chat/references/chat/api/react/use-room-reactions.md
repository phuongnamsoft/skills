# useRoomReactions

The `useRoomReactions` hook enables sending and subscribing to ephemeral room-level reactions. Room reactions are commonly used for live interactions like floating emojis, applause, or other realtime audience feedback. Unlike message reactions, room reactions are not persisted.

<Code>

#### React

```
import { useRoomReactions } from '@ably/chat/react';

const MyComponent = () => {
  const { sendRoomReaction } = useRoomReactions({
    listener: (event) => {
      console.log(`${event.reaction.clientId} reacted with ${event.reaction.name}`);
    },
  });

  return <button onClick={() => sendRoomReaction({ name: '👍' })}>React</button>;
};
```
</Code>

This hook must be used within a [`ChatRoomProvider`](https://ably.com/docs/chat/api/react/providers.md#chatRoomProvider).

## Parameters 

The `useRoomReactions` hook accepts an optional configuration object:

<Table id='UseRoomReactionsParams'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Optional | A callback invoked whenever a room reaction is received. Removed when the component unmounts. | <Table id='RoomReactionListener'/> |
| onDiscontinuity | Optional | A callback to detect and respond to discontinuities. | [DiscontinuityListener](https://ably.com/docs/chat/api/react/providers.md#discontinuityListener) |
| onRoomStatusChange | Optional | A callback invoked when the room status changes. Removed when the component unmounts. | [RoomStatusChange](https://ably.com/docs/chat/api/react/use-room.md#roomStatusChange) |
| onConnectionStatusChange | Optional | A callback invoked when the connection status changes. Removed when the component unmounts. | [ConnectionStatusChange](https://ably.com/docs/chat/api/react/use-chat-connection.md#connectionStatusChange) |

</Table>

<Table id='RoomReactionListener' >

| Parameter | Description | Type |
| --- | --- | --- |
| event | The room reaction event. | <Table id='RoomReactionEvent'/> |

</Table>

<Table id='RoomReactionEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The type of the event. Always `Reaction`. | <Table id='RoomReactionEventType'/> |
| reaction | The reaction that was received. | <Table id='RoomReaction'/> |

</Table>

<Table id='RoomReactionEventType' >

| Value | Description |
| --- | --- |
| Reaction | A room-level reaction was received. The value is `reaction`. |

</Table>

<Table id='RoomReaction' >

| Property | Description | Type |
| --- | --- | --- |
| name | The name of the reaction (for example, an emoji). | String |
| clientId | The client ID of the user who sent the reaction. | String |
| userClaim | The user claim attached to this reaction by the server. Only present if the user's [JWT](https://ably.com/docs/auth/token.md#jwt) contained a claim for the room. | String or Undefined |
| metadata | Additional metadata included with the reaction. Empty object if none provided. | <Table id='RoomReactionMetadata'/> |
| headers | Additional information from Ably message extras. Empty object if none provided. | <Table id='RoomReactionHeaders'/> |
| createdAt | When the reaction was sent. | Date |
| isSelf | Whether the reaction was sent by the current client. | Boolean |

</Table>

<Table id='RoomReactionMetadata' >

| Property | Description | Type |
| --- | --- | --- |
| | Key-value pairs that can be attached to a room reaction for features like animations or styling hints. Keys must be non-empty strings. Values can be any JSON-serializable type. Always present and defaults to an empty object if not provided. | JsonObject |

</Table>

<Table id='RoomReactionHeaders' >

| Property | Description | Type |
| --- | --- | --- |
| | Key-value pairs that can be attached to a room reaction, accessible to integrations such as webhooks, queues, or serverless functions. Keys must be non-empty strings. Always present and defaults to an empty object if not provided. | `Record<string, number \| string \| boolean \| null \| undefined>` |

</Table>

## Returns 

The `useRoomReactions` hook returns an object with the following properties:

<Table id='UseRoomReactionsResponse'>

| Property | Description | Type |
| --- | --- | --- |
| sendRoomReaction | Sends a room-level reaction. | [sendRoomReaction()](#send) |
| roomStatus | The current status of the room, kept up to date by the hook. | [RoomStatus](https://ably.com/docs/chat/api/react/use-room.md#roomStatus) |
| roomError | An error object if the room is in an errored state. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |
| connectionStatus | The current connection status, kept up to date by the hook. | [ConnectionStatus](https://ably.com/docs/chat/api/react/use-chat-connection.md#connectionStatus) |
| connectionError | An error object if there is a connection error. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |

</Table>

## Send a room reaction 

`sendRoomReaction(params: SendReactionParams): Promise<void>`

Sends a room-level reaction. Room reactions are ephemeral events that are not associated with specific messages.

### Parameters 

<Table id='SendReactionParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| params | Required | The reaction parameters. | <Table id='SendReactionParams'/> |

</Table>

<Table id='SendReactionParams' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| name | Required | The name of the reaction, typically an emoji or identifier. | String |
| metadata | Optional | Additional metadata to include with the reaction. | JsonObject |
| headers | Optional | Additional information in Ably message extras, usable for features like referencing external resources. | Headers |

</Table>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the reaction has been sent, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

## Example

<Code>

### React

```
import { useRoomReactions } from '@ably/chat/react';
import { useState, useCallback } from 'react';

function ReactionBar() {
  const [recentReactions, setRecentReactions] = useState([]);

  const { sendRoomReaction } = useRoomReactions({
    listener: (event) => {
      const { reaction } = event;
      setRecentReactions((prev) => [
        ...prev.slice(-9),
        { name: reaction.name, clientId: reaction.clientId, isSelf: reaction.isSelf },
      ]);
    },
  });

  const emojis = ['👍', '❤️', '😂', '🎉', '👏'];

  return (
    <div>
      <div>
        {emojis.map((emoji) => (
          <button key={emoji} onClick={() => sendRoomReaction({ name: emoji })}>
            {emoji}
          </button>
        ))}
      </div>
      <div>
        {recentReactions.map((r, i) => (
          <span key={i}>{r.name}</span>
        ))}
      </div>
    </div>
  );
}
```
</Code>

## Related Topics

- [Providers](https://ably.com/docs/chat/api/react/providers.md): API reference for the ChatClientProvider and ChatRoomProvider components in the Ably Chat React SDK.
- [useChatClient](https://ably.com/docs/chat/api/react/use-chat-client.md): API reference for the useChatClient hook in the Ably Chat React SDK.
- [useChatConnection](https://ably.com/docs/chat/api/react/use-chat-connection.md): API reference for the useChatConnection hook in the Ably Chat React SDK.
- [useRoom](https://ably.com/docs/chat/api/react/use-room.md): API reference for the useRoom hook in the Ably Chat React SDK.
- [useMessages](https://ably.com/docs/chat/api/react/use-messages.md): API reference for the useMessages hook in the Ably Chat React SDK.
- [usePresence](https://ably.com/docs/chat/api/react/use-presence.md): API reference for the usePresence hook in the Ably Chat React SDK.
- [usePresenceListener](https://ably.com/docs/chat/api/react/use-presence-listener.md): API reference for the usePresenceListener hook in the Ably Chat React SDK.
- [useOccupancy](https://ably.com/docs/chat/api/react/use-occupancy.md): API reference for the useOccupancy hook in the Ably Chat React SDK.
- [useTyping](https://ably.com/docs/chat/api/react/use-typing.md): API reference for the useTyping hook in the Ably Chat React SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
