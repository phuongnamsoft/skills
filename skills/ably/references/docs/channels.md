# Channel concepts

Channels are used to separate messages into different topics. They are the building block of creating a realtime application using the publish-subscribe pattern. Channels are also the unit of security and scalability. Clients should only ever be provided the [capabilities](https://ably.com/docs/auth/capabilities.md) for channels that they should have access to.

[Messages](https://ably.com/docs/messages.md) contain the data that a client is communicating, such as the contents of an individual chat message, or an event that has occurred, such as updated financial information.

With [basic pub-sub](https://ably.com/docs/pub-sub.md) you create a channel, subscribe to it, and then publish messages to it. Most other Ably features utilize channels, or a group of channels, to provide additional functionality to your realtime applications.

## Use a channel 

To get started with implementing any feature, a client must first create or retrieve an instance of a channel. A channel is created, or an existing channel is retrieved from the `Channels` collection. You can only connect to one channel in a single operation.

Channels are identified by their unique name. The following restrictions apply to when naming a channel:

* Channel names are case sensitive
* They can't start with `[` or `:`
* They can't be empty
* They can't contain newline characters

While Ably doesn't limit the length of channel names, keeping them under 2048 characters is recommended, since some older browsers have trouble with long URLs.

Use the [`get()`](https://ably.com/docs/api/realtime-sdk/channels.md#get) method to create or retrieve a channel instance:

<Code>

### Realtime Javascript

```
const channel = realtime.channels.get('your-channel-name');
```

### Realtime Nodejs

```
const channel = realtime.channels.get('your-channel-name');
```

### Realtime Java

```
Channel channel = realtime.channels.get("your-channel-name");
```

### Realtime Csharp

```
IRealtimeChannel channel = realtime.Channels.Get("your-channel-name"); realtime
```

### Realtime Ruby

```
channel = realtime.channels.get('your-channel-name') realtime
```

### Realtime Python

```
channel = realtime.channels.get('your-channel-name')
```

### Realtime Objc

```
ARTRealtimeChannel *channel = [realtime.channels get:@"your-channel-name"];
```

### Realtime Swift

```
let channel = realtime.channels.get("your-channel-name")
```

### Realtime Flutter

```
final channel = realtime.channels.get('your-channel-name');
```

### Realtime Go

```
channel := realtime.Channels.Get("your-channel-name")
```

### Rest Javascript

```
const channel = rest.channels.get('your-channel-name');
```

### Rest Nodejs

```
const channel = rest.channels.get('your-channel-name');
```

### Rest Java

```
Channel channel = rest.channels.get("your-channel-name");
```

### Rest Csharp

```
Channel channel = rest.Channels.Get("your-channel-name"); rest
```

### Rest Ruby

```
channel = rest.channels.get('your-channel-name') rest
```

### Rest Python

```
channel = rest.channels.get('your-channel-name')
```

### Rest Php

```
$channel = $rest->channels->get('your-channel-name');
```

### Rest Objc

```
ARTRestChannel *channel = [realtime.channels get:@"your-channel-name"];
```

### Rest Swift

```
let channel = realtime.channels.get("your-channel-name")
```

### Rest Flutter

```
final channel = rest.channels.get('your-channel-name');
```

### Rest Go

```
channel := rest.Channels.Get("your-channel-name")
```
</Code>

<Aside data-type="note">
Although Ably recommends that you use channels to distribute work more evenly across the cluster, there is an [associated cost](https://ably.com/docs/platform/pricing.md) for a high number of channels.

Don't use different channels just to indicate different types of data, or different events, if all messages are going to the same set of clients. Use a single channel and distinguish between them using a different message `name`.
</Aside>

## Channel namespaces 

Channels can be grouped together into a namespace. This enables you to apply operations to a namespace rather than each individual channel within it.

A namespace is the first part of a channel name up to the first colon (`:`). If a channel name does not contain a colon, the namespace is the entire channel name. For example, the following channels are all part of the 'customer' namespace:

* `customer`
* `customer:tracking-id`
* `customer:order:update`

Channel namespaces have the same restrictions as those listed for channels. Additionally they cannot contain the wildcard character `*`.

Use channel namespaces to apply operations to all channels within that group, such as [capabilities](https://ably.com/docs/auth/capabilities.md), [rules](#rules) and [integrations](https://ably.com/docs/platform/integrations.md).

<Aside data-type="note">
Namespaces are not required to refer to a group of channels within a [capability](https://ably.com/docs/auth/capabilities.md). A resource specifier, such as `foo:*`, a glob expression, will match a channel named `foo:bar`, even without a `foo` namespace.
</Aside>

## Publishing and subscribing 

Clients [subscribe](https://ably.com/docs/pub-sub.md#subscribe) to a channel to receive the messages published to it. Clients can subscribe to all messages, or only messages identified by specific names.

[Publishing](https://ably.com/docs/pub-sub.md#publish) messages to a channel is how clients communicate with one another. Any subscribers will receive published messages as long as they are subscribed and have the `subscribe` [capability](https://ably.com/docs/auth/capabilities.md) for that channel.

## Channel options 

[Channel options](https://ably.com/docs/channels/options.md) are used to customize the functionality of channels. This includes enabling features such as [encryption](https://ably.com/docs/channels/options/encryption.md) and [deltas](https://ably.com/docs/channels/options/deltas.md), or for a client to retrieve messages published prior to it attaching to a channel using [rewind](https://ably.com/docs/channels/options/rewind.md).

## Channel metadata 

[Metadata](https://ably.com/docs/metadata-stats/metadata.md) provides additional information about your apps and channels. It includes uses such as enabling clients to be aware of how many other clients are attached to a channel without the need to use [presence,](https://ably.com/docs/presence-occupancy/presence.md) Examples of channel metadata available include the status and occupancy of specific channels.

## Rules 

Rules are used to enforce settings for specific channels, or channel namespaces. They can be broadly categorized into three different types:

* For message storage
* For client security and identification
* To enable features for a channel or namespace

The rules related to message storage are:

| Rule | Description |
|------|-------------|
| Persist last message | If enabled, the very last message published on a channel will be stored for a year. This message is retrievable using [rewind](https://ably.com/docs/channels/options/rewind.md) by attaching to the channel with `rewind=1`. If you send multiple messages in a single protocol message, for example calling `publish()` with an array of messages, you would receive all of them as one message. Be aware that presence messages are not stored and that messages stored in this manner are not accessible using [history](https://ably.com/docs/storage-history/history.md). Note that for each message stored using this rule, an additional message is deducted from your monthly allocation. |
| Persist all messages | If enabled, all messages published on a channel will be stored according to the storage rules for your account. This is 24 hours for free accounts and 72 hours for paid accounts. Messages stored in this manner are accessible using [history](https://ably.com/docs/storage-history/history.md). Note that for each message stored using this rule, an additional message is deducted from your monthly allocation. |

The rules related to security and client identity are:

| Rule | Description |
|------|-------------|
| Identified | If enabled, clients will not be permitted to use (including to attach, publish, or subscribe) matching channels unless they are [identified](https://ably.com/docs/auth/identified-clients.md) (they have an assigned client ID). Anonymous clients are not permitted to join these channels. Find out more about [authenticated and identified clients](https://ably.com/docs/auth/identified-clients.md). |
| TLS only | If enabled, only clients who have connected to Ably over TLS will be allowed to use matching channels. By default all of Ably's client libraries use TLS when communicating with Ably over REST or when using Realtime transports such as Websockets. |

The rules related to enabling features are:

| Rule | Description |
|------|-------------|
| Push notifications enabled | If checked, publishing messages with a push payload in the `extras` field is permitted. This triggers the delivery of a [Push Notification](https://ably.com/docs/push.md) to devices registered for push on the channel. |
| Server-side batching | If enabled, messages are grouped into batches before being sent to subscribers. [Server-side batching](https://ably.com/docs/messages/batch.md#server-side) reduces the overall message count, lowers costs, and mitigates the risk of hitting rate limits during high-throughput scenarios. |
| Message conflation | If enabled, messages are aggregated over a set period of time and evaluated against a conflation key. All but the latest message for each conflation key value will be discarded, and the resulting message, or messages, will be delivered to subscribers as a single batch once the period of time elapses. [Message conflation](https://ably.com/docs/messages.md#conflation) reduces costs in high-throughput scenarios by removing redundant and outdated messages. |
| Message annotations, updates, deletes, and appends | If enabled, allows message [annotations](https://ably.com/docs/messages/annotations.md) to be used, as well as updates, deletes, and appends to be published to messages. Note that these features are currently in public preview. When this feature is enabled, messages will be [persisted](https://ably.com/docs/storage-history/storage.md#all-message-persistence) (necessary in order from them later be annotated or updated), and [continuous history](https://ably.com/docs/storage-history/history.md#continuous-history) features will not work.

To set a rule:

<Tabs>
<Tab value="dashboard" label="Dashboard">

In your app [settings](https://ably.com/accounts/any/apps/any/settings):

1. Click **Add new rule**.
2. Select the channel name or namespace to apply rules to.
3. Check the required rules.
4. Click **Create rule** to save.

</Tab>
<Tab value="control-api" label="Control API">

Create a rule using the Control API by sending a `POST` request to [`/apps/{app_id}/namespaces`](https://ably.com/docs/api/control-api.md):

<Code>

### Shell

```
curl -X POST https://control.ably.net/v1/apps/{APP_ID}/namespaces \
  -H "Authorization: Bearer {ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "id": "my-namespace",
    "persisted": true,
    "persistLast": false,
    "pushEnabled": false,
    "tlsOnly": false,
    "authenticated": false
  }'
```
</Code>

</Tab>
<Tab value="cli" label="Ably CLI">

Use the [Ably CLI](https://ably.com/docs/platform/tools/cli.md) to create a rule:

<Code>

### Shell

```
ably apps rules create \
  --name "my-namespace" \
  --persisted
```
</Code>

Run `ably apps rules create --help` for a full list of available options.

</Tab>
</Tabs>

## Channel history 

Channel [history](https://ably.com/docs/storage-history/history.md) enables clients to retrieve messages that have been previously published on the channel. Messages can be retrieved from history for up to 72 hours in the past, depending on the [persistence](https://ably.com/docs/storage-history/storage.md) configured for the channel.

## Presence 

The [presence](https://ably.com/docs/presence-occupancy/presence.md) feature enables clients to be aware of other clients that are 'present' on the channel. Client status is updated as they enter or leave the presence set. Clients can also provide an optional payload describing their status or attributes, and trigger an update event at any time.

## Channel groups 

Ably does not support channel groups, a concept used by some other providers where channels are placed into groups to work around limitations in dynamically subscribing or unsubscribing from channels.

**Why Ably doesn't need channel groups:**

* With Ably client libraries, you can add or remove subscriptions to channels dynamically at any time.
* All channels operate over a single efficient connection.
* Channel namespaces already provide grouping functionality for configuration purposes.

Instead of channel groups, simply subscribe to the specific channels your client needs access to. The efficient multiplexing ensures optimal performance regardless of the number of channels.

## Related Topics

- [Channel states](https://ably.com/docs/channels/states.md): Channels transition through multiple states.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
