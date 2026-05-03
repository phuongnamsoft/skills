# Deltas

The `delta` channel option enables delta compression. It is applied on the channel you are subscribing to, enabling delta mode.

Delta mode is a way for a client to subscribe to a channel so that message payloads sent contain only the difference between the present message and the previous message sent on the channel.

As `delta` only applies to channel subscriptions, it is only available when using the realtime interface of an Ably SDK, or when using [SSE](https://ably.com/docs/protocols/sse.md) or [MQTT](https://ably.com/docs/protocols/mqtt.md).

`delta` is useful for channels that carry messages representing a series of updates to a particular object or document with a significant degree of similarity between successive messages. A client can apply the delta to the previous message to obtain the full payload.

Using delta mode can significantly reduce the encoded size of each message when the difference between successive message payload sizes are small, relative to the overall size. The reduction can reduce bandwidth costs and transit latencies, and enable greater message throughput on a connection.

![Deltas explanation](https://raw.githubusercontent.com/ably/docs/main/src/images/content/realtime/delta-messages.png)

## Delta processing 

Deltas apply to the `data` property of a [`Message`](https://ably.com/docs/messages.md) payload published via Ably. Other properties, such as `clientId`, `name`, and `extras` remain unchanged and are not compressed when using deltas.

Messages retrieved via [history](https://ably.com/docs/storage-history/history.md), and messages delivered to [integrations](https://ably.com/docs/platform/integrations.md) are not compressed.

The `delta` channel option implementation supports a single representation of a delta, [VCDIFF](https://tools.ietf.org/html/rfc3284).

Delta compression via `vcdiff` is supported for all payloads, whether string, binary, or JSON-encoded. The delta algorithm processes message payloads as opaque binaries and has no dependency on the structure of the payload, for example, it does not process line-oriented diffs.

As delta compression is specified by a subscriber, the publisher has no control over whether or not deltas are generated for any given message. Delta processing is performed for all messages if there is at least one subscriber on a channel that has subscribed with the `delta` option.

There is no constraint on how many publishers or subscribers there are. If there are multiple publishers, then deltas can still be generated, and they will be determined based on the order of messages. Deltas are calculated strictly based on the message ordering in that channel, with the effectiveness being dependent on the level of similarity between successive payloads.

If a delta is generated and it results in a difference that is not appreciably smaller than the original message, or is larger than the original message, for example if successive messages are completely different, then the delta will not be sent. Clients will receive the original, unprocessed message.

<Aside data-type='usp'>
Consistent message ordering for deltas.

Deltas rely on consistent message ordering. Messages published using Realtime from a single publisher are delivered to all subscribers in the [same order](https://ably.com/docs/platform/architecture/message-ordering.md#message-ordering-guarantees), with each message assigned a unique serial number.
</Aside>

<If lang="javascript,nodejs">
## Install vcdiff decoder 

The vcdiff decoder is written in pure JavaScript and enables clients to reconstruct full messages from the small "diffs" sent by Ably.

### Installation from npm for Node.js 

<Code>

#### Shell

```
npm install @ably/vcdiff-decoder
```
</Code>

and require as:

<Code>

#### Javascript

```
const vcdiffPlugin = require('@ably/vcdiff-decoder');
```

#### Nodejs

```
const vcdiffPlugin = require('@ably/vcdiff-decoder');
```
</Code>

### Script include for web browsers 

Include the library in your HTML from our CDN:

<Code>

#### Javascript

```
<script src="https://cdn.ably.io/lib/vcdiff-decoder.min-1.js"></script>
```
</Code>

### Exported functions 

The vcdiff decoder library exports the following function for manual delta decoding.

`decode(delta, source)` applies a vcdiff delta to a source message to return a [`Uint8Array`](https://nodejs.org/api/buffer.html#buffer) containing the target message:

* `delta`: The binary delta/diff data.
* `source`: The original message to apply the delta to.
</If>

<If lang="python">
## Install vcdiff decoder 

The vcdiff decoder is written in pure Python and enables clients to reconstruct full messages from the small "diffs" sent by Ably.

### Installation from pip as ably package extras 

<Code>

#### Shell

```
pip install ably[vcdiff]
```
</Code>
</If>

## Subscribe using delta 

Set the `delta` property of `params` to `vcdiff` in order to enable deltas when subscribing to a channel.

This will cause delta messages to be generated by the server and sent to the client, and the library reconstitutes the original message payload. Messages on the channel are delivered to the subscriber's listener in the same way as with a normal [subscription](https://ably.com/docs/pub-sub.md#subscribe).

Note that in some SDKs, the `vcdiff` delta decoding library is excluded from the default distribution in order to avoid increasing the size. In these cases, it is also necessary to supply the delta decoder plugin when instantiating Ably.

<Code>

### Realtime Javascript

```
/* Make sure to include <script src="//cdn.ably.com/lib/vcdiff-decoder.min-1.js"></script> in your head */
const Ably = require('ably');
const vcdiffPlugin = require('@ably/vcdiff-decoder');

const realtime = new Ably.Realtime({
    key: 'your-api-key',
    plugins: {
        vcdiff: vcdiffPlugin
    },
    log: { level: 4 } // optional
});

const channel = realtime.channels.get('your-ably-channel', {
    params: {
        delta: 'vcdiff'
    }
});

channel.subscribe(msg => console.log("Received message: ", msg));
```

### Realtime Nodejs

```
/* Make sure to include <script src="//cdn.ably.com/lib/vcdiff-decoder.min-1.js"></script> in your head */
const Ably = require('ably');
const vcdiffPlugin = require('@ably/vcdiff-decoder');

const realtime = new Ably.Realtime({
    key: 'your-api-key',
    plugins: {
        vcdiff: vcdiffPlugin
    },
    log: { level: 4 } // optional
});

const channel = realtime.channels.get('your-ably-channel', {
    params: {
        delta: 'vcdiff'
    }
});

channel.subscribe(msg => console.log("Received message: ", msg));
```

### Realtime Java

```
AblyRealtime ably = new AblyRealtime("your-api-key")
ChannelOptions options = new ChannelOptions();
options.params = new HashMap<>();
options.params.put("delta", "vcdiff");
Channel channel = ably.channels.get("your-channel-name", options);
channel.subscribe(new MessageListener() {
  @Override
  public void onMessage(Message message) {
    System.out.println("Received `" + message.name + "` message with data: " + message.data);
  }
});
```

### Realtime Swift

```
let options = ARTClientOptions(key: key)
let client = ARTRealtime(options: options)
let channelOptions = ARTRealtimeChannelOptions()
channelOptions.params = [
  "delta": "vcdiff"
]

let channel = client.channels.get(channelName, options: channelOptions)
```

### Realtime Csharp

```
var clientOptions = new ClientOptions();
clientOptions.Key = "your-api-key";
clientOptions.Environment = AblyEnvironment;
var ably = new AblyRealtime(clientOptions);

var channelParams = new ChannelParams();
channelParams.Add("delta", "vcdiff");
var channelOptions = new ChannelOptions();
channelOptions.Params = channelParams;
var channel = ably.Channels.Get("your-channel-name", channelOptions);

channel.Subscribe(message => {
    Console.WriteLine(message.Data.ToString());
});
```

### Realtime Go

```
ablyVCDiffPlugin := ably.NewVCDiffPlugin()
client, err := ably.NewRealtime(
    ably.WithKey("your-api-key"),
    ably.WithVCDiffPlugin(ablyVCDiffPlugin)
)
if err != nil {
    log.Fatal(err)
}
channel := client.Channels.Get("your-channel-name", ably.ChannelWithVCDiff())
channel.SubscribeAll(context.Background(), func(msg *ably.Message) {
    fmt.Printf("Received message: %+v\n", msg)
})
```

### Realtime Python

```
from ably import AblyRealtime, AblyVCDiffDecoder
from ably.realtime.realtime_channel import ChannelOptions

ably = AblyRealtime("your-api-key", vcdiff_decoder=AblyVCDiffDecoder())

channel = client.channels.get("your-channel-name", ChannelOptions(params={
 'delta': 'vcdiff'
}))

def on_message(message):
    print(f"Received message: {message.data}")

await channel.subscribe(on_message);
```
</Code>

## Known limitations 

In principle, `vcdiff` deltas can be applied to encrypted message payloads, but in practice this provides no benefit because there is no similarity between successive encrypted payloads even for identical or near-identical plaintext message payloads.

If a subscriber has a delta subscription and the channel in question experiences a discontinuity, then a non-delta message will be delivered to the client as the first message after the discontinuity. This ensures that lost messages do not prevent the client from reconstituting messages from deltas.

Note that a channel subscriber can experience a discontinuity in the sequence of messages it receives on a given channel for the following reasons:

* The connection can drop, and there will be a discontinuity if the client is unable to reconnect within a two-minute window that preserves [connection continuity](https://ably.com/docs/connect/states.md).
* The outbound connection may become [rate limited](https://ably.com/docs/platform/pricing/limits.md), which causes some messages to be dropped.
* There may have been an internal error in the Ably system leading to the server being unable to preserve continuity on the channel.

In these cases, the service indicates the discontinuity to the client, together with the reason, and this is usually visible to the subscriber in a channel `UPDATE` event.

## Related optimization techniques 

- [Conflation](https://ably.com/docs/pub-sub/guides/data-streaming.md#conflation) delivers only the latest message per key in a time window. Use when intermediate values can be discarded.
- [Server-side batching](https://ably.com/docs/pub-sub/guides/data-streaming.md#server-side-batching) groups messages into batches. Use when every message matters but delivery can be slightly delayed.
- For a comparison of all optimization techniques, see the [Data Streaming guide](https://ably.com/docs/pub-sub/guides/data-streaming.md).

## Related Topics

- [Overview](https://ably.com/docs/channels/options.md): Channel options customize the functionality of channels.
- [Rewind](https://ably.com/docs/channels/options/rewind.md): The rewind channel param enables clients to attach to a channel and receive messages previously published on it.
- [Echo](https://ably.com/docs/channels/options/echo.md): The echo channel option enables per-channel control over whether a client receives its own published messages.
- [Encryption](https://ably.com/docs/channels/options/encryption.md): Encrypt message payloads using the cipher channel option.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
