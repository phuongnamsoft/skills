# Encryption

The <If lang="javascript,nodejs,go">`Ably.Rest.Crypto`</If><If lang="ruby">`Ably::Util::Crypto`</If><If lang="php">`Ably\Utils\Crypto`</If><If lang="python">`ably.util.crypto`</If><If lang="java">`io.ably.lib.util.crypto`</If><If lang="swift,objc">`ARTCrypto`</If><If lang="csharp">`IO.Ably.Encryption.Crypto`</If> object exposes the following public methods:

## Methods 

### <If lang="javascript,nodejs,java,objc,swift,php">getDefaultParams</If><If lang="ruby">get_default_params</If><If lang="python">get_default_params</If><If lang="csharp">GetDefaultParams</If><If lang="go">DefaultCipherParams</If> 

<If lang="javascript,nodejs">

`Crypto.getDefaultParams(Object params): CipherParams`

</If>

<If lang="ruby">

`CipherParams Crypto.get_default_params(Hash params)`

</If>

<If lang="python">

`CipherParams Crypto.get_default_params(Dict params)`

</If>

<If lang="php">

`CipherParams Crypto.getDefaultParams(Array params)`

</If>

<If lang="java">

`CipherParams Crypto.getDefaultParams(Param[] params)`

</If>

<If lang="csharp">

`CipherParams GetDefaultParams(byte[] key = null, byte[] iv = null, CipherMode? mode = null)`

</If>

<If lang="swift,objc">

`getDefaultParams(values: [NSObject : AnyObject]) -> ARTCipherParams`

</If>

<If lang="go">

`DefaultCipherParams() (*CipherParams, error)`

</If>

