# Basic pub-sub

Ably Pub/Sub enables you to implement the publish-subscribe (pub-sub) pattern. Any number of publishers can send messages to a channel, and any number of subscribers can receive those messages. Publishers and subscribers are completely decoupled from one another.

[Channels](https://ably.com/docs/channels.md) are used to separate messages into different topics. [Messages](https://ably.com/docs/messages.md) contain the data that a client is communicating, such as the contents of an individual chat message, or an event that has occurred, such as updated financial information. Whilst billions of messages may be delivered by Ably, clients receive only the messages on the channels they subscribe to.

To get started with sending and receiving messages, all you need to do is:

* [Use a channel](#use)
* [Subscribe to the channel](#subscribe)
* [Publish messages to the channel](#publish)

## Use a channel 

Channels are used to separate your message traffic into different topics, and are identified by a unique name. Clients create or retrieve a channel and can then subscribe to them, and send messages to them.

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

## Subscribe to a channel 

Clients subscribe to a channel to receive the messages published to it. Clients can subscribe to all messages, or only messages identified by specific names.

Subscribing is an operation that is only available to the realtime interface of Pub/Sub SDKs. This is because it requires establishing a persistent [connection](https://ably.com/docs/connect.md) to Ably in order to receive messages in realtime.

Use the [`subscribe()`](https://ably.com/docs/api/realtime-sdk/channels.md#subscribe) method on a channel to receive any messages that are published to it.

The following is an example of subscribing to all messages on a channel:

<Code>

### Realtime Javascript

```
const realtime = new Ably.Realtime('your-api-key');
const channel = realtime.channels.get('your-channel-name');
await channel.subscribe((message) => {
  alert('Received: ' + message.data);
});
```

### Realtime Nodejs

```
const realtime = new Ably.Realtime('your-api-key');
const channel = realtime.channels.get('your-channel-name');
await channel.subscribe((message) => {
  console.log("Received: " + message.data);
});
```

### Realtime Ruby

```
  realtime = Ably::Realtime.new('your-api-key')
  channel = realtime.channels.get('your-channel-name')
  channel.subscribe do |message|
    puts "Received: #{message.data}"
  end
```

### Realtime Python

```
  realtime = AblyRealtime('your-api-key')
  channel = realtime.channels.get('your-channel-name')
  def listener(message):
    print('Received ' + message.data)
  await channel.subscribe(listener)
```

### Realtime Java

```
  AblyRealtime realtime = new AblyRealtime("your-api-key");
  Channel channel = realtime.channels.get("your-channel-name");
  channel.subscribe(new MessageListener() {
    @Override
    public void onMessage(Message message) {
      System.out.println("New messages arrived. " + message.name);
    }
  });
```

### Realtime Csharp

```
  AblyRealtime realtime = new AblyRealtime("your-api-key");
  IRealtimeChannel channel = realtime.Channels.Get("your-channel-name");
  channel.Subscribe(message => {
    Console.WriteLine($"Message: {message.Name}:{message.Data} received");
  });
```

### Realtime Objc

```
ARTRealtime *realtime = [[ARTRealtime alloc] initWithKey:@"your-api-key"];
ARTRealtimeChannel *channel = [realtime.channels get:@"your-channel-name"];
[channel subscribe:^(ARTMessage *message) {
    NSLog(@"Received: %@", message.data);
}];
```

### Realtime Swift

```
let realtime = ARTRealtime(key: "your-api-key")
let channel = realtime.channels.get("your-channel-name")
channel.subscribe { message in
    print("Received: \(message.data)")
}
```

### Realtime Flutter

```
  final realtime = ably.Realtime(key: 'your-api-key');
  final channel = realtime.channels.get('your-channel-name');
  final channelMessageSubscription = channel
    .subscribe()
    .listen((ably.Message message) {
      print('Received: ${message.data}');
    }
  );
```

### Realtime Go

```
realtime, err := ably.NewRealtime(
  ably.WithKey("your-api-key"))
channel := realtime.Channels.Get("your-channel-name")
if err != nil {
  panic(err)
}

_, err = channel.SubscribeAll(context.Background(), func(msg *ably.Message) {
  fmt.Printf("Received: '%v'\n", msg.Data)
})
```
</Code>

The following is an example of only subscribing to messages with a specific name:

<Code>

### Realtime Javascript

```
await channel.subscribe('myEvent', (message) => {
  console.log('message received for event ' + message.name);
  console.log('message data:' + message.data);
});
```

### Realtime Nodejs

```
await channel.subscribe('myEvent', (message) => {
  console.log('message received for event ' + message.name);
  console.log('message data:' + message.data);
});
```

### Realtime Java

```
channel.subscribe("myEvent", new MessageListener() {
  @Override
  public void onMessage(Message message) {
    System.out.println("Message received: " + message.data);
  }
});
```

### Realtime Csharp

```
channel.Subscribe("myEvent", message =>
{
    Console.WriteLine($"message received for event {message.Name}");
    Console.WriteLine($"message data: {message.Data}");
});
```

### Realtime Ruby

```
channel.subscribe('myEvent') do |message|
  puts "message received for event #{message.name}"
  puts "message data: #{message.data}"
end
```

### Realtime Python

```
  realtime = AblyRealtime('your-api-key')
  channel = realtime.channels.get('your-channel-name')
  def listener(message):
    print(f'Message received for {message.name}: {message.data}')
  await channel.subscribe('myEvent', listener)
```

### Realtime Swift

```
channel.subscribe("myEvent") { message in
    print("message received for event \(message.name)")
    print("message data: \(message.data)")
}
```

### Realtime Objc

```
[channel subscribe:@"myEvent" callback:^(ARTMessage *message) {
    NSLog(@"message received for event %@", message.name);
    NSLog(@"message data: %@", message.data);
}];
```

### Realtime Flutter

```
final channelMessageSubscription = channel
  .subscribe(name: 'myEvent')
  .listen((ably.Message message) {
    print('message received for event ${message.name}');
    print('message data: ${message.data}');
  }
);
```

### Realtime Go

```
_, err = channel.Subscribe(context.Background(), "myEvent", func(msg *ably.Message) {
  fmt.Printf("message received for event: '%v'\n", msg.Name)
  fmt.Printf("message data: '%v'\n", msg.Data)
})
```
</Code>

## Publish a message 

Publishing messages to a channel is how clients communicate with one another. Any subscribers will receive published messages as long as they are subscribed and have the `subscribe` [capability](https://ably.com/docs/auth/capabilities.md) for that channel.

Publishing is an operation available to the realtime and REST interfaces of Pub/Sub SDKs. REST publishing is more efficient if you don't need to establish a persistent [connection](https://ably.com/docs/connect.md) to Ably, such as to subscribe to messages. For example, if you have a server publishing messages to channels that doesn't need to receive any updates from them.

Use the [`publish()`](https://ably.com/docs/api/realtime-sdk/channels.md#publish) method to send messages to a channel.


<Code>

### Realtime Javascript

```
const realtime = new Ably.Realtime('your-api-key');
const channel = realtime.channels.get('your-channel-name');
await channel.publish('example', 'message data');
```

### Realtime Nodejs

```
const realtime = new Ably.Realtime('your-api-key');
const channel = realtime.channels.get('your-channel-name');
await channel.publish('example', 'message data');
```

### Realtime Ruby

```
  realtime = Ably::Realtime.new('your-api-key')
  channel = realtime.channels.get('your-channel-name')
  channel.publish 'example', 'message data'
```

### Realtime Python

```
  # Python realtime currently utilizes a REST publish
  realtime = AblyRealtime('your-api-key')
  channel = realtime.channels.get('your-channel-name')
  await channel.publish('example', 'message data')
```

### Realtime Java

```
  AblyRealtime realtime = new AblyRealtime("your-api-key");
  Channel channel = realtime.channels.get("your-channel-name");
  channel.publish("example", "message data");
```

### Realtime Csharp

```
  AblyRealtime realtime = new AblyRealtime("your-api-key");
  IRealtimeChannel channel = realtime.Channels.Get("your-channel-name");
  channel.Publish("example", "message data");
```

### Realtime Objc

```
ARTRealtime *realtime = [[ARTRealtime alloc] initWithKey:@"your-api-key"];
ARTRealtimeChannel *channel = [realtime.channels get:@"your-channel-name"];
[channel publish:@"example" data:@"message data"];
```

### Realtime Swift

```
let realtime = ARTRealtime(key: "your-api-key")
let channel = realtime.channels.get("your-channel-name")
channel.publish("example", data: "message data")
```

### Realtime Flutter

```
  final realtime = ably.Realtime(key: 'your-api-key');
  final channel = realtime.channels.get('your-channel-name');
  await channel.publish(name: 'example', data: 'message data');
```

### Realtime Go

```
realtime, err := ably.NewRealtime(
    ably.WithKey("your-api-key"))
if err != nil {
    log.Fatalf("Error creating Ably client: %v", err)
}
channel := realtime.Channels.Get("your-channel-name")
channel.Publish(context.Background(), "example", "message data")
```

### Rest Javascript

```
const rest = new Ably.Rest('your-api-key');
const channel = rest.channels.get('your-channel-name');
await channel.publish('example', 'message data');
```

### Rest Nodejs

```
const rest = new Ably.Rest('your-api-key');
const channel = rest.channels.get('your-channel-name');
await channel.publish('example', 'message data');
```

### Rest Ruby

```
  rest = Ably::Rest.new('your-api-key')
  channel = rest.channels.get('your-channel-name')
  channel.publish 'example', 'message data'
```

### Rest Python

```
  rest = AblyRest('your-api-key')
  channel = rest.channels.get('your-channel-name')
  await channel.publish(u'example', u'message data')
```

### Rest Php

```
  $rest = new Ably\AblyRest('your-api-key');
  $channel = $rest->channels->get('your-channel-name');
  $channel->publish('example', 'message data');
```

### Rest Java

```
  AblyRest rest = new AblyRest("your-api-key");
  Channel channel = rest.channels.get("your-channel-name");
  channel.publish("example", "message data");
```

### Rest Csharp

```
  AblyRest rest = new AblyRest("your-api-key");
  var channel = rest.Channels.Get("your-channel-name");
  await channel.PublishAsync("example", "message data");
```

### Rest Objc

```
  ARTRest *rest = [[ARTRest alloc] initWithKey:@"your-api-key"];
  ARTRestChannel *channel = [rest.channels get:@"your-channel-name"];
  [channel publish:@"example" data:@"message data"];
```

### Rest Swift

```
  let rest = ARTRest(key: "your-api-key")
  let channel = rest.channels.get("your-channel-name")
  channel.publish("example", data: "message data")
```

### Rest Flutter

```
  final rest = ably.Rest('your-api-key');
  final channel = rest.channels.get('your-channel-name');
  channel.publish(name: 'example', data: 'message data');
```

### Rest Go

```
rest, err := ably.NewREST(
  ably.WithKey("your-api-key"))
if err != nil {
  panic(err)
}
channel := rest.Channels.Get("your-channel-name")
if err := channel.Publish(context.Background(), "example", "message data"); err != nil {
  panic(err)
}
```
</Code>


<Aside data-type="note">
If you are publishing messages to stream LLM responses to users, [AI Transport](https://ably.com/docs/ai-transport.md) provides purpose-built token streaming with resumable sessions, multi-device continuity, and human-in-the-loop workflows on top of pub-sub.
</Aside>

<Aside data-type="further-reading">
You can find out more detail about how [channels](https://ably.com/docs/channels.md) and [messages](https://ably.com/docs/messages.md) work.

There are also more advanced ways that you can [subscribe](https://ably.com/docs/pub-sub/advanced.md#subscribe) to channels, and [publish](https://ably.com/docs/pub-sub/advanced.md#publish) messages, such as applying filters to your subscriptions or having a server publish messages on behalf of a client.

[Annotate](https://ably.com/docs/messages/annotations.md) messages to add reactions, categorization, and other metadata to them.

</Aside>

## Related Topics

- [Advanced pub-sub](https://ably.com/docs/pub-sub/advanced.md): Utilize advanced pub-sub features, such as, subscription filters and idempotent publishing.
- [React Hooks](https://ably.com/docs/getting-started/react-hooks.md): The React submodule enables you to use React Hooks to connect to Ably.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
