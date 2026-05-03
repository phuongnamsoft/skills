# Share media

Share media such as images, videos and files with users in a chat room.

Upload the media to your own storage service, such as AWS S3, and then use the `metadata` field to reference the location of the media when a user [sends a message](https://ably.com/docs/chat/rooms/messages.md#send). On the receiving end, display the media to [subscribers](https://ably.com/docs/chat/rooms/messages.md#subscribe) that received the message.

## Access control

Ensure that you add a layer of authentication server-side if the media shouldn't be publicly available.

Do not add signed URLs to the message `metadata` because everyone who receives the message will have access to it. Additionally, signed URLs typically have expiration dates and chat messages may be stored for longer.

If you serve the media directly from a service, such as AWS S3, consider saving a file name in the `metadata` of the message. Then use a mechanism for the user to request a signed URL to the file.

## Upload media 

Users need to be able to choose which media to attach to their message in your app. Write an upload function and make it available in the chat app context.

You can use either a unique identifier for the media, or a URL to its location. Ensure that any identifier is unique and that URLs are validated when they are received.

The following is an example of an upload function:

<Code>

### Javascript

```
async function uploadMedia() {
  // ask the user to choose their media asynchronously
  // upload the media to your storage service
  // return a unique identifier for the media

  // mock implementation:
  let mediaId = 'abcd123abcd';

  // Some media metadata, useful for displaying the media in the UI
  let title = 'A beautiful image';
  let width = 1024;
  let height = 768;

  // Return the object
  return { id: mediaId, title, width, height };
}
```

### Swift

```
func uploadMedia() async -> JSONObject {
    // ask the user to choose their media asynchronously
    // upload the media to your storage service
    // return a unique identifier for the media

    // mock implementation:
    let mediaId = "abcd123abcd"

    // Some media metadata, useful for displaying the media in the UI
    let title = "A beautiful image"
    let width = 1024
    let height = 768

    // Return the object
    return [
        "id": .string(mediaId),
        "title": .string(title),
        "width": .number(Double(width)),
        "height": .number(Double(height))
    ]
}
```

### Kotlin

```
import com.ably.chat.json.*

suspend fun uploadMedia(): JsonObject {
    // ask the user to choose their media asynchronously
    // upload the media to your storage service
    // return a unique identifier for the media

    // mock implementation:
    val mediaId = "abcd123abcd"

    // Some media metadata, useful for displaying the media in the UI
    val title = "A beautiful image"
    val width = 1024
    val height = 768

    // Return the object
    return jsonObject {
        put("id", mediaId)
        put("title", title)
        put("width", width)
        put("height", height)
    }
}
```

### Android

```
import com.ably.chat.json.*

suspend fun uploadMedia(): JsonObject {
    // ask the user to choose their media asynchronously
    // upload the media to your storage service
    // return a unique identifier for the media

    // mock implementation:
    val mediaId = "abcd123abcd"

    // Some media metadata, useful for displaying the media in the UI
    val title = "A beautiful image"
    val width = 1024
    val height = 768

    // Return the object
    return jsonObject {
        put("id", mediaId)
        put("title", title)
        put("width", width)
        put("height", height)
    }
}
```
</Code>

Use the `uploadMedia()` flow to save the resulting object. In your UI, the `mediaToAttach` array should be displayed so that users can see which which media will be attached to their message. It also enables users to add or remove selected media.

<Code>

### Javascript

```
let mediaToAttach = [];
async function onMediaAttach() {
  const mediaData = await uploadMedia();
  mediaToAttach.push(mediaData);
}
```

### React

```
import { useState } from 'react';

const ChatComponent = () => {
  const [mediaToAttach, setMediaToAttach] = useState([]);

  const onMediaAttach = async () => {
    const mediaData = await uploadMedia();
    setMediaToAttach(prev => [...prev, mediaData]);
  };

  return (
    <div>
      <button onClick={onMediaAttach}>Attach Media</button>
      {mediaToAttach.map((mediaData, index) => (
        <div key={mediaData.id}>Media to attach: {mediaData.id} ({mediaData.title}, {mediaData.width}x{mediaData.height})</div>
      ))}
    </div>
  );
};
```

### Swift

```
var mediaToAttach: [JSONObject] = []

func onMediaAttach() async {
    let mediaData = await uploadMedia()
    mediaToAttach.append(mediaData)
}
```

### Kotlin

```
import com.ably.chat.json.JsonObject

var mediaToAttach = mutableListOf<JsonObject>()

suspend fun onMediaAttach() {
    val mediaData = uploadMedia()
    mediaToAttach.add(mediaData)
}
```

### Android

```
import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.runtime.*
import com.ably.chat.json.*
import kotlinx.coroutines.launch

@Composable
fun MediaAttachmentComponent() {
    val mediaToAttach = remember { mutableStateListOf<JsonObject>() }
    val coroutineScope = rememberCoroutineScope()

    Column {
        Button(onClick = {
            coroutineScope.launch {
                val mediaData = uploadMedia()
                mediaToAttach += mediaData
            }
        }) {
            Text("Attach Media")
        }

        mediaToAttach.forEach { media ->
            val id = (media["id"] as? JsonString)?.value ?: ""
            val title = (media["title"] as? JsonString)?.value ?: ""
            val width = (media["width"] as? JsonNumber)?.value?.toInt() ?: 0
            val height = (media["height"] as? JsonNumber)?.value?.toInt() ?: 0
            Text("Media to attach: $id ($title, ${width}x${height})")
        }
    }
}
```
</Code>

## Send a message 

Once a user has ['attached'](#upload) their media to the message, use the `metadata` field of the message to store its reference. `metadata` is a key-value object that can also be used to associate additional information such as its title and dimensions.

<Code>

### Javascript

```
async function send(text) {
  let metadata = {};
  if (mediaToAttach.length > 0) {
    metadata["media"] = mediaToAttach;
    mediaToAttach = [];
  }
  await room.messages.send({
    text: text,
    metadata: metadata
  });
}
```

### React

```
import { useState } from 'react';
import { useMessages } from '@ably/chat/react';

const MessageSender = () => {
  const [mediaToAttach, setMediaToAttach] = useState([]);
  const [messageText, setMessageText] = useState('');
  const { sendMessage } = useMessages();

  const handleSend = async () => {
    let metadata = {};
    if (mediaToAttach.length > 0) {
      metadata["media"] = mediaToAttach;
    }
    await sendMessage({
      text: messageText,
      metadata: metadata
    });
    setMediaToAttach([]);
    setMessageText('');
  };

  const onMediaAttach = async () => {
    const mediaId = await uploadMedia();
    setMediaToAttach(prev => [...prev, mediaId]);
  };

  return (
    <div>
      <input
        type="text"
        value={messageText}
        onChange={(e) => setMessageText(e.target.value)}
        placeholder="Type a message..."
      />
      <button onClick={onMediaAttach}>Attach Media</button>
      <button onClick={handleSend}>Send</button>
      {mediaToAttach.map((mediaData, index) => (
        <div key={index}>Media to attach: {mediaData.id} ({mediaData.title}, {mediaData.width}x{mediaData.height})</div>
      ))}
    </div>
  );
};
```

### Swift

```
func send(text: String, mediaToAttach: [JSONObject]) async throws {
    var metadata: MessageMetadata = [:]
    if !mediaToAttach.isEmpty {
        // Convert each JSONObject to JSONValue.object, then wrap in JSONValue.array
        metadata["media"] = .array(mediaToAttach.map { .object($0) })
    }

    _ = try await room.messages.send(withParams: .init(
        text: text,
        metadata: metadata
    ))
}
```

### Kotlin

```
import com.ably.chat.json.*

suspend fun send(text: String, mediaToAttach: List<JsonObject>) {
    // Wrap the media list in a JsonArray for the metadata
    val metadata = if (mediaToAttach.isNotEmpty()) {
        jsonObject {
            put("media", JsonArray(mediaToAttach))
        }
    } else {
        null
    }

    room.messages.send(
        text = text,
        metadata = metadata
    )
}
```

### Android

```
import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.runtime.*
import com.ably.chat.Room
import com.ably.chat.json.*
import kotlinx.coroutines.launch

@Composable
fun MessageSenderComponent(room: Room) {
    val mediaToAttach = remember { mutableStateListOf<JsonObject>() }
    var messageText by remember { mutableStateOf("") }
    val coroutineScope = rememberCoroutineScope()

    Column {
        TextField(
            value = messageText,
            onValueChange = { messageText = it },
            placeholder = { Text("Type a message...") }
        )

        Button(onClick = {
            coroutineScope.launch {
                val mediaData = uploadMedia()
                mediaToAttach += mediaData
            }
        }) {
            Text("Attach Media")
        }

        Button(onClick = {
            coroutineScope.launch {
                val metadata = if (mediaToAttach.isNotEmpty()) {
                    jsonObject {
                        put("media", JsonArray(mediaToAttach))
                    }
                } else null

                room.messages.send(
                    text = messageText,
                    metadata = metadata
                )

                mediaToAttach.clear()
                messageText = ""
            }
        }) {
            Text("Send")
        }

        mediaToAttach.forEach { media ->
            val id = (media["id"] as? JsonString)?.value ?: ""
            val title = (media["title"] as? JsonString)?.value ?: ""
            val width = (media["width"] as? JsonNumber)?.value?.toInt() ?: 0
            val height = (media["height"] as? JsonNumber)?.value?.toInt() ?: 0
            Text("Media to attach: $id ($title, ${width}x${height})")
        }
    }
}
```
</Code>

Be aware that message `metadata` is not validated by the server. Always treat it as untrusted user input.

## Display media to subscribers 

When a message is received that contains media, you need to display it in your app.

Firstly, make sure that you validate the `metadata`. If you are using IDs then ensure they are in the correct format, or if using URLs then validate the schema, domain, path and query parameters are as expected.

Define a function to get the valid media from a message:

<Code>

### Javascript

```
// assume IDs are 10-15 characters long and alphanumeric
const mediaIdRegex = /^[a-z0-9]{10,15}$/;

function getValidMedia(message) {
  if (message.metadata.media && message.metadata.media.length > 0) {
    return message.metadata.media.filter(mediaData => mediaIdRegex.test(mediaData.id));
  }
  return [];
}
```

### React

```
// assume IDs are 10-15 characters long and alphanumeric
const mediaIdRegex = /^[a-z0-9]{10,15}$/;

const getValidMedia = (message) => {
  if (message.metadata.media && message.metadata.media.length > 0) {
    return message.metadata.media.filter(mediaData => mediaIdRegex.test(mediaData.id));
  }
  return [];
};
```

### Swift

```
import Foundation

// assume IDs are 10-15 characters long and alphanumeric
let mediaIdRegex = /^[a-z0-9]{10,15}$/

func getValidMedia(message: Message) -> [JSONObject] {
    guard let mediaArray = message.metadata["media"]?.arrayValue else {
        return []
    }

    return mediaArray.compactMap { mediaValue in
        guard let mediaObj = mediaValue.objectValue,
              let id = mediaObj["id"]?.stringValue,
              id.wholeMatch(of: mediaIdRegex) != nil else {
            return nil
        }
        return mediaObj
    }
}
```

### Kotlin

```
import com.ably.chat.json.*

// assume IDs are 10-15 characters long and alphanumeric
val mediaIdRegex = Regex("^[a-z0-9]{10,15}$")

fun getValidMedia(message: Message): List<JsonObject> {
    val mediaArray = message.metadata["media"] as? JsonArray ?: return emptyList()

    return mediaArray.mapNotNull { mediaValue ->
        val mediaObj = mediaValue as? JsonObject ?: return@mapNotNull null
        val id = (mediaObj["id"] as? JsonString)?.value ?: return@mapNotNull null

        if (mediaIdRegex.matches(id)) {
            mediaObj
        } else {
            null
        }
    }
}
```

### Android

```
import com.ably.chat.Message
import com.ably.chat.json.*

// assume IDs are 10-15 characters long and alphanumeric
val mediaIdRegex = Regex("^[a-z0-9]{10,15}$")

fun getValidMedia(message: Message): List<JsonObject> {
    val mediaArray = message.metadata["media"] as? JsonArray ?: return emptyList()

    return mediaArray.mapNotNull { mediaValue ->
        val mediaObj = mediaValue as? JsonObject ?: return@mapNotNull null
        val id = (mediaObj["id"] as? JsonString)?.value ?: return@mapNotNull null

        if (mediaIdRegex.matches(id)) {
            mediaObj
        } else {
            null
        }
    }
}
```
</Code>

Use a function or component to display the message and its media:

<Code>

### Javascript

```
function createMessageDOM(message) {
  const container = document.createElement("div");
  container.setAttribute('data-message-serial', message.serial)
  container.setAttribute('data-message-version', message.version.serial)

  const text = document.createElement("div");
  text.innerText = message.text;
  container.appendChild(text);
  const validMedia = getValidMedia(message);
  if (validMedia.length > 0) {
    const mediaContainer = document.createElement("div");
    for (let mediaData of validMedia) {
      const img = document.createElement("img");
      img.src = "https://example.com/images/"+mediaData.id;
      img.alt = mediaData.title;
      img.width = mediaData.width;
      img.height = mediaData.height;
      mediaContainer.appendChild(img);
    }
    container.appendChild(mediaContainer);
  }
  return container;
}
```

### React

```
const mediaIdRegex = /^[a-z0-9]{10,15}$/;

const getValidMedia = (message) => {
  if (message.metadata.media && message.metadata.media.length > 0) {
    return message.metadata.media.filter(mediaId => mediaIdRegex.test(mediaId));
  }
  return [];
};

const MessageDisplay = ({ message }) => {
  const validMedia = getValidMedia(message);

  return (
    <div>
      <div>{message.text}</div>
      {validMedia.length > 0 && (
        <div>
          {validMedia.map((media, index) => (
            <img
              key={media.id}
              src={`https://example.com/images/${media.id}`}
              alt={media.title}
              width={media.width}
              height={media.height}
            />
          ))}
        </div>
      )}
    </div>
  );
};
```

### Swift

```
import SwiftUI

