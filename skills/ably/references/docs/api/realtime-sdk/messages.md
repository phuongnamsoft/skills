# Messages

## <If lang="javascript,nodejs,flutter,csharp,objc,swift">Properties</If><If lang="ruby">Attributes</If><If lang="java">Members</If> 

A `Message` represents an individual message that is sent to or received from Ably.

### <If lang="javascript,nodejs,flutter,objc,swift,ruby,java">name</If><If lang="csharp">Name</If> 

The event name, if provided. <br />_Type: `String`_

### <If lang="javascript,nodejs,flutter,objc,swift,ruby,java">data</If><If lang="csharp">Data</If> 

The message payload, if provided.<br />_Type: <If lang="javascript,nodejs">`String`, `StringBuffer`, `JSON Object`</If><If lang="java">`String`, `ByteArray`, `JSONObject`, `JSONArray`</If><If lang="csharp">`String`, `byte[]`, `plain C# object that can be serialized to JSON`</If><If lang="ruby">`String`, `Binary` (ASCII-8BIT String), `Hash`, `Array`</If><If lang="objc">`NSString *`, `NSData *`, `NSDictionary *`, `NSArray *`</If><If lang="swift">`String`, `NSData`, `Dictionary`, `Array`</If><If lang="flutter">`String`, `Map`, `List`</If>_

### <If lang="javascript,nodejs,flutter,objc,swift,ruby,java">extras</If><If lang="csharp">Extras</If> 

