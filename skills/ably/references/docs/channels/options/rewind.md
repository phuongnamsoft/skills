# Rewind

The `rewind` channel param enables a client to specify where to start an attachment from, when attaching to a channel. Rewind can provide context to clients attaching to a channel by passing them previously published messages, such as in the example of a joining a chat room.

Clients can rewind to a point in time in the past, or for a given number of messages.

As `rewind` only applies to channel subscriptions, it is only available when using the realtime interface of an Ably SDK, or when using [SSE](https://ably.com/docs/protocols/sse.md) or [MQTT](https://ably.com/docs/protocols/mqtt.md).

Rewind only has an effect on an initial channel attachment. Any subsequent reattachment of the same channel on the same connection, in order to resume the connection, will attempt to resume with continuity from the point at which the connection dropped. There are a few exceptions to this, such as clients using [`recover` mode](https://ably.com/docs/connect/states.md#recover), where the previous attachment state is not preserved.

## Subscribe with rewind 

The `rewind` property of `params` can be set at a point in time in the past, or for a given number of messages. A `rewind` value that is a number, `N`, is a request to attach to the channel at a position `N` messages before the present position. A `rewind` value with a time specifier is a request to attach to the channel at a point in time in the past, such as `10s` for 10 seconds, or `5m` for 5 minutes.

If the attachment is successful, and one or more messages exist on the channel prior to the present position, then those messages will be delivered to the subscriber immediately after the attachment has completed, and before any subsequent messages that arise in real time.

Any `rewind` value that cannot be parsed either as a number or a time specifier will cause the attachment request to fail and return an error.

<Aside data-type="note">
If you have enabled the [persist last message](https://ably.com/docs/storage-history/storage.md#persist-last-message) rule on a channel, you can attach with `rewind=1` to retrieve the last message. Only the last message published can be stored for up to a year, and persist last message doesn't apply to presence or object messages.
</Aside>

The following example subscribes to a channel and retrieves the most recent message sent on it, if available:

<Code>

### Realtime Javascript

```
  const realtime = new Ably.Realtime('your-api-key');
  const channel = realtime.channels.get('your-channel-name', {
    params: {rewind: '1'}
  });
  await channel.subscribe((message) => {
    console.log('Received message: ' + message.data);
  });
```

### Realtime Nodejs

```
  const realtime = new Ably.Realtime('your-api-key');
  const channel = realtime.channels.get('your-channel-name', {
    params: {rewind: '1'}
  });
  await channel.subscribe((message) => {
    console.log('Received message: ' + message.data);
  });
```

### Realtime Python

```
  # Python must use a channel qualifier to use rewind
  realtime = AblyRealtime('your-api-key')
  realtime.channels.get('[?rewind=1]your-channel-name')
  def listener(message):
    print('Received message: ' + message.data)
  await channel.subscribe(listener)
```

### Realtime Java

```
  final Map<String, String> params = new HashMap<>();
  params.put("rewind", "1");
  final ChannelOptions options = new ChannelOptions();
  options.params = params;
  final Channel channel = ably.channels.get("your-channel-name", options);

  channel.subscribe(new MessageListener() {
    @Override
    public void onMessage(Message message) {
      System.out.println("Received `" + message.name + "` message with data: " + message.data);
    }
  });
```

### Realtime Swift

```
  let options = ARTClientOptions(key: "your-api-key")
  let client = ARTRealtime(options: options)
  let channelOptions = ARTRealtimeChannelOptions()
  channelOptions.params = [
    "rewind": "1"
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
  channelParams.Add("rewind", "1");
  var channelOptions = new ChannelOptions();
  channelOptions.Params = channelParams;
  var channel = ably.Channels.Get("your-channel-name", channelOptions);

  channel.Subscribe(message => {
      Console.WriteLine(message.Data.ToString());
  });
```

### Realtime Go

```
realtime, _ := ably.NewRealtime(
  ably.WithKey("your-api-key"))
channel := realtime.Channels.Get("[?rewind=1]your-channel-name")
channel.SubscribeAll(context.Background(), func(message *ably.Message) {
  log.Printf("Received message: '%v'", message.Data)
})
```

### Realtime Flutter

```
final realtime = ably.Realtime(
    options: ably.ClientOptions(
        key: 'your-api-key'
    )
);
final channel = realtime.channels.get('your-channel-name');
const channelOptions = RealtimeChannelOptions(
  params: { 'rewind': '1' },
);

await channel.setOptions(channelOptions);
channel.subscribe().listen((message) {
  print('Received message: ${message.data}');
});
```
</Code>

<Aside data-type="note">
If using [MQTT](https://ably.com/docs/protocols/mqtt.md) or [SSE](https://ably.com/docs/protocols/sse.md), you can [specify channel params](https://ably.com/docs/channels/options.md#other-sdks) as a query string.
</Aside>

### Retrieve a number of messages 

Set `rewind` to an integer to retrieve a given number of messages in the past. If fewer than the requested number of messages exists on the channel, including the case where there are no prior messages, then any available messages are sent. This does not constitute an error.

The following is an example of qualifying the channel name to rewind by 1 message:

<Code>

#### Realtime Javascript

```
  const realtime = new Ably.Realtime('your-api-key');
  const channel = realtime.channels.get('[?rewind=1]your-channel-name');
  await channel.subscribe((message) => {
    alert('Received: ' + message.data);
  });
```

#### Realtime Nodejs

```
  const realtime = new Ably.Realtime('your-api-key');
  const channel = realtime.channels.get('[?rewind=1]your-channel-name');
  await channel.subscribe((message) => {
    console.log("Received: " + message.data);
  });
```

#### Realtime Ruby

```
  realtime = Ably::Realtime.new('your-api-key')
  channel = realtime.channels.get('[?rewind=1]your-channel-name')
  channel.subscribe do |message|
    puts "Received: #{message.data}"
  end
```

#### Realtime Python

```
  realtime = AblyRealtime('your-api-key')
  realtime.channels.get('[?rewind=1]your-channel-name')
  def listener(message):
    print('Received message: ' + message.data)
  await channel.subscribe(listener)
```

#### Realtime Java

```
  AblyRealtime realtime = new AblyRealtime("your-api-key");
  Channel channel = realtime.channels.get("[?rewind=1]your-channel-name");
  channel.subscribe(new MessageListener() {
    @Override
    public void onMessage(Message message) {
      System.out.println("New messages arrived. " + message.name);
    }
  });
```

#### Realtime Csharp

```
  AblyRealtime realtime = new AblyRealtime("your-api-key");
  IRealtimeChannel channel = realtime.Channels.Get("[?rewind=1]your-channel-name");
  channel.Subscribe(message => {
    Console.WriteLine($"Message: {message.Name}:{message.Data} received");
  });
```

#### Realtime Objc

```
ARTRealtime *realtime = [[ARTRealtime alloc] initWithKey:@"your-api-key"];
ARTRealtimeChannel *channel = [realtime.channels get:@"[?rewind=1]your-channel-name"];
[channel subscribe:^(ARTMessage *message) {
    NSLog(@"Received: %@", message.data);
}];
```

#### Realtime Swift

```
let realtime = ARTRealtime(key: "your-api-key")
let channel = realtime.channels.get("[?rewind=1]your-channel-name")
channel.subscribe { message in
    print("Received: \(message.data)")
}
```

#### Realtime Go

```
realtime, _ := ably.NewRealtime(
  ably.WithKey("your-api-key"))
channel := realtime.Channels.Get("[?rewind=1]your-channel-name")
channel.SubscribeAll(context.Background(), func(message *ably.Message) {
  log.Printf("Received: '%v'", message.Data)
})
```

#### Realtime Flutter

```
final realtime = ably.Realtime(
    options: ably.ClientOptions(
        key: 'your-api-key'
    )
);
final channel = realtime.channels.get('[?rewind=1]your-channel-name');
channel.subscribe().listen((message) {
  print('Received: ${message.data}');
});
```
</Code>

### Retrieve messages from a period of time 

Set `rewind` to an integer with a time specifier to retrieve messages from a period of time in the past. The available time specifiers are are `s` for seconds and `m` for minutes, for example `5s` or `2m`.

The following is an example of qualifying the channel name to rewind by 10 seconds:

<Code>

#### Realtime Javascript

```
  const realtime = new Ably.Realtime('your-api-key');
  const channel = realtime.channels.get('[?rewind=10s]your-channel-name');
  await channel.subscribe((message) => {
    alert('Received: ' + message.data);
  });
```

#### Realtime Nodejs

```
  const realtime = new Ably.Realtime('your-api-key');
  const channel = realtime.channels.get('[?rewind=10s]your-channel-name');
  await channel.subscribe((message) => {
    console.log("Received: " + message.data);
  });
```

#### Realtime Ruby

```
  realtime = Ably::Realtime.new('your-api-key')
  channel = realtime.channels.get('[?rewind=10s]your-channel-name')
  channel.subscribe do |message|
    puts "Received: #{message.data}"
  end
```

#### Realtime Python

```
  realtime = AblyRealtime('your-api-key')
  realtime.channels.get('[?rewind=10s]your-channel-name')
  def listener(message):
    print('Received message: ' + message.data)
  await channel.subscribe(listener)
```

#### Realtime Java

```
  AblyRealtime realtime = new AblyRealtime("your-api-key");
  Channel channel = realtime.channels.get("[?rewind=10s]your-channel-name");
  channel.subscribe(new MessageListener() {
    @Override
    public void onMessage(Message message) {
      System.out.println("New messages arrived. " + message.name);
    }
  });
```

#### Realtime Csharp

```
  AblyRealtime realtime = new AblyRealtime("your-api-key");
  IRealtimeChannel channel = realtime.Channels.Get("[?rewind=10s]your-channel-name");
  channel.Subscribe(message => {
    Console.WriteLine($"Message: {message.Name}:{message.Data} received");
  });
```

#### Realtime Objc

```
ARTRealtime *realtime = [[ARTRealtime alloc] initWithKey:@"your-api-key"];
ARTRealtimeChannel *channel = [realtime.channels get:@"[?rewind=1]your-channel-name"];
[channel subscribe:^(ARTMessage *message) {
    NSLog(@"Received: %@", message.data);
}];
```

#### Realtime Swift

```
let realtime = ARTRealtime(key: "your-api-key")
let channel = realtime.channels.get("[?rewind=10s]your-channel-name")
channel.subscribe { message in
    print("Received: \(message.data)")
}
```

#### Realtime Go

```
realtime, _ := ably.NewRealtime(
  ably.WithKey("your-api-key"))
channel := realtime.Channels.Get("[?rewind=10s]your-channel-name")
channel.SubscribeAll(context.Background(), func(message *ably.Message) {
  log.Printf("Received: '%v'", message.Data)
})
```

#### Realtime Flutter

```
final realtime = ably.Realtime(
    options: ably.ClientOptions(
        key: 'your-api-key'
    )
);
final channel = realtime.channels.get('[?rewind=10s]your-channel-name');
channel.subscribe().listen((message) {
  print('Received: ${message.data}');
});
```
</Code>

### Number of messages and period of time 

It is also possible to rewind by a set number of messages, within a period of time using the `rewindLimit` option.

For example, to request up to 10 messages in a window 5 minutes before the present time, specify a value of `rewind=5m&rewindLimit=10`. If fewer than the requested number of messages exists on the channel, including the case where there are no prior messages, then any available messages are sent. This does not constitute an error.

### Limits on rewind 

At most 100 messages will be sent in a rewind request. If the number of messages within the specified interval is greater than that limit, then only the most recent messages up to that limit are sent. The attachment succeeds, but truncation of the message backlog is indicated as a non-fatal error in the attachment response.

Rewind is restricted by the channel's persistence period. If [persisted history](https://ably.com/docs/storage-history/storage.md), isn't enabled for the channel then this will be 2 minutes. If you have persistence enabled, this will be 24 hours for free accounts, and 72 hours for paid accounts. As an example, if you specify `rewind=3m` without persisted history enabled, you will only receive the last 2 minutes of messages upon attaching.

## Related Topics

- [Overview](https://ably.com/docs/channels/options.md): Channel options customize the functionality of channels.
- [Deltas](https://ably.com/docs/channels/options/deltas.md): The delta channel option enables clients to subscribe to a channel and only receive the difference between the present and previous message.
- [Echo](https://ably.com/docs/channels/options/echo.md): The echo channel option enables per-channel control over whether a client receives its own published messages.
- [Encryption](https://ably.com/docs/channels/options/encryption.md): Encrypt message payloads using the cipher channel option.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