struct MessageView: View {
    let message: Message

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(message.text)

            let validMedia = getValidMedia(message: message)
            if !validMedia.isEmpty {
                VStack(spacing: 4) {
                    ForEach(validMedia, id: \.self) { media in
                        if let id = media["id"]?.stringValue,
                           let title = media["title"]?.stringValue {
                            AsyncImage(url: URL(string: "https://example.com/images/\(id)")) { image in
                                image.resizable().aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .accessibilityLabel(title)
                        }
                    }
                }
            }
        }
    }
}
```

### Kotlin

```
import android.view.View
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import com.ably.chat.json.*

fun createMessageView(message: Message, context: android.content.Context): View {
    val container = LinearLayout(context).apply {
        orientation = LinearLayout.VERTICAL
    }

    val textView = TextView(context).apply {
        text = message.text
    }
    container.addView(textView)

    val validMedia = getValidMedia(message)
    if (validMedia.isNotEmpty()) {
        val mediaContainer = LinearLayout(context).apply {
            orientation = LinearLayout.VERTICAL
        }

        validMedia.forEach { media ->
            val id = (media["id"] as? JsonString)?.value ?: ""
            val imageView = ImageView(context).apply {
                // Load image from URL (using Coil, Glide, or Picasso)
                // load("https://example.com/images/$id")
            }

            mediaContainer.addView(imageView)
        }

        container.addView(mediaContainer)
    }

    return container
}
```

### Android

```
import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.runtime.*
import coil.compose.AsyncImage
import com.ably.chat.Message
import com.ably.chat.json.JsonString

