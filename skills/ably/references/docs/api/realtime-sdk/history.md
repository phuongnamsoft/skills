# History

## Channel object

The [Realtime `Channel` object](https://ably.com/docs/channels.md) exposes the following public method to obtain [`Message`](#message) history.

### Methods 

### <If lang="javascript,nodejs,java,objc,swift,ruby">history</If><If lang="csharp">History</If> 

<If lang="javascript,nodejs">

`history(Object params?): Promise<PaginatedResult<Message>>`

</If>
<If lang="csharp">

`Task<PaginatedResult<Message>> HistoryAsync(PaginatedRequestParams dataQuery, bool untilAttach = false);`

</If>
<If lang="java">

`PaginatedResult<Message> history(Param option)`

</If>
<If lang="objc,swift">

`history(query: ARTRealtimeHistoryQuery?, callback: (ARTPaginatedResult<ARTMessage>?, ARTErrorInfo?) → Void) throws`

</If>
<If lang="ruby">

`Deferrable history(Hash option) → yields PaginatedResult<Message>`

</If>

Gets a [paginated](#paginated-result) set of historical messages for this channel.

#### Parameters

<If lang="javascript,nodejs,java,csharp">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs">params</If><If lang="java">option</If><If lang="csharp">query</If> | <If lang="javascript,nodejs">an optional object containing the query parameters</If><If lang="java">an optional array containing the query parameters</If><If lang="csharp">an optional object containing the query parameters</If> | <If lang="javascript,nodejs">`Object`</If><If lang="java">[`Param[]`](#param)</If><If lang="csharp">[`PaginatedRequestParams`](#paginated-request-params)</If> |

</If>

<If lang="ruby,swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="ruby">option</If><If lang="swift,objc">query</If> | <If lang="ruby">an optional set of key value pairs containing the query parameters</If><If lang="swift,objc">an optional object containing the query parameters</If> | <If lang="ruby">`Hash`</If><If lang="swift,objc">`ARTRealtimeHistoryQuery`</If> |
| <If lang="ruby">&block</If><If lang="swift,objc">callback</If> | <If lang="ruby">yields a `PaginatedResult<Message>` object</If><If lang="swift,objc">called with a [ARTPaginatedResult](#paginated-result)&lt;[ARTMessage](#message)&gt; object or an error</If> | <If lang="ruby">`Block`</If><If lang="swift,objc">`Callback`</If> |

</If>

#### <If lang="javascript,nodejs">`params` parameters</If><If lang="ruby">`options` parameters</If><If lang="java">`options` parameters</If><If lang="swift,objc">`ARTRealtimeHistoryQuery` properties</If><If lang="csharp">`PaginatedRequestParams` properties</If>

<If lang="javascript,nodejs,ruby,java,swift,objc">

| Property | Description | Type |
|----------|-------------|------|
| <If lang="javascript,nodejs">start</If><If lang="ruby">:start</If><If lang="java,swift,objc">start</If> | <If lang="javascript,nodejs">Earliest time in milliseconds since the epoch for any messages retrieved.</If><If lang="ruby">Earliest `Time` or time in milliseconds since the epoch for any messages retrieved.</If><If lang="java,swift,objc">Earliest time in milliseconds since the epoch for any messages retrieved.</If> <br />_Default: beginning of time_ | <If lang="javascript,nodejs">`Number`</If><If lang="ruby">`Int` or `Time`</If><If lang="java,swift,objc">`Long`</If> |
| <If lang="javascript,nodejs">end</If><If lang="ruby">:end</If><If lang="java,swift,objc">end</If> | <If lang="javascript,nodejs">Latest time in milliseconds since the epoch for any messages retrieved.</If><If lang="ruby">Latest `Time` or time in milliseconds since the epoch for any messages retrieved.</If><If lang="java,swift,objc">Latest time in milliseconds since the epoch for any messages retrieved.</If> <br />_Default: current time_ | <If lang="javascript,nodejs">`Number`</If><If lang="ruby">`Int` or `Time`</If><If lang="java,swift,objc">`Long`</If> |
| <If lang="javascript,nodejs">direction</If><If lang="ruby">:direction</If><If lang="java,swift,objc">direction</If> | <If lang="javascript,nodejs">`forwards` or `backwards`.</If><If lang="ruby">`:forwards` or `:backwards`.</If><If lang="java,swift,objc">`forwards` or `backwards`.</If> <br />_Default: <If lang="javascript,nodejs,java,swift,objc">`backwards`</If><If lang="ruby">`:backwards`</If>_ | <If lang="javascript,nodejs,java,swift,objc">`String`</If><If lang="ruby">`Symbol`</If> |
| <If lang="javascript,nodejs">limit</If><If lang="ruby">:limit</If><If lang="java,swift,objc">limit</If> | Maximum number of messages to retrieve per page, up to 1,000. <br />_Default: `100`_ | <If lang="javascript,nodejs">`Number`</If><If lang="ruby,java,swift,objc">`Integer`</If> |
| <If lang="javascript,nodejs,java,swift,objc">untilAttach</If><If lang="ruby">:until_attach</If> | when true, ensures message history is up until the point of the channel being attached. See [continuous history](https://ably.com/docs/storage-history/history.md#continuous-history) for more info. Requires the `direction` to be `backwards` (the default). If the `Channel` is not attached, or if `direction` is set to `forwards`, this option will result in an error. <br />_Default: `false`_ | `Boolean` |

</If>

<If lang="csharp">

| Property | Description | Type |
|----------|-------------|------|
| Start | Earliest `DateTimeOffset` or time in milliseconds since the epoch for any messages retrieved. <br />_Default: beginning of time_ | `DateTimeOffset` |
| End | Latest `DateTimeOffset` or time in milliseconds since the epoch for any messages retrieved. <br />_Default: current time_ | `DateTimeOffset` |
| Direction | `forwards` or `backwards`. <br />_Default: `backwards`_ | `Direction` enum |
| Limit | Maximum number of messages to retrieve per page, up to 1,000. <br />_Default: `100`_ | `Integer` |
| untilAttach | When true, ensures message history is up until the point of the channel being attached. <br />_Default: `false`_ | `Boolean` |

</If>

<If lang="javascript,nodejs">

#### Returns

Returns a promise. On success, the promise is fulfilled with a [`PaginatedResult`](#paginated-result) encapsulating an array of [`Message`](#message) objects corresponding to the current page of results. [`PaginatedResult`](#paginated-result) supports pagination using [`next()`](#paginated-result) and [`first()`](#paginated-result) methods. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="swift,objc">

#### Callback result

On success, `resultPage` contains a [`PaginatedResult`](#paginated-result) encapsulating an array of [`Message`](#message) objects corresponding to the current page of results. [`PaginatedResult`](#paginated-result) supports pagination using [`next()`](#paginated-result) and [`first()`](#paginated-result) methods.

On failure to retrieve message history, `err` contains an [`ErrorInfo`](#error-info) object with the failure reason.

</If>

<If lang="java">

#### Returns

On success, the returned [`PaginatedResult`](#paginated-result) encapsulates an array of [`Message`](#message) objects corresponding to the current page of results. [`PaginatedResult`](#paginated-result) supports pagination using [`next`](#paginated-result) and [`first`](#paginated-result) methods.

Failure to retrieve the message history will raise an [`AblyException`](https://ably.com/docs/api/realtime-sdk/types.md#ably-exception)

</If>

<If lang="csharp">

#### Returns

Returns a `Task` that needs to be awaited.

On success, the returned [`PaginatedResult`](#paginated-result) encapsulates an array of [`Message`](#message) objects corresponding to the current page of results. [`PaginatedResult`](#paginated-result) supports pagination using [`NextAsync`](#paginated-result) and [`FirstAsync`](#paginated-result) methods.

Failure to retrieve the message history will raise an [`AblyException`](https://ably.com/docs/api/realtime-sdk/types.md#ably-exception)

</If>

<If lang="ruby">

#### Returns

A [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) object is returned from the method.

On success, the registered success blocks for the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and any block provided to the method yield a [PaginatedResult](#paginated-result) that encapsulates an array of [`Message`](#message) objects corresponding to the current page of results. [`PaginatedResult`](#paginated-result) supports pagination using [`next()`](#paginated-result) and [`first()`](#paginated-result) methods.

Failure to retrieve the message history will trigger the `errback` callbacks of the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) with an [`ErrorInfo`](#error-info) object with the failure reason.

</If>

## Presence object

[Realtime `Presence` object](https://ably.com/docs/presence-occupancy/presence.md) exposes the following public method to obtain presence event history such as enter, update and leave events. These events are represented as [`PresenceMessage`](#presence-message) objects.

### Methods 



### <If lang="javascript,nodejs,java,objc,swift,ruby">history</If><If lang="csharp">History</If>

<If lang="javascript,nodejs">

`history(Object params?): Promise<PaginatedResult<PresenceMessage>>`

</If>
<If lang="csharp">

`Task<PaginatedResult<PresenceMessage>> HistoryAsync(PaginatedRequestParams query, bool untilAttach = false [deprecated])`

</If>
<If lang="java">

`PaginatedResult<PresenceMessage> history(Param[] option)`

</If>
<If lang="objc,swift">

`history(query: ARTRealtimeHistoryQuery?, callback: (ARTPaginatedResult<ARTPresenceMessage>?, ARTErrorInfo?) → Void) throws`

</If>
<If lang="ruby">

`Deferrable history(Hash option) → yields PaginatedResult<PresenceMessage>`

</If>

Gets a [paginated](#paginated-result) set of historical presence events for this channel.

#### Parameters

<If lang="javascript,nodejs,java,csharp">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs">params</If><If lang="java">option</If><If lang="csharp">query</If> | an optional object containing the query parameters, as specified below. | <If lang="javascript,nodejs">`Object`</If><If lang="java">[`Param[]`](#param)</If><If lang="csharp">[`PaginatedRequestParams`](https://ably.com/docs/api/realtime-sdk/history.md#paginated-request-params)</If> |

</If>

<If lang="ruby,swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="ruby">option</If><If lang="swift,objc">query</If> | <If lang="ruby">an optional set of key value pairs containing the query parameters</If><If lang="swift,objc">an optional object containing the query parameters</If> | <If lang="ruby">`Hash`</If><If lang="swift,objc">`ARTRealtimeHistoryQuery`</If><If lang="csharp">[`PaginatedRequestParams`](#paginated-request-params)</If> |
| <If lang="ruby">&block</If><If lang="swift,objc">callback</If> | <If lang="ruby">yields a `PaginatedResult<PresenceMessage>` object</If><If lang="swift,objc">called with a [ARTPaginatedResult](#paginated-result)&lt;[ARTPresenceMessage](#presence-message)&gt; object or an error</If> | <If lang="ruby">`Block`</If><If lang="swift,objc">`Callback`</If> |

</If>

#### <If lang="javascript,nodejs">`params` parameters</If><If lang="ruby">`options` parameters</If><If lang="java">`options` parameters</If><If lang="swift,objc">`ARTRealtimeHistoryQuery` properties</If><If lang="csharp">`PaginatedRequestParams` properties</If>

<If lang="javascript,nodejs,ruby,java,swift,objc,csharp">

| Property | Description | Type |
|----------|-------------|------|
| <If lang="javascript,nodejs,java,swift,objc">start</If><If lang="ruby">:start</If><If lang="csharp">Start</If> | <If lang="javascript,nodejs,java,swift,objc">Earliest time in milliseconds since the epoch for any presence events retrieved.</If><If lang="ruby">Earliest `Time` or time in milliseconds since the epoch for any presence events retrieved.</If><If lang="csharp">Earliest `DateTimeOffset` or time in milliseconds since the epoch for any presence events retrieved.</If> <br />_Default: beginning of time_ | <If lang="javascript,nodejs">`Number`</If><If lang="ruby">`Int` or `Time`</If><If lang="java,swift,objc">`Long`</If><If lang="csharp">`DateTimeOffset`</If> |
| <If lang="javascript,nodejs,java,swift,objc">end</If><If lang="ruby">:end</If><If lang="csharp">End</If> | <If lang="javascript,nodejs,java,swift,objc">Latest time in milliseconds since the epoch for any presence events retrieved.</If><If lang="ruby">Latest `Time` or time in milliseconds since the epoch for any presence events retrieved.</If><If lang="csharp">Latest `DateTimeOffset` or time in milliseconds since the epoch for any presence events retrieved.</If> <br />_Default: current time_ | <If lang="javascript,nodejs">`Number`</If><If lang="ruby">`Int` or `Time`</If><If lang="java,swift,objc">`Long`</If><If lang="csharp">`DateTimeOffset`</If> |
| <If lang="javascript,nodejs,java,swift,objc">direction</If><If lang="ruby">:direction</If><If lang="csharp">Direction</If> | <If lang="javascript,nodejs,java,swift,objc,csharp">`forwards` or `backwards`.</If><If lang="ruby">`:forwards` or `:backwards`.</If> <br />_Default: <If lang="javascript,nodejs,java,swift,objc">`backwards`</If><If lang="ruby">`:backwards`</If>_ | <If lang="javascript,nodejs,java,swift,objc">`String`</If><If lang="ruby">`Symbol`</If><If lang="csharp">`Direction` enum</If> |
| <If lang="javascript,nodejs,java,swift,objc">limit</If><If lang="ruby">:limit</If><If lang="csharp">Limit</If> | Maximum number of presence events to retrieve up to 1,000. <br />_Default: `100`_ | <If lang="javascript,nodejs">`Number`</If><If lang="ruby,java,swift,objc,csharp">`Integer`</If> |
| <If lang="javascript,nodejs,java,swift,objc,csharp">untilAttach</If><If lang="ruby">:until_attach</If> | when true, ensures presence message history is up until the point of the channel being attached. See [continuous history](https://ably.com/docs/storage-history/history.md#continuous-history) for more info. Requires the `direction` to be `backwards` (the default). If the `Channel` is not attached, or if `direction` is set to `forwards`, this option will result in an error. <br />_Default: `false`_ | `Boolean` |

</If>

<If lang="javascript,nodejs">

#### Returns

Returns a promise. On success, the promise is fulfilled with a [`PaginatedResult`](#paginated-result) encapsulating an array of [`PresenceMessage`](#presence-message) objects corresponding to the current page of results. [`PaginatedResult`](#paginated-result) supports pagination using [`next()`](#paginated-result) and [`first()`](#paginated-result) methods. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="swift,objc">

#### Callback result

On success, `resultPage` contains a [`PaginatedResult`](#paginated-result) encapsulating an array of [`PresenceMessage`](#presence-message) objects corresponding to the current page of results. [`PaginatedResult`](#paginated-result) supports pagination using [`next()`](#paginated-result) and [`first()`](#paginated-result) methods.

On failure to retrieve presence event history, `err` contains an [`ErrorInfo`](#error-info) object with the failure reason.

</If>

<If lang="java">

#### Returns

On success, the returned [`PaginatedResult`](#paginated-result) encapsulates an array of [`PresenceMessage`](#presence-message) objects corresponding to the current page of results. [`PaginatedResult`](#paginated-result) supports pagination using [`next`](#paginated-result) and [`first`](#paginated-result) methods.

Failure to retrieve the presence event history will raise an [`AblyException`](https://ably.com/docs/api/realtime-sdk/types.md#ably-exception)

</If>

<If lang="csharp">

#### Returns

Returns a `Task` that needs to be awaited.

On success, the returned [`PaginatedResult`](#paginated-result) encapsulates an array of [`PresenceMessage`](#presence-message) objects corresponding to the current page of results. [`PaginatedResult`](#paginated-result) supports pagination using [`NextAsync`](#paginated-result) and [`FirstAsync`](#paginated-result) methods.

Failure to retrieve the presence event history will raise an [`AblyException`](https://ably.com/docs/api/realtime-sdk/types.md#ably-exception)

</If>

<If lang="ruby">

#### Returns

A [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) object is returned from the method.

On success, the registered success blocks for the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and any block provided to the method yield a [PaginatedResult](#paginated-result) that encapsulates an array of [`PresenceMessage`](#presence-message) objects corresponding to the current page of results. [`PaginatedResult`](#paginated-result) supports pagination using [`next()`](#paginated-result) and [`first()`](#paginated-result) methods.

Failure to retrieve the presence event history will trigger the `errback` callbacks of the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) with an [`ErrorInfo`](#error-info) object with the failure reason.

</If>

## Related types 

### <If lang="javascript,nodejs">Message</If><If lang="swift,objc">ARTMessage</If><If lang="ruby">Ably::Models::Message Enum</If><If lang="java">io.ably.lib.types.Message</If><If lang="csharp">IO.Ably.Message</If> 

A `Message` represents an individual message that is sent to or received from Ably.

#### Properties

<If lang="javascript,nodejs">

| Property | Description | Type |
|----------|-------------|------|
| name | The event name, if provided. | `String` |
| data | The message payload, if provided. | `String`, `StringBuffer`, `JSON Object` |
| extras | Metadata and/or ancillary payloads, if provided. Valid payloads include [`push`](https://ably.com/docs/push/publish.md#payload), `headers` (a map of strings to strings for arbitrary customer-supplied metadata), [`ephemeral`](https://ably.com/docs/pub-sub/advanced.md#ephemeral), and [`privileged`](https://ably.com/docs/platform/integrations/webhooks.md#skipping) objects. | `JSON Object` |
| id | A Unique ID assigned by Ably to this message. | `String` |
| clientId | The client ID of the publisher of this message. | `String` |
| connectionId | The connection ID of the publisher of this message. | `String` |
| connectionKey | A connection key, which can optionally be included for a REST publish as part of the [publishing on behalf of a realtime client functionality](https://ably.com/docs/pub-sub/advanced.md#publish-on-behalf). | `String` |
| timestamp | Timestamp when the message was first received by the Ably, as milliseconds since the epoch. | `Integer` |
| encoding | This will typically be empty as all messages received from Ably are automatically decoded client-side using this value. However, if the message encoding cannot be processed, this attribute will contain the remaining transformations not applied to the `data` payload. | `String` |
| action | The action type of the message, one of the [`MessageAction`](https://ably.com/docs/api/realtime-sdk/types.md#message-action) enum values. | `int enum { MESSAGE_CREATE, MESSAGE_UPDATE, MESSAGE_DELETE, META, MESSAGE_SUMMARY }` |
| serial | A server-assigned identifier that will be the same in all future updates of this message. It can be used to add annotations to a message. Serial will only be set if you enable annotations in [rules](https://ably.com/docs/channels.md#rules). | `String` |
| annotations | An object containing information about annotations that have been made to the object. | [`MessageAnnotations`](https://ably.com/docs/api/realtime-sdk/types.md#message-annotations) |

</If>

<If lang="java,objc,swift,ruby,csharp">

| Property | Description | Type |
|----------|-------------|------|
| <If lang="java,objc,swift,ruby">name</If><If lang="csharp">Name</If> | The event name, if provided. | `String` |
| <If lang="java,objc,swift,ruby">data</If><If lang="csharp">Data</If> | The message payload, if provided. | <If lang="java">`String`, `ByteArray`, `JSONObject`, `JSONArray`</If><If lang="csharp">`String`, `byte[]`, plain C# object that can be serialized to JSON</If><If lang="ruby">`String`, `Binary` (ASCII-8BIT String), `Hash`, `Array`</If><If lang="objc">`NSString *`, `NSData *`, `NSDictionary *`, `NSArray *`</If><If lang="swift">`String`, `NSData`, `Dictionary`, `Array`</If> |
| <If lang="java,objc,swift,ruby">extras</If><If lang="csharp">Extras</If> | Metadata and/or ancillary payloads, if provided. Valid payloads include [`push`](https://ably.com/docs/push/publish.md#payload), `headers` (a map of strings to strings for arbitrary customer-supplied metadata), [`ephemeral`](https://ably.com/docs/pub-sub/advanced.md#ephemeral), and [`privileged`](https://ably.com/docs/platform/integrations/webhooks.md#skipping) objects. | <If lang="java">`JSONObject`, `JSONArray`</If><If lang="csharp">plain C# object that can be converted to JSON</If><If lang="ruby">`Hash`, `Array`</If><If lang="swift">`Dictionary`, `Array`</If><If lang="objc">`NSDictionary *`, `NSArray *`</If> |
| <If lang="java,objc,swift,ruby">id</If><If lang="csharp">Id</If> | A Unique ID assigned by Ably to this message. | `String` |
| <If lang="ruby">client_id</If><If lang="csharp">ClientId</If><If lang="java,objc,swift">clientId</If> | The client ID of the publisher of this message. | `String` |
| <If lang="ruby">connection_id</If><If lang="csharp">ConnectionId</If><If lang="java,objc,swift">connectionId</If> | The connection ID of the publisher of this message. | `String` |
| <If lang="ruby">connection_key</If><If lang="csharp">ConnectionKey</If><If lang="java,objc,swift">connectionKey</If> | A connection key, which can optionally be included for a REST publish as part of the [publishing on behalf of a realtime client functionality](https://ably.com/docs/pub-sub/advanced.md#publish-on-behalf). | `String` |
| <If lang="java,objc,swift,ruby">timestamp</If><If lang="csharp">Timestamp</If> | Timestamp when the message was first received by the Ably, as <If lang="java">milliseconds since the epoch</If><If lang="ruby">a `Time` object</If><If lang="csharp">a `DateTimeOffset`</If><If lang="objc,swift">`NSDate`</If>. | <If lang="java">`Long Integer`</If><If lang="csharp">`DateTimeOffset`</If><If lang="ruby">`Time`</If><If lang="objc,swift">`NSDate`</If> |
| <If lang="java,objc,swift,ruby">encoding</If><If lang="csharp">Encoding</If> | This will typically be empty as all messages received from Ably are automatically decoded client-side using this value. However, if the message encoding cannot be processed, this attribute will contain the remaining transformations not applied to the `data` payload. | `String` |

</If>

### Message constructors

#### Message.fromEncoded 

<If lang="javascript,nodejs,csharp,java,objc,ruby,swift">

`Message.fromEncoded(Object encodedMsg, ChannelOptions channelOptions?) → Message`

</If>

A static factory method to create a [`Message`](https://ably.com/docs/api/realtime-sdk/types.md#message) from a deserialized `Message`-like object encoded using Ably's wire protocol.

##### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| encodedMsg | a `Message`-like deserialized object. | `Object` |
| channelOptions | an optional [`ChannelOptions`](https://ably.com/docs/api/realtime-sdk/types.md#channel-options). If you have an encrypted channel, use this to allow the library to decrypt the data. | `Object` |

##### Returns

A [`Message`](https://ably.com/docs/api/realtime-sdk/types.md#message) object

#### Message.fromEncodedArray 

<If lang="javascript,nodejs,csharp,java,objc,ruby,swift">

`Message.fromEncodedArray(Object[] encodedMsgs, ChannelOptions channelOptions?) → Message[]`

</If>

A static factory method to create an array of [`Messages`](https://ably.com/docs/api/realtime-sdk/types.md#message) from an array of deserialized `Message`-like object encoded using Ably's wire protocol.

##### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| encodedMsgs | an array of `Message`-like deserialized objects. | `Array` |
| channelOptions | an optional [`ChannelOptions`](https://ably.com/docs/api/realtime-sdk/types.md#channel-options). If you have an encrypted channel, use this to allow the library to decrypt the data. | `Object` |

##### Returns

An `Array` of [`Message`](https://ably.com/docs/api/realtime-sdk/types.md#message) objects

### <If lang="javascript,nodejs">PresenceMessage</If><If lang="swift,objc">ARTPresenceMessage</If><If lang="ruby">Ably::Models::PresenceMessage Enum</If><If lang="java">io.ably.lib.types.PresenceMessage</If><If lang="csharp">IO.Ably.PresenceMessage</If> 

A `PresenceMessage` represents an individual presence update that is sent to or received from Ably.

#### Properties

| Property | Description | Type |
|----------|-------------|------|
| <If lang="java,javascript,nodejs,ruby,objc,swift">action</If><If lang="csharp">Action</If> | the event signified by a PresenceMessage. See [`PresenceMessage.action`](https://ably.com/docs/api/realtime-sdk/types.md#presence-action) | <If lang="java">`enum { ABSENT, PRESENT, ENTER, LEAVE, UPDATE }`</If><If lang="csharp">`enum { Absent, Present, Enter, Leave, Update }`</If><If lang="javascript,nodejs">`int enum { ABSENT, PRESENT, ENTER, LEAVE, UPDATE }`</If><If lang="ruby">`enum { :absent, :present, :enter, :leave, :update }`</If><If lang="objc,swift">`ARTPresenceAction`</If> |
| <If lang="javascript,nodejs,java,objc,swift,ruby">data</If><If lang="csharp">Data</If> | The presence update payload, if provided | <If lang="java">`String`, `ByteArray`, `JSONObject`, `JSONArray`</If><If lang="csharp">`String`, `byte[]`, plain C# object that can be converted to Json</If><If lang="javascript,nodejs">`String`, `StringBuffer`, `JSON Object`</If><If lang="ruby">`String`, `Binary` (ASCII-8BIT String), `Hash`, `Array`</If><If lang="swift">`String`, `NSData`, `Dictionary`, `Array`</If><If lang="objc">`NSString *`, `NSData *`, `NSDictionary *`, `NSArray *`</If> |
| <If lang="javascript,nodejs,java,objc,swift,ruby">extras</If><If lang="csharp">Extras</If> | Metadata and/or ancillary payloads, if provided. The only currently valid payloads for extras are the [`push`](https://ably.com/docs/push/publish.md#sub-channels), [`ref`](https://ably.com/docs/messages.md#interactions) and [`privileged`](https://ably.com/docs/platform/integrations/webhooks.md#skipping) objects. | <If lang="java">`JSONObject`, `JSONArray`</If><If lang="csharp">plain C# object that can be converted to Json</If><If lang="javascript,nodejs">`JSON Object`</If><If lang="ruby">`Hash`, `Array`</If><If lang="swift">`Dictionary`, `Array`</If><If lang="objc">`NSDictionary *`, `NSArray *`</If> |
| <If lang="javascript,nodejs,java,objc,swift,ruby">id</If><If lang="csharp">Id</If> | Unique ID assigned by Ably to this presence update | `String` |
| <If lang="javascript,nodejs">clientId</If><If lang="ruby">client_id</If><If lang="csharp">ClientId</If><If lang="java,objc,swift">clientId</If> | The client ID of the publisher of this presence update | `String` |
| <If lang="javascript,nodejs">connectionId</If><If lang="ruby">connection_id</If><If lang="csharp">ConnectionId</If><If lang="java,objc,swift">connectionId</If> | The connection ID of the publisher of this presence update | `String` |
| <If lang="javascript,nodejs,java,objc,swift,ruby">timestamp</If><If lang="csharp">Timestamp</If> | Timestamp when the presence update was received by Ably<If lang="javascript,nodejs,java">, as milliseconds since the epoch</If>. | <If lang="javascript,nodejs">`Integer`</If><If lang="java">`Long Integer`</If><If lang="csharp">`DateTimeOffset`</If><If lang="ruby">`Time`</If><If lang="objc,swift">`NSDate`</If> |
| <If lang="javascript,nodejs,java,objc,swift,ruby">encoding</If><If lang="csharp">Encoding</If> | This will typically be empty as all presence updates received from Ably are automatically decoded client-side using this value. However, if the message encoding cannot be processed, this attribute will contain the remaining transformations not applied to the `data` payload | `String` |

#### PresenceMessage constructors

#### PresenceMessage.fromEncoded 

<If lang="javascript,nodejs,csharp,java,objc,ruby,swift">

`PresenceMessage.fromEncoded(Object encodedPresMsg, ChannelOptions channelOptions?) → PresenceMessage`

</If>

A static factory method to create a [`PresenceMessage`](https://ably.com/docs/api/realtime-sdk/types.md#presence-message) from a deserialized `PresenceMessage`-like object encoded using Ably's wire protocol.

##### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| encodedPresMsg | a `PresenceMessage`-like deserialized object. | `Object` |
| channelOptions | an optional [`ChannelOptions`](https://ably.com/docs/api/realtime-sdk/types.md#channel-options). If you have an encrypted channel, use this to allow the library to decrypt the data. | `Object` |

##### Returns

A [`PresenceMessage`](https://ably.com/docs/api/realtime-sdk/types.md#presence-message) object

#### PresenceMessage.fromEncodedArray 

<If lang="javascript,nodejs,csharp,java,objc,ruby,swift">

`PresenceMessage.fromEncodedArray(Object[] encodedPresMsgs, ChannelOptions channelOptions?) → PresenceMessage[]`

</If>

A static factory method to create an array of [`PresenceMessages`](https://ably.com/docs/api/realtime-sdk/types.md#presence-message) from an array of deserialized `PresenceMessage`-like object encoded using Ably's wire protocol.

##### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| encodedPresMsgs | an array of `PresenceMessage`-like deserialized objects. | `Array` |
| channelOptions | an optional [`ChannelOptions`](https://ably.com/docs/api/realtime-sdk/types.md#channel-options). If you have an encrypted channel, use this to allow the library to decrypt the data. | `Object` |

##### Returns

An `Array` of [`PresenceMessage`](https://ably.com/docs/api/realtime-sdk/types.md#presence-message) objects

### <If lang="javascript,nodejs">Presence action</If><If lang="swift,objc">ARTPresenceAction</If><If lang="java">io.ably.lib.types.PresenceMessage.Action</If><If lang="ruby">Ably::Models::PresenceMessage::ACTION</If><If lang="csharp">IO.Ably.PresenceAction</If> 

<If lang="javascript,nodejs">

`Presence` `action` is a String with a value matching any of the [Realtime Presence states & events](https://ably.com/docs/presence-occupancy/presence.md#trigger-events).

<Code>

#### Javascript

```
var PresenceActions = [
  'absent', // (reserved for internal use)
  'present',
  'enter',
  'leave',
  'update'
]
```
</Code>

</If>

<If lang="java">

`io.ably.lib.types.PresenceMessage.Action` is an enum representing all the [Realtime Presence states & events](https://ably.com/docs/presence-occupancy/presence.md#trigger-events).

<Code>

#### Java

```
public enum Action {
  ABSENT,  // 0 (reserved for internal use)
  PRESENT, // 1
  ENTER,   // 2
  LEAVE,   // 3
  UPDATE   // 4
}
```
</Code>

</If>

<If lang="csharp">

`IO.Ably.PresenceAction` is an enum representing all the [Realtime Presence states & events](https://ably.com/docs/presence-occupancy/presence.md#trigger-events).

<Code>

#### Csharp

```
public enum Action {
  Absent,  // 0 (reserved for internal use)
  Present, // 1
  Enter,   // 2
  Leave,   // 3
  Update   // 4
}
```
</Code>

</If>

<If lang="ruby">

`Ably::Models::PresenceMessage::ACTION` is an enum-like value representing all the [Realtime Presence states & events](https://ably.com/docs/presence-occupancy/presence.md#trigger-events). `ACTION` can be represented interchangeably as either symbols or constants.

#### Symbol states

<Code>

##### Ruby

```
:absent  # => 0 (reserved for internal use)
:present # => 1
:enter   # => 2
:leave   # => 3
:update  # => 4
```
</Code>

#### Constant states

<Code>

##### Ruby

```
PresenceMessage::ACTION.Absent  # => 0 (internal use)
PresenceMessage::ACTION.Present # => 1
PresenceMessage::ACTION.Enter   # => 2
PresenceMessage::ACTION.Leave   # => 3
PresenceMessage::ACTION.Update  # => 4
```
</Code>

#### Example usage

<Code>

##### Ruby

```
# Example with symbols
presence.on(:attached) { ... }

# Example with constants
presence.on(Ably::Models::PresenceMessage::ACTION.Enter) { ... }

# Interchangeable
Ably::Models::PresenceMessage::ACTION.Enter == :enter # => true
```
</Code>

</If>

<If lang="swift,objc">

`ARTPresenceAction` is an enum representing all the [Realtime Presence states & events](https://ably.com/docs/presence-occupancy/presence.md#trigger-events).

<If lang="objc">

<Code>

##### Objc

```
typedef NS_ENUM(NSUInteger, ARTPresenceAction) {
    ARTPresenceAbsent, // reserved for internal use
    ARTPresencePresent,
    ARTPresenceEnter,
    ARTPresenceLeave,
    ARTPresenceUpdate
};
```
</Code>

</If>
<If lang="swift">

<Code>

##### Swift

```
enum ARTPresenceAction : UInt {
  case Absent // reserved for internal use
  case Present
  case Enter
  case Leave
  case Update
}
```
</Code>

</If>
</If>

<If lang="csharp">

### IO.Ably.PaginatedRequestParams 

`HistoryRequestParams` is a type that encapsulates the parameters for a history queries. For example usage see [`Channel#History`](https://ably.com/docs/api/realtime-sdk/history.md#channel-history).

#### Members

| Property | Description | Type |
|----------|-------------|------|
| Start | The start of the queried interval. <br />_Default: `null`_ | `DateTimeOffset` |
| End | The end of the queried interval. <br />_Default: `null`_ | `DateTimeOffset` |
| Limit | By default it is null. Limits the number of items returned by history or stats. <br />_Default: `null`_ | `Integer` |
| Direction | Enum which is either `Forwards` or `Backwards`. <br />_Default: `Backwards`_ | `Direction` enum |
| ExtraParameters | Optionally any extra query parameters that may be passed to the query. This is mainly used internally by the library to manage paging. | `Dictionary<string, string>` |

</If>

### <If lang="javascript,nodejs">PaginatedResult</If><If lang="swift,objc">ARTPaginatedResult</If><If lang="ruby">Ably::Models::PaginatedResult</If><If lang="java">io.ably.lib.types.PaginatedResult</If><If lang="csharp">IO.Ably.PaginatedResult</If> 

A `PaginatedResult` is a type that represents a page of results for all message and presence history, stats and REST presence requests. The response from a [Ably REST API paginated query](https://ably.com/docs/api/rest-api.md#pagination) is accompanied by metadata that indicates the relative queries available to the `PaginatedResult` object.

#### Properties

| Property | Description | Type |
|----------|-------------|------|
| <If lang="javascript,nodejs,java,objc,swift,ruby">items</If><If lang="csharp">Items</If> | contains the current page of results (for example an Array of [`Message`](#message) or [`PresenceMessage`](#presence-message) objects for a channel history request) | <If lang="javascript,nodejs,java,objc,swift,ruby">`Array <Message, Presence, Stats>`</If><If lang="csharp">`List <Message, Presence, Stats>`</If> |

#### Methods

#### <If lang="javascript,nodejs,java,objc,swift,ruby">first</If><If lang="csharp">First</If>

<If lang="javascript,nodejs">

`first(): Promise<PaginatedResult>`

Returns a promise. On success, the promise is fulfilled with a new [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/history.md#paginated-result) for the first page of results. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="java,swift,objc,ruby">

<If lang="java,ruby">

`PaginatedResult first()`

</If>
<If lang="objc,swift">

`first(callback: (ARTPaginatedResult?, ARTErrorInfo?) → Void)`

</If>

Returns a new `PaginatedResult` for the first page of results. <If lang="ruby">When using the Realtime library, the `first` method returns a [Deferrable](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and yields a [PaginatedResult](#paginated-result).</If>

</If>

<If lang="csharp">

`Task<PaginatedResult<T>> FirstAsync()`

Returns a new `PaginatedResult` for the first page of results. The method is asynchronous and returns a Task which needs to be awaited to get the [PaginatedResult](#paginated-result).

</If>

#### <If lang="javascript,nodejs,java,objc,swift">hasNext</If><If lang="csharp">HasNext</If><If lang="ruby">has_next?</If>

<If lang="javascript,nodejs">

`Boolean hasNext()`

</If>
<If lang="csharp">

`Boolean HasNext()`

</If>
<If lang="java,objc,swift">

`Boolean hasNext()`

</If>
<If lang="ruby">

`Boolean has_next?`

</If>

Returns `true` if there are more pages available by calling <If lang="javascript,nodejs,java,objc,swift,ruby">`next`</If><If lang="csharp">`Next`</If> and returns `false` if this page is the last page available.

#### <If lang="javascript,nodejs,java,objc,swift">isLast</If><If lang="csharp">IsLast</If><If lang="ruby">last?</If>

<If lang="javascript,nodejs">

`Boolean isLast()`

</If>
<If lang="csharp">

`Boolean IsLast()`

</If>
<If lang="java,objc,swift">

`Boolean isLast()`

</If>
<If lang="ruby">

`Boolean last?`

</If>

Returns `true` if this page is the last page and returns `false` if there are more pages available by calling <If lang="javascript,nodejs,java,objc,swift,ruby">`next`</If><If lang="csharp">`Next`</If> available.

#### <If lang="javascript,nodejs,java,objc,swift,ruby">next</If><If lang="csharp">Next</If>

<If lang="javascript,nodejs">

`next(): Promise<PaginatedResult | null>`

Returns a promise. On success, the promise is fulfilled with a new `PaginatedResult` loaded with the next page of results. If there are no further pages, then `null` is returned. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="java,objc,swift,ruby">

<If lang="objc,swift">

`next(callback: (ARTPaginatedResult?, ARTErrorInfo?) → Void)`

</If>
<If lang="java,ruby">

`PaginatedResult next()`

</If>

Returns a new `PaginatedResult` loaded with the next page of results. If there are no further pages, then <If lang="java">`Null`</If><If lang="objc,swift">`nil`</If><If lang="ruby">`null`</If> is returned. <If lang="ruby">When using the Realtime library, the `first` method returns a [Deferrable](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and yields a [PaginatedResult](#paginated-result).</If>

</If>

<If lang="csharp">

`Task<PaginatedResult<T>> NextAsync()`

Returns a new [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/history.md#paginated-result) loaded with the next page of results. If there are no further pages, then a blank PaginatedResult will be returned. The method is asynchronous and return a Task which needs to be awaited to get the `PaginatedResult`

</If>

<If lang="javascript,nodejs">

#### current

`current(): Promise<PaginatedResult>`

Returns a promise. On success, the promise is fulfilled with a new `PaginatedResult` loaded with the current page of results. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

#### Example 

<If lang="javascript">

<Code>

##### Javascript

```
const paginatedResult = await channel.history();
console.log('Page 0 item 0:' + paginatedResult.items[0].data);
const nextPage = await paginatedResult.next();
console.log('Page 1 item 1: ' + nextPage.items[1].data);
console.log('Last page?: ' + nextPage.isLast());
```
</Code>

</If>

<If lang="nodejs">

<Code>

##### Nodejs

```
const paginatedResult = await channel.history();
console.log('Page 0 item 0:' + paginatedResult.items[0].data);
const nextPage = await paginatedResult.next();
console.log('Page 1 item 1: ' + nextPage.items[1].data);
console.log('Last page?: ' + nextPage.isLast());
```
</Code>

</If>

<If lang="java">

<Code>

##### Java

```
PaginatedResult firstPage = channel.history();
System.out.println("Page 0 item 0:" + firstPage.items[0].data);
if (firstPage.hasNext) {
  PaginatedResult nextPage = firstPage.next();
  System.out.println("Page 1 item 1:" + nextPage.items[1].data);
  System.out.println("More pages?:" + Strong.valueOf(nextPage.hasNext()));
};
```
</Code>

</If>

<If lang="csharp">

<Code>

##### Csharp

```
PaginatedResult<Message> firstPage = await channel.HistoryAsync(null);
Message firstMessage = firstPage.Items[0];
Console.WriteLine("Page 0 item 0: " + firstMessage.data);
if (firstPage.HasNext)
{
    var nextPage = await firstPage.NextAsync();
    Console.WriteLine("Page 1 item 1:" + nextPage.Items[1].data);
    Console.WriteLine("More pages?: " + nextPage.HasNext());
}
```
</Code>

</If>

<If lang="ruby">

<Code>

##### Ruby

```
# When using the REST sync library
first_page = channel.history
puts "Page 0 item 0: #{first_page.items[0].data}"
if first_page.has_next?
  next_page = first_page.next
  puts "Page 1 item 1: #{next_page.items[1].data}"
  puts "Last page?: #{next_page.is_last?}"
end

# When using the Realtime EventMachine library
channel.history do |first_page|
  puts "Page 0 item 0: #{first_page.items[0].data}"
  if first_page.has_next?
    first_page.next do |next_page|
      puts "Page 1 item 1: #{next_page.items[1].data}"
      puts "Last page?: #{next_page.is_last?}"
    end
  end
end
```
</Code>

</If>

<If lang="objc">

<Code>

##### Objc

```
[channel history:^(ARTPaginatedResult<ARTMessage *> *paginatedResult, ARTErrorInfo *error) {
    NSLog(@"Page 0 item 0: %@", paginatedResult.items[0].data);
    [paginatedResult next:^(ARTPaginatedResult<ARTMessage *> *nextPage, ARTErrorInfo *error) {
        NSLog(@"Page 1 item 1: %@", nextPage.items[1].data);
        NSLog(@"Last page?: %d", nextPage.isLast());
    }];
}];
```
</Code>

</If>

<If lang="swift">

<Code>

##### Swift

```
channel.history { paginatedResult, error in
    guard let paginatedResult = paginatedResult else {
        print("No results available")
        return
    }
    print("Page 0 item 0: \((paginatedResult.items[0] as! ARTMessage).data)")
    paginatedResult.next { nextPage, error in
        guard let nextPage = nextPage else {
            print("No next page available")
            return
        }
        print("Page 1 item 1: \((nextPage.items[1] as! ARTMessage).data)")
        print("Last page? \(nextPage.isLast())")
    }
}
```
</Code>

</If>

### <If lang="java">io.ably.lib.types.Param</If> 

<If lang="java">

`Param` is a type encapsulating a key/value pair. This type is used frequently in method parameters allowing key/value pairs to be used more flexible, see [`Channel#history`](https://ably.com/docs/api/realtime-sdk/history.md#channel-history) for an example.

Please note that `key` and `value` attributes are always strings. If an `Integer` or other value type is expected, then you must coerce that type into a `String`.

#### Members

| Property | Description | Type |
|----------|-------------|------|
| key | The key value | `String` |
| value | The value associated with the `key` | `String` |

</If>

## Related Topics

- [Constructor](https://ably.com/docs/api/realtime-sdk.md): Realtime Client Library SDK API reference section for the constructor object.
- [Connection](https://ably.com/docs/api/realtime-sdk/connection.md): Realtime Client Library SDK API reference section for the connection object.
- [Channels](https://ably.com/docs/api/realtime-sdk/channels.md): Realtime Client Library SDK API reference section for the channels and channel objects.
- [Channel Metadata](https://ably.com/docs/api/realtime-sdk/channel-metadata.md): Realtime Client Library SDK API reference section for channel metadata.
- [Messages](https://ably.com/docs/api/realtime-sdk/messages.md): Realtime Client Library SDK API reference section for the message object.
- [Presence](https://ably.com/docs/api/realtime-sdk/presence.md): Realtime Client Library SDK API reference section for the presence object.
- [Authentication](https://ably.com/docs/api/realtime-sdk/authentication.md): Realtime Client Library SDK API reference section for authentication.
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
