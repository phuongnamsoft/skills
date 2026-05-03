# Connection

The `Connection` interface represents the connection to Ably and provides methods to monitor connection status changes. Access the connection via `chatClient.connection`.

<Code>

#### Kotlin

```
val connection = chatClient.connection
```
</Code>

## Properties

The `Connection` interface has the following properties:

<Table id='ConnectionProperties'>

| Property | Description | Type |
| --- | --- | --- |
| status | The current connection status. | <Table id='ConnectionStatus'/> |
| error | The error that caused the connection to enter its current status, if any. | [ErrorInfo?](https://ably.com/docs/chat/api/kotlin/chat-client.md#errorinfo) |

</Table>

<Table id='ConnectionStatus' >

| Status | Description |
| --- | --- |
| Initialized | A temporary state for when the library is first initialized. The value is `initialized`. |
| Connecting | The library is currently connecting to Ably. The value is `connecting`. |
| Connected | A connection exists and is active. The value is `connected`. |
| Disconnected | The library is currently disconnected from Ably, but will attempt to reconnect. The value is `disconnected`. |
| Suspended | The library is in an extended state of disconnection, but will attempt to reconnect. The value is `suspended`. |
| Failed | The library is currently disconnected from Ably and will not attempt to reconnect. The value is `failed`. |
| Closing | An explicit request by the developer to close the connection has been sent to the Ably service. The value is `closing`. |
| Closed | The connection has been explicitly closed by the client. No reconnection attempts are made automatically. The value is `closed`. |

</Table>

## Subscribe to connection status changes 

`connection.onStatusChange(listener: ConnectionStatusListener): Subscription`

Registers a listener to be notified of connection status changes.

<Code>

### Kotlin

```
val subscription = chatClient.connection.onStatusChange { change ->
    println("Status changed from ${change.previous} to ${change.current}")
    change.error?.let { error ->
        println("Error: $error")
    }
    change.retryIn?.let { retryIn ->
        println("Retrying in $retryIn ms")
    }
}

// To unsubscribe
subscription.unsubscribe()
```
</Code>

### Parameters 

The `onStatusChange()` method takes the following parameters:

<Table id='OnStatusChangeParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| listener | Required | A callback invoked on status changes. | <Table id='ConnectionStatusListener'/> |

</Table>

<Table id='ConnectionStatusListener' >

| Parameter | Description | Type |
| --- | --- | --- |
| change | The status change event. | <Table id='ConnectionStatusChange'/> |

</Table>

<Table id='ConnectionStatusChange' >

| Property | Description | Type |
| --- | --- | --- |
| current | The new connection status. | <Table id='ConnectionStatus'/> |
| previous | The previous connection status. | <Table id='ConnectionStatus'/> |
| error | An error that provides a reason why the connection has entered the new status, if applicable. | [ErrorInfo?](https://ably.com/docs/chat/api/kotlin/chat-client.md#errorinfo) |
| retryIn | The time in milliseconds that the client will wait before attempting to reconnect, if applicable. | Long? |

</Table>

### Returns 

[`Subscription`](https://ably.com/docs/chat/api/kotlin/rooms.md#Subscription)

Returns a `Subscription` object.

#### Deregister the listener 

`subscription.unsubscribe(): Unit`

Call `unsubscribe()` to deregister the connection status listener.

## Collect connection status changes as a Flow 

`Connection.statusAsFlow(): Flow<ConnectionStatusChange>`

Returns a Kotlin `Flow` that emits connection status changes. This is an extension function on the `Connection` interface that provides a reactive alternative to listener-based subscriptions.

<Code>

### Kotlin

```
import kotlinx.coroutines.launch

launch {
    chatClient.connection.statusAsFlow().collect { change ->
        println("Status changed from ${change.previous} to ${change.current}")
    }
}
```
</Code>

### Returns 

`Flow<ConnectionStatusChange>`

Returns a `Flow` that emits `ConnectionStatusChange` events. The flow automatically manages the underlying subscription.

## Example

<Code>

### Kotlin

```
import com.ably.chat.ConnectionStatus
import kotlinx.coroutines.launch

// Monitor connection status with a listener
val subscription = chatClient.connection.onStatusChange { change ->
    when (change.current) {
        ConnectionStatus.Connected ->
            println("Connected to Ably")
        ConnectionStatus.Disconnected ->
            println("Disconnected, will retry...")
        ConnectionStatus.Suspended ->
            println("Connection suspended, retrying in ${change.retryIn} ms")
        ConnectionStatus.Failed ->
            println("Connection failed: ${change.error}")
        else -> {}
    }
}

// Or use Flow for reactive collection
launch {
    chatClient.connection.statusAsFlow().collect { change ->
        println("Status: ${change.current}")
    }
}

// Check current status
println("Current status: ${chatClient.connection.status}")

// Clean up
subscription.unsubscribe()
```
</Code>

## Related Topics

- [ChatClient](https://ably.com/docs/chat/api/kotlin/chat-client.md): API reference for the ChatClient interface in the Ably Chat Kotlin SDK.
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