<If lang="javascript,nodejs,java,objc,swift,php,python,ruby">This call obtains a [`CipherParams`](#cipher-params) object using the values passed in (which must be a subset of `CipherParams` fields that at a minimum includes a `key`), filling in any unspecified fields with default values, and checks that the result is a valid and self-consistent.</If><If lang="csharp">This call takes a key, an initialization vector (iv) and a Cipher mode. There is also on override which accepts the `key` and `iv` as base64 encoded strings. It will validate the passed values and generate `CipherParams`</If><If lang="go">returns a [`CipherParams`](#cipher-params) object with fields set to default values. This generates random secret key and initialization vector (iv) values.</If><br /><br />

You will rarely need to call this yourself, since the client library will handle it for you if you specify `cipher` params when initializing a channel (as in the example [at the top](https://ably.com/docs/channels/options/encryption.md))<If lang="javascript,nodejs"> or when setting channel options with `channel#setOptions`</If>.

<If lang="javascript,nodejs,java,objc,swift,php,python,ruby,csharp">

#### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs,java,objc,swift,php,python,ruby">params</If><If lang="csharp">arguments</If> | The cipher <If lang="javascript,nodejs,java,objc,swift,php,python,ruby">params</If><If lang="csharp">arguments</If> that you want to specify. It must at a minimum include a `key`, which should be either a binary (<If lang="java,csharp">`byte[]`</If><If lang="javascript">`ArrayBuffer` or `Uint8Array`</If><If lang="nodejs">`Buffer`</If><If lang="ruby">byte array</If><If lang="objc,swift">`NSData`</If>) or a base64-encoded <If lang="objc">`NS`</If>`String`. | Object |

</If>

#### Returns

On success, the method returns a complete [`CipherParams`](#cipher-params) object. Failure will raise an <If lang="php,ruby,java,python">[`AblyException`](https://ably.com/docs/api/rest-sdk/types.md#ably-exception)</If><If lang="javascript,nodejs,csharp,objc,swift,go">exception</If>.

#### Example

<If lang="javascript">

<Code>

##### Javascript

```
const cipherParams = Ably.Rest.Crypto.getDefaultParams({ key: <key> });
const channelOpts = { cipher: cipherParams };
const channel = rest.channels.get('your-channel-name', channelOpts);
```
</Code>

</If>
<If lang="nodejs">

<Code>

##### Nodejs

```
const cipherParams = Ably.Rest.Crypto.getDefaultParams({ key: <key> });
const channelOpts = { cipher: cipherParams };
const channel = rest.channels.get('your-channel-name', channelOpts);
```
</Code>

</If>
<If lang="ruby">

<Code>

##### Ruby

```
cipher_params = Ably::Util::Crypto.get_default_params({key: <key>})
channel_opts = { cipher: cipher_params }
channel = rest.channels.get('your-channel-name', channel_opts)
```
</Code>

</If>
<If lang="python">

<Code>

##### Python

```
cipher_params = ably.util.crypto.get_default_params({'key': <key>})
channel = rest.channels.get('your-channel-name', cipher=cipher_params)
```
</Code>

</If>
<If lang="php">

<Code>

##### Php

```
$cipherParams = Ably\Utils\Crypto->getDefaultParams(array('key' => <key>));
$channelOpts = array('cipher' => $cipherParams);
$channel = $rest->channels->get('your-channel-name', $channelOpts);
```
</Code>

</If>
<If lang="java">

<Code>

##### Java

```
CipherParams params = Crypto.getDefaultParams(new Param[]{ new Param("key", <key>) });
ChannelOptions options = new ChannelOptions();
options.encrypted = true;
options.cipherParams = params;
Channel channel = rest.channels.get("your-channel-name", options);
```
</Code>

</If>
<If lang="csharp">

<Code>

##### Csharp

```
CipherParams cipherParams = Crypto.GetDefaultParams(<key>);
var channel = rest.Channels.Get("your-channel-name", new ChannelOptions(cipherParams));
```
</Code>

</If>
<If lang="objc">

<Code>

##### Objc

```
ARTCipherParams *params = [ARTCrypto getDefaultParams:@{@"key": <key>}];
ARTChannelOptions *options = [[ARTChannelOptions alloc] initWithCipher:params];
ARTRealtimeChannel *channel = [rest.channels get:@"your-channel-name" options:options];
```
</Code>

</If>
<If lang="swift">

<Code>

##### Swift

```
let params = ARTCrypto.getDefaultParams(["key": <key>])
let options = ARTChannelOptions(cipher: params)
let channel = rest.channels.get("your-channel-name", options: options)
```
</Code>

</If>
<If lang="go">

<Code>

##### Go

```
params, err := Crypto.DefaultCipherParams()
```
</Code>

</If>

### <If lang="javascript,nodejs,java,objc,swift,php">generateRandomKey</If><If lang="ruby">generate_random_key</If><If lang="python">generate_random_key</If><If lang="csharp,go">GenerateRandomKey</If> 

<If lang="javascript">

`Crypto.generateRandomKey(Number keyLength?): Promise<ArrayBuffer>`

</If>
<If lang="nodejs">

`Crypto.generateRandomKey(Number keyLength?): Promise<Buffer>`

</If>
<If lang="ruby">

`byte array Crypto.generate_random_key(Int key_length?)`

</If>
<If lang="python">

`byte array Crypto.generate_random_key(Int key_length?)`

</If>
<If lang="php">

`string Crypto.generateRandomKey(Int keyLength?)`

</If>
<If lang="java">

`byte[] Crypto.generateRandomKey(Int keyLength?)`

</If>
<If lang="csharp">

`byte[] GenerateRandomKey(int? keyLength = null, CipherMode? mode = null)`

</If>
<If lang="objc,swift">

`generateRandomKey(length?: UInt) -> NSData`

</If>
<If lang="go">

`GenerateRandomKey(keyLength ...int) ([]byte, error)`

</If>

This call obtains a randomly-generated binary key of the specified key length<If lang="csharp"> and optional CipherMode</If>.

#### Parameters

<If lang="javascript,nodejs,java,objc,swift,php,python,ruby,go">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="javascript,nodejs,java,objc,swift,php,go">keyLength</If><If lang="ruby,python">key_length</If> | Optional with the length of key to generate. For AES, this should be either 128 or 256. If unspecified, defaults to 256. | <If lang="javascript,nodejs">number</If><If lang="java,objc,swift,php,python,ruby,go">Int</If> |

</If>

<If lang="csharp">

| Parameter | Description | Type |
|-----------|-------------|------|
| keyLength | Optional with the length of key to generate. For AES, this should be either 128 or 256. If unspecified, defaults to 256. | int? |
| mode | Optional AES which is used when the key is generated | `CipherMode` |

</If>

<If lang="javascript,nodejs">

#### Returns

Returns a promise. On success, the promise is fulfilled with the generated key as <If lang="javascript">an `ArrayBuffer`</If><If lang="nodejs">a `Buffer`</If>. On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/rest-sdk/types.md#error-info) object that details the reason why it was rejected.

</If>
<If lang="java,ruby,objc,swift,php,python,csharp,go">

#### Returns

On success, the method returns the generated key as a <If lang="java">`byte[]` array</If><If lang="python">`bytes`</If><If lang="ruby">byte array</If><If lang="php">binary string</If><If lang="objc,swift">`NSData`</If><If lang="go">`[]byte` array</If>. <If lang="java,ruby,objc,swift,php,python,csharp">Failure will raise an [`AblyException`](https://ably.com/docs/api/rest-sdk/types.md#ably-exception)</If><If lang="go">Failure will cause error to contain an [`ErrorInfo`](#error-info) object describing the failure reason.</If>

</If>

#### Example

<If lang="javascript,nodejs">

<Code>

##### Javascript

```
const key = await Ably.Rest.Crypto.generateRandomKey(256);
const channel = rest.channels.get('your-channel-name', { cipher: { key: key } });
```
</Code>

</If>
<If lang="ruby">

<Code>

##### Ruby

```
key = Ably::Util::Crypto.generate_random_key(256)
channel = rest.channels.get('your-channel-name', { cipher: {key: key}})
```
</Code>

</If>
<If lang="python">

<Code>

##### Python

```
cipher_params = ably.util.crypto.generate_random_key(256)
channel = rest.channels.get('your-channel-name', cipher={'key': key})
```
</Code>

</If>
<If lang="php">

<Code>

##### Php

```
$key = Ably\Utils\Crypto->generateRandomKey(256);
$channel = $rest->channels->get('your-channel-name', array('cipher' => array('key' => $key)));
```
</Code>

</If>
<If lang="java">

<Code>

##### Java

```
byte[] key = Crypto.generateRandomKey(256);
ChannelOptions options = ChannelOptions.withCipher(key);
Channel channel = rest.channels.get("your-channel-name", options);
```
</Code>

</If>
<If lang="csharp">

<Code>

##### Csharp

```
byte[] key = Crypto.GenerateRandomKey(256);
ChannelOptions options = new ChannelOptions(key);
var channel = rest.Channels.Get("your-channel-name", options);
```
</Code>

</If>
<If lang="objc">

<Code>

##### Objectivec

```
NSData *key = [ARTCrypto generateRandomKey:256];
ARTChannelOptions *options = [[ARTChannelOptions alloc] initWithCipherKey:key];
ARTRealtimeChannel *channel = [rest.channels get:@"your-channel-name" options:options];
```
</Code>

</If>
<If lang="swift">

<Code>

##### Swift

```
let key = ARTCrypto.generateRandomKey(256)
let options = ARTChannelOptions(cipherWithKey: key)
let channel = rest.channels.get("your-channel-name", options: options)
```
</Code>

</If>
<If lang="go">

<Code>

##### Go

```
key, err := Crypto.GenerateRandonKey(256)
```

</Code>
</If>

## Related types 

### <If lang="javascript,nodejs,go">ChannelOptions Object</If><If lang="objc,swift">ARTChannelOptions</If><If lang="ruby">ChannelOptions Hash</If><If lang="python">ChannelOptions Dict</If><If lang="php">ChannelOptions Array</If><If lang="csharp">IO.Ably.ChannelOptions</If><If lang="java">io.ably.lib.types.ChannelOptions</If> 

Channel options are used for <If lang="javascript,nodejs,java,swift,objc,csharp">setting [channel parameters](https://ably.com/docs/channels/options.md) and</If> [configuring encryption](https://ably.com/docs/channels/options/encryption.md).

<If lang="javascript,nodejs">

`ChannelOptions`, a plain JavaScript object, may optionally be specified when instancing a [`Channel`](https://ably.com/docs/channels.md), and this may be used to specify channel-specific options. The following attributes can be defined on the object:

</If>
<If lang="ruby">

`ChannelOptions`, a Hash object, may optionally be specified when instancing a [`Channel`](https://ably.com/docs/channels.md), and this may be used to specify channel-specific options. The following key symbol values can be added to the Hash:

</If>
<If lang="php">

`ChannelOptions`, an Associative Array, may optionally be specified when instancing a [`Channel`](https://ably.com/docs/channels.md), and this may be used to specify channel-specific options. The following named keys and values can be added to the Associated Array:

</If>
<If lang="java,swift,objc,go">

<If lang="swift,objc">`ART`</If><If lang="java">`io.ably.lib.types.`</If>`ChannelOptions` may optionally be specified when instancing a [`Channel`](https://ably.com/docs/channels.md), and this may be used to specify channel-specific options.

</If>
<If lang="csharp">

`IO.Ably.ChannelOptions` may optionally be specified when instancing a [`Channel`](https://ably.com/docs/channels.md), and this may be used to specify channel-specific options.

</If>

#### <If lang="javascript,nodejs,python,php,ruby,go,objc,swift,csharp">Properties</If><If lang="java">Members</If>

<If lang="ruby,php,python,go">

| Property | Description | Type |
|----------|-------------|------|
| <If lang="ruby">:cipher</If><If lang="csharp,go">CipherParams</If><If lang="python,php">cipher</If> | Requests encryption for this channel when not null, and specifies encryption-related parameters (such as algorithm, chaining mode, key length and key). See [an example](https://ably.com/docs/channels/options/encryption.md) | [`CipherParams`](https://ably.com/docs/api/realtime-sdk/encryption.md#cipher-params)<If lang="ruby"> or an options hash containing at a minimum a `key`</If><If lang="php"> or an Associative Array containing at a minimum a `key`</If> |

</If>

<If lang="javascript,nodejs,java,swift,objc,csharp">

| Property | Description | Type |
|----------|-------------|------|
| <If lang="javascript,nodejs,java,swift,objc">params</If><If lang="csharp">Params</If> | Optional [parameters](https://ably.com/docs/channels/options.md) which specify behaviour of the channel. | <If lang="java">`Map<String, String>`</If><If lang="javascript,nodejs,objc,csharp,swift">`JSON Object`</If> |
| <If lang="javascript,nodejs,java,swift,objc">cipher</If><If lang="csharp">CipherParams</If> | Requests encryption for this channel when not null, and specifies encryption-related parameters (such as algorithm, chaining mode, key length and key). See [an example](https://ably.com/docs/api/realtime-sdk/encryption.md#getting-started) | [`CipherParams`](https://ably.com/docs/api/realtime-sdk/encryption.md#cipher-params)<If lang="javascript,nodejs"> or an options object containing at a minimum a `key`</If><If lang="java"> or a [`Param[]`](#param) list containing at a minimum a `key`</If> |

</If>

<If lang="java">

#### Static methods

##### withCipherKey 

```java
static ChannelOptions.withCipherKey(Byte[] or String key)
```

A helper method to generate a `ChannelOptions` for the simple case where you only specify a key.

#### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| key | A binary `Byte[]` array or a base64-encoded `String`. | `Byte[]` or `String` |

#### Returns

On success, the method returns a complete `ChannelOptions` object. Failure will raise an [`AblyException`](https://ably.com/docs/api/realtime-sdk/types.md#ably-exception).

</If>

### <If lang="javascript,nodejs,go">CipherParams</If><If lang="objc,swift">ARTCipherParams</If><If lang="ruby">CipherParams Hash</If><If lang="python">CipherParams Dict</If><If lang="php">CipherParams Array</If><If lang="csharp">IO.Ably.CipherParams</If><If lang="java">io.ably.lib.util.Crypto.CipherParams</If> 

A `CipherParams` contains configuration options for a channel cipher, including algorithm, mode, key length and key. Ably client libraries currently support AES with CBC, PKCS#7 with a default key length of 256 bits. All implementations also support AES128.

Individual client libraries may support either instancing a `CipherParams` directly, using <If lang="javascript,nodejs,java,objc,swift,php,python,go">[`Crypto.getDefaultParams()`](https://ably.com/docs/api/realtime-sdk/encryption.md#get-default-params)</If><If lang="csharp">[`Crypto.GetDefaultParams()`](https://ably.com/docs/api/realtime-sdk/encryption.md#get-default-params)</If><If lang="ruby">[`Crypto.get_default_params()`](https://ably.com/docs/api/realtime-sdk/encryption.md#get-default-params)</If>, or generating one automatically when initializing a channel, as in [this example](https://ably.com/docs/channels/options/encryption.md).

#### <If lang="javascript,nodejs,python,php,ruby,go,objc,swift,csharp">Properties</If><If lang="java">Members</If>

<If lang="javascript,nodejs,python,php,ruby,go,objc,swift,csharp">

| Property | Description | Type |
|----------|-------------|------|
| <If lang="javascript,nodejs,objc,swift,php,python">key</If><If lang="csharp,go">Key</If><If lang="ruby">:key</If> | A binary (<If lang="csharp">`byte[]`</If><If lang="javascript">`ArrayBuffer` or `Uint8Array`</If><If lang="nodejs">`Buffer`</If><If lang="ruby">byte array</If><If lang="objc,swift">`NSData`</If>) or base64-encoded <If lang="objc">`NS`</If>`String` containing the secret key used for encryption and decryption | |
| <If lang="javascript,nodejs,objc,swift,php">algorithm</If><If lang="ruby">:algorithm</If><If lang="csharp,go">Algorithm</If> | The name of the algorithm in the default system provider, or the lower-cased version of it; eg "aes" or "AES"<br />default: _AES_ | `String` |
| <If lang="python">key_length</If><If lang="ruby">:key_length</If><If lang="javascript,nodejs,objc,swift,php">keyLength</If><If lang="csharp,go">KeyLength</If> | The key length in bits of the cipher, either 128 or 256<br />default: _256_ | `Integer` |
| <If lang="javascript,nodejs,objc,swift,php,python,ruby">mode</If><If lang="csharp,go">Mode</If> | The cipher mode<br />default: _CBC_ | <If lang="javascript,nodejs,objc,swift,php,python,ruby,go">`String`</If><If lang="csharp">`CipherMode`</If> |

</If>

<If lang="java">

| Property | Description | Type |
|----------|-------------|------|
| key | A binary (`byte[]`) or base64-encoded `String` containing the secret key used for encryption and decryption | |
| algorithm | The name of the algorithm in the default system provider, or the lower-cased version of it; eg "aes" or "AES"<br />default: _AES_ | `String` |
| keyLength | The key length in bits of the cipher, either 128 or 256<br />default: _256_ | `Integer` |
| mode | The cipher mode<br />default: _CBC_ | `String` |
| keySpec | A `KeySpec` for the cipher key | `SecretKeySpec` |

</If>

## Related Topics

- [Constructor](https://ably.com/docs/api/rest-sdk.md): Client Library SDK REST API Reference constructor documentation.
- [Channels](https://ably.com/docs/api/rest-sdk/channels.md): Client Library SDK REST API Reference Channels documentation.
- [Channel Status](https://ably.com/docs/api/rest-sdk/channel-status.md): Client Library SDK REST API Reference Channel Status documentation.
- [Messages](https://ably.com/docs/api/rest-sdk/messages.md): Client Library SDK REST API Reference Message documentation.
- [Presence](https://ably.com/docs/api/rest-sdk/presence.md): Presence events provide clients with information about the status of other clients 'present' on a channel
- [Authentication](https://ably.com/docs/api/rest-sdk/authentication.md): Client Library SDK REST API Reference Authentication documentation.
- [History](https://ably.com/docs/api/rest-sdk/history.md): Client Library SDK REST API Reference History documentation.
- [Push Notifications - Admin](https://ably.com/docs/api/rest-sdk/push-admin.md): Client Library SDK REST API Reference Push documentation.
- [Statistics](https://ably.com/docs/api/rest-sdk/statistics.md): Client Library SDK REST API Reference Statistics documentation.
- [Types](https://ably.com/docs/api/rest-sdk/types.md): Client Library SDK REST API Reference Types documentation.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
