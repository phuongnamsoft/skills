# MQTT

The Ably MQTT protocol adapter is able to translate back and forth between [MQTT](https://mqtt.org/) and Ably's own protocol, allowing for seamless integration of any systems you may have. MQTT (MQ Telemetry Transport) is a [publish/subscribe](https://ably.com/topic/pub-sub), lightweight messaging protocol designed for constrained devices and low-bandwidth networks. One of the major uses of MQTT is with IoT (Internet of Things), where these principles are key to having effective communication between various devices.

## When to use the MQTT adapter 

The MQTT adapter is our recommended way of interacting with Ably from devices which do not have a native Ably SDK, such as Arduino platforms, C/C++ applications, and so on. Anyone who has previously been using Pubnub or Pusher SDKs for this purpose may want to consider switching to MQTT. Compared to the Pubnub protocol, using MQTT will result in better performance with lower latency. The MQTT adapter typically adds only 1-10ms of latency. Compared to the Pusher protocol, MQTT will give you connection state recovery.

Behind the scenes, the adapter just uses the normal Ably service, so there is no problem with using MQTT and Ably SDKs side by side. You can mix and match as you like; for example, using MQTT on your IoT devices, but using the Ably Realtime API on your servers.

MQTT is recommended to interact with Ably when:

* Bandwidth is limited and you want to keep network traffic to a minimum

## Known limitations 

Using the MQTT adapter will be a little slower than using an Ably SDK, as an adapter adds some level of latency. Typically the impact is in the low milliseconds.

While the adapter can be useful for devices which need to use MQTT, there are many benefits to using an Ably SDK, such as continuity guarantees, fallback host support, history and presence. As a result, if an Ably SDK is available for your platform, it is recommended you consider using it instead of the protocol adapter.

Our MQTT adapter only supports features supported by both the MQTT protocol and the Ably platform:

* Only supports MQTT 3.1.1 clients only, connection attempts using earlier protocol versions will be rejected
* Publishing supports QoS 0 or 1
* Subscribing only supports QoS 0
* Session resumption is supported within the usual [Ably time limit of two minutes](https://ably.com/docs/storage-history/storage.md#default-persistence)
* Doesn't support any MQTT features that aren't normally supported by Ably, such as `WILL` messages, the `RETAIN` flag or [wildcard channel subscriptions](https://ably.com/docs/channels.md)
* Doesn't support Ably features that aren't supported by the MQTT protocol, such as presence, history and push notifications, though you can use the Ably REST API in conjunction with the adapter to access features available over REST

<Aside data-type='usp'>
Consistent regional message ordering.

Within a single region, all MQTT subscribers will observe messages in the [same order](https://ably.com/docs/platform/architecture/message-ordering.md#practical-implications-of-dual-ordering), ensuring consistent experiences for users in that region.
</Aside>

## Configuration 

To use the Ably MQTT protocol adapter, you'll need to ensure you correctly configure your MQTT client as follows:

* Set the host to "main.mqtt.ably.net"
* Set SSL / TLS to true and the port to 8883. (If your MQTT client does not support SSL, you should instead use port 1883, but in this case Ably disallows api-key auth—see [SSL usage note](#ssl) below)
* Set the keep alive time to somewhere between 15 and 60 seconds. (60s will maximize battery life, 15s will maximize responsiveness to network issues. It must not be any higher than 60s to avoid our load balancer terminating the TCP socket for inactivity)
* If using an API key, set the username to the part of the API key before the colon, and the password to the part after the colon
* If using a token, set the username to the token, and leave the password blank

For example, in the NodeJS [MQTT package](https://www.npmjs.com/package/mqtt), you'd need to specify the following:

<Code>

### Javascript

```
var options = {
  keepalive: 30,
  username: '{{API_KEY_NAME}}', /* API key's name */
  password: '{{API_KEY_SECRET}}', /* API key's secret */
  port: 8883
};

var client = mqtt.connect('mqtts:main.mqtt.ably.net', options);
```
</Code>

### Token Authentication 

Ably recommends that you always make use of [token Authentication over basic Authentication](https://ably.com/docs/auth.md) when trying to connect from devices you may not trust. In addition, if you're using Basic Authentication you'll be required to use SSL to connect to our adapter to ensure the API key cannot be accessed by someone listening in.

For Token Authentication you'll be required to [create a token from your own servers](https://ably.com/docs/auth/token.md). Once you have the token, you can simply pass it through when trying to connect to Ably as the connection's `username`, leaving the `password` empty.

If using Token Authentication, you can subscribe to a special topic, `[mqtt]tokenevents`, to get a warning when the current connection's token is about to expire. This will be a single message, sent 30 seconds before the token expires, with the 13 byte payload `expirywarning`.

On receiving this, the client is recommended to get a new token, then disconnect and reconnect with the new token themselves. If this is not done, the server will abruptly disconnect the connection once the token expires.

An example of this with the NodeJS [MQTT package](https://www.npmjs.com/package/mqtt) would be:

<Code>

#### Javascript

```
var client = mqtt.connect('mqtts:main.mqtt.ably.net', options);
client.subscribe('[mqtt]tokenevents');

client.on('message', function(topic, message) {
  if(topic === '[mqtt]tokenevents') {
    /* some function that fetches a new token from an auth server */
    getNewToken(function(err, newToken) {
      if(err) {
        // error handling
        return;
      }
      /* reconnect with the new token */
      client.end();
      options.username = newToken;
      client = mqtt.connect('mqtts:main.mqtt.ably.net', options);
    });
    return;
  }
});
```
</Code>

## Pub/Sub with MQTT 

[Ably's channels](https://ably.com/docs/channels.md) correlate to topics in MQTT. An example of how to publish and subscribe with the NodeJS [MQTT package](https://www.npmjs.com/package/mqtt) would be as follows:

<Code>

### Javascript

```
const mqtt = require('mqtt');
const encoding = require('text-encoding');
var decoder = new encoding.TextDecoder();
var options = {
  keepalive: 30,
  username: '{{API_KEY_NAME}}', /* API key's name */
  password: '{{API_KEY_SECRET}}', /* API key's secret */
  port: 8883
};

var client = mqtt.connect('mqtts:main.mqtt.ably.net', options);

client.on('message', function(topic, message) {
  console.log(decoder.decode(message));
});

client.subscribe('my_channel', function (err) {
  if (!err) {
    client.publish('my_channel', 'my_message', { qos: 0 });
  }
});
```
</Code>

## Decode messages 

Any data published through or received by the MQTT adapter will be binary encoded, due to MQTT being a binary protocol. This means that you'll need to interpret the message to get the original contents out. For example, to interpret a message using Ably Realtime with JavaScript you'd need to do the following, using the [text-encoding NPM module's TextDecoder](https://www.npmjs.com/package/text-encoding) to decode from binary to text:

<Code>

### Javascript

```
var ably = new Ably.Realtime('your-api-key');
var decoder = new TextDecoder();
var channel = ably.channels.get('my_channel');

channel.subscribe(function(message) {
  var command = decoder.decode(message.data);
});
```

### Nodejs

```
const encoding = require('text-encoding');
var decoder = new encoding.TextDecoder();
var client = mqtt.connect('mqtts:main.mqtt.ably.net', options);

client.on('connect', function () {
  client.subscribe('my_channel');
});

client.on('message', function (topic, message) {
  console.log(decoder.decode(message));
});
```
</Code>

In the above example, `command` will now contain the message in its original string form.

## SSL/TLS 

Ably supports both SSL and non-SSL connections (the latter uses a different port, see above), but strongly recommends using SSL wherever possible. If you are not using SSL, note that the same restrictions apply as if you were using an Ably client without SSL. That is, [connection attempts using Basic Authentication (i.e. an API key) are disallowed](https://ably.com/docs/auth/basic.md), and any [namespaces which you've enabled 'require TLS' on](https://ably.com/docs/channels.md) will be inaccessible. [Contact us](https://ably.com/support) if this is a problem for you.

## Channel options 

In an MQTT connection you can specify [channel options](https://ably.com/docs/channels/options.md) with a query string in the channel name qualifier.

The qualifier part is in square brackets at the start of the channel name. To specify the channel option `foo` with value `bar` on channel `baz`, the qualified channel name would be `[?foo=bar]baz`. If the channel name already has a qualifier, such as `[meta]log`, then the query string follows the existing qualifier, as in `[meta?foo=bar]log`.

The [rewind](https://ably.com/docs/channels/options/rewind.md) and [delta](https://ably.com/docs/channels/options/deltas.md) channel options are supported with MQTT.

### Delta with MQTT 

If subscribing to a channel in delta mode using MQTT then you will need to decode any received delta messages yourself.

Some transports provide raw message payloads - that is, the content of the `data` attribute of a `Message` - without the accompanying metadata. That means that the recipient of the message does not have access to the `extras` or `encoding` attributes of the message that would ordinarily be used to decode delta message payloads.

In order to assist applications that use these transports, `vcdiff` decoder libraries can check for the `vcdiff` header at the start of the message payload as an inexact method of determining whether or not the message is a regular message or a delta. Note that, in order to rely on that check, you need to know that that header will not be present in any valid (uncompressed) message in your app. No valid JSON value, for example, will match the `vcdiff` header check, so it is safe to perform this sniffing on JSON message payloads.

Read more in the [delta section](https://ably.com/docs/channels/options/deltas.md).

#### Delta example 

<Code>

##### Javascript

```
  var mqtt = require('mqtt');
  var { VcdiffDecoder } = require('@ably/vcdiff-decoder');

  var options = {
    keepalive: 30,
    username: '{{API_KEY_NAME}}', /* API key's name */
    password: '{{API_KEY_SECRET}}', /* API key's secret */
    port: 8883
  };
  var client = mqtt.connect('mqtts:main.mqtt.ably.net', options);
  var channelName = 'sample-app-mqtt';
  var channelDecoder = new VcdiffDecoder();

  client.on('message', (_, payload) => {
    var data = payload;

    try {
      if (VcdiffDecoder.isDelta(data)) {
        data = channelDecoder.applyDelta(data).asUint8Array();
      } else {
        channelDecoder.setBase(data);
      }
    } catch(e) {
      /* Delta decoder error */
      console.log(e);
    }

    /* Process decoded data */
    console.log(data);
  });

  client.subscribe(`[?delta=vcdiff]${channelName}`);
```
</Code>

### Rewind with MQTT 

The `rewind` channel option enables a client to specify where to start an attachment from. This can be a point in time in the past, or a given number of messages.

Read more in the [Rewind section.](https://ably.com/docs/channels/options/rewind.md).

#### Rewind example 

<Code>

##### Javascript

```
var mqtt = require('mqtt');
var options = {
  keepalive: 30,
  username: '{{API_KEY_NAME}}', /* API key's name */
  password: '{{API_KEY_SECRET}}', /* API key's secret */
  port: 8883
};
var client = mqtt.connect('mqtts:main.mqtt.ably.net', options);
client.on('connect', () => {
  client.subscribe('[?rewind=1]your-channel-name');
});
client.on('message', (topic, message) => {
  ...
});
```
</Code>

## Related Topics

- [Overview](https://ably.com/docs/protocols.md): Clients can use the Ably network protocol adapters. This is especially useful where an Ably SDK is not available for your language of choice, or where platform resource constraints prohibit use of an SDK.
- [Server-Sent Events (SSE)](https://ably.com/docs/protocols/sse.md): Ably provides support for Server-Sent Events (SSE). This is useful for where browser clients support SSE, and the use case does not require or support the resources used by an Ably SDK.
- [Pusher Adapter](https://ably.com/docs/protocols/pusher.md): Use the Pusher Adapter to migrate from Pusher to Ably by only changing your API key.
- [PubNub Adapter](https://ably.com/docs/protocols/pubnub.md): Use the PubNub Adapter to migrate from PubNub to Ably by only changing your API key.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