@Composable
fun MessageDisplayComponent(message: Message) {
    val validMedia = getValidMedia(message)

    Column {
        Text(text = message.text)

        if (validMedia.isNotEmpty()) {
            Column {
                validMedia.forEach { media ->
                    val id = (media["id"] as? JsonString)?.value ?: ""
                    val title = (media["title"] as? JsonString)?.value ?: ""
                    AsyncImage(
                        model = "https://example.com/images/$id",
                        contentDescription = title,
                    )
                }
            }
        }
    }
}
```
</Code>

### Add media to an existing message 

You can also add media to an existing message by editing its `metadata`:

<Code>

#### Javascript

```
let mediaId = 'abcd123abcd'; // assume this is the media we want to add
let message = ...; // assume this is the message we want to edit

const newMetadata = structuredClone(message.metadata);
if (!newMetadata.media) {
  newMetadata.media = [];
}
newMetadata.media.push(mediaId);

room.messages.update(message.serial, message.copy({metadata: newMetadata}))
```

#### React

```
import { useMessages } from '@ably/chat/react';

const AddMediaToMessage = ({ message }) => {
  const { updateMessage } = useMessages();

  const addMediaToMessage = async () => {
    const mediaId = 'abcd123abcd'; // assume this is the media we want to add

    const newMetadata = structuredClone(message.metadata);
    if (!newMetadata.media) {
      newMetadata.media = [];
    }
    newMetadata.media.push(mediaId);

    await updateMessage(message.serial, message.copy({metadata: newMetadata}));
  };

  return (
    <button onClick={addMediaToMessage}>
      Add Media to Message
    </button>
  );
};
```

#### Swift

```
func addMediaToMessage(message: Message, mediaData: JSONObject) async throws {
    var newMetadata = message.metadata

    // Get existing media array or start with empty array
    var mediaArray = newMetadata["media"]?.arrayValue ?? []
    mediaArray.append(.object(mediaData))
    newMetadata["media"] = .array(mediaArray)

    _ = try await room.messages.update(
        withSerial: message.serial,
        params: .init(
            text: message.text,
            metadata: newMetadata
        ),
        details: nil
    )
}
```

#### Kotlin

```
import com.ably.chat.json.*

