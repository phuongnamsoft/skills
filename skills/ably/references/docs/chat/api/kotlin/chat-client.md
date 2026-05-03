# ChatClient

The `ChatClient` interface is the main entry point for using the Ably Chat SDK. It provides access to chat rooms, connection management, and the underlying Ably Realtime client.

The Chat SDK is built on top of the Ably Pub/Sub SDK and uses that to establish a connection with Ably. Instantiate a realtime client using the Pub/Sub SDK and pass the generated client into the Chat factory function.

<Code>

#### Kotlin

```
import com.ably.chat.ChatClient
import com.ably.chat.LogLevel
import io.ably.lib.realtime.AblyRealtime
import io.ably.lib.types.ClientOptions

val realtimeClient = AblyRealtime(ClientOptions().apply {
    key = "your-api-key"
    clientId = "<clientId>"
})
val chatClient = ChatClient(realtimeClient) {
    logLevel = LogLevel.Error
}
```
</Code>

An API key is required to authenticate with Ably. API keys are used either to authenticate directly with Ably using basic authentication, or to generate tokens for untrusted clients using [JWT authentication](https://ably.com/docs/auth/token.md#jwt).

<Aside data-type='important'>
Basic authentication should never be used on the client-side in production, as it exposes your Ably API key. Instead, use JWT authentication.
</Aside>

## Properties

The `ChatClient` interface has the following properties:

<Table id='ChatClientProperties'>

| Property | Description | Type |
| --- | --- | --- |
| rooms | The rooms object, used to get or create chat room instances. | [Rooms](https://ably.com/docs/chat/api/kotlin/rooms.md) |
| connection | The connection object, used to monitor the connection status with Ably. | [Connection](https://ably.com/docs/chat/api/kotlin/connection.md) |
| clientId | The client ID configured on the underlying Ably Realtime client. Used to identify the current user. | String? |
| realtime | The underlying Ably Realtime client instance. Note: this property is experimental and may change in a future release. | AblyRealtime |
| clientOptions | The resolved configuration options with defaults applied. | <Table id='ChatClientOptions'/> |

</Table>

<Table id='ChatClientOptions' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| logLevel | Optional | The logging level to use. Default: `LogLevel.Error`. | <Table id='LogLevel'/> |
| logHandler | Optional | A custom log handler function that receives log messages from the SDK. | `((LogEntry) -> Unit)?` |
| stateDispatcher | Optional | The coroutine dispatcher used for managing state updates within the chat client. Allows controlling concurrency and dispatching of state management tasks. Note: this property is experimental and may change in a future release. | `CoroutineDispatcher` |

</Table>

<Table id='LogLevel' >

| Value | Description |
| --- | --- |
| Trace | Log all messages. |
| Debug | Log debug, info, warn, and error messages. |
| Info | Log info, warn, and error messages. |
| Warn | Log warn and error messages. |
| Error | Log error messages only. |
| Silent | Disable logging. |

</Table>

## Create a chat client 

`ChatClient(realtimeClient: AblyRealtime, clientOptions: ChatClientOptions = buildChatClientOptions()): ChatClient`

Create a new `ChatClient` instance by passing an Ably Realtime client and optional configuration options. `ChatClient` is a top-level factory function, not a class constructor.

<Code>

### Kotlin

```
import com.ably.chat.ChatClient
import com.ably.chat.buildChatClientOptions
import com.ably.chat.LogLevel
import io.ably.lib.realtime.AblyRealtime
import io.ably.lib.types.ClientOptions

val realtimeClient = AblyRealtime(ClientOptions().apply {
    key = "your-api-key"
    clientId = "user-123"
})

val chatClient = ChatClient(realtimeClient, buildChatClientOptions {
    logLevel = LogLevel.Debug
})
```
</Code>

A DSL builder overload is also available:

`ChatClient(realtimeClient: AblyRealtime, init: MutableChatClientOptions.() -> Unit): ChatClient`

<Code>

### Kotlin

```
val chatClient = ChatClient(realtimeClient) {
    logLevel = LogLevel.Debug
}
```
</Code>

### Parameters 

The `ChatClient()` factory function takes the following parameters:

<Table id='ConstructorParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| realtimeClient | Required | An instance of the Ably Realtime client, configured with your API key and a `clientId`. The `clientId` is required for all chat operations. | AblyRealtime |
| clientOptions | Optional | Configuration options for the Chat client. | <Table id='ChatClientOptions'/> |

</Table>

## ChatException 

A specialized exception class for errors that occur during chat operations. `ChatException` extends `RuntimeException` and wraps an [`ErrorInfo`](#errorinfo) object containing detailed error information. All suspend functions in the SDK throw `ChatException` on failure.

<Table id='ChatExceptionProperties'>

| Property | Description | Type |
| --- | --- | --- |
| errorInfo | Detailed error information including Ably-specific error codes and HTTP status codes. | [ErrorInfo](#errorinfo) |
| message | The exception message. | String? |
| cause | The underlying cause of the exception, if any. | Throwable? |

</Table>

<Code>

### Kotlin

```
import com.ably.chat.ChatException

try {
    room.messages.send(text = "Hello!")
} catch (e: ChatException) {
    println("Error code: ${e.errorInfo.code}")
    println("Message: ${e.errorInfo.message}")
    println("Status: ${e.errorInfo.statusCode}")
}
```
</Code>

## ErrorInfo 

A standardized, generic Ably error object that contains an Ably-specific status code, and a generic HTTP status code. All errors thrown by the SDK are compatible with the `ErrorInfo` structure.

<Table id='ErrorInfo'>

| Property | Description | Type |
| --- | --- | --- |
| code | Ably-specific error code. | Int |
| statusCode | HTTP status code corresponding to this error, where applicable. | Int |
| message | Additional information about the error. | String |
| href | A URL providing more information about the error. | String? |
| cause | The underlying cause of the error. | ErrorInfo? |
| requestId | The request ID if the error originated from an API request. | String? |

</Table>

## Example

<Code>

### Kotlin

```
import com.ably.chat.ChatClient
import com.ably.chat.LogLevel
import io.ably.lib.realtime.AblyRealtime
import io.ably.lib.types.ClientOptions

val realtimeClient = AblyRealtime(ClientOptions().apply {
    key = "your-api-key"
    clientId = "user-123"
})

val chatClient = ChatClient(realtimeClient) {
    logLevel = LogLevel.Debug
}

// Access rooms
val room = chatClient.rooms.get("my-room")

// Check connection status
println(chatClient.connection.status)

// Get current user ID
println(chatClient.clientId)
```
</Code>

## Related Topics

- [Connection](https://ably.com/docs/chat/api/kotlin/connection.md): API reference for the Connection interface in the Ably Chat Kotlin SDK.
- [Rooms](https://ably.com/docs/chat/api/kotlin/rooms.md): API reference for the Rooms interface in the Ably Chat Kotlin SDK.
- [Room](https://ably.com/docs/chat/api/kotlin/room.md): API reference for the Room interface in the Ably Chat Kotlin SDK.
- [Messages](https://ably.com/docs/chat/api/kotlin/messages.md): API reference for the Messages interface in the Ably Chat Kotlin SDK.
- [Message](https://ably.com/docs/chat/api/kotlin/message.md): API reference for the Message interface in the Ably Chat Kotlin SDK.
- [MessageReactions](https://ably.com/docs/chat/api/kotlin/message-reactions.md): API reference for the MessageReactions interface in the Ably Chat Kotlin SDK.
- [Presence](https://ably.com/docs/chat/api/kotlin/presence.md): API reference for the Presence interface in the Ably Chat Kotlin SDK.
- [Occupancy](https://ably.com/docs/chat/api/kotlin/occupancy.md): API reference for the Occupancy interface in the Ably Chat Kotlin SDK.
- [Typing](https://ably.com/docs/chat/api/kotlin/typing.md): API reference for the Typing interface in the Ably Chat Kotlin SDK.
- [RoomReactions](https://ably.com/docs/chat/api/kotlin/room-reactions.md): API reference for the RoomReactions interface in the Ably Chat Kotlin SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
