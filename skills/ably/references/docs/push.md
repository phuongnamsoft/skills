# Push notifications overview

Push notifications notify user devices or browsers regardless of whether an application is open and running. They deliver information, such as app updates, social media alerts, or promotional offers, directly to the user's screen. Ably sends push notifications to devices using [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging) or [Apple Push Notification Service](https://developer.apple.com/notifications/), and to browsers using [Web Push](https://developer.mozilla.org/en-US/docs/Web/API/Push_API). Push notifications don't require a device or browser to stay connected to Ably. Instead, a device's or browser's operating system or web browser maintains its own battery-efficient transport to receive notifications.

<Aside data-type='usp'>
Enterprise-scale push notification delivery.

Ably's infrastructure serves billions of devices each month, handling [enterprise-scale traffic](https://ably.com/docs/platform/architecture/platform-scalability.md) reliably and quickly.
</Aside>

You can publish push notifications to user devices or browsers [directly](https://ably.com/docs/push/publish.md#direct-publishing) or [via channels](#via-channels).

Publishing directly sends push notifications to specific devices or browsers identified by unique identifiers, such as a `deviceId` or a `clientId`. This approach is akin to sending a personal message or alerts directly to an individual user's device or browser, bypassing the need for channel subscriptions. It excels in targeted and personalized communications, such as alerts specific to a user's actions, account notifications, or customized updates.

Publishing via channels uses a [Pub/Sub](https://ably.com/docs/messages.md) model. Messages are sent to channels to which multiple devices or browsers can subscribe. When a message is published to a channel, all devices or browsers subscribed to that channel receive the notification. This approach is particularly powerful for simultaneously publishing messages to multiple users.

<Aside data-type="note">
Push subscriptions do not count toward your connection limit since devices don't need to maintain an active connection to receive push notifications. However, publishing push notifications via channels does activate those channels, so your concurrent peak channel count will equal the number of channels you publish to simultaneously.
</Aside>

## Push notification process

Integrating push notifications into your application includes a few essential configuration steps.

The following diagram demonstrates the push notification process:

![Push Notifications in Ably](https://raw.githubusercontent.com/ably/docs/main/src/images/content/diagrams/push-process-overview.png)

### Configure

Configuring push notifications sets your [device's](https://ably.com/docs/push/configure/device.md) or [browser's](https://ably.com/docs/push/configure/web.md) push notification service to operate with the Ably [platform](https://ably.com/docs.md). This process includes inputting the necessary credentials into your Ably [dashboard](https://ably.com/accounts).

### Activate

Activate devices or browsers for push notifications [directly](https://ably.com/docs/push/configure/device.md#device) or [via a server](https://ably.com/docs/push/configure/device.md#server):

* Activating **directly** enables devices or browsers to receive push notifications. This process involves obtaining a device or browser unique identifier, which serves as a push recipient. Direct activation is typically used when the application can directly handle device or browser registration without intermediaries, providing a straightforward approach to activation.

* Activating **via server** delegates the activation process to your server rather than handling it directly on devices or browsers. This approach is often preferred to minimize the capabilities assigned to untrusted devices or browsers, enhancing security and control. By managing device or browser registrations server-side, you can also centralize activation logistics and handle sensitive operations away from the client.

### Publish

Publish push notifications using Ably via [channels](https://ably.com/docs/push/publish.md#channel-pub) or [directly](https://ably.com/docs/push/publish.md#direct-publishing):

* Publishing directly allows for the delivery of push notifications straight to individual devices or browsers. This process is beneficial for targeting a specific device or browser using a unique [`deviceId`](https://ably.com/docs/push/publish.md#device-id), [`clientId`](https://ably.com/docs/push/publish.md#client-id), or [`recipient`](#recipient). Direct publishing is akin to sending a personal, targeted message to a user's device or browser.

* Publishing via channels operates similarly to Ably's [Pub/Sub](https://ably.com/docs/messages.md) messaging model, broadcasting notifications to all channel subscribers. This process leverages Ably [channels](https://ably.com/docs/channels.md) to distribute push notifications efficiently to all devices or browsers subscribed to those channels. It is ideal for scenarios where the same information, such as alerts or updates, needs to be sent to multiple users.

#### Subscribe

If you publish via channels, devices or browsers must subscribe to those channels to receive notifications. This process offers flexibility in managing and delivering notifications. Subscriptions can be made using the `deviceId` or `clientId`:

* The [`deviceId`](https://ably.com/docs/push/publish.md#sub-deviceID) process subscribes devices or browsers directly to a channel using its unique `deviceId`, assigned by Ably, for push notifications upon device activation.

* The [`clientId`](https://ably.com/docs/push/publish.md#sub-clientID) process subscribes all devices or browsers tied to a particular `clientId` to a channel in one action, for example the same user's laptop and mobile phone. This approach is useful for subscribing multiple devices or browsers simultaneously.

## Push notification lifecycle 

The following diagram shows the push notification lifecycle:

![Push notifications lifecycle](https://raw.githubusercontent.com/ably/docs/main/src/images/content/diagrams/push-lifecycle.png)

The following explains the push notification lifecycle:

* Publish a push notification:
  * The process begins with your app (client) or server, which publishes a push notification.
  * Your app or server sends the notification data to Ably.
* Handle push notification:
  * After receiving the push notification, Ably processes and packages the notification.
  * Ably then forwards the packaged message to the appropriate push notification service *FCM*, *APNs*, or Web Push.
* Deliver push notification:
  * The selected push notification service takes responsibility for delivering the notification to the target devices.
  * The push notification arrives at the end-user's devices or browsers, displaying the notification on their screen.

## Push admin API 

Ably's [push admin API](https://ably.com/docs/api/realtime-sdk/push-admin.md) is a set of functionalities designed for backend servers to manage push notification tasks. It handles registering devices or browsers for push notifications, managing subscriptions to specific channels, and sending push notifications directly to devices, browsers or users identified by a client identifier. It can be used with both the realtime and REST interfaces of an Ably SDK.

Using the push Admin API requires explicit capabilities within a client's credentials:

* Access using the [`push-admin`](https://ably.com/docs/api/realtime-sdk/push-admin.md#methods) capabilities grants full API access, enabling the management of registrations and subscriptions for all devices or browsers.

* Access using the [`push-subscribe`](https://ably.com/docs/api/realtime-sdk/push-admin.md#methods) capabilities designates a client as a push target device or browser. It can only manage its own registration and subscriptions, not those of other devices or browsers.

Each push target device or browser is associated with a unique `deviceId` and authentication credentials. Authentication can be achieved in two ways when using the push Admin API:

* By utilizing an Ably token containing the device's or browser's `deviceId`.

* By employing a standard [Ably key](https://ably.com/docs/auth/basic.md) or [Token](https://ably.com/docs/auth/token.md), with a `deviceIdentityToken`, a credential generated during registration to assert the device's or browser's identity, included in the request header.

The service credential management is handled by the [Ably SDK](https://ably.com/docs/sdks.md), removing the need for the client application to manage device credentials unless accessing the [push admin API](https://ably.com/docs/api/realtime-sdk/push-admin.md) directly via HTTP.

#### Error handling 

Metachannels, such as `[meta]log:push`, publish events and errors that aren't otherwise available to clients. It's important to note that client-returned errors will not be published to this channel.

The following example subscribes to the `[meta]log:push` channel:

<Code>

##### Javascript

```
const channel = realtime.channels.get('[meta]log:push');
channel.subscribe(msg => console.log(msg));
```
</Code>

## Related Topics

- [Publish](https://ably.com/docs/push/publish.md): Learn how to publish and manage push notifications with Ably, covering direct and channel-based processes, payload details, and subscription management.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