suspend fun addMediaToMessage(message: Message, mediaData: JsonObject) {
    val existingMedia = message.metadata["media"] as? JsonArray ?: JsonArray(emptyList())

    val newMediaArray = JsonArray(existingMedia + mediaData)

    val newMetadata = jsonObject {
        message.metadata.forEach { (key, value) ->
            if (key != "media") {
                put(key, value)
            }
        }
        put("media", newMediaArray)
    }

    room.messages.update(
        serial = message.serial,
        text = message.text,
        metadata = newMetadata
    )
}
```

#### Android

```
import androidx.compose.material.*
import androidx.compose.runtime.*
import com.ably.chat.*
import com.ably.chat.json.*
import kotlinx.coroutines.launch

@Composable
fun AddMediaToMessageComponent(room: Room, message: Message) {
    val coroutineScope = rememberCoroutineScope()

    Button(onClick = {
        coroutineScope.launch {
            val mediaData = uploadMedia()

            val existingMedia = message.metadata["media"] as? JsonArray ?: JsonArray(emptyList())

            val newMediaArray = JsonArray(existingMedia + mediaData)

            val newMetadata = jsonObject {
                message.metadata.forEach { (key, value) ->
                    if (key != "media") {
                        put(key, value)
                    }
                }
                put("media", newMediaArray)
            }

            room.messages.update(
                serial = message.serial,
                text = message.text,
                metadata = newMetadata
            )
        }
    }) {
        Text("Add Media to Message")
    }
}
```
</Code>

### Remove media from an existing message 

You can remove media from an existing message by updating its `metadata`:

<Code>

#### Javascript

```
let mediaId = 'abcd123abcd'; // assume this is the media we want to remove
let message = ...; // assume this is the message we want to edit

