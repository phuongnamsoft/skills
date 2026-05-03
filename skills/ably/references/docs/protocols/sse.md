# SSE

The Ably SSE (Server-Sent Events) API provides realtime event streams without needing a full SDK or an [MQTT](https://ably.com/docs/protocols/mqtt.md) library. [SSE](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events) is a lightweight streaming layer over HTTP, primarily accessed through the [EventSource API](https://developer.mozilla.org/en-US/docs/Web/API/EventSource) in modern web browsers — the preferred method to harness SSE.

With HTTP streaming, servers can maintain client requests and transmit data without repetitive requests, offering efficiency akin to WebSockets.

SSE allows subscribe-only functionality. This means you can't:

* Publish
* Enter presence
* Query the existing presence set
* Attach and detach from channels without restarting the stream.

Ably advise SSE for simplified, subscribe-only streams on platforms. Its status as an open standard eliminates the need for client-side SDKs. However, the [Ably SDK](https://ably.com/docs/sdks.md) is recommended overall for its [expanded features and superior reliability](https://ably.com/docs/basics.md).

## When to use the SSE adapter 

SSE is an excellent alternative to Ably SDK in memory-limited environments.

### Applicability of SSE 

* When operating under severe memory constraints
* Where no Ably native library is available for your desired platform
* When Ably provides only a REST SDK for your designated platform, but a realtime client interface is requisite
* Where the sole operation is the subscription to channel events

### Advantages of Ably SDKs and Realtime Protocol 

* Assured high service quality and resilience, particularly in DNS (Domain Name System) disruptions or network partitioning scenarios.
* Access to a comprehensive range of features including, but not limited to, [publishing](https://ably.com/docs/push/publish.md), [presence](https://ably.com/docs/presence-occupancy/presence.md), [history](https://ably.com/docs/storage-history/history.md), [push notifications](https://ably.com/docs/push.md), [automatic payload encoding](https://ably.com/docs/channels/options/encryption.md), and [symmetric encryption](https://ably.com/docs/channels/options/encryption.md).
* Optimal compatibility with browsers via the WebSocket protocol.

<Aside data-type="note">
If you are streaming LLM responses to users, [AI Transport](https://ably.com/docs/ai-transport.md) provides purpose-built token streaming with resumable sessions and multi-device continuity, addressing the limitations of HTTP-based streaming.
</Aside>

<Aside data-type='usp'>
Resilient connections with DNS failover.

Ably's DNS uses a [60-second TTL](https://ably.com/docs/platform/architecture/edge-network.md#dns-organization-and-latency-based-routing), allowing traffic to be rerouted away from unhealthy datacenters within minutes when issues are detected.
</Aside>

## Configuration 

The following code sample provides an example of how to use SSE with Ably:

<Code>

### Javascript

```
var apiKey ='your-api-key';
var url ='https://main.realtime.ably.net/event-stream?channels=myChannel&v=1.2&key=' + apiKey;
var eventSource = new EventSource(url);

eventSource.onmessage = function(event) {
  var message = JSON.parse(event.data);
  console.log('Message: ' + message.name + ' - ' + message.data);
};
```
</Code>

## Authentication 

Authentication with SSE allows for two methods: [basic auth](https://ably.com/docs/auth/basic.md) using an [API key](https://ably.com/docs/getting-started.md) or [token auth](https://ably.com/docs/auth/token.md), using a token from your server. For enhanced security and control over connections, token auth is recommended for client-side use. Basic auth is simpler as it omits the need for an auth server and the potential need for clients to refresh expired tokens.

It is possible to use either [basic auth](https://ably.com/docs/auth/basic.md), with an [API key](https://ably.com/docs/getting-started.md), or [token auth](https://ably.com/docs/auth/token.md), with a [token issued from your server](https://ably.com/docs/auth/token.md), with SSE. It's recommended to use token auth on the client side for [security reasons](https://ably.com/docs/auth.md), so you have control over who can connect. Basic auth, while lacking this control, is simpler (it doesn't require you to run an auth server), and you don't have to worry about the client obtaining a new token when the old one expires.

If using basic auth, you can use a querystring parameter of `key` or an `Authorization: Basic <base64-encoded key>` header. If using token auth, you can use an `accessToken` querystring parameter or an `Authorization: Bearer <base64-encoded token>` header. See [REST API authentication](https://ably.com/docs/auth.md) for more information.

Note that [connection state](https://ably.com/docs/connect.md) is only retained for two minutes.

The SSE protocol and EventSource API seamlessly resume dropped connections. The client reconnects, supplying a `lastEventId` parameter, ensuring no event is missed from the previous connection's endpoint. Ably uses this feature to resume channels from where they left off.

At the point of token expiration, the connection terminates. The default EventSource reconnection won't function due to the expired credentials embedded in the connection URL. The solution is initiating a new connection with an updated `accessToken`, ensuring continuity by providing the right `lastEventId` for a seamless transition from the previous connection's endpoint.

### Implementing message continuity with token auth 

To enable transparent connection resumption when tokens must be renewed:

1. Detect token expiration.
2. Resume the connection precisely from the last delivered message using the `lastEventId` attribute.

#### Detecting token expiry 

If there is an error that causes a connection to be interrupted, the `error` event will be activated on the `EventSource` instance. This applies to all types of connection disruptions. The data attribute of the event provides an Ably error body that describes the cause of the error. If the issue is related to the authorization token, the error code will indicate this. Token-related errors are identified by codes in the range of `40140 <= code < 40150`. In these situations, a new `accessToken` can be obtained and authentication can be attempted again.

#### Specifying the lastEventId 

When you receive a message on a connection, it will include a `lastEventId` attribute with the last `ID`. To set this value for a new connection, specify it as a `lastEvent` parameter in the URL.

The following is an example of implementing message continuity with token auth:

<Code>

##### Javascript

```
let lastEvent;

const connectToAbly = () => {
  // obtain a token
  const token = <GET-NEW-ABLY-AUTH-TOKEN>

  // establish a connection with that token
  const lastEventParam = lastEvent ? ('&lastEvent=' + lastEvent) : '';
  eventSource = new EventSource(`https://main.realtime.ably.net/sse?v=1.1&accessToken=${token}&channels=${channel}${lastEventParam}`);

  // handle incoming messages
  eventSource.onmessage = msg => {
    lastEvent = msg.lastEventId;
    // ... normal message processing
  }

  // handle connection errors
  eventSource.onerror = msg => {
    const err = JSON.parse(msg.data);
    const isTokenErr = err.code >= 40140 && err.code < 40150;
    if(isTokenErr) {
      eventSource.close();
      connectToAbly();
    } else {
      // ... handle other types of error -- for example, retry on 5xxxx, close on 4xxxx
    }
  }
}

connectToAbly();
```
</Code>

The EventSource API will automatically attempt to reconnect and re-subscribe to the SSE endpoint in case of errors, even if the token has expired.

Manually re-subscribing to the SSE endpoint with a fresh token inadvertently creates two active subscriptions:
1. The expired token _that will consistently error out_
2. The new token

To avoid this, close the previous `EventSource` subscription with `eventSource.close()` before starting a new one, as shown in the code snippet.

## Channel options 

In an SSE connection you can specify [channel options](https://ably.com/docs/channels/options.md) in two different ways:

1. With a query string in the channel name qualifier
2. As a query string in the connection URL

By including options in the connection URL, they will apply to all attached channels. However, if you use a channel name qualifier, you can apply options to individual channels. This is useful if you need to override the options set in the connection URL for specific channels.

When creating a channel, you can use a qualifier in the form of square brackets at the beginning of the channel name. For example, to indicate the channel option with the name `foo` with value `bar` on a channel named `baz` the qualified channel name would be `[?foo=bar]baz`. If the channel name already has a qualifier, like `[meta]log`, you can add a query string after the existing qualifier, such as `[meta?foo=bar]log`.

The [rewind](https://ably.com/docs/channels/options/rewind.md) and [delta](https://ably.com/docs/channels/options/deltas.md) channel options are supported with SSE.

### Delta with SSE 

If you subscribe to a channel in delta mode using SSE, you must decode any delta messages you receive.

Certain transports may only provide the content of the `data` attribute of a `message`, without any accompanying metadata. This means that the receiver of the message may not have access to the `extras` or `encoding` attributes typically used to decode message updates.

To help applications utilizing these transports, `vcdiff` decoder libraries can examine the message payload's start for the vcdiff header. This is an approximate method for determining whether the message is a standard message or a delta. It's important to understand that, to depend on this check, you must ensure that the header is not present in any valid (uncompressed) message in your application. JSON messages, for instance, do not match the vcdiff header check, making it secure to conduct this sniffing on JSON message payloads.

For more information, see [Deltas](https://ably.com/docs/channels/options/deltas.md).

### Delta example with SSE 

You can subscribe to messages in delta mode, using the SSE transport, as follows.

<Code>

#### Javascript

```
  /* Make sure to include <script src="https://cdn.ably.com/lib/delta-codec.min-1.js"></script> in your head */
  var key = 'your-api-key';
  var channel = 'your-channel-name';
  var baseUrl = 'https://main.realtime.ably.net/event-stream';
  var urlParams = `?channels=${channel}&v=1.1&key=${key}&delta=vcdiff`;
  var url = baseUrl + urlParams;
  var eventSource = new EventSource(url);
  var channelDecoder = new DeltaCodec.CheckedVcdiffDecoder();

  eventSource.onmessage = function(event) {
    /* event.data is JSON-encoded Ably Message
       (see https://ably.com/docs/api/realtime-sdk/types#message) */
    var message = JSON.parse(event.data);
    var { id, extras } = message;
    var { data } = message;

    try {
      if (extras && extras.delta) {
        data = channelDecoder.applyBase64Delta(data, id, extras.delta.from).asUtf8String();
      } else {
        channelDecoder.setBase(data, id);
      }
    } catch(e) {
      /* Delta decoder error */
      console.log(e);
    }

    /* Process decoded data */
    console.log(data);
  };
```
</Code>

### Delta example with unenveloped SSE 

For more information on enveloped and unenveloped SSE, please see the [SSE API](https://ably.com/docs/api/sse.md#sse)

<Code>

#### Javascript

```
  /* Make sure to include <script src="https://cdn.ably.com/lib/delta-codec.min-1.js"></script> in your head */
  var DeltaCodec = require('@ably/delta-codec');

  var key = 'your-api-key';
  var channel = 'sample-app-sse';
  var baseUrl = 'https://main.realtime.ably.net/event-stream';
  var urlParams = `?channels=${channel}&v=1.1&key=${key}&delta=vcdiff&enveloped=false`;
  var url = baseUrl + urlParams;
  var eventSource = new EventSource(url);
  var channelDecoder = new DeltaCodec.VcdiffDecoder();

  eventSource.onmessage = function(event) {
      var data = event.data;

      try {
          if (DeltaCodec.VcdiffDecoder.isBase64Delta(data)) {
              data = channelDecoder.applyBase64Delta(data).asUtf8String();
          } else {
              channelDecoder.setBase(data);
          }
      } catch(e) {
          /* Delta decoder error */
          console.log(e);
      }

      /* Process decoded data */
      console.log(data);
  };
```
</Code>

### Rewind with SSE 

You can use the [`rewind`](https://ably.com/docs/channels/options/rewind.md) channel option to choose the starting point of an attachment, either by specifying a specific moment in the past or a certain number of messages. For example, apply the `rewind` channel option with a value of `1` to all channels using a querystring parameter.

<Code>

#### Javascript

```
  var querystring = 'v=1.2&channels=your-channel-name&rewind=1&key=your-api-key';
  var eventSource = new EventSource('https://main.realtime.ably.net/event-stream?' + querystring);
```
</Code>

Or to specify the same parameter but only applying to one channel of two, using a qualified channel name:

<Code>

#### Javascript

```
  var channelOne = encodeURIComponent('[?rewind=1]channel1');
  var channelTwo = 'channel2';
  var channels = channelOne + ',' + channelTwo;
  var querystring = 'v=1.2&key=your-api-key&channels=' + channels';
  var eventSource = new EventSource('https://main.realtime.ably.net/event-stream?' + querystring);
```
</Code>

## Statistics 

You can stream app [statistics](https://ably.com/docs/metadata-stats/stats.md) directly to the console using SSE by connecting and subscribing to the metachannel [`[meta]stats:minute`](/docs/metadata-stats/metadata/subscribe#stats).

The following is an example of subscribing to `[meta]stats:minute`:

<Code>

### Shell

```
curl -s -u "your-api-key" "https://main.realtime.ably.net/sse?channel=[meta]stats:minute&v=1.2"
```
</Code>

The following is an example statistics event returned to the console from `[meta]stats:minute`:

<Code>

### Json

```
{
  "id": "1083hjuJAB3NbG@1633679346115-0",
  "event": "message",
  "data": {
    "id": "MVphZHA7l9:0:0",
    "timestamp": 1633679346026,
    "encoding": "json",
    "channel": "[meta]stats:minute",
    "data": {
      "intervalId": "2021-10-08:07:48",
      "unit": "minute",
      "schema": "https://schemas.ably.com/json/app-stats-0.0.1.json",
      "entries": {
        "messages.all.all.count": 1,
        "messages.all.messages.count": 1,
        "messages.outbound.realtime.all.count": 1,
        "messages.outbound.realtime.messages.count": 1,
        "messages.outbound.all.all.count": 1,
        "messages.outbound.all.messages.count": 1,
        "connections.all.peak": 2,
        "connections.all.min": 1,
        "connections.all.mean": 1,
        "connections.all.opened": 1
      }
    },
    "name": "update"
  }
}
```
</Code>

There may be a delay of up to one minute before receiving the initial statistics event. Use the [rewind channel option](#rewind-sse) to retrieve the most recent event and subscribe to subsequent events.

The following is an example curl command subscribing to `[meta]stats:minute` with a rewind value of 1:

<Code>

### Shell

```
curl -s -u "your-api-key" "https://main.realtime.ably.net/sse?channel=[meta]stats:minute&v=1.2&rewind=1"
```
</Code>

## Related Topics

- [Overview](https://ably.com/docs/protocols.md): Clients can use the Ably network protocol adapters. This is especially useful where an Ably SDK is not available for your language of choice, or where platform resource constraints prohibit use of an SDK.
- [MQTT](https://ably.com/docs/protocols/mqtt.md): Any MQTT-enabled client can communicate with the Ably service through the Ably MQTT protocol adapter. This is especially useful where an Ably SDK is not available for your language of choice.
- [Pusher Adapter](https://ably.com/docs/protocols/pusher.md): Use the Pusher Adapter to migrate from Pusher to Ably by only changing your API key.
- [PubNub Adapter](https://ably.com/docs/protocols/pubnub.md): Use the PubNub Adapter to migrate from PubNub to Ably by only changing your API key.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
