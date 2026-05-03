# ChatClient

The `ChatClient` class is the main entry point for using the Ably Chat SDK. It provides access to chat rooms, connection management, and the underlying Ably Realtime client.

The Chat SDK is built on top of the Ably Pub/Sub SDK and uses that to establish a connection with Ably. Instantiate a realtime client using the Pub/Sub SDK and pass the generated client into the Chat constructor.

<Code>

#### Javascript

```
import { LogLevel } from '@ably/chat'

const realtimeClient = new Ably.Realtime({ key: 'your-api-key', clientId: '<clientId>'});
const chatClient = new ChatClient(realtimeClient, { logLevel: LogLevel.Error });
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
| rooms | The rooms object, used to get or create chat room instances. | [Rooms](https://ably.com/docs/chat/api/javascript/rooms.md) |
| connection | The connection object, used to monitor the connection status with Ably. | [Connection](https://ably.com/docs/chat/api/javascript/connection.md) |
| clientId | The client ID configured on the underlying Ably Realtime client. Used to identify the current user. May be `undefined` until authenticated with a token. | String or Undefined |
| realtime | The underlying Ably Realtime client instance. | Ably.Realtime |
| clientOptions | The resolved configuration options with defaults applied. | <Table id='ChatClientOptions'/> |

</Table>

<Table id='ChatClientOptions' >

| Property | Required | Description | Type |
| --- | --- | --- | --- |
| logLevel | Optional | The logging level to use. Default: `LogLevel.Error`. | <Table id='LogLevel'/> |
| logHandler | Optional | A custom log handler function that receives log messages from the SDK. | <Table id='LogHandler'/> |

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

<Table id='LogHandler' >

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| message | Required | The log message. | String |
| level | Required | The severity level of the log message. | <Table id='LogLevel'/> |
| context | Optional | Additional contextual data associated with the log entry. | <Table id='LogContext'/> |

</Table>

<Table id='LogContext' >

| Property | Description | Type |
| --- | --- | --- |
| | Additional contextual key-value pairs associated with a log message. | `Record<string, any>` |

</Table>

## Create a new chat client 

`new ChatClient(realtime: Realtime, clientOptions?: ChatClientOptions)`

Create a new `ChatClient` instance by passing an Ably Realtime client and optional configuration options.

<Code>

### Javascript

```
import * as Ably from 'ably';
import { ChatClient } from '@ably/chat';

const realtimeClient = new Ably.Realtime({
  key: 'your-api-key',
  clientId: 'user-123'
});

const chatClient = new ChatClient(realtimeClient, clientOptions);
```
</Code>

### Parameters 

The `ChatClient()` constructor takes the following parameters:

<Table id='ConstructorParameters'>

| Parameter | Required | Description | Type |
| --- | --- | --- | --- |
| realtime | Required | An instance of the Ably Realtime client, configured with your API key and a `clientId`. The `clientId` is required for all chat operations. | Ably.Realtime |
| clientOptions | Optional | Configuration options for the Chat client. | <Table id='ChatClientOptions'/> |

</Table>

## Dispose of the chat client 

`chatClient.dispose(): Promise<void>`

Disposes of the ChatClient instance and releases all resources, including all chat rooms. After calling this method, the ChatClient instance is no longer usable.

<Code>

### Javascript

```
await chatClient.dispose();
```
</Code>

### Returns 

`Promise<void>`

Returns a promise. The promise is fulfilled when the client has been disposed, or rejected with an [`ErrorInfo`](#errorinfo) object.

## ErrorInfo 

A standardized, generic Ably error object that contains an Ably-specific status code, and a generic HTTP status code. All errors returned from Ably are compatible with the `ErrorInfo` structure.

<Table id='ErrorInfo'>

| Property | Description | Type |
| --- | --- | --- |
| code | Ably-specific error code. | Number |
| statusCode | HTTP status code corresponding to this error, where applicable. | Number |
| message | Additional information about the error. | String |
| cause | The underlying cause of the error, where applicable. | ErrorInfo |
| detail | Optional map of string key-value pairs containing structured metadata associated with the error. | `Record<string, string>` or Undefined |

</Table>

## Example

<Code>

### Javascript

```
import * as Ably from 'ably';
import { ChatClient, LogLevel } from '@ably/chat';

const realtimeClient = new Ably.Realtime({
  key: 'your-api-key',
  clientId: 'user-123'
});

const chatClient = new ChatClient(realtimeClient, {
  logLevel: LogLevel.Debug
});

// Access rooms
const room = await chatClient.rooms.get('my-room');

// Check connection status
console.log(chatClient.connection.status);

// Get current user ID
console.log(chatClient.clientId);
```
</Code>

## Related Topics

- [Connection](https://ably.com/docs/chat/api/javascript/connection.md): API reference for the Connection interface in the Ably Chat JavaScript SDK.
- [Rooms](https://ably.com/docs/chat/api/javascript/rooms.md): API reference for the Rooms interface in the Ably Chat JavaScript SDK.
- [Room](https://ably.com/docs/chat/api/javascript/room.md): API reference for the Room interface in the Ably Chat JavaScript SDK.
- [Messages](https://ably.com/docs/chat/api/javascript/messages.md): API reference for the Messages interface in the Ably Chat JavaScript SDK.
- [Message](https://ably.com/docs/chat/api/javascript/message.md): API reference for the Message interface in the Ably Chat JavaScript SDK.
- [MessageReactions](https://ably.com/docs/chat/api/javascript/message-reactions.md): API reference for the MessageReactions interface in the Ably Chat JavaScript SDK.
- [Presence](https://ably.com/docs/chat/api/javascript/presence.md): API reference for the Presence interface in the Ably Chat JavaScript SDK.
- [Occupancy](https://ably.com/docs/chat/api/javascript/occupancy.md): API reference for the Occupancy interface in the Ably Chat JavaScript SDK.
- [Typing](https://ably.com/docs/chat/api/javascript/typing.md): API reference for the Typing interface in the Ably Chat JavaScript SDK.
- [RoomReactions](https://ably.com/docs/chat/api/javascript/room-reactions.md): API reference for the RoomReactions interface in the Ably Chat JavaScript SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
