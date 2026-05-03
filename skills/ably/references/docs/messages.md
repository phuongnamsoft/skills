# Message concepts

Messages contain the data that a client is communicating, such as the contents of a chat message. Clients publish messages on [channels](https://ably.com/docs/channels.md), and these messages are received by clients that have [subscribed](https://ably.com/docs/pub-sub.md#subscribe) to them. This pattern is otherwise known as pub/sub, as publishers and subscribers are completely decoupled.

<Aside type="note">
Messages are counted in 5KiB chunks. See [what counts as a message](https://faqs.ably.com/how-does-ably-count-messages).
</Aside>

## Message properties 

The following are the properties of a message:

| Property | Description |
|----------|-------------|
| **name** | The name of the message |
| **data** | The contents of the message. Also known as the message payload |
| **id** | Each message sent through Ably is assigned a unique ID, unless you provide your own ID, which serves as the [idempotency key](https://ably.com/docs/pub-sub/advanced.md#idempotency) |
| **clientId** | The [ID of the client](https://ably.com/docs/auth/identified-clients.md) that published the message |
| **connectionId** | The ID of the connection used to publish the message |
| **timestamp** | The timestamp of when the message was first received by Ably, as milliseconds since the Unix epoch |
| **extras** | A JSON object of arbitrary key-value pairs that may contain metadata, and/or ancillary payloads. Valid payloads include those related to [Push Notifications](https://ably.com/docs/push.md), [deltas](https://ably.com/docs/channels/options/deltas.md) and headers |
| **encoding** | This is typically empty, as all messages received from Ably are automatically decoded client-side using this value. However, if the message encoding cannot be processed, this attribute contains the remaining transformations not applied to the data payload |
| **action** | An [enum](https://ably.com/docs/api/realtime-sdk/types.md#message-action) telling you whether this is a normal ('create') message, an update to a previous message, an annotation summary, etc. |
| **serial** | The message's serial (a server-assigned identifier that will be the same in all future updates of this message, and can be used to add [annotations](https://ably.com/docs/messages/annotations.md) or to [update or delete](https://ably.com/docs/messages/updates-deletes.md) the message). This will only be set if you enable annotations, updates, deletes, and appends in [rules](https://ably.com/docs/channels.md#rules) |
| **annotations** | An object containing a summary of any [annotations](https://ably.com/docs/messages/annotations.md) that have been made to the message |
| **version** | An object containing [version metadata](https://ably.com/docs/messages/updates-deletes.md#version-structure) for messages that have been updated or deleted |

## Message delivery tracking 

Ensure a message was successfully published by checking the [history](https://ably.com/docs/storage-history/history.md) of the channel for your message. It is only possible to check if a device has received a message from the device itself.

Ably does not store per-message delivery logs, nor logs of who is subscribed to a channel at any point in time. This means it is not possible to check which users have received messages retroactively.

<Aside data-type='usp'>
Message continuity during disruptions.

Applications maintain their state during brief disruptions. If a client reconnects within two minutes, all messages are received in the correct order with [no message loss](https://ably.com/docs/platform/architecture/connection-recovery.md#message-identification-with-timeserial).
</Aside>

## Message conflation 

Use message conflation to ensure that clients only ever receive the most up-to-date message, by removing redundant and outdated messages. Message conflation will aggregate published messages for a set period of time and evaluate all messages against a [conflation key](#routing). All but the latest message for each conflation key value will be discarded, and the resulting message, or messages, will be delivered to subscribers as a single batch once the period of time elapses.

For example, messages published with the following in the `extras.headers` field will alternate between four different values for the market:

<Code>

### Javascript

```
market = pickOneFrom('market-A', 'market-B', 'market-C', 'market-D')
headers = { market };
channel.publish({ name: 'update', data: { market, update: counter++ }, extras: { headers }});
```
</Code>

If the conflation key for this channel is set to `#{message.extras.headers['market']}` with a 200ms conflation interval, then at the end of each 200ms interval a maximum of four messages will be delivered to subscribers in a single batch.

Conflation is useful in scenarios where the latest state of a message matters most. Applications in the betting or stocks industry are good examples of this, where odds and prices are changing rapidly, but end-users don't need to be overwhelmed by receiving a message with every single change. Instead they can receive only the latest update every 100ms, for example.

In these instances the frequency of updates for the subscriber are of less importance than the rate at which the updates are published. It also reduces the message cost of applications by not propagating every single update to subscribers.

### Configure message conflation 

When configuring message conflation, you need to set a conflation interval, in milliseconds. Messages sent to Ably during this interval are temporarily held and assessed against the [conflation key](#routing). Once the interval elapses, the latest version of each message for a unique conflation key value will be delivered to subscribers as a single batch.

Use one of the following methods to configure message conflation for a channel or channel namespace:

<Tabs>
<Tab value="dashboard" label="Dashboard">

In your app [settings](https://ably.com/accounts/any/apps/any/settings):

1. Click **Add new rule**.
2. Enter the channel name or namespace to apply message conflation to.
3. Check **Conflation enabled**.
4. Choose a conflation interval over which to aggregate messages.
5. Enter a [conflation key](#routing) to assess messages against.
6. Click **Create rule** to save.

</Tab>
<Tab value="control-api" label="Control API">

Create a rule with message conflation using the Control API by sending a `POST` request to [`/apps/{app_id}/namespaces`](https://ably.com/docs/api/control-api.md):

<Code>

#### Shell

```
curl -X POST https://control.ably.net/v1/apps/{APP_ID}/namespaces \
  -H "Authorization: Bearer {ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "id": "my-namespace",
    "conflationEnabled": true,
    "conflationInterval": 100,
    "conflationKey": "name"
  }'
```
</Code>

</Tab>
<Tab value="cli" label="Ably CLI">

Use the [Ably CLI](https://ably.com/docs/platform/tools/cli.md) to create a rule with message conflation:

<Code>

#### Shell

```
ably apps rules create \
  --name "my-namespace" \
  --conflation-enabled \
  --conflation-interval 100 \
  --conflation-key "name"
```
</Code>

Run `ably apps rules create --help` for a full list of available options.

</Tab>
</Tabs>

<Aside data-type="note">
Message conflation is mutually exclusive with [server-side batching](https://ably.com/docs/messages/batch.md#server-side) on a channel, or channel namespace.
</Aside>

## Message routing and conflation syntax 

Ably uses common syntax to select which messages are routed to integrations and for assessing which messages to apply conflation to. The following properties and features use this syntax:

* `routingKey` for [AMQP](https://ably.com/docs/platform/integrations/streaming/amqp.md) and [Kafka](https://ably.com/docs/platform/integrations/streaming/kafka.md) integrations
* `partitionKey` for [AWS Kinesis](https://ably.com/docs/platform/integrations/streaming/kinesis.md) integrations
* `conflationKey` for [message conflation](#conflation)

### Interpolation 

As part of the syntax, interpolation is available to use the properties of a message to create the routing or conflation key.

The following properties can be used as variables:

| Variable | Description |
|----------|-------------|
| **`channelName`** | The name of a channel |
| **`message.name`** | The name of the message |
| **`message.id`** | The unique ID of the message |
| **`message.clientId`** | The ID of the client that published the message |
| **`message.extras.headers['<header-name>']`** | The value of the specified header in the `message.extras` field |

Interpolation uses the `#{...}` syntax, for example `channel-name-identifier-#{channel-1}`.

<Aside data-type="note">
For a Kafka rule, the `routingKey` includes both the topic and message routing key joined by a colon, for example `topic:key`, or with interpolation `topic-#{channelName}:message-key-#{message.name}`. So either, or both, can be dynamic. This split is done after any interpolation, but since Kafka topics cannot contain a colon, this does not introduce any ambiguity.
</Aside>

### Filters 

Interpolation can optionally be followed by a filter using pipe syntax.

The following filters are supported:

- **hash** - Transforms the variable into a stringified 32-bit fingerprint. It takes an optional numerical argument, the base to use when stringifying, which defaults to 16.
- **moduloHash** - Similar to hash, but runs the result through a modulo function before stringifying. This is useful for bucketing. It takes one mandatory argument; the number of buckets, and one optional argument; the base to use when stringifying, which defaults to 16.

If using a filter, you can specify a tuple of two or more variables as the input to the filter. It should be comma-separated and delimited with parentheses.

### Routing and conflation syntax examples 

The following are examples of using interpolation and filters to create a routing or conflation key:

* Hashed channel name as hex: `#{channelName | hash}`
* Hashed channel name as decimal: `#{channelName | hash(10)}`
* `the-foo-header-is-#{ message.extras.headers['foo'] }`
* Channel name in mod 256: `#{channelName | moduloHash(256)}`
* Channel name in octal: `#{channelName | moduloHash(256, 8)}`
* `message name: #{message.name}, clientId: #{message.clientId}`
* Hexadecimal hash combining all message properties except id: `#{(message.name, message.clientId, channelName) | hash}`
* `#{message.id}` will be different for every message, so useful for routing to kinesis shards at random
* `shard-#{message.id | moduloHash(4, 10)}` will be one of "shard-0", "shard-1", "shard-2", "shard-3"

## Related Topics

- [Message batching](https://ably.com/docs/messages/batch.md): Send messages to multiple channels in a single transaction, or batch messages server-side before sending them to subscribers.
- [Message annotations](https://ably.com/docs/messages/annotations.md): Annotate messages on a channel with additional metadata.
- [Updates, deletes and appends](https://ably.com/docs/messages/updates-deletes.md): Update and delete messages published to a channel, and retrieve message version history.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
