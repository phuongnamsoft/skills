# Messages

A `Message` represents an individual message that is sent to or received from Ably.

### name 

The event name, if provided. <br />_Type: `String`_

### data 

The message payload, if provided.<br />_Type: <If lang="javascript,nodejs,go">`String`, `StringBuffer`, `JSON Object`</If><If lang="java">`String`, `ByteArray`, `JSONObject`, `JSONArray`</If><If lang="csharp">`String`, `byte[]`, `plain C# object that can be serialized to JSON`</If><If lang="ruby">`String`, `Binary` (ASCII-8BIT String), `Hash`, `Array`</If><If lang="python">`String`, `Bytearray`, `Dict`, `List`</If><If lang="php">`String`, `Binary String`, `Associative Array`, `Array`</If><If lang="objc">`NSString *`, `NSData *`, `NSDictionary *`, `NSArray *`</If><If lang="swift">`String`, `NSData`, `Dictionary`, `Array`</If><If lang="flutter">`String`, `Map`, `List`</If>_

### extras 

Metadata and/or ancillary payloads, if provided. Valid payloads include [`push`](https://ably.com/docs/push/publish.md#payload), `headers` (a map of strings to strings for arbitrary customer-supplied metadata), [`ephemeral`](https://ably.com/docs/pub-sub/advanced.md#ephemeral), and [`privileged`](https://ably.com/docs/platform/integrations/webhooks.md#skipping) objects.<br />_Type: <If lang="javascript,nodejs,flutter,go">`JSON Object`</If><If lang="java">`JSONObject`, `JSONArray`</If><If lang="csharp">plain C# object that can be converted to JSON</If><If lang="ruby">`Hash`, `Array`</If><If lang="python">`Dict`, `List`</If><If lang="swift">`Dictionary`, `Array`</If><If lang="objc">`NSDictionary *`, `NSArray *`</If><If lang="php">`Associative Array`, `Array`</If>_

### id 

A Unique ID assigned by Ably to this message.<br />_Type: `String`_

### clientId 

The client ID of the publisher of this message.<br />_Type: `String`_

### connectionId 

The connection ID of the publisher of this message.<br />_Type: `String`_

### connectionKey 

A connection key, which can optionally be included for a REST publish as part of the [publishing on behalf of a realtime client functionality](https://ably.com/docs/pub-sub/advanced.md#publish-on-behalf).<br />_Type: `String`_

### timestamp 

Timestamp when the message was first received by the Ably, as <If lang="javascript,nodejs,php,flutter,go,python,java,csharp,objc,swift">milliseconds since the epoch</If><If lang="ruby">a `Time` object</If><br />_Type: <If lang="javascript,nodejs,php,flutter,go,python">`Integer`</If><If lang="java">`Long Integer`</If><If lang="csharp">`DateTimeOffset`</If><If lang="ruby">`Time`</If><If lang="objc,swift">`NSDate`</If>_

### encoding 

This will typically be empty as all messages received from Ably are automatically decoded client-side using this value. However, if the message encoding cannot be processed, this attribute will contain the remaining transformations not applied to the `data` payload.<br />_Type: `String`_

<If lang="javascript,nodejs">

#### action

The action type of the message, one of the [`MessageAction`](https://ably.com/docs/api/realtime-sdk/types.md#message-action) enum values.<br />_Type: `int enum { MESSAGE_CREATE, MESSAGE_UPDATE, MESSAGE_DELETE, META, MESSAGE_SUMMARY }`_

#### serial

A server-assigned identifier that will be the same in all future updates of this message. It  can be used to add annotations to a message. Serial will only be set if you enable annotations in [rules](https://ably.com/docs/channels.md#rules) .<br />_Type: `String`_

#### annotations

An object containing information about annotations that have been made to the object.<br />_Type: [`MessageAnnotations`](https://ably.com/docs/api/realtime-sdk/types.md#message-annotations)_

</If>

## Message constructors 

### Message.fromEncoded 

`Message.fromEncoded(Object encodedMsg, ChannelOptions channelOptions?) -> Message`

A static factory method to create a [`Message`](https://ably.com/docs/api/realtime-sdk/types.md#message) from a deserialized `Message`-like object encoded using Ably's wire protocol.

#### Parameters

| Name | Description | Type |
|------|-------------|------|
| encodedMsg | a `Message`-like deserialized object. | `Object` |
| channelOptions | an optional [`ChannelOptions`](https://ably.com/docs/api/realtime-sdk/types.md#channel-options). If you have an encrypted channel, use this to allow the library to decrypt the data. | `Object`t

#### Returns

A [`Message`](https://ably.com/docs/api/realtime-sdk/types.md#message) object

### Message.fromEncodedArray 

`Message.fromEncodedArray(Object[] encodedMsgs, ChannelOptions channelOptions?) -> Message[]`

A static factory method to create an array of [`Messages`](https://ably.com/docs/api/realtime-sdk/types.md#message) from an array of deserialized `Message`-like object encoded using Ably's wire protocol.

#### Parameters

| Name | Description | Type |
|------|-------------|------|
| encodedMsgs | an array of `Message`-like deserialized objects. | `Array` |
| channelOptions | an optional [`ChannelOptions`](https://ably.com/docs/api/realtime-sdk/types.md#channel-options). If you have an encrypted channel, use this to allow the library to decrypt the data. | `Object`t

#### Returns

An `Array` of [`Message`](https://ably.com/docs/api/realtime-sdk/types.md#message) objects

## MessageVersion 

#### Properties

| Property | Description | Type |
|----------|-------------|------|
| serial | An Ably-generated ID that uniquely identifies this version of the message. Can be compared lexicographically to determine version ordering. For an original message with an action of `message.create`, this will be equal to the top-level `serial`. | `String` |
| timestamp | The time this version was created (when the update or delete operation was performed). For an original message, this will be equal to the top-level `timestamp`. | <If lang="javascript,nodejs,php,flutter,go,python">`Integer`</If><If lang="java">`Long Integer`</If><If lang="csharp">`DateTimeOffset`</If><If lang="ruby">`Time`</If><If lang="objc,swift">`NSDate`</If> |
| clientId | The client identifier of the user who performed the update or delete operation. Only present for `message.update` and `message.delete` actions. | `String` (optional) |
| description | Optional description provided when the update or delete was performed. Only present for `message.update` and `message.delete` actions. | `String` (optional) |
| metadata | Optional metadata provided when the update or delete was performed. Only present for `message.update` and `message.delete` actions. | `Object` (optional) |

## Related Topics

- [Constructor](https://ably.com/docs/api/rest-sdk.md): Client Library SDK REST API Reference constructor documentation.
- [Channels](https://ably.com/docs/api/rest-sdk/channels.md): Client Library SDK REST API Reference Channels documentation.
- [Channel Status](https://ably.com/docs/api/rest-sdk/channel-status.md): Client Library SDK REST API Reference Channel Status documentation.
- [Presence](https://ably.com/docs/api/rest-sdk/presence.md): Presence events provide clients with information about the status of other clients 'present' on a channel
- [Authentication](https://ably.com/docs/api/rest-sdk/authentication.md): Client Library SDK REST API Reference Authentication documentation.
- [History](https://ably.com/docs/api/rest-sdk/history.md): Client Library SDK REST API Reference History documentation.
- [Push Notifications - Admin](https://ably.com/docs/api/rest-sdk/push-admin.md): Client Library SDK REST API Reference Push documentation.
- [Encryption](https://ably.com/docs/api/rest-sdk/encryption.md): Client Library SDK REST API Reference Crypto documentation.
- [Statistics](https://ably.com/docs/api/rest-sdk/statistics.md): Client Library SDK REST API Reference Statistics documentation.
- [Types](https://ably.com/docs/api/rest-sdk/types.md): Client Library SDK REST API Reference Types documentation.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
