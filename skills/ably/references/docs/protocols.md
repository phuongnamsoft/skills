# Protocols

Ably SDKs are the recommended method for connecting to Ably because they offer support for a comprehensive set of Ably features, such as automatic [connection management](https://ably.com/docs/connect.md), [authentication token renewal](https://ably.com/docs/auth/token.md) and [presence](https://ably.com/docs/presence-occupancy.md).

Protocol adapters offer an alternative method for connecting to Ably. The advantage to protocol adapters is that they require fewer resources in terms of memory and network overhead such as in smaller footprint devices, or on a platform where an Ably SDK isn't available such as an Arduino-based IoT wearable. The potential drawback to consider when evaluating protocol adapters is that they do not support the full set of Ably features, for example the MQTT protocol adapter does not support presence, and the SSE protocol adapter does not support automatic token renewal.

## Migrate to Ably 

Ably helps customers migrate from other data streaming networks including PubNub and Pusher. Protocol adapters facilitate risk-free migration by allowing you to use existing protocols and client libraries while transitioning to Ably SDKs over time.

Protocol adapters ensure interoperability between different protocols. For example, you can publish sensor data from an MQTT device, subscribe to that data using a Pusher client library for dashboard display, support mobile apps using Ably SDKs, and process data using AMQP worker queues - all within the same system.

Migration times typically range from a few hours (using protocol adapters) to a week, depending on your migration strategy and whether you choose to adopt Ably's native SDKs immediately or transition gradually.

A full list of Ably SDKs can be found on the [SDK page](https://ably.com/docs/sdks.md).

## Available Protocol Adapters 

Ably supports multiple protocols in addition to the native WebSockets-based one:

* [MQTT](#mqtt)
* [SSE](#sse)
* [AMQP](#amqp)
* [STOMP](#stomp)
* [Pusher](#pusher)
* [PubNub](#pubnub)

### MQTT 

MQTT (MQ Telemetry Transport) is a publish/subscribe, lightweight messaging protocol designed for constrained devices and low-bandwidth networks. One of the major uses of MQTT is with IoT (Internet of Things), where these principles are key to having effective communication between various devices.

MQTT can also be used with Ably as a basic event broker or if an SDK is not available for your target platform. However, without an SDK you don't get access to the full range of platform features and data guarantees.

Read more in the [MQTT section](https://ably.com/docs/protocols/mqtt.md).

### SSE 

SSE is a push technology commonly used to send unidirectional message updates or continuous data streams to a browser client. SSE aims to enhance native, cross-browser server-to-client streaming through a JavaScript API called EventSource, standardized as part of HTML5 by the World Wide Web Consortium (W3C).

The Ably SSE and raw HTTP streaming API provides a way to get a realtime stream of events from Ably in circumstances where using a full Ably Realtime SDK, or even an MQTT library, is impractical.

Read more in the [SSE section](https://ably.com/docs/protocols/sse.md).

### AMQP 

The AMQP protocol provides a rich set of functionality to amongst other things bind to exchanges, provision queues and configure routing. The functionality exists so that queues can be dynamically provisioned by clients and messages can be routed to these queues as required.

Read more in the [queues section](https://ably.com/docs/platform/integrations/queues.md).

### STOMP 

STOMP is a simple text-based messaging protocol, typically used for communication between message brokers. It provides an interoperable wire format so that STOMP clients can communicate with any message broker that supports the STOMP protocol and as such is a good fit for use with Ably queues.

Read more in the [queues section](https://ably.com/docs/platform/integrations/queues.md).

### Pusher 

Ably is the only cloud vendor that supports the Pusher protocol. It's simple to migrate to Ably, or use Ably as a failover for Pusher in hours instead of months.

Seamlessly migrate from Pusher by connecting your existing clients to the Ably network with practically zero changes to your code.

Read more in the [Pusher Adapter section](https://ably.com/docs/protocols/pusher.md).

### PubNub 

Ably is the only cloud vendor that supports the PubNub protocol. It's simple to migrate to Ably, or improve resilience with failover options in hours instead of months.

Seamlessly migrate from PubNub by connecting to the Ably network using the PubNub protocol.

Read more in the [PubNub Adapter section](https://ably.com/docs/protocols/pubnub.md).

## How protocol adapters work 

The Ably platform is available at the endpoint `realtime.ably.io` for socket connections and `rest.ably.io` for REST-based requests and HTTP fallbacks for devices not supporting sockets. Ably client libraries always communicate directly with the Ably platform through those endpoints, and Ably ensures those endpoints route users to the closest available datacenter.

Protocol adapters use different endpoints from the default Ably endpoints and route users to a protocol adapter layer that also runs in each of our datacenters. For example, if a client uses MQTT, the endpoint is `mqtt.ably.io`. Ably's latency-based DNS ensures that the client connecting to `mqtt.ably.io` is routed to the closest datacenter, and when the routing layer receives the request, it identifies which protocol the request is destined for based on the hostname. The router then routes the request to a local frontend designed to process data for that protocol.

Protocol adapters run as middleware between the routers and the rest of the Ably service, ensuring that all incoming requests are transformed into the Ably protocol and sent to the Ably service, and all data received from Ably is transformed back to the client's protocol. The adapters are stateful, maintaining connections similar to how Ably provides connection state recovery. The routers ensure that requests are routed to the correct adapter handling each connection for each request.

Protocol adapters provide a seamless way to connect using different protocols to Ably without having to worry about the complexities of ensuring interoperability between protocols.

## Pricing 

Use of protocol adapters carries no additional charge. You are charged for the total number of peak connections and messages sent as if you were using Ably's native protocol. See the [pricing](https://ably.com/docs/platform/pricing.md) page for more details.

## Getting started with protocol adapters 

If you are interested in using our protocol adapters to assist with migration from another service, or would like to use another protocol not listed here with Ably, then please [get in touch](https://ably.com/contact).

## Related Topics

- [Server-Sent Events (SSE)](https://ably.com/docs/protocols/sse.md): Ably provides support for Server-Sent Events (SSE). This is useful for where browser clients support SSE, and the use case does not require or support the resources used by an Ably SDK.
- [MQTT](https://ably.com/docs/protocols/mqtt.md): Any MQTT-enabled client can communicate with the Ably service through the Ably MQTT protocol adapter. This is especially useful where an Ably SDK is not available for your language of choice.
- [Pusher Adapter](https://ably.com/docs/protocols/pusher.md): Use the Pusher Adapter to migrate from Pusher to Ably by only changing your API key.
- [PubNub Adapter](https://ably.com/docs/protocols/pubnub.md): Use the PubNub Adapter to migrate from PubNub to Ably by only changing your API key.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
