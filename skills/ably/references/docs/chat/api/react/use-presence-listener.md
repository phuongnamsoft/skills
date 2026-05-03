# usePresenceListener

The `usePresenceListener` hook provides live presence information for all users in a room. It automatically subscribes to presence events and maintains an up-to-date roster of presence members. Use [`usePresence`](https://ably.com/docs/chat/api/react/use-presence.md) to manage the current user's own presence state.

<Code>

#### React

```
import { usePresenceListener } from '@ably/chat/react';

const MyComponent = () => {
  const { presenceData } = usePresenceListener();

  return (
    <ul>
      {presenceData.map((member) => (
        <li key={member.clientId}>{member.clientId}</li>
      ))}
    </ul>
  );
};
```
</Code>

This hook must be used within a [`ChatRoomProvider`](https://ably.com/docs/chat/api/react/providers.md#chatRoomProvider).

## Parameters 

The `usePresenceListener` hook accepts an optional configuration object:

<Table id='UsePresenceListenerParams'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Optional | A callback invoked whenever the presence state changes. Removed when the component unmounts. | <Table id='PresenceListener'/> |
| onDiscontinuity | Optional | A callback to detect and respond to discontinuities. | [DiscontinuityListener](https://ably.com/docs/chat/api/react/providers.md#discontinuityListener) |
| onRoomStatusChange | Optional | A callback invoked when the room status changes. Removed when the component unmounts. | [RoomStatusChange](https://ably.com/docs/chat/api/react/use-room.md#roomStatusChange) |
| onConnectionStatusChange | Optional | A callback invoked when the connection status changes. Removed when the component unmounts. | [ConnectionStatusChange](https://ably.com/docs/chat/api/react/use-chat-connection.md#connectionStatusChange) |

</Table>

<Table id='PresenceListener' >

| Parameter | Description | Type |
| --- | --- | --- |
| event | The presence event. | <Table id='PresenceEvent'/> |

</Table>

<Table id='PresenceEvent' >

| Property | Description | Type |
| --- | --- | --- |
| type | The type of presence event. | <Table id='PresenceEventType'/> |
| member | The presence member associated with this event. | <Table id='PresenceMember'/> |

</Table>

<Table id='PresenceEventType' >

| Value | Description |
| --- | --- |
| Enter | A user has entered the presence set. The value is `enter`. |
| Leave | A user has left the presence set. The value is `leave`. |
| Update | A user has updated their presence data. The value is `update`. |
| Present | Indicates a user is present (received during initial sync). The value is `present`. |

</Table>

<Table id='PresenceMember' >

| Property | Description | Type |
| --- | --- | --- |
| clientId | The client ID of the present user. | String |
| userClaim | The user claim attached to this presence event by the server. Only present if the user's [JWT](https://ably.com/docs/auth/token.md#jwt) contained a claim for the room. | String or Undefined |
| connectionId | The connection ID of the present user. | String |
| data | The presence data associated with the user. | <Table id='PresenceData'/> or Undefined |
| extras | Additional data included with the presence message. | JsonObject or Undefined |
| encoding | The encoding applied to the presence data, if any. Contains remaining transformations not yet applied to the `data` property. | String or Undefined |
| updatedAt | When this presence state was last updated. | Date |

</Table>

<Table id='PresenceData' >

| Property | Description | Type |
| --- | --- | --- |
| | JSON-serializable data that can be associated with a user's presence in a room. | JsonObject |

</Table>

## Returns 

The `usePresenceListener` hook returns an object with the following properties:

<Table id='UsePresenceListenerResponse'>

| Property | Description | Type |
| --- | --- | --- |
| presenceData | The current state of all presence members, updated in realtime. Only emitted while presence is not syncing. | <Table id='PresenceMember'/>[] |
| error | Tracks presence listener errors during asynchronous data fetching. Set when the initial presence data fetch fails or when errors occur after presence events. Clears upon successful new presence event processing. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |
| roomStatus | The current status of the room, kept up to date by the hook. | [RoomStatus](https://ably.com/docs/chat/api/react/use-room.md#roomStatus) |
| roomError | An error object if the room is in an errored state. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |
| connectionStatus | The current connection status, kept up to date by the hook. | [ConnectionStatus](https://ably.com/docs/chat/api/react/use-chat-connection.md#connectionStatus) |
| connectionError | An error object if there is a connection error. | [ErrorInfo](https://ably.com/docs/chat/api/react/providers.md#errorInfo) or Undefined |

</Table>

## Example

<Code>

### React

```
import { PresenceEventType } from '@ably/chat';
import { usePresenceListener } from '@ably/chat/react';

function OnlineUsers() {
  const { presenceData, error } = usePresenceListener({
    listener: (event) => {
      switch (event.type) {
        case PresenceEventType.Enter:
          console.log(`${event.member.clientId} joined`);
          break;
        case PresenceEventType.Leave:
          console.log(`${event.member.clientId} left`);
          break;
        case PresenceEventType.Update:
          console.log(`${event.member.clientId} updated their status`);
          break;
      }
    },
  });

  if (error) {
    return <p>Error loading presence: {error.message}</p>;
  }

  return (
    <div>
      <h3>Online ({presenceData.length})</h3>
      <ul>
        {presenceData.map((member) => (
          <li key={member.clientId}>
            {member.clientId}
            {member.data?.status && ` (${member.data.status})`}
          </li>
        ))}
      </ul>
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
- [useOccupancy](https://ably.com/docs/chat/api/react/use-occupancy.md): API reference for the useOccupancy hook in the Ably Chat React SDK.
- [useTyping](https://ably.com/docs/chat/api/react/use-typing.md): API reference for the useTyping hook in the Ably Chat React SDK.
- [useRoomReactions](https://ably.com/docs/chat/api/react/use-room-reactions.md): API reference for the useRoomReactions hook in the Ably Chat React SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
