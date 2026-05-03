# Channel options overview

Channel options can be used to customize the functionality of channels. This includes enabling features such as [encryption](https://ably.com/docs/channels/options/encryption.md) and [deltas](https://ably.com/docs/channels/options/deltas.md), retrieving messages published prior to attaching using [rewind](https://ably.com/docs/channels/options/rewind.md), or controlling per-channel [echo](https://ably.com/docs/channels/options/echo.md) behavior.

<Aside data-type='note'>
Looking for message throughput optimization? For channels with high-frequency updates where only the latest value matters, see [Conflation](https://ably.com/docs/pub-sub/guides/data-streaming.md#conflation). For server-side message grouping, see [Server-side batching](https://ably.com/docs/pub-sub/guides/data-streaming.md#server-side-batching).
</Aside>

Channel options are set under the following properties:

* [`Params`](#params)
* [`Modes`](#modes)
* [`Cipher`](#cipher)

## Set channel options 

Channel options can be set in two different ways:

* When a channel instance is first obtained using [`channels.get()`](https://ably.com/docs/api/realtime-sdk/channels.md#get).
* Using `channel.setOptions()` at any point after the channel instance has been obtained.

### channels.get 

Pass a `channelOptions` object into the call to [`get()`](https://ably.com/docs/api/realtime-sdk/channels.md#get) in order to set the desired channel options when obtaining a channel instance.

The following is an example of setting the `cipher` property to set [encryption](https://ably.com/docs/channels/options/encryption.md) when obtaining a channel instance:

<Code>

#### Realtime Javascript

```
const realtime = new Ably.Realtime('your-api-key');
const cipherKey = await realtime.Crypto.generateRandomKey();
const channel = realtime.channels.get('your-channel-name', {cipher: {key: cipherKey}});
```

#### Realtime Nodejs

```
const realtime = new Ably.Realtime('your-api-key');
const cipherKey = await realtime.Crypto.generateRandomKey();
const channel = realtime.channels.get('your-channel-name', {cipher: {key: cipherKey}});
```

#### Realtime Java

```
CipherParams params = Crypto.getDefaultParams(key);
ChannelOptions options = new ChannelOptions();
options.encrypted = true;
options.cipherParams = params;
Channel channel = realtime.channels.get("your-channel-name", options);
```

#### Realtime Csharp

```
// Requires: using IO.Ably.Encryption;
byte[] key = Crypto.GenerateRandomKey();
CipherParams cipherParams = Crypto.GetDefaultParams(key);
ChannelOptions channelOpts = new ChannelOptions(cipherParams);
IRealtimeChannel encryptedChannel = realtime.Channels.Get("channelName", channelOpts);
```

#### Realtime Ruby

```
key = Ably::Util::Crypto.generate_random_key
options = { cipher: { key: key } }
channel = realtime.channels.get('channelName', options)
```

#### Realtime Objc

```
NSData *key = [ARTCrypto generateRandomKey];
ARTChannelOptions *options = [[ARTChannelOptions alloc] initWithCipherKey:key];
ARTRealtimeChannel *channel = [realtime.channels get:@"channelName" options:options];
```

#### Realtime Swift

```
let key = ARTCrypto.generateRandomKey()
let options = ARTChannelOptions(cipherKey: key)
let channel = realtime.channels.get("channelName", options: options)
```

#### Realtime Go

```
cipher := ably.CipherParams{
      Key:       key,
      KeyLength: 128,
      Algorithm: ably.CipherAES,
}
channel := realtime.Channels.Get("channelName", ably.ChannelWithCipher(cipher))
```

#### Rest Javascript

```
const rest = new Ably.Rest('your-api-key');
const cipherKey = await rest.Crypto.generateRandomKey();
const channel = rest.channels.get('your-channel-name', {cipher: {key: cipherKey}});
```

#### Rest Nodejs

```
const rest = new Ably.Rest('your-api-key');
const cipherKey = await rest.Crypto.generateRandomKey();
const channel = rest.channels.get('your-channel-name', {cipher: {key: cipherKey}});
```

#### Rest Ruby

```
  key = Ably::Util::Crypto.generateRandomKey()
  channel_opts = { cipher: { key: key } }
  channel = rest.channels.get('your-channel-name', channel_opts)
```

#### Rest Python

```
  key = ably.util.crypto.generate_random_key()
  channel = rest.channels.get('your-channel-name', cipher={'key': key})
```

#### Rest Php

```
  $key = Ably\Utils\Crypto::generateRandomKey();
  $channelOpts = ['cipher' => ['key' => $key]];
  $channel = $rest->channels->get('your-channel-name', $channelOpts);
```

#### Rest Java

```
  ChannelOptions options = ChannelOptions.withCipherKey(<key>);
  Channel channel = rest.channels.get("your-channel-name", options);
```

#### Rest Csharp

```
  // Requires: using IO.Ably.Encryption;
  AblyRest rest = new AblyRest("your-api-key");
  byte[] key = Crypto.GenerateRandomKey();
  ChannelOptions options = new ChannelOptions(key);
  IRestChannel channel = rest.Channels.Get("your-channel-name", options);
```

#### Rest Objc

```
  ARTChannelOptions *options = [[ARTChannelOptions alloc] initWithCipherKey:<key>];
  ARTRestChannel *channel = [rest.channels get:@"your-channel-name" options:options];
```

#### Rest Swift

```
  let options = ARTChannelOptions(cipherKey: <key>)
  let channel = rest.channels.get("your-channel-name", options: options)
```

#### Rest Go

```
  cipher := ably.CipherParams{
        Key:       key,
        KeyLength: 128,
        Algorithm: ably.CipherAES,
  }
  channel := rest.Channels.Get("channelName", ably.ChannelWithCipher(cipher))
```
</Code>

### channel.setOptions 

You can modify the `channelOptions` associated with a given channel instance by calling `setOptions()` and passing a new `channelOptions` object. The modified options will either take effect at the time of attachment, if an attach for that channel has not yet been initiated, or the `setOptions()` call will trigger an immediate attach operation to apply the modified options. Success or failure of any triggered attach operation is indicated in the result of the `setOptions()` call.

The following is an example of setting the [`rewind`](https://ably.com/docs/channels/options/rewind.md) property to 15 seconds using `setOptions()`:

<Code>

#### Realtime Javascript

```
const realtime = new Ably.Realtime('your-api-key');
const channelOpts = {params: {rewind: '15s'}}
await channel.setOptions(channelOpts);
```

#### Realtime Nodejs

```
const realtime = new Ably.Realtime('your-api-key');
const channelOpts = {params: {rewind: '15s'}}
await channel.setOptions(channelOpts);
```

#### Realtime Java

```
  final Map<String, String> params = new HashMap<>();
  params.put("rewind", "15s");
  final ChannelOptions options = new ChannelOptions();
  options.params = params;
  final Channel channel = ably.channels.get("your-channel-name", options);
```

#### Realtime Swift

```
  let options = ARTClientOptions(key: key)
  let client = ARTRealtime(options: options)
  let channelOptions = ARTRealtimeChannelOptions()
  channelOptions.params = [
    "rewind": "15s"
  ]

  let channel = client.channels.get(channelName, options: channelOptions)
```

#### Realtime Csharp

```
  var clientOptions = new ClientOptions();
  clientOptions.Key = "your-api-key";
  clientOptions.Environment = AblyEnvironment;
  var ably = new AblyRealtime(clientOptions);

  var channelParams = new ChannelParams();
  channelParams.Add("rewind", "15s");
  var channelOptions = new ChannelOptions();
  channelOptions.Params = channelParams;
  var channel = ably.Channels.Get("your-channel-name", channelOptions);

  channel.Subscribe(message => {
      Console.WriteLine(message.Data.ToString());
  });
```

#### Realtime Go

```
	channel := realtime.Channels.Get("your-channel-name", ably.ChannelWithParams("rewind", "15s"))

	_, err := channel.SubscribeAll(context.Background(), func(msg *ably.Message) {
		log.Println("Received message:", msg)
	})
	if err != nil {
		log.Panic(err)
	}
```

#### Realtime Flutter

```
final realtime = ably.Realtime(
    options: ably.ClientOptions(
        key: 'your-api-key'
    )
);
const channelOptions = RealtimeChannelOptions(
  params: {'rewind': '15s'},
);

await channel.setOptions(channelOptions);
```
</Code>

## Params 

The `params` property can be used to enable additional features on a channel-by-channel basis.

### Rewind 

The [`rewind`](https://ably.com/docs/channels/options/rewind.md) feature enables clients to replay messages that were published to the channel prior to that clients attachment. This can be by a specific number of messages, or a by a period of time.

### Delta 

The [`delta`](https://ably.com/docs/channels/options/deltas.md) feature enables clients to subscribe to a channel so that message payloads only contain the difference, or delta, between the current and previous message.

### Append mode 

When using [message appends](https://ably.com/docs/messages/updates-deletes.md#append), subscribers receive incremental append payloads by default. Set `appendMode` to `full` to receive `update` messages, with the full message data so far in each message, instead of just the incremental `append`:

<Code>

#### Realtime Javascript

```
const channelOpts = { params: { appendMode: 'full' } };
const channel = realtime.channels.get('your-channel-name', channelOpts);
```

#### Realtime Nodejs

```
const channelOpts = { params: { appendMode: 'full' } };
const channel = realtime.channels.get('your-channel-name', channelOpts);
```
</Code>

### Occupancy 

[Occupancy](https://ably.com/docs/presence-occupancy/occupancy.md) provides metrics about the clients attached to a channel, such as the number of connections and the number of clients subscribed to the channel. `occupancy` can be specified in the `params` property in order to subscribe a client to occupancy metrics for the channel. The metrics will be received by a client as events on the channel.

As `occupancy` requires a channel subscription, it is only available when using the realtime interface of an Ably SDK.

<Aside data-type="important">
Clients require the `channel-metadata` [capability](https://ably.com/docs/auth/capabilities.md) to subscribe to occupancy metrics.
</Aside>

#### Subscribe to occupancy events 

The value of the `occupancy` property can be set depending on the metrics you want to subscribe to:

| Value | Description |
|-------|-------------|
| `metrics` | This enables events containing the full `occupancy` details in their `data` payload. Events are sent when the count for any of the included categories changes. Updates that involve mode changes (for example, at least one publisher existing where there were none before) are propagated immediately. Updates that do not involve a mode change are debounced, for no more than 15 seconds. |
| `metrics.<category>` | This enables events whose `data` payload contains an `occupancy` value containing the occupancy, that is the client count, for only the given category. Events are sent when the count for any of the included categories changes. Updates that involve mode changes (for example, at least one publisher existing where there were none before) are propagated immediately. Updates that do not involve a mode change are debounced, for no more than 15 seconds. |

Occupancy metrics have an event name of `[meta]occupancy` which can be used to subscribe to that event type when registering a listener.

The following example shows how to subscribe to all occupancy metrics:

<Code>

##### Realtime Javascript

```
const channelOpts = { params: { occupancy: 'metrics' } };
const channel = ably.channels.get('your-channel-name', channelOpts);

await channel.subscribe('[meta]occupancy', (message) => {
  console.log('occupancy: ', message.data);
});
```

##### Realtime Go

```
channel := realtime.Channels.Get("your-channel-name", ably.ChannelWithParams("occupancy", "metrics"))

_, err := channel.Subscribe(context.Background(), "[meta]occupancy", func(message *ably.Message) {
  log.Println("occupancy:", message.Data)
})
if err != nil {
  log.Panic(err)
}
```

##### Realtime Flutter

```
final channel = realtime.channels.get('your-channel-name');
const channelOptions = RealtimeChannelOptions(
  params: {'occupancy': 'metrics'},
);

await channel.setOptions(channelOptions);
channel.subscribe(name: '[meta]occupancy').listen((message) {
  print('occupancy: ${message.data}');
});
```

##### Realtime Java

```
ChannelOptions channelOpts = new ChannelOptions();
channelOpts.params = new HashMap<>();
channelOpts.params.put("occupancy", "metrics");

Channel channel = ably.channels.get("your-channel-name", channelOpts);

// Subscribe to the '[meta]occupancy' event
channel.subscribe("[meta]occupancy", new Channel.MessageListener() {
    @Override
    public void onMessage(Message message) {
        System.out.println("occupancy: " + message.data);
    }
})
```
</Code>

The following example shows how to subscribe to only subscriber metrics:

<Code>

##### Realtime Javascript

```
const channelOpts = { params: { occupancy: 'metrics.subscribers' } };
const channel = ably.channels.get('your-channel-name', channelOpts);

await channel.subscribe('[meta]occupancy', (message) => {
  console.log('occupancy: ', message.data);
});
```

##### Realtime Go

```
channel := realtime.Channels.Get("your-channel-name", ably.ChannelWithParams("occupancy", "metrics.subscribers"))

_, err := channel.Subscribe(context.Background(), "[meta]occupancy", func(message *ably.Message) {
  log.Println("occupancy:", message.Data)
})
if err != nil {
  log.Panic(err)
}
```

##### Realtime Flutter

```
final channel = realtime.channels.get('your-channel-name');
const channelOptions = RealtimeChannelOptions(
  params: {'occupancy': 'metrics.subscribers'},
);

await channel.setOptions(channelOptions);
channel.subscribe(name: '[meta]occupancy').listen((message) {
  print('occupancy: ${message.data}');
});
```

##### Realtime Java

```
ChannelOptions channelOpts = new ChannelOptions();
channelOpts.params = new HashMap<>();
channelOpts.params.put("occupancy", "metrics.subscribers");

Channel channel = ably.channels.get("your-channel-name", channelOpts);

// Subscribe to the '[meta]occupancy' event
channel.subscribe("[meta]occupancy", new Channel.MessageListener() {
    @Override
    public void onMessage(Message message) {
        System.out.println("occupancy: " + message.data);
    }
});
```
</Code>

The following is an example of an occupancy metric event:

<Code>

##### Json

```
{
  "name": "[meta]occupancy",
  "id": "V12G5ABc_M:0:0",
  "timestamp": 1612286351217,
  "clientId": null,
  "connectionId": null,
  "connectionKey": null,
  "data": {
    "metrics": {
      "connections": 1,
      "publishers": 1,
      "subscribers": 1,
      "presenceConnections": 1,
      "presenceMembers": 0,
      "presenceSubscribers": 1,
      "objectPublishers": 1,
      "objectSubscribers": 1
    }
  },
  "encoding": null,
  "extras": null,
  "size": null
}
```
</Code>

Occupancy events have a payload in the `data` property with a value of `occupancy`. If a client only subscribes to a single metric category, then only that member is present. For example if only subscribing to the `publishers` category:

<Code>

##### Json

```
{
  "name": "[meta]occupancy",
  "data": {
    "metrics": {
      "publishers": 2
    }
  }
}
```
</Code>

### Inband Objects 

[Inband objects](https://ably.com/docs/liveobjects/inband-objects.md) allows clients to subscribe to changes to [LiveObjects](https://ably.com/docs/liveobjects.md) channel objects as regular channel messages. Set the `objects` channel parameter to `'objects'` to stream the full state, or `'notification'` to receive change notifications.

When using inband objects, the client receives messages with the special name `[meta]objects` that describe the current set of objects on a channel.

<Aside data-type="note">
This feature enables clients to subscribe to LiveObjects updates in realtime even on platforms that don't yet have a dedicated LiveObjects Realtime client implementation. If you're using LiveObjects from one of the the following languages, then use the LiveObjects plugin which has dedicated support for all LiveObjects features:

* [JavaScript/TypeScript](https://ably.com/docs/liveobjects/quickstart/javascript.md)
* [Swift](https://ably.com/docs/liveobjects/quickstart/swift.md)
* [Java](https://ably.com/docs/liveobjects/quickstart/java.md)
</Aside>

For more information see the [inband objects](https://ably.com/docs/liveobjects/inband-objects.md) documentation.

### Echo 

By default, clients receive their own messages back when subscribed to a channel they publish on. This is not always desirable — for example, a client streaming pricing updates or publishing telemetry data does not need its own messages echoed back. The [`echo`](https://ably.com/docs/channels/options/echo.md) channel param suppresses echo on individual channels, regardless of the connection-level [`echoMessages`](https://ably.com/docs/api/realtime-sdk/types.md#client-options) setting.

<Code>

#### Realtime Javascript

```
const channelOpts = { params: { echo: 'false' } };
const channel = realtime.channels.get('your-channel-name', channelOpts);
```

#### Realtime Nodejs

```
const channelOpts = { params: { echo: 'false' } };
const channel = realtime.channels.get('your-channel-name', channelOpts);
```

#### Realtime Java

```
ChannelOptions channelOpts = new ChannelOptions();
channelOpts.params = new HashMap<>();
channelOpts.params.put("echo", "false");

Channel channel = ably.channels.get("your-channel-name", channelOpts);
```

#### Realtime Go

```
channel := realtime.Channels.Get("your-channel-name", ably.ChannelWithParams("echo", "false"))
```

#### Realtime Flutter

```
final channel = realtime.channels.get('your-channel-name');
const channelOptions = RealtimeChannelOptions(
  params: {'echo': 'false'},
);

await channel.setOptions(channelOptions);
```
</Code>

## Modes 

Channel mode flags enable a client to specify which functionality they will use on the channel.

A client can explicitly request a set of modes using the `modes` property. If the `modes` property is not provided, the default modes will be used.

The available set of channel mode flags are:

| Flag | Description | Default? |
|------|-------------|----------|
| `SUBSCRIBE` | Can subscribe to receive messages on the channel. | Yes |
| `PUBLISH` | Can publish messages to the channel. | Yes |
| `PRESENCE_SUBSCRIBE` | Can subscribe to receive presence events on the channel. | Yes |
| `PRESENCE` | Can register presence on the channel. | Yes |
| `OBJECT_PUBLISH` | Can update objects on the channel. | No |
| `OBJECT_SUBSCRIBE` | Can subscribe to receive updates to objects on the channel. | No |
| `ANNOTATION_PUBLISH` | Can publish annotations to messages on the channel. | Yes |
| `ANNOTATION_SUBSCRIBE` | Can subscribe to individual annotations on the channel. | No |

The set of modes available to a client is determined by the set of [capabilities](https://ably.com/docs/auth/capabilities.md) granted by their token or API key.

The modes granted by each capability are:

| Capability | Granted Modes |
|------------|---------------|
| `subscribe` | `SUBSCRIBE`, `PRESENCE_SUBSCRIBE`, `OBJECT_SUBSCRIBE` |
| `publish` | `PUBLISH` |
| `presence` | `PRESENCE` |
| `object-subscribe` | `OBJECT_SUBSCRIBE` |
| `object-publish` | `OBJECT_PUBLISH` |
| `annotation-publish` | `ANNOTATION_PUBLISH` |
| `annotation-subscribe` | `ANNOTATION_SUBSCRIBE` |

The actual modes assigned to a client will be the **intersection** of the requested `modes` and the modes available to the client according to its capabilities. For example, a client with the `subscribe` capability which explicitly requests `SUBSCRIBE` and `PUBLISH` modes will be assigned only the `SUBSCRIBE` mode.

The following is an example of setting channel mode flags:

<Code>

### Realtime Javascript

```
const realtime = new Ably.Realtime('your-api-key');
const channelOptions = {
  modes: ['PUBLISH', 'SUBSCRIBE', 'PRESENCE']
};
const channel = realtime.channels.get('your-channel-name', channelOptions);
```

### Realtime Java

```
AblyRealtime realtime = new AblyRealtime("your-api-key");
ChannelOptions channelOpts = new ChannelOptions();
channelOpts.modes = new ChannelMode[] { ChannelMode.publish, ChannelMode.subscribe, ChannelMode.presence };

Channel channel = realtime.channels.get("your-channel-name", channelOpts);
```

### Realtime Go

```
realtime, _ := ably.NewRealtime(
  ably.WithKey("your-api-key"))
channelModes := []ably.ChannelMode{ably.ChannelModePublish, ably.ChannelModeSubscribe, ably.ChannelModePresence}

channel := realtime.Channels.Get("your-channel-name",
  ably.ChannelWithModes(channelModes...))
```

### Realtime Flutter

```
final realtime = ably.Realtime(
    options: ably.ClientOptions(
        key: 'your-api-key'
    )
);
final channel = realtime.channels.get('your-channel-name');
const channelOptions = RealtimeChannelOptions(
  modes: [ably.ChannelMode.publish, ably.ChannelMode.subscribe, ably.ChannelMode.presence],
);

await channel.setOptions(channelOptions);
```
</Code>

A common use case for channel mode flags is to provide clients the ability to be present on a channel, without subscribing to [presence](https://ably.com/docs/presence-occupancy/presence.md) events.

The following example demonstrates this use case, where the client would be present on the channel without receiving presence notifications from other clients in the presence set. As this is server-side filtering, clients won't be receiving presence notifications which saves a potentially high volume of messages from being used.

<Code>

### Realtime Javascript

```
const realtime = new Ably.Realtime('your-api-key');
const channelOptions = {
  modes: ['PUBLISH', 'SUBSCRIBE', 'PRESENCE']
};
const channel = realtime.channels.get('your-channel-name', channelOptions);
```

### Realtime Java

```
AblyRealtime realtime = new AblyRealtime("your-api-key");
ChannelOptions channelOpts = new ChannelOptions();
channelOpts.modes = new ChannelMode[] { ChannelMode.publish, ChannelMode.subscribe, ChannelMode.presence };

Channel channel = realtime.channels.get("your-channel-name", channelOpts);
```

### Realtime Go

```
realtime, _ := ably.NewRealtime(
  ably.WithKey("your-api-key"))
channelModes := []ably.ChannelMode{ably.ChannelModePublish, ably.ChannelModeSubscribe, ably.ChannelModePresence}

channel := realtime.Channels.Get("your-channel-name",
  ably.ChannelWithModes(channelModes...))
```

### Realtime Flutter

```
final realtime = ably.Realtime(
    options: ably.ClientOptions(
        key: 'your-api-key'
    )
);
final channel = realtime.channels.get('your-channel-name');
const channelOptions = RealtimeChannelOptions(
  modes: [ably.ChannelMode.publish, ably.ChannelMode.subscribe, ably.ChannelMode.presence],
);

await channel.setOptions(channelOptions);
```
</Code>

## Cipher 

The `cipher` property can be used to enable message [encryption](https://ably.com/docs/channels/options/encryption.md). This ensures that message payloads are opaque and can only only be decrypted by other clients that share your secret key.

## Channel params without Ably SDK support 

For any Ably SDKs that do not currently expose the channel options API, a set of channel params can be expressed by including a query string with standard URL query syntax and encoding, within the qualifier part of a channel name. The qualifier part is in square brackets at the start of the channel name.

To specify the channel param `foo` with value `bar` on channel `baz`, the qualified channel name would be `[?foo=bar]baz`. If the channel name already has a qualifier, such as `[meta]log`, then the query string follows the existing qualifier, as in `[meta?foo=bar]log`.

Using this syntax with a non-supported Ably SDK means that channel params are specified for the lifetime of the `Channel` instance. In order to reference the same channel, but with different params, it is necessary to get a new `Channel` instance, using a qualified name that includes the new channel params.

For example, to specify the `rewind` channel param with the value `"1"`:

<Code>

### Realtime Javascript

```
const realtime = new Ably.Realtime('your-api-key');
const channel = realtime.channels.get('[?rewind=1]your-channel-name');
```

### Realtime Java

```
AblyRealtime realtime = new AblyRealtime("your-api-key");
Channel channel = realtime.channels.get("[?rewind=1]your-channel-name");
```

### Realtime Python

```
realtime = AblyRealtime(key='your-api-key')

channel = realtime.channels.get('[?rewind=1]your-channel-name')
```

### Realtime Go

```
realtime, _ := ably.NewRealtime(
  ably.WithKey("your-api-key"))

channel := realtime.Channels.Get("[?rewind=1]your-channel-name")
```

### Realtime Flutter

```
final realtime = ably.Realtime(
    options: ably.ClientOptions(
        key: 'your-api-key'
    )
);
final channel = realtime.channels.get('[?rewind=1]your-channel-name');
```
</Code>

## Related Topics

- [Rewind](https://ably.com/docs/channels/options/rewind.md): The rewind channel param enables clients to attach to a channel and receive messages previously published on it.
- [Deltas](https://ably.com/docs/channels/options/deltas.md): The delta channel option enables clients to subscribe to a channel and only receive the difference between the present and previous message.
- [Echo](https://ably.com/docs/channels/options/echo.md): The echo channel option enables per-channel control over whether a client receives its own published messages.
- [Encryption](https://ably.com/docs/channels/options/encryption.md): Encrypt message payloads using the cipher channel option.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
