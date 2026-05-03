# API Reference

This section of the documentation contains the API references for Ably.

The following API references are available:

* [Client library Realtime SDK](https://ably.com/docs/api/realtime-sdk.md)
* [Client library REST SDK](https://ably.com/docs/api/rest-sdk.md)
* [REST API](https://ably.com/docs/api/rest-api.md)
* [SSE API](https://ably.com/docs/api/sse.md)
* [Control API](https://ably.com/docs/api/control-api.md)

## Client library SDKs 

Depending on availability, an Ably client library SDK may support both a realtime interface and a REST interface. Some SDKs only provide a REST interface. You can check availability on the [SDK page](https://ably.com/download).

The [realtime interface](https://ably.com/docs/api/realtime-sdk.md) allows your client to both publish and subscribe to a channel, but the REST interface only allows you to publish to a channel. The [REST interface](https://ably.com/docs/api/rest-sdk.md) can also be used for non-recurring operations such as obtaining statistics, or checking status. The REST interface has less resource impact, as it is much simpler than the realtime interface.

Typically the REST interface is used on the server, as the server's main task is to authenticate clients, but does not usually need to subscribe to a channel to obtain realtime events.

### API references generated from source code 

API references generated from the source code are available for the realtime and REST client library SDKs. They have been generated for each SDK using tooling common to that language, such as [Jazzy](https://github.com/realm/jazzy) for Swift and Objective-C, and [YARD](https://yardoc.org/) for Ruby.

The API references generated from source code are structured by classes. The combined API references, featuring all languages, are organized by Ably features and strictly separate the realtime and REST interfaces.

The SDKs that have API references generated from source code are:

* [Java](https://ably.com/docs/sdk/java/v1.2.md)
* [JavaScript](https://ably.com/docs/sdk/js/v2.0.md)
* [Objective-C](https://ably.com/docs/sdk/cocoa/v1.2.md)
* [Ruby](https://ably.com/docs/sdk/ruby/v1.2.md)
* [Swift](https://ably.com/docs/sdk/cocoa/v1.2.md)

## REST API 

A raw [REST API](https://ably.com/docs/api/rest-api.md) is also provided - you don't need to install any SDK to use this. This is used where an Ably client library SDK is not available for your chosen platform, or you do not wish to use a client library SDK due to resource constraints.

## SSE API 

The [Ably Server-Sent Events API](https://ably.com/docs/api/sse.md), and raw HTTP streaming API, provide a way to get a realtime stream of events from Ably in circumstances where using a full Ably Realtime client library, or even an MQTT library, is impractical due to resource constraints. HTTP streaming can be used where an SSE client is not supported.

## Control API 

[Ably Control API](https://ably.com/docs/api/control-api.md) is a REST API that enables you to manage your Ably account programmatically. The Control API also enables you to build web apps and command-line tools, to create and manage your Ably realtime infrastructure.

## Spaces SDK 

The API reference for the [Spaces SDK](https://sdk.ably.com/builds/ably/spaces/main/typedoc/index.html) is generated using [TypeDoc](https://typedoc.org/). [Spaces](https://ably.com/docs/spaces.md) enables you to build collaborative environments in your applications, with features such as an avatar stack, live cursors and component locking.

## Chat SDK 

The API reference for the [Chat SDK](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/index.html) is generated using [TypeDoc](https://typedoc.org/). [Chat](https://ably.com/docs/chat.md) enables you to build highly scalable chat features into your applications.

## Further information 

In addition to the API references listed previously, our developer documentation also provides information on how these interfaces are used, and this covers key concepts such as connections, channels, messages and the pub/sub pattern. You can find that information on the following pages:

* [Client library Realtime SDK - Overview](https://ably.com/docs/api/realtime-sdk.md)
* [Client library REST SDK - Overview](https://ably.com/docs/api/rest-sdk.md)
* [Realtime and REST interface use cases](https://ably.com/docs/api/realtime-sdk.md#realtime-vs-rest)
* [REST API - Overview](https://ably.com/docs/api/rest-api.md)
* [SSE API - Overview](https://ably.com/docs/protocols/sse.md)
* [Control API - Overview](https://ably.com/docs/api/control-api.md)

## Related Topics

- [REST API](https://ably.com/docs/api/rest-api.md): Ably provides the raw REST API for situations where an Ably client library SDK is not available on the platform of choice, or due to resource constraints.
- [SSE API](https://ably.com/docs/api/sse.md): Ably provides support for Server-Sent Events (SSE). This is useful for where browser clients support SSE, and the use case does not require or support the resources used by the Ably client library SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
