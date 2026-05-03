# Push Notifications - Admin

## Push Admin object 

This object is accessible through `client.push.admin` and provides:

### <If lang="javascript,nodejs,java,android,php,swift,objc">Push Admin Properties</If><If lang="ruby">Push::Admin Properties</If> 

The push admin object exposes the following public <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">properties</If>:

#### <If lang="javascript,nodejs,java,android,php,swift,objc">deviceRegistrations</If><If lang="ruby">device_registrations</If> 

The returned [`DeviceRegistrations`](#device-registrations-object) object provides functionality for registering, updating, listing and de-registering push devices.

#### <If lang="javascript,nodejs,java,android,php,swift,objc">channelSubscriptions</If><If lang="ruby">channel_subscriptions</If> 

The returned [`PushChannelSubscriptions`](#push-channel-subscriptions) object provides functionality for subscribing, listing and unsubscribing individual devices or groups of [identified devices](https://ably.com/docs/auth/identified-clients.md) to push notifications published on channels.

### Methods 

#### <If lang="javascript,nodejs,java,android,ruby,php,swift,objc">publish</If> 

<If lang="javascript,nodejs">

`publish(Object recipient, Object payload): Promise<void>`

</If>

<If lang="ruby">

`Deferrable publish(Hash recipient, Hash data) -> yield`

</If>

<If lang="php">

`publish(Array recipient, Array data)`

</If>

<If lang="swift,objc">

`publish(recipient: ARTPushRecipient, data: AnyObject?, callback: ((ARTErrorInfo?) -> Void)?)`

</If>

<If lang="java,android">

`void publish(String recipient, Object data, CompletionListener listener)`

</If>

Publishes a push notification directly to a device or group of devices sharing a [client identifier](https://ably.com/docs/auth/identified-clients.md). See the [push notification direct publishing documentation](https://ably.com/docs/push/publish.md#direct-publishing) for more information.

##### Parameters

<If lang="javascript,nodejs">

| Parameter | Description | Type |
|-----------|-------------|------|
| recipient | an object containing the push recipient details. See the [push notification publish REST API documentation](https://ably.com/docs/api/rest-api.md#push-publish) for details on the supported recipient fields | Object |
| payload | an object containing the push notification data. See the [push admin payload structure](https://ably.com/docs/push/publish.md#payload) for details on the supported push payload fields | Object |

</If>

<If lang="java,android">

| Parameter | Description | Type |
|-----------|-------------|------|
| recipient | an object containing the push recipient details. See the [push notification publish REST API documentation](https://ably.com/docs/api/rest-api.md#push-publish) for details on the supported recipient fields | Object |
| data | an object containing the push notification data. See the [push admin payload structure](https://ably.com/docs/push/publish.md#payload) for details on the supported push payload fields | Object |
| listener | Listener to be notified on completion | [`CompletionListener`](#completion-listener) |

</If>

<If lang="swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| recipient | an object containing the push recipient details. See the [push notification publish REST API documentation](https://ably.com/docs/api/rest-api.md#push-publish) for details on the supported recipient fields | Object |
| data | an object containing the push notification data. See the [push admin payload structure](https://ably.com/docs/push/publish.md#payload) for details on the supported push payload fields | Object |
| callback | called upon publishing the message, or with an error | Callback |

</If>

<If lang="ruby">

| Parameter | Description | Type |
|-----------|-------------|------|
| recipient | a Hash containing the push recipient details. See the [push notification publish REST API documentation](https://ably.com/docs/api/rest-api.md#push-publish) for details on the supported recipient fields | Object |
| data | a Hash containing the push notification data. See the [push admin payload structure](https://ably.com/docs/push/publish.md#payload) for details on the supported push payload fields | Object |
| &block | yielded upon success | Block |

</If>

<If lang="php">

| Parameter | Description | Type |
|-----------|-------------|------|
| recipient | an array containing the push recipient details. See the [push notification publish REST API documentation](https://ably.com/docs/api/rest-api.md#push-publish) for details on the supported recipient fields | Object |
| data | an array containing the push notification data. See the [push admin payload structure](https://ably.com/docs/push/publish.md#payload) for details on the supported push payload fields | Object |

</If>

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success to publish the push notification, the promise resolves. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="swift,objc">

##### Callback result

The callback is called upon success or failure to publish the push notification. When this operation fails, `err` contains an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

<If lang="ruby">

##### Returns

A [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) object is returned from the method.

On success, the registered success blocks for the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and any block provided to the method are yielded to.

Failure to publish the push notification will trigger the `errback` callback of the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

<If lang="java,android">

##### Listener result

On successful publish of the message, the `onSuccess` method of the [CompletionListener](#completion-listener) is called. On failure to publish the message, the `onError` method is called with an [`ErrorInfo`](#error-info) argument describing the failure reason.

</If>

## <If lang="javascript,nodejs">PushDeviceRegistrations object</If><If lang="java,android,ruby,php,swift,objc">DeviceRegistrations object</If> 

This object is accessible through <If lang="javascript,nodejs,java,android,php,swift,objc">`client.push.admin.deviceRegistrations`</If><If lang="ruby">`client.push.admin.device_registrations`</If> and provides an API to register new push notification devices, update existing devices, deregister old devices, and retrieve or list devices registered to an app.

### Methods 

#### <If lang="javascript,nodejs,java,android,ruby,php,swift,objc">get</If> 

<If lang="javascript,nodejs">

`get(String deviceId): Promise<DeviceDetails>`

</If>

<If lang="ruby">

`Deferrable get(String deviceId) -> yields DeviceDetails`

</If>

<If lang="php">

`DeviceDetails get(String deviceId)`

`get(DeviceDetails device, callback(ErrorInfo err, DeviceDetails device))`

</If>

<If lang="swift,objc">

`get(deviceId: ArtDeviceId, callback: ((ARTDeviceDetails?, ARTErrorInfo?) -> Void))`

</If>

<If lang="java,android">

`DeviceDetails get(String deviceId)`

`getAsync(String deviceId, Callback<DeviceDetails> callback)`

`get(DeviceDetails device, callback(ErrorInfo err, DeviceDetails device))`

</If>

<If lang="javascript,nodejs">

`get(DeviceDetails deviceDetails): Promise<DeviceDetails>`

</If>

<If lang="ruby">

`Deferrable get(DeviceDetails device) -> yields DeviceDetails`

</If>

Obtain the `DeviceDetails` for a device registered for receiving push registrations matching the `deviceId` argument, or the `id` attribute of the provided `DeviceDetails` object. Requires `push-admin` permission or `push-subscribe` permission together with device authentication matching the requested `deviceId`.

##### Parameters

<If lang="javascript,nodejs,java,android,php,swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| deviceId | the unique device ID String for the requested device | String |
| <If lang="javascript,nodejs">deviceDetails</If><If lang="java,android,php,swift,objc">device</If> | a [`DeviceDetails`](#device-details) object containing at a minimum the `deviceId` of the requested device | Object |

</If>

<If lang="ruby">

| Parameter | Description | Type |
|-----------|-------------|------|
| deviceId | the unique device ID String for the requested device | String |
| device | a [`DeviceDetails`](#device-details) object containing at a minimum the `deviceId` of the requested device | Object |
| &block | yields a `DeviceDetails` object upon success | Block |

</If>

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success, the promise is fulfilled with a [`DeviceDetails`](#device-details) object representing the device registered for push notifications. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="swift,objc">

##### Callback result

On success, `device` contains the device registered for push notifications as a [`DeviceDetails`](#device-details) object.

On failure to retrieve the device, `err` contains an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

<If lang="ruby">

##### Returns

A [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) object is returned from the method.

On success, the registered success blocks for the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and any block provided to the method yield the device registered for push notifications as a [`DeviceDetails`](#device-details) object.

Failure to retrieve the device will trigger the `errback` callbacks of the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

<If lang="java,android">

##### Listener result

On successful publish of the message, the `onSuccess` method of the [CompletionListener](#completion-listener) is called. On failure to get the device, the `onError` method is called with an [`ErrorInfo`](#error-info) argument describing the failure reason.

</If>

#### <If lang="javascript,nodejs,java,android,ruby,php,swift,objc">list</If> 

<If lang="javascript,nodejs">

`list(Object params): Promise<PaginatedResult<DeviceDetails>>`

</If>

<If lang="ruby">

`Deferrable list(Hash params) -> yields PaginatedResult<DeviceDetails>`

</If>

<If lang="php">

`PaginatedResult list_(Array params)`

</If>

<If lang="swift,objc">

`list(params: NSDictionary *, callback: ((ARTPaginatedResult?, ARTErrorInfo?) -> Void))`

</If>

<If lang="java,android">

`PaginatedResult list(Param[] params)`

</If>

Retrieve all devices matching the params filter as a paginated list of [`DeviceDetails`](#device-details) objects. Requires `push-admin` permission.

##### Parameters

<If lang="javascript,nodejs,java,android,php,swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs,php,swift,objc">params</If><If lang="java,android">params</If> | an object containing the query parameters as key value pairs as specified below. | <If lang="javascript,nodejs,php,swift,objc">Object</If><If lang="java,android">[`Param[]`](#param)</If> |

</If>

<If lang="ruby">

| Parameter | Description | Type |
|-----------|-------------|------|
| params | an object containing the query parameters as key value pairs as specified below. | Object |
| &block | yields a `PaginatedResult<DeviceDetails>` object | Block |

</If>

##### `params` properties

<If lang="java,android,php,swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| clientId | optional filter to restrict to devices associated with that client identifier. Cannot be used with a `deviceId` param | String |
| deviceId | optional filter to restrict to devices associated with that device identifier. Cannot be used with a `clientId` param | String |
| limit | maximum number of devices per page to retrieve, up to 1,000<br />_default: 100_ | Integer |

</If>

<If lang="ruby">

| Parameter | Description | Type |
|-----------|-------------|------|
| :client_id | optional filter to restrict to devices associated with that client identifier. Cannot be used with a `:device_id` param | String |
| :device_id | optional filter to restrict to devices associated with that device identifier. Cannot be used with a `:client_id` param | String |
| :limit | maximum number of devices per page to retrieve, up to 1,000<br />_default: 100_ | Integer |

</If>

<If lang="javascript,nodejs">

| Parameter | Description | Type |
|-----------|-------------|------|
| clientId | optional filter to restrict to devices associated with that client identifier. Cannot be used with a `deviceId` param | String |
| deviceId | optional filter to restrict to devices associated with that device identifier. Cannot be used with a `clientId` param | String |
| limit | maximum number of devices per page to retrieve, up to 1,000<br />_default: 100_ | Integer |
| state | optional filter by the state of the device. Must be one of `ACTIVE`, `FAILING` or `FAILED` | String |

</If>

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success, the promise is fulfilled with a [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) encapsulating an array of [`DeviceDetails`](#device-details) objects corresponding to the current page of results. [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) supports pagination using [`next()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) and [`first()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) methods.

On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="objc,swift">

##### Callback result

On success, `resultPage` contains a [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) encapsulating an array of [`DeviceDetails`](#device-details) objects corresponding to the current page of results. [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) supports pagination using [`next()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) and [`first()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) methods.

On failure to retrieve the devices, `err` contains an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

<If lang="ruby">

##### Returns

A [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) object is returned from the method.

On success, the registered success blocks for the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and any block provided to the method yield a [PaginatedResult](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) that encapsulates an array of [`DeviceDetails`](#device-details) corresponding to the current page of results. [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) supports pagination using [`next()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) and [`first()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) methods.

Failure to retrieve the devices will trigger the `errback` callbacks of the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

#### <If lang="javascript,nodejs,java,android,ruby,php,swift,objc">save</If> 

<If lang="javascript,nodejs">

`save(DeviceDetails deviceDetails): Promise<DeviceDetails>`

</If>

<If lang="ruby">

`Deferrable save(DeviceDetails device) -> yields DeviceDetails`

</If>

<If lang="php">

`DeviceDetails save(DeviceDetails deviceDetails)`

</If>

<If lang="swift,objc">

`save(deviceDetails: DeviceDetails, callback: ((DeviceDetails?, ARTErrorInfo?) -> Void))`

</If>

<If lang="java,android">

`DeviceDetails save(DeviceDetails deviceDetails)`

</If>

Register a new `DeviceDetails` object, or update an existing `DeviceDetails` object with the Ably service. Requires `push-admin` permission or `push-subscribe` permission together with device authentication matching the requested `deviceId`.

##### Parameters

<If lang="javascript,nodejs,java,android,php,swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs">deviceDetails</If><If lang="java,android,php,swift,objc">device</If> | a [`DeviceDetails`](#device-details) object | Object |

</If>

<If lang="ruby">

| Parameter | Description | Type |
|-----------|-------------|------|
| device | a [`DeviceDetails`](#device-details) object | Object |
| &block | yields the new `DeviceDetails` object upon success | Block |

</If>

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success, the promise is fulfilled with a [`DeviceDetails`](#device-details) object representing the newly registered or updated device. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="swift,objc">

##### Callback result

On success, `device` contains the newly registered or updated device as a [`DeviceDetails`](#device-details) object.

On failure to create or update the device, `err` contains an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

<If lang="ruby">

##### Returns

A [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) object is returned from the method.

On success, the registered success blocks for the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and any block provided to the method yield the newly registered or updated device as a [`DeviceDetails`](#device-details) object.

Failure to create or update the device will trigger the `errback` callbacks of the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

#### <If lang="javascript,nodejs,java,android,ruby,php,swift,objc">remove</If> 

<If lang="javascript,nodejs">

`remove(String deviceId): Promise<void>`

`remove(DeviceDetails deviceDetails): Promise<void>`

</If>

<If lang="ruby">

`Deferrable remove(String deviceId)`

`Deferrable remove(DeviceDetails device) -> yield`

</If>

<If lang="php">

`remove(String deviceId)`

`remove(DeviceDetails deviceDetails)`

</If>

<If lang="swift,objc">

`remove(deviceDetails: DeviceDetails, callback: ((DeviceDetails?, ARTErrorInfo?) -> Void))`

`remove(deviceDetails: DeviceDetails, callback: ((ARTErrorInfo?) -> Void))`

</If>

<If lang="java,android">

`DeviceDetails save(DeviceDetails deviceDetails)`

</If>

Remove a device registered for receiving push registrations that matches the `deviceId` argument, or the `id` attribute of the provided [`DeviceDetails`](#device-details) object. Requires `push-admin` permission or `push-subscribe` permission together with device authentication matching the requested `deviceId`.

##### Parameters

<If lang="javascript,nodejs,java,android,php,swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| deviceId | the unique device ID String for the device | String |
| <If lang="javascript,nodejs">deviceDetails</If><If lang="java,android,php,swift,objc">device</If> | a [`DeviceDetails`](#device-details) object containing at a minimum the `deviceId` of the device | Object |

</If>

<If lang="ruby">

| Parameter | Description | Type |
|-----------|-------------|------|
| deviceId | the unique device ID String for the device | String |
| device | a [`DeviceDetails`](#device-details) object containing at a minimum the `deviceId` of the device | Object |
| &block | yields upon success | Block |

</If>

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success to delete the device, the promise resolves. Note that a request to delete a device that does not exist will result in a successful operation. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="swift,objc">

##### Callback result

The callback is called upon success or failure to delete the device. Note that a request to delete a device that does not exist will result in a successful operation.

When this operation fails, `err` contains an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

<If lang="ruby">

##### Returns

A [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) object is returned from the method.

On success, the registered success blocks for the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and any block provided to the method are yielded to. Note that a request to delete a device that does not exist will result in a successful operation.

Failure to delete the device will trigger the `errback` callbacks of the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

#### <If lang="javascript,nodejs,java,android,php,swift,objc">removeWhere</If><If lang="ruby">remove_where</If> 

<If lang="javascript,nodejs">

`removeWhere(Object params): Promise<void>`

</If>

<If lang="ruby">

`Deferrable remove_where(Hash params) -> yield`

</If>

<If lang="php">

`removeWhere(Array params)`

</If>

<If lang="swift,objc">

`removeWhere(params: NSDictionary *, callback: (ARTErrorInfo?) -> Void)`

</If>

<If lang="java,android">

`removeWhere(Param[] params)`

</If>

Delete all devices matching the params filter. Requires `push-admin` permission.

##### Parameters

<If lang="javascript,nodejs,java,android,php,swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs,php,swift,objc">params</If><If lang="java,android">params</If> | an object containing the filter parameters as key value pairs as specified below. | <If lang="javascript,nodejs,php,swift,objc">Object</If><If lang="java,android">[`Param[]`](#param)</If> |

</If>

<If lang="ruby">

| Parameter | Description | Type |
|-----------|-------------|------|
| params | an object containing the filter parameters as key value pairs as specified below. | Object |
| &block | yields upon success | Block |

</If>

##### `params` properties

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs,java,android,php,swift,objc">clientId</If><If lang="ruby">:client_id</If> | optional filter to restrict to devices associated with that client identifier. Cannot be used with a <If lang="javascript,nodejs,java,android,php,swift,objc">`deviceId`</If><If lang="ruby">`:device_id`</If> param | String |
| <If lang="javascript,nodejs,java,android,php,swift,objc">deviceId</If><If lang="ruby">:device_id</If> | optional filter to restrict to devices associated with that device identifier. Cannot be used with a <If lang="javascript,nodejs,java,android,php,swift,objc">`clientId`</If><If lang="ruby">`:client_id`</If> param | String |

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success to delete the device, the promise resolves. Note that a request that does match any existing devices will result in a successful operation. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="swift,objc">

##### Callback result

The callback is called upon success or failure to delete the device. Note that a request that does match any existing devices will result in a successful operation.

When this operation fails, `err` contains an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

<If lang="ruby">

##### Returns

A [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) object is returned from the method.

On success, the registered success blocks for the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and any block provided to the method are yielded to. Note that a request that does match any existing devices will result in a successful operation.

Failure to delete the device will trigger the `errback` callbacks of the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

## PushChannelSubscriptions object 

This object is accessible through <If lang="javascript,nodejs,java,android,php,swift,objc">`client.push.admin.channelSubscriptions`</If><If lang="ruby">`client.push.admin.channel_subscriptions`</If> and provides an API to subscribe a push notification device to a channel ensuring it receives any push notifications published in the future on that channel. Additionally, this object allows these subscriptions to be retrieved, listed, updated or removed.

### Methods 

#### <If lang="javascript,nodejs,java,android,ruby,php,swift,objc">list</If> 

<If lang="javascript,nodejs">

`list(Object params): Promise<PaginatedResult<PushChannelSubscription>>`

</If>

<If lang="ruby">

`Deferrable list(Hash params) -> yields PaginatedResult<PushChannelSubscription>`

</If>

<If lang="php">

`PaginatedResult list_(Array params)`

</If>

<If lang="swift,objc">

`list(params: NSDictionary *, callback: ((ARTPaginatedResult?, ARTErrorInfo?) -> Void))`

</If>

<If lang="java,android">

`PaginatedResult list(Param[] params)`

</If>

Retrieve all push channel subscriptions that match the provided params filter as a paginated list of [`PushChannelSubscription`](#push-channel-subscription) objects. Each [`PushChannelSubscription`](#push-channel-subscription) represents a device or set of devices sharing the same [client identifier](https://ably.com/docs/auth/identified-clients.md) registered to a channel to receive push notifications.

##### Parameters

<If lang="javascript,nodejs,java,android,php,swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs,php,swift,objc">params</If><If lang="java,android">params</If> | an object containing the query parameters as key value pairs as specified below. | <If lang="javascript,nodejs,php,swift,objc">Object</If><If lang="java,android">[`Param[]`](#param)</If> |

</If>

<If lang="ruby">

| Parameter | Description | Type |
|-----------|-------------|------|
| params | an object containing the query parameters as key value pairs as specified below. | Object |
| &block | yields a `PaginatedResult<PushChannelSubscription>` object | Block |

</If>

##### `params` properties

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs,java,android,php,swift,objc">channel</If><If lang="ruby">:channel</If> | filter to restrict to subscriptions associated with that `channel` | String |
| <If lang="javascript,nodejs,java,android,php,swift,objc">clientId</If><If lang="ruby">:client_id</If> | optional filter to restrict to devices associated with that client identifier. Cannot be used with a <If lang="javascript,nodejs,java,android,php,swift,objc">`deviceId`</If><If lang="ruby">`:device_id`</If> param | String |
| <If lang="javascript,nodejs,java,android,php,swift,objc">deviceId</If><If lang="ruby">:device_id</If> | optional filter to restrict to devices associated with that device identifier. Cannot be used with a <If lang="javascript,nodejs,java,android,php,swift,objc">`clientId`</If><If lang="ruby">`:client_id`</If> param | String |
| <If lang="javascript,nodejs,java,android,php,swift,objc">limit</If><If lang="ruby">:limit</If> | maximum number of channel subscriptions per page to retrieve, up to 1,000<br />_default: 100_ | Integer |

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success, the promise is fulfilled with a [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) encapsulating an array of [`PushChannelSubscription`](#push-channel-subscription) objects corresponding to the current page of results. [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) supports pagination using [`next()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) and [`first()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) methods.

On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="swift,objc">

##### Callback result

On success, `resultPage` contains a [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) encapsulating an array of [`PushChannelSubscription`](#push-channel-subscription) objects corresponding to the current page of results. [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) supports pagination using [`next()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) and [`first()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) methods.

On failure to retrieve the channel subscriptions, `err` contains an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object which contains the failure reason.

</If>

<If lang="ruby">

##### Returns

A [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) object is returned from the method.

On success, the registered success blocks for the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and any block provided to the method yield a [PaginatedResult](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) that encapsulates an array of [`PushChannelSubscription`](#push-channel-subscription) corresponding to the current page of results. [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) supports pagination using [`next()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) and [`first()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) methods.

Failure to retrieve the channel subscriptions will trigger the `errback` callbacks of the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

#### <If lang="javascript,nodejs,java,android,php,swift,objc">listChannels</If><If lang="ruby">list_channels</If> 

<If lang="javascript,nodejs">

`listChannels(Object params): Promise<PaginatedResult<String>>`

</If>

<If lang="ruby">

`Deferrable list_channels(Hash params) -> yields PaginatedResult<String>`

</If>

<If lang="php">

`PaginatedResult listChannels(Array params)`

</If>

<If lang="swift,objc">

`listChannels(params: NSDictionary *, callback: ((ARTPaginatedResult?, ARTErrorInfo?) -> Void))`

</If>

<If lang="java,android">

`PaginatedResult listChannels(Param[] params)`

</If>

Retrieve a list of channels that have at least one device [subscribed to push notifications](https://ably.com/docs/push/publish.md#sub-channels) as a paginated list of channel name `String` objects. Requires `push-admin` permission.

##### Parameters

<If lang="javascript,nodejs,java,android,php,swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs,php,swift,objc">params</If><If lang="java,android">params</If> | an object containing the query parameters as key value pairs as specified below. | <If lang="javascript,nodejs,php,swift,objc">Object</If><If lang="java,android">[`Param[]`](#param)</If> |

</If>

<If lang="ruby">

| Parameter | Description | Type |
|-----------|-------------|------|
| params | an object containing the query parameters as key value pairs as specified below. | Object |
| &block | yields a `PaginatedResult<String>` object | Block |

</If>
##### `params` properties

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs,java,android,php,swift,objc">limit</If><If lang="ruby">:limit</If> | maximum number of channels per page to retrieve, up to 1,000<br />_default: 100_ | Integer |

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success, the promise is fulfilled with a [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) encapsulating an array of channel name `String` values corresponding to the current page of results. [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) supports pagination using [`next()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) and [`first()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) methods.

On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="swift,objc">

##### Callback result

On success, `resultPage` contains a [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) encapsulating an array of channel name `String` values corresponding to the current page of results. [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) supports pagination using [`next()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) and [`first()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) methods.

On failure to retrieve the channels, `err` contains an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

<If lang="ruby">

##### Returns

A [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) object is returned from the method.

On success, the registered success blocks for the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and any block provided to the method yield a [PaginatedResult](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) that encapsulates an array of channel name `String` values corresponding to the current page of results. [`PaginatedResult`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) supports pagination using [`next()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) and [`first()`](https://ably.com/docs/api/realtime-sdk/types.md#paginated-result) methods.

Failure to retrieve the channels will trigger the `errback` callbacks of the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

#### <If lang="javascript,nodejs,java,android,ruby,php,swift,objc">save</If> 

<If lang="javascript,nodejs">

`save(PushChannelSubscription subscription): Promise<PushChannelSubscription>`

</If>

<If lang="ruby">

`save(PushChannelSubscription channel_subscription)`

</If>

<If lang="php">

`PushChannelSubscription save(PushChannelSubscription channelSubscription)`

</If>

<If lang="swift,objc">

`save(channelSubscription: PushChannelSubscription, callback: ((PushChannelSubscription?, ARTErrorInfo?) -> Void))`

</If>

<If lang="java,android">

`PushChannelSubscription save(PushChannelSubscription channelSubscription)`

</If>

Subscribe a device or group of devices sharing a [client identifier](https://ably.com/docs/auth/identified-clients.md) for push notifications published on a channel.

##### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs">subscription</If><If lang="java,android,php,swift,objc">channelSubscription</If><If lang="ruby">channel_subscription</If> | a [`PushChannelSubscription`](#push-channel-subscription) object | Object |

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success, the promise is fulfilled with a [`PushChannelSubscription`](#push-channel-subscription) object representing the newly subscribed or updated push channel subscription. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="swift,objc">

##### Callback result

On success, `channelSubscription` contains the newly subscribed or updated push channel subscription as a [`PushChannelSubscription`](#push-channel-subscription) object.

On failure to create or update the channel subscription, `err` contains an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

#### <If lang="javascript,nodejs,java,android,ruby,php,swift,objc">remove</If> 

<If lang="javascript,nodejs">

`remove(PushChannelSubscription subscription): Promise<void>`

</If>

<If lang="ruby">

`remove(PushChannelSubscription channel_subscription)`

</If>

<If lang="php">

`remove(PushChannelSubscription subscription)`

</If>

<If lang="swift,objc">

`remove(channelSubscription: PushChannelSubscription, callback: ((ARTErrorInfo?) -> Void))`

</If>

<If lang="java,android">

`void save(PushChannelSubscription channelSubscription)`

</If>

Unsubscribe a device or group of devices sharing a [client identifier](https://ably.com/docs/auth/identified-clients.md) from push notifications on a channel. Requires `push-admin` permission or, in the case of a subscription associated with a given `deviceId`, `push-subscribe` permission together with device authentication matching that `deviceId`.

##### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs">subscription</If><If lang="java,android,php,swift,objc">channelSubscription</If><If lang="ruby">channel_subscription</If> | a [`PushChannelSubscription`](#push-channel-subscription) object | Object |

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success to unsubscribe, the promise resolves. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="swift,objc">

##### Callback result

The callback is called upon success or failure to unsubscribe. Note that a request to unsubscribe or remove a subscription that does not exist will result in a successful operation.

When this operation fails, `err` contains an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

#### <If lang="javascript,nodejs,java,android,php,swift,objc">removeWhere</If><If lang="ruby">remove_where</If> 

<If lang="javascript,nodejs">

`removeWhere(Object params): Promise<void>`

</If>

<If lang="ruby">

`remove_where(Hash params)`

</If>

<If lang="php">

`removeWhere(Array params)`

</If>

<If lang="swift,objc">

`removeWhere(params: NSDictionary *, callback: (ARTErrorInfo?) -> Void)`

</If>

<If lang="java,android">

`removeWhere(Param[] params)`

</If>

Delete all push channel subscriptions matching the `params` filter. Requires `push-admin` permission.

##### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs,ruby,php,swift,objc">params</If><If lang="java,android">params</If> | an object containing the filter parameters as key value pairs as specified below. | <If lang="javascript,nodejs,ruby,php,swift,objc">Object</If><If lang="java,android">[`Param[]`](#param)</If> |

##### `params` properties

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs,java,android,php,swift,objc">channel</If><If lang="ruby">:channel</If> | filter to restrict to subscriptions associated with that `channel` | String |
| <If lang="javascript,nodejs,java,android,php,swift,objc">clientId</If><If lang="ruby">:client_id</If> | optional filter to restrict to devices associated with that client identifier. Cannot be used with <If lang="javascript,nodejs,java,android,php,swift,objc">`deviceId`</If><If lang="ruby">`:device_id`</If> param | String |
| <If lang="javascript,nodejs,java,android,php,swift,objc">deviceId</If><If lang="ruby">:device_id</If> | optional filter to restrict to devices associated with that device identifier. Cannot be used with <If lang="javascript,nodejs,java,android,php,swift,objc">`clientId`</If><If lang="ruby">`:client_id`</If> param | String |

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success to unsubscribe, the promise resolves. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="swift,objc">

##### Callback result

The callback is called upon success or failure to unsubscribe. Note that a request to unsubscribe or remove a subscription that does not exist will result in a successful operation.

When this operation fails, `err` contains an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

## Related types 

### <If lang="javascript,nodejs,java,android,php">DeviceDetails</If><If lang="ruby">Ably::Models::DeviceDetails</If><If lang="swift,objc">ARTDeviceDetails</If> 

A `DeviceDetails` is a type encapsulating attributes of a device registered for push notifications.

#### <If lang="javascript,nodejs,java,android,php,swift,objc">Properties</If><If lang="ruby">Attributes</If>

| Property | Description | Type |
|----------|-------------|------|
| id | unique identifier for the device generated by the device itself | String |
| <If lang="javascript,nodejs,java,android,php,swift,objc">clientId</If><If lang="ruby">client_id</If> | optional trusted [client identifier](https://ably.com/docs/auth/identified-clients.md) for the device | String |
| <If lang="javascript,nodejs,java,android,php,swift,objc">formFactor</If><If lang="ruby">form_factor</If> | form factor of the push device. Must be one of `phone`, `tablet`, `desktop`, `tv`, `watch`, `car` <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">or `embedded`</If><If lang="javascript,nodejs">or `other`</If> | String |
| <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">metadata</If> | optional metadata object for this device. The metadata for a device may only be set by clients with `push-admin` privileges | <If lang="javascript,nodejs,java,android,swift,objc">Object</If><If lang="php">Array</If><If lang="ruby">Hash</If> |
| <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">platform</If> | platform of the push device. Must be one of `ios` <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">or `android`</If><If lang="javascript,nodejs">or `browser`</If> | String |
| <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">deviceSecret</If> | Secret value for the device. | String |
| push.recipient | push recipient details for this device. See the [REST API push publish documentation](https://ably.com/docs/api/rest-api.md#message-extras-push) for more details | <If lang="javascript,nodejs,java,android,swift,objc">Object</If><If lang="php">Array</If><If lang="ruby">Hash</If> |
| push.state | the current state of the push device being either <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">`Active`, `Failing` or `Failed`</If><If lang="javascript,nodejs">`ACTIVE`, `FAILING` or `FAILED`</If> | String |
| <If lang="java,android,php,swift,objc">push.errorReason</If><If lang="javascript,nodejs">push.error</If><If lang="ruby">push.error_reason</If> | when the device's state is failing or failed, this attribute contains the reason for the most recent failure | [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) |

### <If lang="javascript,nodejs,java,android,php,objc,swift">PushChannel</If><If lang="ruby">Ably::Models::PushChannel</If> 

A `PushChannel` is a property of a [`RealtimeChannel`](https://ably.com/docs/api/realtime-sdk/channels.md#properties) or [`RestChannel`](https://ably.com/docs/api/rest-sdk/channels.md#properties). It provides [push devices](https://ably.com/docs/push.md) the ability to subscribe and unsubscribe to push notifications on channels.

#### Methods

##### <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">subscribeDevice</If> 

<If lang="javascript,nodejs">

`subscribeDevice(): Promise<void>`

</If>

Subscribe your device to the channel's push notifications.

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success, the promise resolves. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

##### <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">subscribeClient</If> 

<If lang="javascript,nodejs">

`subscribeClient(): Promise<void>`

</If>

[Subscribe all devices associated with your device's clientId](https://ably.com/docs/push/publish.md#sub-channels) to the channel's push notifications.

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success, the promise resolves. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

##### <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">unsubscribeDevice</If> 

<If lang="javascript,nodejs">

`unsubscribeDevice(): Promise<void>`

</If>

Unsubscribe your device from the channel's push notifications.

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success, the promise resolves. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

##### <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">unsubscribeClient</If> 

<If lang="javascript,nodejs">

`unsubscribeClient(): Promise<void>`

</If>

[Unsubscribe all devices associated with your device's clientId](https://ably.com/docs/push/publish.md#sub-channels) from the channel's push notifications.

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success, the promise resolves. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

##### <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">listSubscriptions</If> 

<If lang="javascript,nodejs">

`listSubscriptions(Record<string, string> params?): Promise<PaginatedResult<PushChannelSubscription>>`

</If>

<If lang="java,android">

`PaginatedResult<PushChannelSubscription> listSubscriptions(String deviceId, String clientId, String deviceClientId, String channel)`

</If>

<If lang="objc,swift">

`listSubscriptions(deviceId: String?, clientId: String?, deviceClientId: String?, channel: String?, callback: (ARTPaginatedResult<PushChannelSubscription>?, ARTErrorInfo?) -> Void)`

</If>

Lists push subscriptions on a channel specified by its channel name (`channel`). These subscriptions can be either be a list of client (`clientId`) subscriptions, device (`deviceId`) subscriptions, or if `concatFilters` is set to `true`, a list of both. This method requires clients to have the [Push Admin capability](https://ably.com/docs/push.md#push-admin). For more information, see `GET main.realtime.ably.net/push/channelSubscriptions` [Rest API](https://ably.com/docs/api/rest-api.md).

##### Parameters

<If lang="java,android,ruby,php">

| Parameter | Description | Type |
|-----------|-------------|------|
| deviceId | a deviceId to filter by | String |
| clientId | a clientId to filter by | String |
| deviceClientId | a client ID associated with a device to filter by | String |

</If>

<If lang="swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| deviceId | a deviceId to filter by | String |
| clientId | a clientId to filter by | String |
| deviceClientId | a client ID associated with a device to filter by | String |
| callback | called with a [`ARTPaginatedResult`](#paginated-result)\<[`PushChannelSubscription`](https://ably.com/docs/api/realtime-sdk/push-admin.md#push-channel-subscription)> object or an error | Callback |

</If>

<If lang="javascript,nodejs">

| Parameter | Description | Type |
|-----------|-------------|------|
| deviceId | a deviceId to filter by | String |
| clientId | a clientId to filter by | String |
| deviceClientId | a client ID associated with a device to filter by | String |
| params | An optional object containing key-value pairs to filter subscriptions by. Can contain `clientId`, `deviceId` or a combination of both, and a `limit` on the number of subscriptions returned, up to 1,000 | Record\<string, string> |

</If>

<If lang="javascript,nodejs">

##### Returns

Returns a promise. On success, the promise is fulfilled with [`PaginatedResult`](#paginated-result) which encapsulates an array of [PushChannelSubscription](#push-channel-subscription) objects corresponding to the current page of results. [`PaginatedResult`](#paginated-result) supports pagination using [`next`](#paginated-result) and [`first`](#paginated-result) methods. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="objc,swift">

##### Callback result

On success, `resultPage` contains a [`PaginatedResult`](#paginated-result) encapsulating an array of [PushChannelSubscription](https://ably.com/docs/api/realtime-sdk/push-admin.md#push-channel-subscription) objects corresponding to the current page of results. [`PaginatedResult`](#paginated-result) supports pagination using [`next()`](#paginated-result) and [`first()`](#paginated-result) methods.

On failure to retrieve message history, `err` contains an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the failure reason.

</If>

<If lang="java,android">

##### Returns

On success, the returned [`PaginatedResult`](#paginated-result) encapsulates an array of [PushChannelSubscription](#push-channel-subscription) objects corresponding to the current page of results. [`PaginatedResult`](#paginated-result) supports pagination using [`next`](#paginated-result) and [`first`](#paginated-result) methods.

Failure to retrieve the message history will raise an [`AblyException`](https://ably.com/docs/api/realtime-sdk/types.md#ably-exception)

</If>

### <If lang="javascript,nodejs,php">PushChannelSubscription</If><If lang="ruby">Ably::Models::PushChannelSubscription</If><If lang="java,android">ChannelSubscription</If><If lang="swift,objc">ARTPushChannelSubscription</If> 

An `PushChannelSubscription` is a type encapsulating the subscription of a device or group of devices sharing a [client identifier](https://ably.com/docs/auth/identified-clients.md) to a channel in order to receive push notifications.

#### <If lang="javascript,nodejs,java,android,php,swift,objc">Properties</If><If lang="ruby">Attributes</If>

| Property | Description | Type |
|----------|-------------|------|
| channel | the channel that this push notification subscription is associated with | String |
| <If lang="javascript,nodejs,java,android,php,swift,objc">deviceId</If><If lang="ruby">device_id</If> | the device with this identifier is linked to this channel subscription. When present, <If lang="javascript,nodejs,java,android,php,swift,objc">`clientId`</If><If lang="ruby">`client_id`</If> is never present | String |
| <If lang="javascript,nodejs,java,android,php,swift,objc">clientId</If><If lang="ruby">client_id</If> | devices with this [client identifier](https://ably.com/docs/auth/identified-clients.md) are included in this channel subscription. When present, <If lang="javascript,nodejs,java,android,php,swift,objc">`deviceId`</If><If lang="ruby">`device_id`</If> is never present | String |

<If lang="java,android,php,ruby,swift,objc">

#### PushChannelSubscription constructors

##### <If lang="java,android,php,swift,objc">PushChannelSubscription.forDevice</If><If lang="ruby">PushChannelSubscription.for_device</If> 

<If lang="java,android,php,swift,objc">

`PushChannelSubscription.forDevice(String channel, String deviceId) -> PushChannelSubscription`

</If>

<If lang="ruby">

`PushChannelSubscription.for_device(String channel, String device_id) -> PushChannelSubscription`

</If>

A static factory method to create a `PushChannelSubscription` object for a channel and single device.

##### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| channel | channel name linked to this push channel subscription | String |
| <If lang="java,android,php,swift,objc">deviceId</If><If lang="ruby">device_id</If> | the device with this identifier will be linked with this push channel subscription | String |

##### Returns

A [`PushChannelSubscription`](https://ably.com/docs/api/realtime-sdk/types.md#push-channel-subscription) object

##### <If lang="java,android,php,swift,objc">PushChannelSubscription.forClient</If><If lang="ruby">PushChannelSubscription.for_client</If> 

<If lang="java,android,php,swift,objc">

`PushChannelSubscription.forClient(String channel, String clientId) -> PushChannelSubscription`

</If>

<If lang="ruby">

`PushChannelSubscription.for_client(String channel, String client_id) -> PushChannelSubscription`

</If>

A static factory method to create a `PushChannelSubscription` object for a channel and group of devices sharing a [client identifier](https://ably.com/docs/auth/identified-clients.md).

##### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| channel | channel name linked to this push channel subscription | String |
| <If lang="javascript,nodejs,java,android,php,swift,objc">clientId</If><If lang="ruby">client_id</If> | devices with this [client identifier](https://ably.com/docs/auth/identified-clients.md) are included in the new push channel subscription | String |

##### Returns

A `PushChannelSubscription` object

</If>

### <If lang="javascript,nodejs,php">PaginatedResult</If><If lang="swift,objc">ARTPaginatedResult</If><If lang="ruby">Ably::Models::PaginatedResult</If><If lang="java,android">io.ably.lib.types.PaginatedResult</If> 

A `PaginatedResult` is a type that represents a page of results for all message and presence history, stats and REST presence requests. The response from a [Ably REST API paginated query](https://ably.com/docs/api/rest-api.md#pagination) is accompanied by metadata that indicates the relative queries available to the `PaginatedResult` object.

#### <If lang="javascript,nodejs,php,swift,objc">Properties</If><If lang="ruby">Attributes</If><If lang="java,android">Members</If>

| Property | Description | Type |
|----------|-------------|------|
| <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">items</If> | contains the current page of results (for example an Array of [`Message`](#message) or [`PresenceMessage`](#presence-message) objects for a channel history request) | `Array <Message, Presence, Stats>` |

#### Methods

##### <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">first</If>

<If lang="javascript,nodejs">

`first(): Promise<PaginatedResult>`

</If>

<If lang="ruby">

`PaginatedResult first`

</If>

<If lang="php">

`PaginatedResult first()`

</If>

<If lang="java,android">

`PaginatedResult first()`

</If>

<If lang="swift,objc">

`first(callback: (ARTPaginatedResult?, ARTErrorInfo?) -> Void)`

</If>

<If lang="java,android,php,ruby,swift,objc">

Returns a new `PaginatedResult` for the first page of results. <If lang="ruby">When using the Realtime library, the `first` method returns a [Deferrable](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and yields a [PaginatedResult](#paginated-result).</If>

</If>

<If lang="javascript,nodejs">

Returns a promise. On success, the promise is fulfilled with a new `PaginatedResult` for the first page of results. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

##### <If lang="javascript,nodejs,java,android,php,swift,objc">hasNext</If><If lang="ruby">has_next?</If>

<If lang="javascript,nodejs,java,android,php,swift,objc">

`Boolean hasNext()`

</If>

<If lang="ruby">

`Boolean has_next?`

</If>

Returns `true` if there are more pages available by calling <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">`next`</If> and returns `false` if this page is the last page available.

##### <If lang="javascript,nodejs,java,android,php,swift,objc">isLast</If><If lang="ruby">last?</If>

<If lang="javascript,nodejs,java,android,php,swift,objc">

`Boolean isLast()`

</If>

<If lang="ruby">

`Boolean last?`

</If>

Returns `true` if this page is the last page and returns `false` if there are more pages available by calling <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">`next`</If> available.

##### <If lang="javascript,nodejs,java,android,php,ruby,swift,objc">next</If>

<If lang="javascript,nodejs">

`next(): Promise<PaginatedResult | null>`

</If>

<If lang="ruby">

`PaginatedResult next`

</If>

<If lang="php">

`PaginatedResult next()`

</If>

<If lang="java,android">

`PaginatedResult next()`

</If>

<If lang="swift,objc">

`next(callback: (ARTPaginatedResult?, ARTErrorInfo?) -> Void)`

</If>

<If lang="java,android,php,ruby,swift,objc">

Returns a new `PaginatedResult` loaded with the next page of results. If there are no further pages, then <If lang="php">`null`</If><If lang="java,android">`Null`</If><If lang="objc,swift">`nil`</If> is returned. <If lang="ruby">When using the Realtime library, the `first` method returns a [Deferrable](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and yields a [PaginatedResult](#paginated-result).</If>

</If>

<If lang="javascript,nodejs">

Returns a promise. On success, the promise is fulfilled with a new `PaginatedResult` loaded with the next page of results. If there are no further pages, then `null` is returned. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>

<If lang="javascript,nodejs">

##### current 

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

<If lang="java,android">

<Code>

##### Java

```
PaginatedResult firstPage = channel.history();
System.out.println("Page 0 item 0:" + firstPage.items[0].data);
if (firstPage.hasNext) {
  PaginatedResult nextPage = firstPage.next();
  System.out.println("Page 1 item 1: " + nextPage.items[1].data);
  System.out.println("More pages?:" + Strong.valueOf(nextPage.hasNext()));
};
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

<If lang="php">

<Code>

##### Php

```
$firstPage = $channel.history();
echo("Page 0 item 0: " . $firstPage->items[0]->data);
if ($firstPage->hasNext()) {
  $nextPage = $firstPage->next();
  echo("Page 1 item 1: " . $nextPage->items[1]->data);
  echo("Last page?: " . $nextPage->isLast());
}
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

## Related Topics

- [Constructor](https://ably.com/docs/api/rest-sdk.md): Client Library SDK REST API Reference constructor documentation.
- [Channels](https://ably.com/docs/api/rest-sdk/channels.md): Client Library SDK REST API Reference Channels documentation.
- [Channel Status](https://ably.com/docs/api/rest-sdk/channel-status.md): Client Library SDK REST API Reference Channel Status documentation.
- [Messages](https://ably.com/docs/api/rest-sdk/messages.md): Client Library SDK REST API Reference Message documentation.
- [Presence](https://ably.com/docs/api/rest-sdk/presence.md): Presence events provide clients with information about the status of other clients 'present' on a channel
- [Authentication](https://ably.com/docs/api/rest-sdk/authentication.md): Client Library SDK REST API Reference Authentication documentation.
- [History](https://ably.com/docs/api/rest-sdk/history.md): Client Library SDK REST API Reference History documentation.
- [Encryption](https://ably.com/docs/api/rest-sdk/encryption.md): Client Library SDK REST API Reference Crypto documentation.
- [Statistics](https://ably.com/docs/api/rest-sdk/statistics.md): Client Library SDK REST API Reference Statistics documentation.
- [Types](https://ably.com/docs/api/rest-sdk/types.md): Client Library SDK REST API Reference Types documentation.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
