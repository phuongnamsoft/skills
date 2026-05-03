# Occupancy

Occupancy enables you to view the number of users currently online in a room. This feature can be used to display user counts to highlight popular, or trending chat rooms.

<Aside data-type='note'>
Occupancy generates messages on any client entering/leaving a room, and so increases the number of billable messages sent in a room - as such, it is disabled by default and needs to be [enabled](https://ably.com/docs/chat/rooms.md#create) when creating or retrieving a room.
</Aside>

## Subscribe to room occupancy 

<If lang="javascript,swift,kotlin">
Subscribe to a room's occupancy by registering a listener. Occupancy events are emitted whenever the number of online users within a room changes. Use the <If lang="javascript">[`occupancy.subscribe()`](https://ably.com/docs/chat/api/javascript/occupancy.md#subscribe)</If><If lang="swift">[`occupancy.subscribe()`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/occupancy/subscribe%28%29-3loon)</If><If lang="kotlin">[`occupancy.subscribe()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-occupancy/subscribe.html)</If> method in a room to receive updates:
</If>

<If lang="android">
Use the [`collectAsOccupancy()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/jetpack/chat-extensions-compose/com.ably.chat.extensions.compose/collect-as-occupancy.html) extension function to observe occupancy changes reactively in Jetpack Compose:
</If>

<If lang="react">
Subscribe to a room's occupancy with the [`useOccupancy`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/functions/chat-react.useOccupancy.html) hook.
</If>

<Code>

### Javascript

```
const {unsubscribe} = room.occupancy.subscribe((event) => {
  console.log(event);
});
```

### React

```
import { useOccupancy } from '@ably/chat/react';

const MyComponent = () => {
  const { connections, presenceMembers } = useOccupancy({
    listener: (occupancyEvent) => {
      console.log('Number of users connected is: ', occupancyEvent.occupancy.connections);
      console.log('Number of members present is: ', occupancyEvent.occupancy.presenceMembers);
    },
  });
  return (
    <div>
      <p>Number of users connected is: {connections}</p>
      <p>Number of members present is: {presenceMembers}</p>
    </div>
  );
};
```

### Swift

```
let occupancySubscription = room.occupancy.subscribe()
for await event in occupancySubscription {
  occupancyInfo = "Connections: \(event.occupancy.presenceMembers) (\(event.occupancy.connections))"
}
```

### Kotlin

```
val subscription = room.occupancy.subscribe { event: OccupancyEvent ->
    println("Number of users connected is: ${event.occupancy.connections}")
    println("Number of members present is: ${event.occupancy.presenceMembers}")
}
```

### Android

```
import androidx.compose.material.*
import androidx.compose.runtime.*
import com.ably.chat.Room
import com.ably.chat.extensions.compose.collectAsOccupancy

@Composable
fun OccupancyComponent(room: Room) {
  val occupancy by room.collectAsOccupancy()

  Text("Number of users connected: ${occupancy.connections}")
  Text("Number of members present: ${occupancy.presenceMembers}")
}
```
</Code>

<Aside data-type='note'>
Occupancy events are debounced for a maximum of 15 seconds. However, if a mode change occurs, the change is emitted immediately. For example, if at least one connection is established where none existed before.
</Aside>

### Occupancy event structure

The following is the structure of an occupancy event:

<If lang="javascript,react">
<Code>

#### Json

```
{
  "type": "occupancy.updated",
  "occupancy": {
    "connections": 103,
    "presenceMembers": 95
  }
}
```
</Code>
</If>

<If lang="kotlin,swift,android">
<Code>

#### Json

```
{
  "connections": 103,
  "presenceMembers": 95
}
```
</Code>
</If>

The following are the properties of an occupancy event:


<If lang="javascript,react">

| Property | Description | Type |
| -------- | ----------- | ---- |
| `type` | The type of the occupancy event. | `String` |
| `occupancy` | The occupancy data for the room. | `OccupancyData` |
| `occupancy.connections` | The number of connections in the room. | `Number` |
| `occupancy.presenceMembers` | The number of users entered into the [presence set](https://ably.com/docs/chat/rooms/presence.md) of the room. | `Number` |

</If>

<If lang="kotlin,swift,android">

| Property | Description | Type |
| -------- | ----------- | ---- |
| `connections` | The number of connections in the room. | `Number` |
| `presenceMembers` | The number of users entered into the [presence set](https://ably.com/docs/chat/rooms/presence.md) of the room. | `Number` |

</If>


<Aside data-type='note'>
A user is counted for every device that they are in the room with. For example, if a user enters a room on their phone and their desktop, this counts as two connections. Similarly if they enter into presence for the room on both devices, this also counts as two unique presence members.
</Aside>

### Unsubscribe from room occupancy

<If lang="javascript,kotlin">
Use the `unsubscribe()` function returned in the `subscribe()` response to remove a room occupancy listener:
</If>

<If lang="android">
Jetpack Compose automatically handles lifecycle and cleanup when using `collectAsOccupancy()`.
</If>

<If lang="swift">
You don't need to handle removing listeners, as this is done automatically by the SDK.
</If>

<If lang="react">
When you unmount the component that is using the `useOccupancy` hook, it will automatically handle unsubscribing any associated listeners registered for room occupancy.
</If>

<If lang="javascript,kotlin">
<Code>

#### Javascript

```
// Initial subscription
const { unsubscribe } = room.occupancy.subscribe((event) => {
  console.log(event);
});

// To remove the listener
unsubscribe();
```

#### Kotlin

```
// Initial subscription
val (unsubscribe) = room.occupancy.subscribe { event ->
  println(event)
}

// To remove the listener
unsubscribe()
```
</Code>
</If>

## Current room occupancy

The latest occupancy received in realtime (the same mechanism that powers occupancy subscriptions) can be retrieved in a one-off call.

<If lang="javascript,swift,kotlin,android">

Use the <If lang="javascript">[`occupancy.current`](https://ably.com/docs/chat/api/javascript/occupancy.md#properties)</If><If lang="swift">[`occupancy.current`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/occupancy/current)</If><If lang="kotlin,android">[`occupancy.current`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-occupancy/current.html)</If> property to retrieve the most recently received room occupancy:

<Code>

### Javascript

```
const occupancy = room.occupancy.current;
```

### Swift

```
let occupancy = room.occupancy.current
```

### Kotlin

```
val occupancy = room.occupancy.current
```

### Android

```
val occupancy = room.occupancy.current
```
</Code>
</If>

<If lang="react">
Use the [`connections`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/interfaces/chat-react.UseOccupancyResponse.html#connections) and [`presenceMembers`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/interfaces/chat-react.UseOccupancyResponse.html#presenceMembers) properties available from the response of the `useOccupancy` hook to view the occupancy of a room.
</If>


The following is the structure of the occupancy data:

<Code>

### Json

```
{
  "connections": 103,
  "presenceMembers": 95,
}
```
</Code>

The following are the properties of the occupancy data:

| Property | Description | Type |
| -------- | ----------- | ---- |
| `connections` | The number of connections in the room. | `Number` |
| `presenceMembers` | The number of users entered into the [presence set](https://ably.com/docs/chat/rooms/presence.md) of the room. | `Number` |

## Retrieve room occupancy

<If lang="javascript,swift,kotlin,android">
The occupancy of a room can be retrieved in one-off calls instead of subscribing to updates.

Use the <If lang="javascript">[`occupancy.get()`](https://ably.com/docs/chat/api/javascript/occupancy.md#get)</If><If lang="swift">[`occupancy.get()`](https://sdk.ably.com/builds/ably/ably-chat-swift/main/AblyChat/documentation/ablychat/occupancy/get%28%29)</If><If lang="kotlin,android">[`occupancy.get()`](https://sdk.ably.com/builds/ably/ably-chat-kotlin/main/dokka/chat/com.ably.chat/-occupancy/get.html)</If> method to retrieve the occupancy of a room:

<Code>

### Javascript

```
const occupancy = await room.occupancy.get();
```

### Swift

```
let occupancy = try await room.occupancy.get()
```

### Kotlin

```
val occupancy = room.occupancy.get()
```

### Android

```
val occupancy = room.occupancy.get()
```
</Code>
</If>

<If lang="react">
Use the [`connections`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/interfaces/chat-react.UseOccupancyResponse.html#connections) and [`presenceMembers`](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/interfaces/chat-react.UseOccupancyResponse.html#presenceMembers) properties available from the response of the `useOccupancy` hook to view the occupancy of a room.
</If>

The following is the structure the occupancy data:

<Code>

### Json

```
{
  "connections": 103,
  "presenceMembers": 95,
}
```
</Code>

The following are the properties of an occupancy data:

| Property | Description | Type |
| -------- | ----------- | ---- |
| `connections` | The number of connections in the room. | `Number` |
| `presenceMembers` | The number of users entered into the [presence set](https://ably.com/docs/chat/rooms/presence.md) of the room. | `Number` |

<Aside data-type='note'>
A user is counted for every device that they are in the room with. For example, if a user enters a room on their phone and their desktop, this counts as two connections. Similarly if they enter into presence for the room on both devices, this also counts as two unique presence members.
</Aside>

## Related Topics

- [Messages](https://ably.com/docs/chat/rooms/messages.md): Send, update, delete, and receive messages in chat rooms.
- [Message history](https://ably.com/docs/chat/rooms/history.md): Retrieve previously sent messages from history.
- [Presence](https://ably.com/docs/chat/rooms/presence.md): Use presence to see which users are online and their user status.
- [Message reactions](https://ably.com/docs/chat/rooms/message-reactions.md): React to chat messages
- [Typing indicators](https://ably.com/docs/chat/rooms/typing.md): Display typing indicators in a room so that users can see when someone else is writing a message.
- [Room reactions](https://ably.com/docs/chat/rooms/reactions.md): Enable users to send reactions at the room level, based on what is happening in your application, such as a goal being scored in your livestream.
- [Share media](https://ably.com/docs/chat/rooms/media.md): Share media such as images, videos, or files in a chat room.
- [Message replies](https://ably.com/docs/chat/rooms/replies.md): Add reply functionality to messages in a chat room.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
