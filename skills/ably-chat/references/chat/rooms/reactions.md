# Room reactions

Users can send reactions to the entire chat room to show their sentiment as to what is happening. For example, agreeing with the content in a livestream using a thumbs up, or sending a heart when their team scores in a sports game.

Room reactions are ephemeral and not stored or aggregated by Ably. The intention being that they show the overall sentiment of a room at a point in time.

## Subscribe to room reactions 

<If lang="javascript,swift,kotlin">
Subscribe to room reactions by registering a listener. Use the <If lang="javascript">[`reactions.subscribe()`](https://ably.com/docs/chat/api/javascript/room-reactions.md#subscribe)</If><If lang="swift">[`reactions.subscribe()`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/roomreactions/subscribe%28%29-64gdf)</If><If lang="kotlin">[`reactions.subscribe()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-room-reactions/subscribe.html)</If> method in a room to receive reactions:
</If>

<If lang="android">
Use the [`reactions.asFlow()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/as-flow.html) to receive new room reactions:
</If>

<If lang="react">
Subscribe to room reactions with the [`useRoomReactions`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/functions/chat-react.useRoomReactions.html) hook. Supply an optional listener to receive the room reactions.
</If>

<Code>

### Javascript

```
const {unsubscribe} = room.reactions.subscribe((event) => {
  const reaction = event.reaction;
  console.log(`Received a reaction from ${reaction.clientId} with name ${reaction.name}, and metadata ${reaction.metadata}`);
});
```

### React

```
import React from 'react';
import { useRoomReactions } from '@ably/chat/react';

const MyComponent = () => {
  useRoomReactions({
    listener: (reactionEvent) => {
      console.log('Received reaction: ', reactionEvent.reaction);
    },
  });

  return <div>Room Reactions Component</div>;
};
```

### Swift

```
let reactionSubscription = room.reactions.subscribe()
for await event in reactionSubscription {
  print("Received a reaction of name \(event.reaction.name), and metadata \(event.reaction.metadata)")
}
```

### Kotlin

```
val subscription = room.reactions.subscribe { event: RoomReactionEvent ->
    println("Received a reaction of name ${event.reaction.name} with metadata ${event.reaction.metadata}")
}
```

### Android

```
import androidx.compose.runtime.*
import com.ably.chat.Room
import com.ably.chat.RoomReactionEvent

@Composable
fun RoomReactionsComponent(room: Room) {
  LaunchedEffect(room) {
    room.reactions.asFlow().collect { event: RoomReactionEvent ->
      println("Received a reaction of name ${event.reaction.name} with metadata ${event.reaction.metadata}")
    }
  }
}
```
</Code>

### Room reaction event structure 

The following are the properties of a room reaction event:

| Property | Description | Type |
| -------- | ----------- | ---- |
| `type` | The type of reaction event. | `String` |
| `reaction` | The reaction data. | `Object` |
| `reaction.name` | The name of the reaction, for example a 'like' or a heart emoji. | `String` |
| `reaction.headers` | Optional headers for adding additional information to a reaction. | `Object` |
| `reaction.metadata` | Optional metadata about the reaction, such as an animation or effect. This information is not read by Ably. | `Object` |
| `reaction.createdAt` | The time the reaction was sent. | `Date` |
| `reaction.clientId` | The client identifier of the user that sent the reaction. | `String` |
| `reaction.isSelf` | Will be `true` for the user that sent the reaction. | `Boolean` |
| `reaction.userClaim` | A server-signed [user claim](https://ably.com/docs/chat/setup.md#user-claims) attached to this reaction, derived from the user's [JWT](https://ably.com/docs/chat/setup.md#set-user-claims). | `String` (optional) |

### Unsubscribe from room reactions 

<If lang="javascript,kotlin">
Use the `unsubscribe()` function returned in the `subscribe()` response to remove a room reaction listener:
</If>

<If lang="android">
Jetpack Compose automatically handles lifecycle and cleanup when using `LaunchedEffect` with `asFlow`.
</If>

<If lang="swift">
You don't need to handle removing listeners, as this is done automatically by the SDK.
</If>

<If lang="react">
When you unmount the component that is using the `useRoomReactions` hook, it will automatically handle unsubscribing any associated listeners registered for room reactions.
</If>

<If lang="javascript,kotlin">
<Code>

#### Javascript

```
// Initial subscription
const {unsubscribe} = room.reactions.subscribe((event) => {
  console.log(`Received a reaction of type ${event.reaction.name}, and metadata ${event.reaction.metadata}`);
});

// To remove the listener
unsubscribe();
```

#### Kotlin

```
// Initial subscription
val (unsubscribe) = room.reactions.subscribe { event ->
  println("Received a reaction of type ${event.reaction.name}, and metadata ${event.reaction.metadata}")
}

// To remove the listener
unsubscribe()
```
</Code>
</If>

## Send a room reaction 

<If lang="javascript,swift,kotlin,android">
Use the <If lang="javascript">[`reactions.send()`](https://ably.com/docs/chat/api/javascript/room-reactions.md#send)</If><If lang="swift">[`reactions.send()`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/roomreactions/send%28withparams%3A%29)</If><If lang="kotlin,android">[`reactions.send()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-room-reactions/send.html)</If> method to send a room-level reaction. The most common way of using this method is to trigger it whenever a user clicks an emoji button in a room:
</If>

<If lang="react">
Use the [`sendRoomReaction()`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/interfaces/chat-react.UseRoomReactionsResponse.html#sendroomreaction) method available from the response of the `useRoomReactions` hook to emit an event when a user reacts, for example when they click an emoji button:
</If>

<Code>

### Javascript

```
await room.reactions.send({name: "like"});

await room.reactions.send({name: "heart", metadata: {"effect": "fireworks"}});
```

### React

```
import { useRoomReactions } from '@ably/chat/react';

const MyComponent = () => {
  const { sendRoomReaction } = useRoomReactions();

  const sendLike = () => {
    sendRoomReaction({ name: 'like' });
  };

  return (
    <div>
      <button onClick={sendLike}>Send Like</button>
    </div>
  );
};
```

### Swift

```
try await room.reactions.send(params: .init(name: "like"))

try await room.reactions.send(params: .init(name: "heart",
                              metadata: ["effect": "fireworks"]))
```

### Kotlin

```
room.reactions.send(name = "like")
// import com.ably.chat.json.*
room.reactions.send(name = "heart", metadata = jsonObject {
  put("effect", "fireworks")
})
```

### Android

```
import androidx.compose.material.*
import androidx.compose.runtime.*
import com.ably.chat.Room
import com.ably.chat.json.*
import kotlinx.coroutines.launch

@Composable
fun SendReactionComponent(room: Room) {
  val coroutineScope = rememberCoroutineScope()

  Button(onClick = {
    coroutineScope.launch {
      room.reactions.send(name = "like")
    }
  }) {
    Text("Send Like")
  }

  Button(onClick = {
    coroutineScope.launch {
      room.reactions.send(
        name = "heart",
        metadata = jsonObject {
          put("effect", "fireworks")
        }
      )
    }
  }) {
    Text("Send Heart with Effect")
  }
}
```
</Code>

<Aside data-type="usp">
Cost-efficient reaction batching.

Use [server-side batching](https://ably.com/docs/messages/batch.md#server-side) to group high-frequency room reactions, minimizing message costs while ensuring all participants see reactions in realtime.
</Aside>

## Related Topics

- [Messages](https://ably.com/docs/chat/rooms/messages.md): Send, update, delete, and receive messages in chat rooms.
- [Message history](https://ably.com/docs/chat/rooms/history.md): Retrieve previously sent messages from history.
- [Presence](https://ably.com/docs/chat/rooms/presence.md): Use presence to see which users are online and their user status.
- [Occupancy](https://ably.com/docs/chat/rooms/occupancy.md): Use occupancy to see how many users are in a room.
- [Message reactions](https://ably.com/docs/chat/rooms/message-reactions.md): React to chat messages
- [Typing indicators](https://ably.com/docs/chat/rooms/typing.md): Display typing indicators in a room so that users can see when someone else is writing a message.
- [Share media](https://ably.com/docs/chat/rooms/media.md): Share media such as images, videos, or files in a chat room.
- [Message replies](https://ably.com/docs/chat/rooms/replies.md): Add reply functionality to messages in a chat room.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
