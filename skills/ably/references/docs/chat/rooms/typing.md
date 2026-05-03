# Typing indicators

Typing indicators enable you to display which users are currently writing a message in a room. This feature can be used to display a message such as *Sandi is typing...*, or when a certain threshold is reached you could instead display *Multiple people are typing...* or *12 people are typing...*. Typing events are emitted whenever a user starts or stops typing.

## Subscribe to typing events 

<If lang="javascript,swift,kotlin">
Subscribe to typing events by registering a listener. Typing events can be emitted when a user starts typing, and when they stop typing. Use the <If lang="javascript">[`typing.subscribe()`](https://ably.com/docs/chat/api/javascript/typing.md#subscribe)</If><If lang="swift">[`typing.subscribe()`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/typing/subscribe%28%29-7uox7)</If><If lang="kotlin">[`typing.subscribe()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-typing/subscribe.html)</If> method in a room to receive these updates:
</If>

<If lang="android">
Use the [`collectAsCurrentlyTyping()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/jetpack/chat-extensions-compose/com.ably.chat.extensions.compose/collect-as-currently-typing.html) extension function to observe typing changes reactively in Jetpack Compose:
</If>

<If lang="react">
Subscribe to typing events with the [`useTyping`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/functions/chat-react.useTyping.html) hook. Supply an optional listener to receive the typing events, or use the [`currentlyTyping`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/interfaces/chat-react.UseTypingResponse.html#currentlyTyping) property returned by the hook to access the list of those users that are currently typing.
</If>

<Code>

### Javascript

```
const {unsubscribe} = room.typing.subscribe((event) => {
  console.log("Currently typing: ", event.currentlyTyping);
});
```

### React

```
import { useTyping } from '@ably/chat/react';
import { TypingSetEvent } from '@ably/chat';

const MyComponent = () => {
  const { currentlyTyping, roomError } = useTyping({
    listener: (typingEvent: TypingSetEvent) => {
      console.log('Typing event received: ', typingEvent);
    },
  });

  return (
    <div>
      {roomError && <p>Typing Error: {roomError.message}</p>}
      <p>Currently typing: {Array.from(currentlyTyping).join(', ')}</p>
    </div>
  );
};
```

### Swift

```
let typingSubscription = room.typing.subscribe()
for await typing in typingSubscription {
  typingInfo = typing.currentlyTyping.isEmpty ? "" :
                "Typing: \(typing.currentlyTyping.joined(separator: ", "))..."
}
```

### Kotlin

```
val subscription = room.typing.subscribe { event: TypingSetEvent ->
    println("currently typing: ${event.currentlyTyping}")
}
```

### Android

```
import androidx.compose.material.*
import androidx.compose.runtime.*
import com.ably.chat.Room
import com.ably.chat.extensions.compose.collectAsCurrentlyTyping

@Composable
fun TypingComponent(room: Room) {
  val currentlyTyping by room.collectAsCurrentlyTyping()

  Text("Currently typing: ${currentlyTyping.joinToString(", ")}")
}
```
</Code>

### Typing event structure 

The following is the structure of a typing event:

<Code>

#### Json

```
{
  "type": "typing.set.changed",
  "currentlyTyping": ["clemons", "zoranges"],
  "currentTypers": [
    { "clientId": "clemons", "userClaim": "{\"display_name\":\"Clem\"}" },
    { "clientId": "zoranges" }
  ],
  "change": {
    "type": "typing.started",
    "clientId": "clemons",
    "userClaim": "{\"display_name\":\"Clem\"}"
  }
}
```
</Code>

The following are the properties of a typing event:

| Property | Description | Type |
|----------|-------------|------|
| `type` | The type of the event. | `String` |
| `currentlyTyping` | A set of all `clientId`s currently typing. Deprecated: use `currentTypers` instead. | `Set` |
| `currentTypers` | An array of users currently typing, with associated metadata including `clientId` and `userClaim`. | `Array` |
| `change` | The single change that resulted in the event. | `Object` |
| `change.type` | The type of change that occurred. | `String` |
| `change.clientId` | The `clientId` of the user that triggered the change. | `String` |
| `change.userClaim` | A server-signed [user claim](https://ably.com/docs/chat/setup.md#user-claims) attached to this typing event, derived from the user's [JWT](https://ably.com/docs/chat/setup.md#set-user-claims). | `String` (optional) |

You can use the size of the `currentlyTyping` set to decide whether to display individual user names, or that multiple people are typing in your user interface.

### Unsubscribe from typing events 

<If lang="javascript,kotlin">
Use the `unsubscribe()` function returned in the `subscribe()` response to remove a typing listener:
</If>

<If lang="android">
Jetpack Compose automatically handles lifecycle and cleanup when using `collectAsCurrentlyTyping()`.
</If>

<If lang="swift">
You don't need to handle removing listeners, as this is done automatically by the SDK.
</If>

<If lang="react">
When you unmount the component that is using the `useTyping` hook, it will automatically handle unsubscribing any associated listeners registered for typing events.
</If>

<If lang="javascript,kotlin">
<Code>

#### Javascript

```
// Initial subscription
import { TypingSetEvent } from '@ably/chat';
const { unsubscribe } = room.typing.subscribe((event: TypingSetEvent) => {
  console.log('Typing event received: ', event);
});

// To remove the listener
unsubscribe();
```

#### Kotlin

```
// Initial subscription
val (unsubscribe) = room.typing.subscribe { event ->
  println("Typing event received: $event")
}

// To remove the listener
unsubscribe()
```
</Code>
</If>

## Set typing status 

<If lang="javascript,swift,kotlin,android">
Use the <If lang="javascript">[`typing.keystroke()`](https://ably.com/docs/chat/api/javascript/typing.md#keystroke)</If><If lang="swift">[`typing.keystroke()`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/typing/keystroke%28%29)</If><If lang="kotlin,android">[`typing.keystroke()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-typing/keystroke.html)</If> method to emit a typing event with `type` set to `typing.started`.
</If>

<If lang="react">
Use the [`keystroke()`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/interfaces/chat-react.UseTypingResponse.html#keystroke) method available from the response of the `useTyping` hook to emit an event when a user has started typing.
</If>

<Code>

### Javascript

```
await room.typing.keystroke();
```

### React

```
import { useTyping } from '@ably/chat/react';

const MyComponent = () => {
  const { keystroke, currentlyTyping, roomError } = useTyping();
  const handleKeystrokeClick = () => {
    keystroke();
  };

  return (
    <div>
      {roomError && <p>Typing Error: {roomError.message}</p>}
      <button onClick={handleKeystrokeClick}>Start Typing</button>
      <p>Currently typing: {Array.from(currentlyTyping).join(', ')}</p>
    </div>
  );
};
```

### Swift

```
try await room.typing.keystroke()
```

### Kotlin

```
room.typing.keystroke()
```

### Android

```
import androidx.compose.material.*
import androidx.compose.runtime.*
import com.ably.chat.Room
import kotlinx.coroutines.launch

@Composable
fun TypingKeystrokeComponent(room: Room) {
  val coroutineScope = rememberCoroutineScope()
  var text by remember { mutableStateOf("") }

  TextField(
    value = text,
    onValueChange = { newText ->
      text = newText
      coroutineScope.launch {
        room.typing.keystroke()
      }
    },
    label = { Text("Type a message") }
  )
}
```
</Code>

<If lang="javascript,swift,kotlin,android">
Use the <If lang="javascript">[`stop()`](https://ably.com/docs/chat/api/javascript/typing.md#stop)</If><If lang="swift">[`stop()`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/typing/stop%28%29)</If><If lang="kotlin,android">[`stop()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-typing/stop.html)</If> method to emit a typing event with `type` set to `typing.stopped`.
</If>

<If lang="react">
Use the [`stop()`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/interfaces/chat-react.UseTypingResponse.html#stop) method available from the response of the `useTyping` hook to emit an event when a user has stopped typing.
</If>

<Code>

### Javascript

```
await room.typing.stop();
```

### React

```
import { useTyping } from '@ably/chat/react';

const MyComponent = () => {
  const { stop, roomError } = useTyping();
  const handleStopClick = () => {
    stop();
  };

  return (
    <div>
      {roomError && <p>Typing Error: {roomError.message}</p>}
      <button onClick={handleStopClick}>Stop Typing</button>
    </div>
  );
};
```

### Swift

```
try await room.typing.stop()
```

### Kotlin

```
room.typing.stop()
```

### Android

```
import androidx.compose.material.*
import androidx.compose.runtime.*
import com.ably.chat.Room
import kotlinx.coroutines.launch

@Composable
fun StopTypingComponent(room: Room) {
  val coroutineScope = rememberCoroutineScope()

  Button(onClick = {
    coroutineScope.launch {
      room.typing.stop()
    }
  }) {
    Text("Stop Typing")
  }
}
```
</Code>

### Typing Event Frequency 

The Typing feature includes a configurable timer that controls how often typing events are sent to the server. This timer is reset each time a new typing event is sent, it works as follows:
* On the **first call** to `keystroke()`, the timer is set and an event is sent to the server.
* **Subsequent calls** before the timer expires result in a no-op.
* After the timer expires, a new typing event is sent and the timer is reset.
* If `stop()` is called, the timer is reset and a `typing.stopped` event is sent to the server.

You can configure the length of this timer using the `heartbeatThrottleMs` parameter in `RoomOptions` (default: **10,000ms**).
It is recommended that you call `keystroke()` with every keypress, and the SDK will handle when and if to send a typing indicator to the server.

### Emulating User Behavior 

You can emulate user behavior (e.g., in chatbots) by setting a timeout to call `keystroke()` at intervals equal to the `heartbeatThrottleMs` plus a small delay, e.g. 200ms. This will ensure the typing indicator remains active.

### Grace Period for Typing Events 

For the recipient of typing events:
* The typing indicator remains active for the **duration** defined by the `heartbeatThrottleMs` parameter, plus a predefined **2000ms grace period**.
* Receiving a new typing event before the grace period ends will reset the timeout.
* If the grace period ends without receiving a new typing event, the SDK will emit a `typing.stopped` event for that client to any subscribed listeners.

**For example:** With the `heartbeatThrottleMs` set to **10,000ms**, the typing indicator remains active for **12,000ms**. If no new typing event is received within this time, the SDK will emit a `typing.stopped` event.

### Adjusting the Event Frequency 

You can adjust the `heartbeatThrottleMs` parameter to balance responsiveness and resource costs:
* **Increase responsiveness**: Lower the value → More typing events are sent to the server → Higher cost as more messages are sent.
* **Save resource costs**: Raise the value → Fewer typing events are sent to the server → Lower responsiveness, but less cost as fewer messages are sent overall.

This balance allows you to optimize cost and responsiveness based on your applications needs.

<Aside data-type='note'>
All clients in a room must have the same timeout value configured. If not, typing indicators might not display correctly.
</Aside>

## Retrieve a list of users that are currently typing 

<If lang="javascript">
Use the [`typing.currentTypers`](https://ably.com/docs/chat/api/javascript/typing.md#properties) property to retrieve the users that are currently typing in the room:
</If>

<If lang="react">
Use the [`currentTypers`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/interfaces/chat-react.UseTypingResponse.html#currentTypers) property available from the response of the `useTyping` hook to view the users that are currently typing in the room:
</If>

<If lang="swift,kotlin,android">
Use the <If lang="swift">[`typing.current`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/typing/current)</If><If lang="kotlin,android">[`typing.current`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-typing/current.html)</If> property to retrieve a set of `clientId`s for all users that are currently typing in the room:
</If>

<Code>

### Javascript

```
const currentlyTyping = room.typing.currentTypers;
```

### React

```
import { useTyping } from '@ably/chat/react';

const MyComponent = () => {
  const { currentTypers } = useTyping();

  return (
    <div>
      <p>Currently typing: {currentTypers.map((typer) => typer.clientId).join(', ')}</p>
    </div>
  );
};
```

### Swift

```
let currentlyTypingClientIds = room.typing.current
```

### Kotlin

```
val currentlyTypingClientIds = room.typing.current
```

### Android

```
val currentlyTypingClientIds = room.typing.current
```
</Code>

## Related Topics

- [Messages](https://ably.com/docs/chat/rooms/messages.md): Send, update, delete, and receive messages in chat rooms.
- [Message history](https://ably.com/docs/chat/rooms/history.md): Retrieve previously sent messages from history.
- [Presence](https://ably.com/docs/chat/rooms/presence.md): Use presence to see which users are online and their user status.
- [Occupancy](https://ably.com/docs/chat/rooms/occupancy.md): Use occupancy to see how many users are in a room.
- [Message reactions](https://ably.com/docs/chat/rooms/message-reactions.md): React to chat messages
- [Room reactions](https://ably.com/docs/chat/rooms/reactions.md): Enable users to send reactions at the room level, based on what is happening in your application, such as a goal being scored in your livestream.
- [Share media](https://ably.com/docs/chat/rooms/media.md): Share media such as images, videos, or files in a chat room.
- [Message replies](https://ably.com/docs/chat/rooms/replies.md): Add reply functionality to messages in a chat room.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
