# Echo

By default, clients receive their own messages when subscribed to a channel they publish on. This is useful in many applications because it means every subscriber, including the publisher, renders state from the same stream of messages. For example, in a chat application or collaborative editor, a client can publish a message and then update its UI only when that message arrives back on the channel, guaranteeing that all participants see the same ordering and state.

However, this is not always desirable. A client streaming pricing updates, publishing telemetry data, or sending tokens via [AI Transport](https://ably.com/docs/ai-transport.md) does not need to hear its own messages echoed back. Suppressing echo on these channels reduces unnecessary bandwidth and message processing.

Set `echo` to `false` in the channel `params` to suppress echo on a per-channel basis. As `echo` only applies to channel subscriptions, it is only available when using the realtime interface of an Ably SDK, or when using [SSE](https://ably.com/docs/protocols/sse.md) or [MQTT](https://ably.com/docs/protocols/mqtt.md).

## When to suppress echo 

Suppressing echo per-channel is useful when a client publishes and subscribes on the same channel but does not need its own messages back:

- **Streaming data**: A client publishing live pricing updates, sensor readings, or telemetry to a channel does not need those messages echoed back. Suppressing echo avoids redundant processing and reduces bandwidth.
- **AI token streaming**: An [AI Transport](https://ably.com/docs/ai-transport.md) agent publishes tokens at high frequency and subscribes for steering or control messages. Echoing every token back to the publishing agent is wasteful.
- **RPC over channels**: A caller publishes a request and subscribes for the response on the same channel. The caller already knows what it sent.
- **Mixed workloads**: Some channels on a connection need echo, such as collaborative editing where a client confirms its updates, while others do not, such as notification or logging channels.

The connection-level [`echoMessages`](https://ably.com/docs/api/realtime-sdk/types.md#client-options) option disables echo across all channels on a connection. The `echo` channel param provides finer control, disabling echo on specific channels while leaving others unaffected.

## Suppress echo on a channel 

Set the `echo` param to `false` when obtaining a channel instance:

<Code>

### Realtime Javascript

```
const channel = realtime.channels.get('your-channel-name', {
  params: { echo: 'false' }
});

await channel.subscribe((message) => {
  // Only receives messages from other clients, not from this client
  console.log('Received:', message.data);
});
```

### Realtime Nodejs

```
const channel = realtime.channels.get('your-channel-name', {
  params: { echo: 'false' }
});

await channel.subscribe((message) => {
  // Only receives messages from other clients, not from this client
  console.log('Received:', message.data);
});
```

### Realtime Java

```
ChannelOptions channelOpts = new ChannelOptions();
channelOpts.params = new HashMap<>();
channelOpts.params.put("echo", "false");

Channel channel = ably.channels.get("your-channel-name", channelOpts);

channel.subscribe(new Channel.MessageListener() {
    @Override
    public void onMessage(Message message) {
        // Only receives messages from other clients, not from this client
        System.out.println("Received: " + message.data);
    }
});
```

### Realtime Go

```
channel := realtime.Channels.Get("your-channel-name", ably.ChannelWithParams("echo", "false"))

_, err := channel.SubscribeAll(context.Background(), func(msg *ably.Message) {
	// Only receives messages from other clients, not from this client
	log.Println("Received:", msg.Data)
})
if err != nil {
	log.Panic(err)
}
```

### Realtime Flutter

```
final channel = realtime.channels.get('your-channel-name');
const channelOptions = RealtimeChannelOptions(
  params: {'echo': 'false'},
);

await channel.setOptions(channelOptions);
channel.subscribe().listen((message) {
  // Only receives messages from other clients, not from this client
  print('Received: ${message.data}');
});
```
</Code>

## Interaction with connection-level echo 

The channel-level `echo` param works alongside the connection-level [`echoMessages`](https://ably.com/docs/api/realtime-sdk/types.md#client-options) setting:

| Connection `echoMessages` | Channel `echo` param | Result |
|---------------------------|---------------------|--------|
| `true` (default) | Not set | Messages echoed |
| `true` (default) | `false` | Messages suppressed on this channel |
| `false` | Not set | Messages suppressed (connection-level) |
| `false` | `false` | Messages suppressed |

The channel-level param only adds suppression. If the connection already has `echoMessages` set to `false`, echo is suppressed regardless of the channel param.

<Aside data-type='note'>
The `echo` channel param only affects messages. Presence events are always delivered regardless of the echo setting.
</Aside>

## Related Topics

- [Overview](https://ably.com/docs/channels/options.md): Channel options customize the functionality of channels.
- [Rewind](https://ably.com/docs/channels/options/rewind.md): The rewind channel param enables clients to attach to a channel and receive messages previously published on it.
- [Deltas](https://ably.com/docs/channels/options/deltas.md): The delta channel option enables clients to subscribe to a channel and only receive the difference between the present and previous message.
- [Encryption](https://ably.com/docs/channels/options/encryption.md): Encrypt message payloads using the cipher channel option.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