if (!message.metadata.media || message.metadata.media.length === 0) {
  //do nothing if there is no media
  return;
}
const newMetadata = structuredClone(message.metadata);
newMetadata.media = newMetadata.media.filter(id => mediaId !== id);

room.messages.update(message.serial, message.copy({metadata: newMetadata}))
```

#### React

```
import { useMessages } from '@ably/chat/react';

const RemoveMediaFromMessage = ({ message }) => {
  const { updateMessage } = useMessages();

  const removeMediaFromMessage = async () => {
    const mediaId = 'abcd123abcd'; // assume this is the media we want to remove

    if (!message.metadata.media || message.metadata.media.length === 0) {
      // do nothing if there is no media
      return;
    }

    const newMetadata = structuredClone(message.metadata);
    newMetadata.media = newMetadata.media.filter(id => mediaId !== id);

    await updateMessage(message.serial, message.copy({metadata: newMetadata}));
  };

  return (
    <button onClick={removeMediaFromMessage}>
      Remove Media from Message
    </button>
  );
};
```

#### Swift

```
func removeMediaFromMessage(message: Message, mediaIdToRemove: String) async throws {
    guard let mediaArray = message.metadata["media"]?.arrayValue,
          !mediaArray.isEmpty else {
        // do nothing if there is no media
        return
    }

    let newMediaArray = mediaArray.filter { mediaValue in
        // Keep items that don't match the ID to remove
        mediaValue.objectValue?["id"]?.stringValue != mediaIdToRemove
    }

    var newMetadata = message.metadata
    newMetadata["media"] = .array(newMediaArray)

    try await room.messages.update(
        withSerial: message.serial,
        params: .init(
            text: message.text,
            metadata: newMetadata
        ),
        details: nil
    )
}
```

#### Kotlin

```
import com.ably.chat.json.*

