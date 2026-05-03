# Rooms

Rooms are used to organize and logically separate your users and chat messages into 'rooms'. They are the entry object into using chat and provide access to all other chat features, such as messages, online status and typing indicators. A room can represent a 1:1 chat between an agent and a customer, a private message between two users in a chat application, a large group conversation, or the chat section of a livestream with thousands of users.

## Relationship between rooms and channels 

It is important to note that each room is backed by a single Ably Pub/Sub channel. You may need to be aware of this when using some [integrations](https://ably.com/docs/chat/integrations.md) with Ably, such as the [Pulsar](https://ably.com/docs/platform/integrations/streaming/pulsar.md#creating-pulsar-rule) connectors, or if you are operating in an environment where a Chat SDK is not available.

The channel name is the same as the room name with an appended suffix of `::$chat` (e.g `some-room-id::$chat`). In most cases, you will not need to worry about this, as the Chat SDK handles the channel creation and management for you and capabilities can be configured at the room level.

### Message persistence 

Chat room channels have persistence enabled by default with a retention period of 30 days. This ensures that messages are automatically stored and can be retrieved using the [history feature](https://ably.com/docs/chat/rooms/history.md).

The default 30-day retention period can be extended up to 365 days by [contacting us](https://ably.com/support). This automatic persistence is essential for supporting features such as [message updates](https://ably.com/docs/chat/rooms/messages.md#update), [message deletions](https://ably.com/docs/chat/rooms/messages.md#delete), and [message reactions](https://ably.com/docs/chat/rooms/message-reactions.md), all of which require access to previously sent messages.

## Use a room 

Users send messages to a room and subscribe to the room in order to receive messages.

<If lang="javascript,swift,kotlin,android">
To get an instance of a chat room, use the <If lang="javascript">[`rooms.get()`](https://ably.com/docs/chat/api/javascript/rooms.md#get)</If><If lang="swift">[`rooms.get()`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/rooms/get%28named%3Aoptions%3A%29)</If><If lang="kotlin,android">[`rooms.get()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-rooms/get.html)</If> method. It will create a new room instance if one doesn't already exist, or return the existing one if it does.
</If>

<If lang="react">
The [`ChatRoomProvider`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/functions/chat-react.ChatRoomProvider.html) provides access to a specific chat room to all child components in the component tree.

Pass in the name of the room to use. If you need to provide further feature configuration, such as enabling occupancy messages, you can pass in an optional [`RoomOptions`](https://ably.com/docs/chat/api/javascript/rooms.md#get-params) object to the provider.

<Aside data-type='note'>
All components that utilize chat feature hooks must be children of a `ChatRoomProvider`. This includes `useRoom`, [`useMessages`](https://ably.com/docs/chat/rooms/messages.md), [`useOccupancy`](https://ably.com/docs/chat/rooms/occupancy.md), [`usePresence`](https://ably.com/docs/chat/rooms/presence.md), [`usePresenceListener`](https://ably.com/docs/chat/rooms/presence.md), [`useRoomReactions`](https://ably.com/docs/chat/rooms/reactions.md) and [`useTyping`](https://ably.com/docs/chat/rooms/typing.md).
</Aside>
</If>


<Code>

### Javascript

```
const room = await chatClient.rooms.get('basketball-stream', {occupancy: {enableEvents: true}});
```

### React

```
import * as Ably from 'ably';
import { LogLevel } from '@ably/chat';
import { ChatClientProvider, ChatRoomProvider } from '@ably/chat/react';

const realtimeClient = new Ably.Realtime({ key: 'your-api-key', clientId: 'clientId' });
const chatClient = new ChatClient(realtimeClient);

const App = () => {
  return (
    <ChatClientProvider client={chatClient}>
      <ChatRoomProvider
        name="my-room-id"
        options={{occupancy: {enableEvents: true}}}
      >
        <RestOfYourApp />
      </ChatRoomProvider>
    </ChatClientProvider>
  );
};
```

### Swift

```
let room = try await chatClient.rooms.get(named: "basketball-stream", options: .init(occupancy: .init(enableEvents: true)))
```

### Kotlin

```
val room = chatClient.rooms.get(roomId = "basketball-stream")
```

### Android

```
val room = chatClient.rooms.get(roomId = "basketball-stream")
```
</Code>

<If lang="react">
<Aside data-type='important'>
The [`ChatClientProvider`](https://ably.com/docs/chat/setup.md#instantiate) does not memoize values passed to the `options` parameter.
If the value changes between re-renders then the room will be discarded and recreated with the new options. To prevent a parent component re-render causing the `ChatRoomProvider` to re-render, either memoize or provide a stable reference to your room options.
</Aside>
</If>

<If lang="javascript,swift,kotlin,android">

When you create or retrieve a room using `rooms.get()`, you can provide custom configuration for some features for that room by passing a <If lang="javascript">[`RoomOptions`](https://ably.com/docs/chat/api/javascript/rooms.md#get-params)</If><If lang="swift">[`RoomOptions`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/roomoptions)</If><If lang="kotlin,android">[`RoomOptions`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-room-options/index.html)</If> object as the second argument. If you do not provide a `RoomOptions` object, the default settings will be used.

<Code>

### Javascript

```
const options: RoomOptions = {
  typing: {
    heartbeatThrottleMs: 5000,
  },
  presence: {
    enableEvents: true,
  },
  occupancy: {
    enableEvents: true,
  },
};
const room = await chatClient.rooms.get('basketball-stream', options);
```

### Swift

```
let presence = PresenceOptions(enableEvents: false)
let typing = TypingOptions(heartbeatThrottle: 5.0) // seconds
// using defaults for reactions and occupancy
let options = RoomOptions(presence: presence, typing: typing, occupancy: .init())
let room = try await chatClient.rooms.get(named: "basketball-stream", options: options)
```

### Kotlin

```
val room = chatClient.rooms.get(roomId = "basketball-stream") {
  typing {
    heartbeatThrottle = 5.seconds
  }
  presence {
    enableEvents = true
  }
  occupancy {
    enableEvents = true
  }
}
```

### Android

```
val room = chatClient.rooms.get(roomId = "basketball-stream") {
  typing {
    heartbeatThrottle = 5.seconds
  }
  presence {
    enableEvents = true
  }
  occupancy {
    enableEvents = true
  }
}
```
</Code>

The details of the options available to each feature are documented on their respective pages:

| Feature | `RoomOption` | Default settings |
| ------- | ------------ | ---------------- |
| [Presence](https://ably.com/docs/chat/rooms/presence.md) | `presence.enableEvents` | `true` |
| [Occupancy](https://ably.com/docs/chat/rooms/occupancy.md) | `occupancy.enableEvents` | `false` |
| [Typing indicators](https://ably.com/docs/chat/rooms/typing.md) | `typing.heartbeatThrottleMs` | `10000` |

</If>

### Release a room 

Releasing a room allows the underlying resources to be garbage collected or released.

Releasing a room may be optional for many applications. If you have multiple transient rooms, such as in the case of a 1:1 support chat, then it may be more beneficial. Also, proactively disconnecting rather than waiting for the standard two-minute timeout can help reduce costs and improve performance.

<If lang="javascript,swift,kotlin,android">
Once <If lang="javascript">[`rooms.release()`](https://ably.com/docs/chat/api/javascript/rooms.md#release)</If><If lang="swift">[`rooms.release()`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/rooms/release%28named%3A%29)</If><If lang="kotlin,android">[`rooms.release()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-rooms/release.html)</If> has been called, the room will be unusable and a new instance will need to be created using [`rooms.get()`](#create) if you want to reuse it.

<Code>

#### Javascript

```
await rooms.release('basketball-stream');
```

#### Swift

```
try await rooms.release(named: "basketball-stream")
```

#### Kotlin

```
rooms.release("basketball-stream")
```

#### Android

```
rooms.release("basketball-stream")
```
</Code>
</If>

<If lang="javascript">
Note that any unresolved promises from `rooms.get()` will be rejected when `rooms.release()` is called.
</If>

<If lang="react">
By default the `ChatRoomProvider` will automatically call [`release()`](https://ably.com/docs/chat/api/javascript/rooms.md#release) on the room when it unmounts. Set the [`release`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/interfaces/chat-react.ChatRoomProviderProps.html#release) property to `false` to change this behavior and have the room only [detach](#detach) when the component unmounts. You can manually control this attachment behavior using the [`useRoom`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/functions/chat-react.useRoom.html) hook.
</If>

## Attach to a room 

To start receiving messages and events from a room, you need to attach to it. Attaching to a room tells Ably to start streaming messages to the client, and ensures that events are not missed in case of temporary network interruptions.

<If lang="javascript,swift,kotlin,android">
Once an instance of a room has been created using `rooms.get()`, clients attach to it to start receiving messages and events from the room.

Use the <If lang="javascript">[`attach()`](https://ably.com/docs/chat/api/javascript/room.md#attach)</If><If lang="swift">[`attach()`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/room/attach%28%29)</If><If lang="kotlin,android">[`attach()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-room/attach.html)</If> method on a room to attach to it:
</If>

<If lang="react">
The first `ChatRoomProvider` for a given room will automatically call [`attach()`](https://ably.com/docs/chat/api/javascript/room.md#attach) on the room when it first mounts. Equally, the last `ChatRoomProvider` for a given room will automatically call [`detach()`](https://ably.com/docs/chat/api/javascript/room.md#detach) on the room when it unmounts. You can also call `attach()` and `detach()` manually using the [`useRoom`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/functions/chat-react.useRoom.html) hook.
</If>

<Code>

### Javascript

```
await room.attach();
```

### React

```
import { useRoom } from '@ably/chat/react';

const MyComponent = () => {
  const { attach } = useRoom();
  return (
    <div>
      <button onClick={attach}>Attach Me!</button>
    </div>
  );
};
```

### Swift

```
try await room.attach()
```

### Kotlin

```
room.attach()
```

### Android

```
room.attach()
```
</Code>

<Aside data-type="usp">
Resilient room state.

Rooms maintain their state during temporary disruptions, with all messages received in correct order and [zero message loss](https://ably.com/docs/platform/architecture/connection-recovery.md).
</Aside>

As soon as a client is attached to a room, Ably will begin streaming messages and events to them. To receive the messages and events in your application code, you need to add listeners to the events that you are interested in by subscribing, for example using the [`messages.subscribe()`](https://ably.com/docs/chat/rooms/messages.md#subscribe) method. Add listeners before attaching to avoid missing any messages or events.

<Aside data-type='note'>
  Attaching to a room is simply a way for the client to tell Ably that this client is interested in receiving messages and events from the room. It is not a persistent state and it does not confer membership to the room. Rooms are only attached for the duration of the connection.

  Ably Chat currently does not offer a room membership feature where clients belong to rooms long-term. Ably Chat does provide [presence](https://ably.com/docs/chat/rooms/presence.md), which is a way to share information about the users currently in a room, for example to share a status message or a profile picture.
</Aside>

### Detach from a room 

<If lang="javascript,swift,kotlin,android">
Use the <If lang="javascript">[`detach()`](https://ably.com/docs/chat/api/javascript/room.md#detach)</If><If lang="swift">[`detach()`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/room/detach%28%29)</If><If lang="kotlin,android">[`detach()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-room/detach.html)</If> method on a room to detach from it and stop receiving messages and events:

<Code>

#### Javascript

```
await room.detach();
```

#### Swift

```
try await room.detach()
```

#### Kotlin

```
room.detach()
```

#### Android

```
room.detach()
```
</Code>
</If>

<If lang="react">
By default the `ChatRoomProvider` will automatically call [`release()`](https://ably.com/docs/chat/api/javascript/rooms.md#release) on the room when it unmounts. Set the [`release`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/interfaces/chat-react.ChatRoomProviderProps.html#release) property to `false` to change this behavior and have the room only [detach](#detach) when the component unmounts. You can manually control this attachment behavior using the [`useRoom`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/functions/chat-react.useRoom.html) hook.

Note that automatically detaching from a room will only happen if [`attach`](#attach) is also set to `true`.
</If>

If a client detaches from a room without de-registering any of their listeners, they can subsequently re-attach at a later point and their listeners will continue to receive messages and events.

## Room status 

Monitoring the status of a room enables you to track its lifecycle and react accordingly.

A room can have any of the following statuses:

| Status | Description |
| ------ | ----------- |
| `initializing` | The library is initializing the room. This status is only used for React when the room has not yet resolved. |
| `initialized` | The room has been initialized, but no attach has been attempted yet. |
| `attaching` | An attach has been initiated by sending a request to Ably. This is a transient status and will be followed either by a transition to attached, suspended, or failed. |
| `attached` | An attach has succeeded. In the attached status a client can publish and subscribe to messages, and enter the presence set. |
| `detaching` | A detach has been initiated on the attached room by sending a request to Ably. This is a transient status and will be followed either by a transition to detached or failed. |
| `detached` | The room has been detached by the client. |
| `suspended` | The room, having previously been attached, has lost continuity. This is normally due to the client being disconnected from Ably for more than two minutes. The client will automatically attempt to reattach as soon as connectivity is restored. |
| `failed` | An indefinite failure condition. This status is entered if an error has been received from Ably, such as an attempt to attach without the necessary access rights. |

<If lang="javascript,swift,kotlin,android">
Use the <If lang="javascript">[`status`](https://ably.com/docs/chat/api/javascript/room.md#onStatusChange)</If><If lang="swift">[`status`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/roomstatus)</If><If lang="kotlin,android">[`status`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-room/status.html)</If> property to check which status a room is currently in:
</If>

<If lang="react">
Use the `roomStatus` property to view the current [`Room`](https://ably.com/docs/chat/api/javascript/room.md) status changes. The `roomError` property is its associated error. Any hooks that take an optional listener have these properties available in their response, such as `useMessages` or `useTyping`. It is more common that you will monitor the room status in the specific feature hooks rather than needing to use `useRoom`. These events are related to the room instance of the nearest [`ChatRoomProvider`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/functions/chat-react.ChatRoomProvider.html). For example, with the `useMessages` hook:
</If>

<Code>

### Javascript

```
const currentStatus = room.status;

// The error related to the current room status
const currentError = room.error;
```

### React

```
import { useMessages } from '@ably/chat/react';

const MyComponent = () => {
  const { roomStatus, roomError } = useMessages({
    listener: (message) => {
      console.log('Received message: ', message);
    },
  });

  return (
    <div>
      Room status is: {roomStatus}
      Room error is: {roomError}
    </div>
  );
};
```

### Swift

```
let status = room.status
```

### Kotlin

```
val status = room.status
```

### Android

```
val status = room.status
```
</Code>

<If lang="javascript,swift,kotlin">
You can also subscribe to room status updates by registering a listener. An event will be emitted whenever the status of the room changes.

Use the <If lang="javascript">[`room.onStatusChange()`](https://ably.com/docs/chat/api/javascript/room.md#onStatusChange)</If><If lang="swift">[`room.onStatusChange()`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/room/onstatuschange%28%29-s9g)</If><If lang="kotlin">[`room.onStatusChange()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-room/on-status-change.html)</If> method in a room to register a listener for status change updates:
</If>

<If lang="android">
Use the [`collectAsStatus()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/jetpack/chat-extensions-compose/com.ably.chat.extensions.compose/collect-as-status.html) extension function to observe room status changes reactively in Jetpack Compose:
</If>

<Code>

### Javascript

```
const { off } = room.onStatusChange((change) =>
console.log(change));
```

### Swift

```
let statusSubscription = room.onStatusChange()
for await status in statusSubscription {
  print("Room status: \(status)")
}
```

### Kotlin

```
val (off) = room.onStatusChange { statusChange: RoomStatusChange ->
    println(statusChange.toString())
}
```

### Android

```
import androidx.compose.material.*
import androidx.compose.runtime.*
import com.ably.chat.Room
import com.ably.chat.extensions.compose.collectAsStatus

@Composable
fun MyComponent(room: Room) {
  val roomStatus by room.collectAsStatus()

  LaunchedEffect(roomStatus) {
    println("Room status changed to: $roomStatus")
  }

  Text("Room status: $roomStatus")
}
```
</Code>

<If lang="javascript,kotlin">
Use the `off()` function returned in the `onStatusChange()` response to remove a room status listener:
</If>


<If lang="javascript,kotlin">
<Code>

### Javascript

```
off();
```

### Kotlin

```
off()
```
</Code>
</If>

<If lang="react">
Listeners can also be registered to monitor the changes in room status. Any hooks that take an optional listener to monitor their events, such as typing indicator events in the `useTyping` hook, can also register a status change listener. Changing the value provided for a listener will cause the previously registered listener instance to stop receiving events. All messages will be received by exactly one listener.

<Code>

### React

```
import { useOccupancy } from '@ably/chat/react';

const MyComponent = () => {
  useOccupancy({
    onRoomStatusChange: (roomStatusChange) => {
      console.log('Room status change:', roomStatusChange);
    },
    onDiscontinuity: (error) => {
      console.log('Discontinuity detected:', error);
    },
  });
  return <div>Occupancy Component</div>;
};
```
</Code>
</If>

## Related Topics

- [SDK setup](https://ably.com/docs/chat/setup.md): Install, authenticate and instantiate the Chat SDK.
- [Authentication](https://ably.com/docs/chat/authentication.md): Configure authentication for Chat applications with the required capabilities.
- [Connections](https://ably.com/docs/chat/connect.md): Manage the realtime connections to Ably.
- [Integrations](https://ably.com/docs/chat/integrations.md): Ably Chat integrations with external services.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
