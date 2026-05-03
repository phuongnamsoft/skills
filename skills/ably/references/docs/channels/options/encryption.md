# Encryption

[Transport Layer Security (TLS)](https://en.wikipedia.org/wiki/Transport_Layer_Security) is enabled by default in Ably SDKs so that data is securely sent to, and received from, Ably. However, messages are not encrypted within the Ably system. Use the encryption channel option to ensure that message payloads are opaque, that they can't be decrypted by Ably, and can only be decrypted by other clients that share your secret key.

## TLS transport security 

All Ably client libraries use TLS by default when communicating with Ably over REST or via realtime transports such as WebSockets. This provides a secure transport for communication with Ably, ensuring that messages in transit cannot be intercepted, inspected, or tampered with.

### Disabling TLS

If you need to disable TLS (typically to reduce communication overhead for public data streams), you can specify `tls: false` in your [client options](https://ably.com/docs/api/realtime-sdk.md#client-options) when instantiating a Realtime or REST library.

<Aside data-type='important'>
Disabling TLS is strongly discouraged and is enabled by default in all client libraries for security reasons.
</Aside>

### TLS restrictions

Unencrypted communication with Ably is **disallowed** if any of the following conditions are met:

* You attempt to use [Basic Authentication](https://ably.com/docs/auth/basic.md) and thus transmit a private API key over an unencrypted connection. You are only permitted to use unencrypted connections with [Token Authentication](https://ably.com/docs/auth/token.md) as tokens expire, limiting the impact of token interception.

* You have specified that TLS is required in your [app settings](https://ably.com/docs/platform/account/app/settings.md).

* A client using an unencrypted connection attempts to attach to a channel that is configured to be used with [TLS only](https://ably.com/docs/channels.md#rules).

### TLS vs. message encryption

While TLS encryption ensures that messages in transit to and from Ably cannot be intercepted, inspected, or tampered with, it does not ensure that the Ably service itself is unable to inspect your messages and their content. If you want to ensure that all messages are encrypted and inaccessible to even Ably, consider using the [message-level encryption](#with-ably) feature included in the client libraries.

Setting encryption using channel options means that encryption is a feature that can be set per-channel. Apps may have both un-encrypted and encrypted channels on a single connection.

## Cross-platform symmetric encryption 

All officially supported Ably client libraries provide **cross-platform symmetric encryption**, ensuring that encrypted messages can be sent from one platform and successfully decrypted on any other supported platform.

Ably SDKs support encryption purely as a convenience. The SDKs ensure interoperability between environments by having compatible implementations of encryption algorithms and by making common choices on things such as format, mode and padding. However, Ably intentionally does not manage the distribution of keys between clients, and end-to-end encryption is enabled without exposing keys to the Ably service at all. This has the advantage that Ably has no access to the un-encrypted contents of your messages, but also means that each app is responsible for enabling the distribution of keys to clients independently of Ably.

Encryption with Ably supports **symmetric encryption only** and requires each participating client to each specify the correct [`CipherParams`](https://ably.com/docs/api/realtime-sdk/encryption.md#cipher-params) secret `key` when creating a `channel` instance. Clients that do not specify a key will receive the still-encrypted message payloads, that they can subsequently decrypt offline if necessary.

Only the AES algorithm, with a default key length of 256 bits, and CBC mode are supported. These defaults are intended to ensure that encryption support can be provided in all target environments and platforms.

Encryption is supported for the `data` attribute, or payload, of published [messages](https://ably.com/docs/messages.md) and [presence messages](https://ably.com/docs/presence-occupancy/presence.md) on a channel, using both the REST and realtime interfaces. Decryption is supported for message and presence message subscriptions in the realtime interface, and for both the REST and realtime interfaces when using [history](https://ably.com/docs/storage-history/history.md).

Other attributes of messages and presence messages, such as event `name` and `clientId` remain un-encrypted. This means that all sensitive data should be placed in the `data` attribute to ensure it is encrypted before it is transmitted to Ably.

The key that's in use at any given time is known by the SDK. The Ably service only knows that a given message payload was encrypted, not the key used to encrypt it. When accessing messages using the history feature, it is the caller's responsibility to ensure that the correct key is configured for the channel before the history request is made.

<If lang="javascript">
  <Aside data-type='note'>
    To use encrypted channels in a React Native project, you’ll need to complete several additional setup steps.

     React Native does **not** provide cryptographic primitives out of the box. Ably relies on the well-documented **WebCrypto** interfaces instead. In particular, Ably uses:

     - `crypto.subtle.importKey`
     - `crypto.subtle.encrypt`
     - `crypto.subtle.decrypt`

     Ably also depends on `TextDecoder` (Expo provides this by default; for bare React Native you’ll need to install it manually, e.g. [text-encoding](https://www.npmjs.com/package/text-encoding)) and `randomBytes`.

     We recommend the following polyfills:
     - `@react-native-module/randombytes` — for `randomBytes`
     - `react-native-quick-crypto` — for WebCrypto (`crypto.subtle`)
  </Aside>
</If>

## Encrypt a channel 

Set the `cipher` property to enable message encryption by passing a [`CipherParams`](https://ably.com/docs/api/realtime-sdk/encryption.md#cipher-params) object that contains at least a secret `key`.

A `key` should be a cryptographic key generated from a secure random source, 128 or 256 bits long and binary or base-64 encoded. Ably SDKs are also capable of [generating a random key](https://ably.com/docs/api/realtime-sdk/encryption.md#generate-random-key). If you wish to encrypt messages with a pass-phrase, for example one entered by a user then use a [key derivation function](https://en.wikipedia.org/wiki/Key_derivation_function) to transform that into a key.

The following is an example of setting encryption when obtaining a channel instance:

<Code>

### Realtime Javascript

```
  const realtime = new Ably.Realtime('your-api-key');
  const cipherKey = await realtime.Crypto.generateRandomKey();
  const channel = realtime.channels.get('your-channel-name', {cipher: {key: cipherKey}});

  await channel.subscribe((message) => {
    console.log(message.name) //unencrypted
    console.log(message.data) //encrypted
  });

  await channel.publish('unencrypted-name', 'data is encrypted');
```

### Realtime Nodejs

```
  const realtime = new Ably.Realtime('your-api-key');
  const cipherKey = await realtime.Crypto.generateRandomKey();
  const channel = realtime.channels.get('your-channel-name', {cipher: {key: cipherKey}});

  await channel.subscribe((message) => {
    console.log(message.name) //unencrypted
    console.log(message.data) //encrypted
  });

  await channel.publish('unencrypted-name', 'data is encrypted');
```

### Realtime Ruby

```
  key = Ably::Util::Crypto.generateRandomKey()
  channel_opts = { cipher: { key: key } }
  channel = realtime.channels.get('your-channel-name', channel_opts)
  channel.subscribe do |message|
    puts "Decrypted data: #{message.data}"
  end
  channel.publish 'unencrypted', 'encrypted secret payload'
```

### Realtime Java

```
  ChannelOptions options = ChannelOptions.withCipherKey(<key>);
  Channel channel = realtime.channels.get("your-channel-name", options);
  channel.subscribe(new MessageListener() {
    @Override
    public void onMessage(Message message) {
      System.out.println("Decrypted data: " + message.data);
    }
  });
  channel.publish('unencrypted', 'encrypted secret payload');
```

### Realtime Csharp

```
  // Requires: using IO.Ably.Encryption;
  byte[] key = Crypto.GenerateRandomKey();
  ChannelOptions options = new ChannelOptions(key);
  IRealtimeChannel channel = realtime.Channels.Get("your-channel-name", options);
  channel.Subscribe(message => {
    Console.WriteLine("Decrypted data: " + message.Data);
  });
  channel.Publish("unencrypted", "encrypted secret payload");
```

### Realtime Objc

```
  ARTChannelOptions *options = [[ARTChannelOptions alloc] initWithCipherKey:<key>];
  ARTRealtimeChannel *channel = [realtime.channels get:@"your-channel-name" options:options];
  [channel subscribe:^(ARTMessage *message) {
    NSLog(@"Decrypted data: %@", message.data);
  }];
  [channel publish:@"unencrypted" data:@"encrypted secret payload"];
```

### Realtime Swift

```
  let options = ARTChannelOptions(cipherKey: <key>)
  let channel = realtime.channels.get("your-channel-name", options: options)
  channel.subscribe { message in
    print("Decrypted data: \(message.data)")
  }
  channel.publish("unencrypted", data: "encrypted secret payload")
```

### Realtime Flutter

```
final clientOptions = ably.ClientOptions(
  key: 'your-api-key',
);
final realtime = ably.Realtime(options: clientOptions);
final channel = realtime.channels.get('your-channel-name');
await channel.setOptions(
  await ably.RealtimeChannelOptions.withCipherKey(key),
);

channel
    .subscribe()
    .listen((ably.Message message) {
  print('message.name'); //unencrypted
  print('message.data'); //encrypted
});
```

### Rest Javascript

```
  const rest = new Ably.Rest('your-api-key');
  const cipherKey = await rest.Crypto.generateRandomKey();
  const channel = rest.channels.get('your-channel-name', {cipher: {key: cipherKey}});

  await channel.publish('unencrypted-name', 'data is encrypted');
```

### Rest Nodejs

```
  const rest = new Ably.Rest('your-api-key');
  const cipherKey = await rest.Crypto.generateRandomKey();
  const channel = rest.channels.get('your-channel-name', {cipher: {key: cipherKey}});

  await channel.publish('unencrypted-name', 'data is encrypted');
```

### Rest Ruby

```
  key = Ably::Util::Crypto.generateRandomKey()
  channel_opts = { cipher: { key: key } }
  channel = rest.channels.get('your-channel-name', channel_opts)
  channel.publish 'unencrypted', 'encrypted secret payload'
```

### Rest Python

```
  key = ably.util.crypto.generate_random_key()
  channel = rest.channels.get('your-channel-name', cipher={'key': key})
  channel.publish(u'unencrypted', u'encrypted secret payload')
```

### Rest Php

```
  $key = Ably\Utils\Crypto::generateRandomKey();
  $channelOpts = ['cipher' => ['key' => $key]];
  $channel = $rest->channels->get('your-channel-name', $channelOpts);
  $channel->publish('unencrypted', 'encrypted secret payload');
```

### Rest Java

```
  ChannelOptions options = ChannelOptions.withCipherKey(<key>);
  Channel channel = rest.channels.get("your-channel-name", options);
  channel.publish("unencrypted", "encrypted secret payload");
```

### Rest Csharp

```
  // Requires: using IO.Ably.Encryption;
  AblyRest rest = new AblyRest("your-api-key");
  byte[] key = Crypto.GenerateRandomKey();
  ChannelOptions options = new ChannelOptions(key);
  IRestChannel channel = rest.Channels.Get("your-channel-name", options);
  await channel.PublishAsync("unencrypted", "encrypted secret payload");
```

### Rest Objc

```
  ARTChannelOptions *options = [[ARTChannelOptions alloc] initWithCipherKey:<key>];
  ARTRestChannel *channel = [rest.channels get:@"your-channel-name" options:options];
  [channel publish:@"unencrypted" data:@"encrypted secret payload"];
```

### Rest Swift

```
  let options = ARTChannelOptions(cipherKey: <key>)
  let channel = rest.channels.get("your-channel-name", options: options)
  channel.publish("unencrypted", data: "encrypted secret payload")
```

### Rest Go

```
cipherKey, _ := ably.Crypto.GenerateRandomKey(0)
cipher := ably.CipherParams{
  Key:       cipherKey,
  KeyLength: 128,
  Algorithm: ably.CipherAES,
}
channel := rest.Channels.Get("your-channel-name", ably.ChannelWithCipher(cipher))
```

### Rest Flutter

```
final clientOptions = ably.ClientOptions(
  key: 'your-api-key',
);
final realtime = ably.Realtime(options: clientOptions);
final channel = realtime.channels.get('your-channel-name');
await channel.setOptions(
  await ably.RealtimeChannelOptions.withCipherKey(key),
);

channel.publish('unencrypted-name', 'data is encrypted');
```
</Code>

<If lang="python">
If you are using Python 2 and you wish to pass in a base64-encoded key, make sure you pass it in as a `unicode` string, not a `str`, or the library will interpret it as a binary.
</If>

## Related Topics

- [Overview](https://ably.com/docs/channels/options.md): Channel options customize the functionality of channels.
- [Rewind](https://ably.com/docs/channels/options/rewind.md): The rewind channel param enables clients to attach to a channel and receive messages previously published on it.
- [Deltas](https://ably.com/docs/channels/options/deltas.md): The delta channel option enables clients to subscribe to a channel and only receive the difference between the present and previous message.
- [Echo](https://ably.com/docs/channels/options/echo.md): The echo channel option enables per-channel control over whether a client receives its own published messages.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
