# About Pub/Sub

Ably Pub/Sub is Ably's core product. Its flexible APIs are powerful building blocks that you can use to create any realtime experience with.

## Features

The following features are some of the basics that you need to develop realtime applications:

* [Publish and subscribe](#pub-sub)
* [Message history](#history)
* [Presence](#presence)
* [Push notifications](#push)

### Publish and subscribe 

Ably Pub/Sub enables you to implement the [publish-subscribe (pub-sub) pattern](https://ably.com/docs/pub-sub.md). Any number of publishers can send messages to a channel, and any number of subscribers can receive those messages. Publishers and subscribers are completely decoupled from one another.

[Channels](https://ably.com/docs/channels.md) are used to separate messages into different topics. [Messages](https://ably.com/docs/messages.md) contain the data that a client is communicating, such as the contents of an individual chat message, or an event that has occurred, such as updated financial information. Whilst billions of messages may be delivered by Ably, clients receive only the messages on the channels they subscribe to.

### Presence 

The [presence](https://ably.com/docs/presence-occupancy.md) feature enables clients to be aware of other clients that are currently "present" on a channel. Subscribers receive three types of updates from presence members. These are when a client joins the presence set, when they leave the presence set, and when they update an optional payload associated with each member. The payload can be used to describe their status, or attributes associated with them, such as setting their status to 'out for lunch'.

Presence is most commonly used as an online indicator to create an avatar stack for an application, or to notify occupants of a chat room that a member has joined or left.

### Message history 

Messages received by Ably are [stored](https://ably.com/docs/storage-history/storage.md) in memory for 2 minutes in every location that the channel is active in. This enables Pub/Sub SDKs to automatically retrieve them in the event of network connectivity issues, or a lost connection, as long as the connection is re-established within 2 minutes.

Messages can be stored for much longer on disk by Ably through additional configuration. The [history](https://ably.com/docs/storage-history/history.md) feature can be used to retrieve previously sent messages as a paginated list. History can retrieve messages from as far back as the message persistence configured for a channel.

### Push notifications 

[Push notifications](https://ably.com/docs/push.md) notify user devices whether or not an application is open and running. They deliver information, such as app updates, social media alerts, or promotional offers, directly to the user's screen.

Ably sends push notifications to devices using Google's Firebase Cloud Messaging service ([FCM](https://firebase.google.com/docs/cloud-messaging)) and Apple's Push Notification Service ([APNs](https://developer.apple.com/notifications/)). Push notifications don't require a device to stay connected to Ably. Instead, a device's operating system maintains its own battery-efficient transport to receive notifications.

You can publish push notifications to user devices [directly](https://ably.com/docs/push/publish.md#direct-publishing) or [via channels](https://ably.com/docs/push/publish.md#via-channels).

## Realtime and REST 

Pub/Sub SDKs provide a consistent and idiomatic API across a variety of [supported platforms](https://ably.com/docs/sdks.md) and are the most feature-rich method of integrating Ably into an application. Ably SDKs contain a realtime and a REST interface, each of which can be used to satisfy different use cases.

### REST interface 

The REST interface communicates with Ably using the HTTP protocol and is effectively stateless. The REST interface provides a convenient way to access the [REST HTTP API](#rest-api) and is intended to be used by clients that don't require realtime updates. It is more commonly used server-side. It is used to:

* publish messages
* publish messages on behalf of other clients
* issue tokens on behalf of other realtime clients
* retrieve persisted messages, presence history and application usage statistics

### Realtime interface 

The realtime interface is implemented using an Ably-defined protocol, primarily over WebSockets. It enables clients to establish and maintain a persistent connection to Ably. The realtime interface extends the functionality of the REST interface and is most commonly used client-side. It is used to:

* maintain a persistent connection to Ably
* attach to one or more channels, and publish and subscribe to messages to them
* register their presence on a channel, or listen for others present in realtime
* publish at very high message rates, or with the lowest possible realtime latencies

### REST HTTP API 

Interacting with the [REST HTTP API](https://ably.com/docs/api/rest-api.md) directly is fully supported. However, Ably recommends using the REST interface of an SDK where possible, as they provide additional features that improve performance and resilience that the REST HTTP API can't deliver on its own.

## Supported protocols 

Whilst SDKs are the recommended method of integrating Ably in the majority of cases, there are [alternatives available](https://ably.com/docs/protocols.md) when your use case requires it.

They are less feature-rich than SDKs, however they require fewer resources in terms of memory and network overhead to run. They can also be used to build applications using frameworks that don't have an available Ably SDK.

The following other protocols are supported:

| Protocol | Description |
|----------|-------------|
| [MQTT](https://ably.com/docs/protocols/mqtt.md) | Translate between the [Message Queuing Telemetry Transport (MQTT)](https://mqtt.org) and Ably's own protocol. Often used in remote devices with small footprints |
| [SSE](https://ably.com/docs/protocols/sse.md) | Use Server Sent Events (SSE) to get a realtime stream of events from Ably, where using a full SDK is impractical. Often used when you have stringent memory restrictions and only need to subscribe to events, not publish them |
| [Pusher Adapter](https://ably.com/docs/protocols/pusher.md) | Quickly migrate from Pusher to Ably using the Pusher Adapter |
| [PubNub Adapter](https://ably.com/docs/protocols/pubnub.md) | Quickly migrate from PubNub to Ably using the PubNub Adapter |

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
