# Message replies

Reply to messages that have been previously sent in the chat room.

Message replies are implemented using the `metadata` field when you [send a message](https://ably.com/docs/chat/rooms/messages.md#send).

## Send a reply 

Use the [`metadata`](https://ably.com/docs/chat/rooms/messages.md#structure) field of a message to store the reply when you [send a message](https://ably.com/docs/chat/rooms/messages.md#send).

You need to at least include the `serial` of the parent message that you're replying to. Other information can be included such as a preview of the text:

<Code>

### Javascript

```
async function sendReply(replyToMessage, replyText) {
  const metadata = {
    reply: {
      serial: replyToMessage.serial,
      timestamp: replyToMessage.timestamp.getTime(),
      clientId: replyToMessage.clientId,
      previewText: replyToMessage.text.substring(0, 140)
    }
  };

  await room.messages.send({
    text: replyText,
    metadata: metadata
  });
}
```

### React

```
import { useMessages } from '@ably/chat/react';

const ReplyComponent = ({ messageToReplyTo }) => {
  const { sendMessage } = useMessages();

  const sendReply = async (replyText) => {
    const metadata = {
      reply: {
        serial: messageToReplyTo.serial,
        timestamp: messageToReplyTo.timestamp.getTime(),
        clientId: messageToReplyTo.clientId,
        previewText: messageToReplyTo.text.substring(0, 140)
      }
    };

    await sendMessage({
      text: replyText,
      metadata: metadata
    });
  };

  return (
    <div>
      <button onClick={() => sendReply("My reply")}>Send Reply</button>
    </div>
  );
};
```

### Swift

```
func sendReply(replyToMessage: Message, replyText: String) async throws {
    let metadata: MessageMetadata = [
        "reply": .object([
            "serial": .string(replyToMessage.serial),
            "timestamp": .number(Double(replyToMessage.timestamp.timeIntervalSince1970 * 1000)),
            "clientId": .string(replyToMessage.clientID),
            "previewText": .string(String(replyToMessage.text.prefix(140)))
        ])
    ]

    try await room.messages.send(withParams: .init(
        text: replyText,
        metadata: metadata
    ))
}
```

### Kotlin

```
import com.ably.chat.json.jsonObject

suspend fun sendReply(replyToMessage: Message, replyText: String) {
    val metadata = jsonObject {
        putObject("reply") {
            put("serial", replyToMessage.serial)
            put("timestamp", replyToMessage.timestamp)
            put("clientId", replyToMessage.clientId)
            put("previewText", replyToMessage.text.take(140))
        }
    }

    room.messages.send(
        text = replyText,
        metadata = metadata
    )
}
```

### Android

```
import androidx.compose.material.*
import androidx.compose.runtime.*
import com.ably.chat.Message
import com.ably.chat.Room
import com.ably.chat.json.jsonObject
import kotlinx.coroutines.launch

@Composable
fun SendReplyComponent(room: Room, messageToReplyTo: Message) {
    val coroutineScope = rememberCoroutineScope()

    Button(onClick = {
        coroutineScope.launch {
            val metadata = jsonObject {
                putObject("reply") {
                    put("serial", messageToReplyTo.serial)
                    put("timestamp", messageToReplyTo.timestamp)
                    put("clientId", messageToReplyTo.clientId)
                    put("previewText", messageToReplyTo.text.take(140))
                }
            }

            room.messages.send(
                text = "My reply",
                metadata = metadata
            )
        }
    }) {
        Text("Send Reply")
    }
}
```
</Code>

<Aside data-type="usp">
Ultra-low latency replies.

Ably achieves a global [median message delivery latency of 37ms](https://ably.com/docs/platform/architecture/latency.md#how-latency-is-measured), ensuring replies appear instantly across all participants.
</Aside>

## Subscribe to message replies 

Message replies will be received as normal messages in the room using the [`subscribe()`](https://ably.com/docs/chat/rooms/messages.md#subscribe) method.

You just need to handle storing and displaying the reply:

### Store reply information 

When a user replies to a message, extract and store the parent message details:

<Code>

#### Javascript

```
function prepareReply(parentMessage) {
  return {
    serial: parentMessage.serial,
    timestamp: parentMessage.timestamp.getTime(),
    clientId: parentMessage.clientId,
    previewText: parentMessage.text.substring(0, 140)
  };
}
```

#### React

```
const prepareReply = (parentMessage) => {
  return {
    serial: parentMessage.serial,
    timestamp: parentMessage.timestamp.getTime(),
    clientId: parentMessage.clientId,
    previewText: parentMessage.text.substring(0, 140)
  };
};
```

#### Swift

```
func prepareReply(parentMessage: Message) -> JSONObject {
    return [
        "serial": .string(parentMessage.serial),
        "timestamp": .number(Double(parentMessage.timestamp.timeIntervalSince1970 * 1000)),
        "clientId": .string(parentMessage.clientID),
        "previewText": .string(String(parentMessage.text.prefix(140)))
    ]
}
```

#### Kotlin

```
import com.ably.chat.json.jsonObject

fun prepareReply(parentMessage: Message) = jsonObject {
    put("serial", parentMessage.serial)
    put("timestamp", parentMessage.timestamp)
    put("clientId", parentMessage.clientId)
    put("previewText", parentMessage.text.take(140))
}
```

#### Android

```
import com.ably.chat.Message
import com.ably.chat.json.jsonObject

fun prepareReply(parentMessage: Message) = jsonObject {
    put("serial", parentMessage.serial)
    put("timestamp", parentMessage.timestamp)
    put("clientId", parentMessage.clientId)
    put("previewText", parentMessage.text.take(140))
}
```
</Code>

If a parent message isn't in local state, fetch it directly using its `serial`:

<Code>

#### Javascript

```
async function fetchParentMessage(replyData) {
  const message = await room.messages.get(replyData.serial);
  return message;
}
```

#### React

```
const FetchParentMessage = ({ replyData }) => {
  const [parentMessage, setParentMessage] = useState();

  useEffect(() => {
    const fetchMessage = async () => {
      const message = await room.messages.get(replyData.serial);
      setParentMessage(message);
    };

    fetchMessage();
  }, [replyData]);

  return parentMessage ? (
    <div>{parentMessage.text}</div>
  ) : null;
};
```

#### Swift

```
func fetchParentMessage(replyData: JSONObject) async throws -> Message {
    guard let serial = replyData["serial"]?.stringValue else {
        throw NSError(domain: "ReplyError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid serial"])
    }
    return try await room.messages.get(withSerial: serial)
}
```

#### Kotlin

```
import com.ably.chat.json.*

suspend fun fetchParentMessage(replyData: JsonObject): Message {
    val serial = (replyData["serial"] as? JsonString)?.value
        ?: throw IllegalArgumentException("Invalid serial")
    return room.messages.get(serial)
}
```

#### Android

```
import androidx.compose.material.*
import androidx.compose.runtime.*
import com.ably.chat.*
import com.ably.chat.json.*

@Composable
fun FetchParentMessageComponent(room: Room, replyData: JsonObject) {
    var parentMessage by remember { mutableStateOf<Message?>(null) }

    LaunchedEffect(replyData) {
        val serial = (replyData["serial"] as? JsonString)?.value
        if (serial != null) {
            parentMessage = room.messages.get(serial)
        }
    }

    parentMessage?.let { message ->
        Text(text = message.text)
    }
}
```
</Code>

### Display replies 

Check incoming messages for reply `metadata` and display accordingly:

<Code>

#### Javascript

```
room.messages.subscribe((messageEvent) => {
  const message = messageEvent.message;

  if (message.metadata?.reply) {
    const replyData = message.metadata.reply;
    const parentMessage = localMessages.find(msg => msg.serial === replyData.serial);

    if (parentMessage) {
      console.log(`Reply to ${parentMessage.clientId}: ${parentMessage.text}`);
    } else {
      console.log(`Reply to ${replyData.clientId}: ${replyData.previewText}`);
    }
  }

  console.log(`Message: ${message.text}`);
});
```

#### React

```
import { useMessages } from '@ably/chat/react';
import { ChatMessageEventType } from '@ably/chat';

const MessageList = () => {
  const [messages, setMessages] = useState([]);

  useMessages({
    listener: (event) => {
      if (event.type === ChatMessageEventType.Created) {
        setMessages(prev => [...prev, event.message]);
      }
    }
  });

  const findParentMessage = (replyData) => {
    return messages.find(msg => msg.serial === replyData.serial);
  };

  return (
    <div>
      {messages.map(message => (
        <div key={message.serial}>
          {message.metadata?.reply && (
            <div>
              Replying to: {message.metadata.reply.previewText}
            </div>
          )}
          <div>{message.text}</div>
        </div>
      ))}
    </div>
  );
};
```

#### Swift

```
// Extension to extract reply data from a message
extension Message {
    var replySerial: String? {
        metadata["reply"]?.objectValue?["serial"]?.stringValue
    }

    var replyPreview: (clientId: String, text: String)? {
        guard let replyData = metadata["reply"]?.objectValue,
              let clientId = replyData["clientId"]?.stringValue,
              let previewText = replyData["previewText"]?.stringValue else {
            return nil
        }
        return (clientId, previewText)
    }
}

// Subscribe to messages and handle replies
var localMessages: [Message] = []

for await event in room.messages.subscribe() {
    let message = event.message

    if let replySerial = message.replySerial {
        if let parentMessage = localMessages.first(where: { $0.serial == replySerial }) {
            print("Reply to \(parentMessage.clientID): \(parentMessage.text)")
        } else if let preview = message.replyPreview {
            print("Reply to \(preview.clientId): \(preview.text)")
        }
    }

    print("Message: \(message.text)")
    localMessages.append(message)
}
```

#### Kotlin

```
import com.ably.chat.json.*

// Subscribe to messages and handle replies
val localMessages = mutableListOf<Message>()

room.messages.subscribe { event ->
    val message = event.message

    val replyData = message.metadata["reply"] as? JsonObject
    if (replyData != null) {
        val replySerial = (replyData["serial"] as? JsonString)?.value
        val parentMessage = localMessages.find { it.serial == replySerial }

        if (parentMessage != null) {
            println("Reply to ${parentMessage.clientId}: ${parentMessage.text}")
        } else {
            val replyClientId = (replyData["clientId"] as? JsonString)?.value
            val previewText = (replyData["previewText"] as? JsonString)?.value
            println("Reply to $replyClientId: $previewText")
        }
    }

    println("Message: ${message.text}")
    localMessages.add(message)
}
```

#### Android

```
import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.runtime.*
import com.ably.chat.*
import com.ably.chat.json.*

@Composable
fun MessageListComponent(room: Room) {
    val messages = remember { mutableStateListOf<Message>() }

    DisposableEffect(room) {
        val (unsubscribe) = room.messages.subscribe { event ->
            messages += event.message
        }

        onDispose {
            unsubscribe()
        }
    }

    Column {
        messages.forEach { message ->
            Column {
                // Display reply information if present
                val replyData = message.metadata["reply"] as? JsonObject
                if (replyData != null) {
                    val previewText = (replyData["previewText"] as? JsonString)?.value
                    Text(text = "Replying to: $previewText")
                }

                // Display the message text
                Text(text = message.text)
            }
        }
    }
}
```
</Code>

## Considerations

Consider the following when implementing message replies:

- Older messages may not be available depending on message persistence settings.
- Messages can be [updated](https://ably.com/docs/chat/rooms/messages.md#update), potentially removing references to replies.
- The `metadata` field is not server-validated.
- Nested replies can be complex and expensive to implement, so consider limiting reply depth.

## Related Topics

- [Messages](https://ably.com/docs/chat/rooms/messages.md): Send, update, delete, and receive messages in chat rooms.
- [Message history](https://ably.com/docs/chat/rooms/history.md): Retrieve previously sent messages from history.
- [Presence](https://ably.com/docs/chat/rooms/presence.md): Use presence to see which users are online and their user status.
- [Occupancy](https://ably.com/docs/chat/rooms/occupancy.md): Use occupancy to see how many users are in a room.
- [Message reactions](https://ably.com/docs/chat/rooms/message-reactions.md): React to chat messages
- [Typing indicators](https://ably.com/docs/chat/rooms/typing.md): Display typing indicators in a room so that users can see when someone else is writing a message.
- [Room reactions](https://ably.com/docs/chat/rooms/reactions.md): Enable users to send reactions at the room level, based on what is happening in your application, such as a goal being scored in your livestream.
- [Share media](https://ably.com/docs/chat/rooms/media.md): Share media such as images, videos, or files in a chat room.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
