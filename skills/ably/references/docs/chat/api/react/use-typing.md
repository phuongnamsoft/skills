# useTyping

The `useTyping` hook manages typing indicator state for a chat room, automatically tracking users who are currently typing and updating state in realtime.

<Code>

#### React

```
import { useTyping } from '@ably/chat/react';

const MyComponent = () => {
  const { keystroke, stop, currentTypers } = useTyping();

  return (
    <div>
      {currentTypers.length > 0 && (
        <p>{currentTypers.map(t => t.clientId).join(', ')} typing...</p>
      )}
      <input
        onInput={() => keystroke()}
        onBlur={() => stop()}
      />
    </div>
  );
};
```
</Code>

This hook must be used within a [`ChatRoomProvider`](https://ably.com/docs/chat/api/react/providers.md#chatRoomProvider).

## Parameters 

The `useTyping` hook accepts an optional configuration object:

<Table id='TypingParams'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Optional | A callback invoked whenever a typing event occurs. Removed when the component unmounts. | <Table id='TypingListener'/> |
| onDiscontinuity | Optional | A callback to detect and respond to discontinuities. | [DiscontinuityListener](https://ably.com/docs/chat/api/react/providers.md#discontinuityListener) |
| onRoomStatusChange | Optional | A callback invoked when the room status changes. Removed when the component unmounts. | [RoomStatusChange](https://ably.com/docs/chat/api/react/use-room.md#roomStatusChange) |
| onConnectionStatusChange | Optional | A callback invoked when the connection status changes. Removed when the component unmounts. | [ConnectionStatusChange](https://ably.com/docs/chat/api/react/use-chat-connection.md#connectionStatusChange) |

</Table>

<Table id='TypingListener' >

| Parameter | Description | Type |
| --- | --- | --- |
| event | The typing event. | <Table id='TypingSetEvent'/> |

</Table>

<Table id='TypingSetEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The type of the event. Always `SetChanged`. | <Table id='TypingSetEventType'/> |
| currentTypers | The set of users currently typing, with associated metadata such as user claims. | <Table id='TypingMember'/>[] |
| currentlyTyping | **Deprecated.** Use `currentTypers` instead. The set of client IDs currently typing. | `Set<string>` |
| change | Information about the specific change that triggered this event. | <Table id='TypingSetEvent.change'/> |

</Table>

<Table id='TypingSetEventType' >

| Value | Description |
| --- | --- |
| SetChanged | The set of currently typing users has changed. The value is `typing.set.changed`. |

</Table>

<Table id='TypingMember' >

| Property | Description | Type |
| --- | --- | --- |
| clientId | The client ID of the typing user. | String |
| userClaim | The user claim attached to this typing event by the server. Only present if the user's [JWT](https://ably.com/docs/auth/token.md#jwt) contained a claim for the room. | String or Undefined |

</Table>

<Table id='TypingSetEvent.change' >

| Property | Description | Type |
| --- | --- | --- |
| clientId | The client ID whose typing state changed. | String |
| type | Whether the user started or stopped typing. | <Table id='TypingEventType'/> |
| userClaim | The user claim attached to this typing event by the server. Only present if the user's [JWT](https://ably.com/docs/auth/token.md#jwt) contained a claim for the room. | String or Undefined |

</Table>

<Table id='TypingEventType' >

| Value | Description |
| --- | --- |
| Started | A user has started typing. The value is `typing.started`. |
| Stopped | A user has stopped typing. The value is `typing.stopped`. |

</Table>

## Returns 

The `useTyping` hook returns an object with the following properties:

<Table id='UseTypingResponse'>

| Property | Description | Type |
| --- | --- | --- |
| currentTypers | The set of users currently typing in the room, with associated metadata. Updated automatically from room events. | <Table id='TypingMember'/>[] |
| keystroke | Sends a typing-started notification. | [keystroke()](#keystroke) |
| stop | Sends a typing-stopped notification. | [stop()](#stop) |
| roomStatus | The current status of the room, kept up to date by the hook. | [RoomStatus](https://ably.com/docs/chat/api/react/use-room.md#roomStatus) |
| roomError | An error object if the room is in an errored state. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |
| connectionStatus | The current connection status, kept up to date by the hook. | [ConnectionStatus](https://ably.com/docs/chat/api/react/use-chat-connection.md#connectionStatus) |
| connectionError | An error object if there is a connection error. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |

</Table>

## Start typing 

`keystroke(): Promise<void>`

Sends a typing started event to notify other users that the current user is typing.

Events are throttled according to the `heartbeatThrottleMs` room option to prevent excessive network traffic. If called within the throttle interval, the operation becomes a no-op.

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the typing event has been sent, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

## Stop typing 

`stop(): Promise<void>`

Sends a typing stopped event to notify other users that the current user has stopped typing.

If the user is not currently typing, this operation is a no-op.

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the typing stopped event has been sent, or rejected with an [`ErrorInfo`](https://ably.com/docs/chat/api/react/providers.md#errorInfo) object.

## Example

<Code>

### React

```
import { useTyping } from '@ably/chat/react';
import { useState, useCallback } from 'react';

function MessageInput({ onSend }) {
  const [text, setText] = useState('');
  const { keystroke, stop, currentTypers } = useTyping({
    listener: (event) => {
      const { change } = event;
      if (change.type === 'typing.started') {
        console.log(`${change.clientId} started typing`);
      }
    },
  });

  const handleInput = useCallback((e) => {
    setText(e.target.value);
    if (e.target.value.length > 0) {
      keystroke();
    } else {
      stop();
    }
  }, [keystroke, stop]);

  const handleSubmit = useCallback(async () => {
    await onSend(text);
    setText('');
    await stop();
  }, [text, onSend, stop]);

  return (
    <div>
      {currentTypers.length > 0 && (
        <p>
          {currentTypers.length === 1
            ? `${currentTypers[0].clientId} is typing...`
            : `${currentTypers.map(t => t.clientId).join(', ')} are typing...`}
        </p>
      )}
      <input value={text} onChange={handleInput} onBlur={() => stop()} />
      <button onClick={handleSubmit}>Send</button>
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
- [useRoomReactions](https://ably.com/docs/chat/api/react/use-room-reactions.md): API reference for the useRoomReactions hook in the Ably Chat React SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