Metadata and/or ancillary payloads, if provided. Valid payloads include [`push`](https://ably.com/docs/push/publish.md#payload), [`headers`](https://ably.com/docs/channels.md#metadata) (a map of strings to strings for arbitrary customer-supplied metadata), [`ephemeral`](https://ably.com/docs/pub-sub/advanced.md#ephemeral), and [`privileged`](https://ably.com/docs/platform/integrations/webhooks.md#skipping).<br />_Type: <If lang="java">`JSONObject`, `JSONArray`</If><If lang="csharp">plain C# object that can be converted to JSON</If><If lang="javascript,nodejs">`JSON Object`</If><If lang="ruby">`Hash`, `Array`</If><If lang="swift">`Dictionary`, `Array`</If><If lang="objc">`NSDictionary *`, `NSArray *`</If>_

### <If lang="javascript,nodejs,flutter,objc,swift,ruby,java">id</If><If lang="csharp">Id</If> 

A Unique ID assigned by Ably to this message.<br />_Type: `String`_

### <If lang="javascript,nodejs,flutter,objc,swift,java">clientId</If><If lang="csharp">ClientId</If><If lang="ruby,python">client_id</If> 

The client ID of the publisher of this message.<br />_Type: `String`_

### <If lang="javascript,nodejs,flutter,objc,swift,java">connectionId</If><If lang="csharp">ConnectionId</If><If lang="ruby,python">connection_id</If> 

The connection ID of the publisher of this message.<br />_Type: `String`_

### <If lang="javascript,nodejs,flutter,objc,swift,java">connectionKey</If><If lang="csharp,go">ConnectionKey</If><If lang="ruby,python">connection_key</If> 

A connection key, which can optionally be included for a REST publish as part of the [publishing on behalf of a realtime client functionality](https://ably.com/docs/pub-sub/advanced.md#publish-on-behalf).<br />_Type: `String`_

### <If lang="javascript,nodejs,flutter,objc,swift,ruby,java">timestamp</If><If lang="csharp">Timestamp</If> 

Timestamp when the message was first received by the Ably, as <If lang="javascript,nodejs,flutter,swift,csharp,objc,java">milliseconds since the epoch</If><If lang="ruby">a `Time` object</If>.<br />_Type: <If lang="javascript,nodejs,flutter">`Integer`</If><If lang="java">`Long Integer`</If><If lang="csharp">`DateTimeOffset`</If><If lang="ruby">`Time`</If><If lang="objc,swift">`NSDate`</If>_

### <If lang="javascript,nodejs,flutter,objc,swift,ruby,java">encoding</If><If lang="csharp">Encoding</If> 

This will typically be empty as all messages received from Ably are automatically decoded client-side using this value. However, if the message encoding cannot be processed, this attribute will contain the remaining transformations not applied to the `data` payload.<br />_Type: `String`_

<If lang="javascript,nodejs,objc,swift,java">

### action 

The action type of the message, one of the [`MessageAction`](https://ably.com/docs/api/realtime-sdk/types.md#message-action) enum values.<br />_Type: `enum { MESSAGE_CREATE, MESSAGE_UPDATE, MESSAGE_DELETE, META, MESSAGE_SUMMARY }`_

### serial 

A server-assigned identifier that will be the same in all future updates of this message. It can be used to add [annotations](https://ably.com/docs/messages/annotations.md) to a message or to [update or delete](https://ably.com/docs/messages/updates-deletes.md) it. Serial will only be set if you enable annotations, updates, deletes, and appends in [rules](https://ably.com/docs/channels.md#rules).<br />_Type: `String`_

### annotations 

An object containing information about annotations that have been made to the object.<br />_Type: [`MessageAnnotations`](https://ably.com/docs/api/realtime-sdk/types.md#message-annotations)_

### version 

An object containing version metadata for messages that have been updated or deleted. See [updating and deleting messages](https://ably.com/docs/messages/updates-deletes.md) for more information.<br />_Type: [`MessageVersion`](#message-version)_

</If>

### Message constructors 

#### <If lang="javascript,nodejs,flutter,csharp,objc,swift,ruby,java">Message.fromEncoded</If> 

`Message.fromEncoded(Object encodedMsg, ChannelOptions channelOptions?) -> Message`

A static factory method to create a [`Message`](https://ably.com/docs/api/realtime-sdk/types.md#message) from a deserialized `Message`-like object encoded using Ably's wire protocol.

##### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| encodedMsg | A `Message`-like deserialized object. | `Object` |
| channelOptions | An optional [`ChannelOptions`](https://ably.com/docs/api/realtime-sdk/types.md#channel-options). If you have an encrypted channel, use this to allow the library to decrypt the data. | `Object` |

##### Returns

A [`Message`](https://ably.com/docs/api/realtime-sdk/types.md#message) object

#### <If lang="javascript,nodejs,flutter,objc,swift,ruby,java">Message.fromEncodedArray</If> 

`Message.fromEncodedArray(Object[] encodedMsgs, ChannelOptions channelOptions?) -> Message[]`

A static factory method to create an array of [`Messages`](https://ably.com/docs/api/realtime-sdk/types.md#message) from an array of deserialized `Message`-like object encoded using Ably's wire protocol.

##### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| encodedMsgs | An array of `Message`-like deserialized objects. | `Array` |
| channelOptions | An optional [`ChannelOptions`](https://ably.com/docs/api/realtime-sdk/types.md#channel-options). If you have an encrypted channel, use this to allow the library to decrypt the data. | `Object` |

##### Returns

An `Array` of [`Message`](https://ably.com/docs/api/realtime-sdk/types.md#message) objects

## MessageAnnotations 

#### <If lang="javascript,nodejs,flutter,objc,csharp,swift">Properties</If><If lang="java">Members</If><If lang="ruby">Attributes</If>

| Property | Description | Type |
|----------|-------------|------|
| summary | An object whose keys are annotation types, and the values are aggregated summaries for that annotation type | `Record<String, JsonObject>` |

## MessageVersion 

#### <If lang="javascript,nodejs,flutter,objc,csharp,swift">Properties</If><If lang="java">Members</If><If lang="ruby">Attributes</If>

| Property | Description | Type |
|----------|-------------|------|
| serial | An Ably-generated ID that uniquely identifies this version of the message. Can be compared lexicographically to determine version ordering. For an original message with an action of `message.create`, this will be equal to the top-level `serial`. | `String` |
| timestamp | The time this version was created (when the update or delete operation was performed). For an original message, this will be equal to the top-level `timestamp`. | <If lang="javascript,nodejs,flutter">`Integer`</If><If lang="java">`Long Integer`</If><If lang="csharp">`DateTimeOffset`</If><If lang="ruby">`Time`</If><If lang="objc,swift">`NSDate`</If> |
| clientId | The client identifier of the user who performed the update or delete operation. Only present for `message.update` and `message.delete` actions. | `String` (optional) |
| description | Optional description provided when the update or delete was performed. Only present for `message.update` and `message.delete` actions. | `String` (optional) |
| metadata | Optional metadata provided when the update or delete was performed. Only present for `message.update` and `message.delete` actions. | `Object` (optional) |

## Related Topics

- [Constructor](https://ably.com/docs/api/realtime-sdk.md): Realtime Client Library SDK API reference section for the constructor object.
- [Connection](https://ably.com/docs/api/realtime-sdk/connection.md): Realtime Client Library SDK API reference section for the connection object.
- [Channels](https://ably.com/docs/api/realtime-sdk/channels.md): Realtime Client Library SDK API reference section for the channels and channel objects.
- [Channel Metadata](https://ably.com/docs/api/realtime-sdk/channel-metadata.md): Realtime Client Library SDK API reference section for channel metadata.
- [Presence](https://ably.com/docs/api/realtime-sdk/presence.md): Realtime Client Library SDK API reference section for the presence object.
- [Authentication](https://ably.com/docs/api/realtime-sdk/authentication.md): Realtime Client Library SDK API reference section for authentication.
- [History](https://ably.com/docs/api/realtime-sdk/history.md): Realtime Client Library SDK API reference section for the history methods.
- [Push Notifications - Admin](https://ably.com/docs/api/realtime-sdk/push-admin.md): Realtime Client Library SDK API reference section for push notifications admin.
- [Push Notifications - Devices](https://ably.com/docs/api/realtime-sdk/push.md): Realtime Client Library SDK API reference section for push notification device subscription.
- [Encryption](https://ably.com/docs/api/realtime-sdk/encryption.md): Realtime Client Library SDK API reference section for the crypto object.
- [Statistics](https://ably.com/docs/api/realtime-sdk/statistics.md): Realtime Client Library SDK API reference section for the stats object.
- [Types](https://ably.com/docs/api/realtime-sdk/types.md): Realtime Client Library SDK API reference section for types.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