suspend fun removeMediaFromMessage(message: Message, mediaIdToRemove: String) {
    val existingMedia = message.metadata["media"] as? JsonArray
    if (existingMedia == null || existingMedia.isEmpty()) {
        // do nothing if there is no media
        return
    }

    val newMediaArray = JsonArray(existingMedia.filter { mediaValue ->
        val mediaObj = mediaValue as? JsonObject
        val id = (mediaObj?.get("id") as? JsonString)?.value
        id != mediaIdToRemove
    })

    val newMetadata = jsonObject {
        message.metadata.forEach { (key, value) ->
            if (key != "media") {
                put(key, value)
            }
        }
        put("media", newMediaArray)
    }

    room.messages.update(
        serial = message.serial,
        text = message.text,
        metadata = newMetadata
    )
}
```

#### Android

```
import androidx.compose.material.*
import androidx.compose.runtime.*
import com.ably.chat.*
import com.ably.chat.json.*
import kotlinx.coroutines.launch

@Composable
fun RemoveMediaFromMessageComponent(room: Room, message: Message) {
    val coroutineScope = rememberCoroutineScope()

    Button(onClick = {
        coroutineScope.launch {
            val mediaIdToRemove = "abcd123abcd"

            val existingMedia = message.metadata["media"] as? JsonArray
            if (existingMedia == null || existingMedia.isEmpty()) {
                // do nothing if there is no media
                return@launch
            }

            val newMediaArray = JsonArray(existingMedia.filter { mediaValue ->
                val mediaObj = mediaValue as? JsonObject
                val id = (mediaObj?.get("id") as? JsonString)?.value
                id != mediaIdToRemove
            })

            val newMetadata = jsonObject {
                message.metadata.forEach { (key, value) ->
                    if (key != "media") {
                        put(key, value)
                    }
                }
                put("media", newMediaArray)
            }

            room.messages.update(
                serial = message.serial,
                text = message.text,
                metadata = newMetadata
            )
        }
    }) {
        Text("Remove Media from Message")
    }
}
```
</Code>

## Media moderation

Ably [moderation feature](https://ably.com/docs/chat/moderation.md) is currently limited to text moderation. To add automatic or human moderation for media, you'll need to implement moderation server-side.

An example flow for this would be:

1. Upload the media to your storage service.
2. Asynchronously start the moderation process on the server.
3. Send a message with the `metadata` containing information about the media; either an ID or URL.
4. When a user requests the media from your server, check the moderation status and serve it or return an error.

This means you don't need to update the `metadata` field of the message to reflect its moderation status.

## Related Topics

- [Messages](https://ably.com/docs/chat/rooms/messages.md): Send, update, delete, and receive messages in chat rooms.
- [Message history](https://ably.com/docs/chat/rooms/history.md): Retrieve previously sent messages from history.
- [Presence](https://ably.com/docs/chat/rooms/presence.md): Use presence to see which users are online and their user status.
- [Occupancy](https://ably.com/docs/chat/rooms/occupancy.md): Use occupancy to see how many users are in a room.
- [Message reactions](https://ably.com/docs/chat/rooms/message-reactions.md): React to chat messages
- [Typing indicators](https://ably.com/docs/chat/rooms/typing.md): Display typing indicators in a room so that users can see when someone else is writing a message.
- [Room reactions](https://ably.com/docs/chat/rooms/reactions.md): Enable users to send reactions at the room level, based on what is happening in your application, such as a goal being scored in your livestream.
- [Message replies](https://ably.com/docs/chat/rooms/replies.md): Add reply functionality to messages in a chat room.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
