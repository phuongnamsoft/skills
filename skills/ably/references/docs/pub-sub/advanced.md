# Advanced pub-sub

After understanding the [basics](https://ably.com/docs/pub-sub.md) of subscribing to a channel and publishing messages to it, explore the more advanced concepts and features to build more complex and efficient applications.

## Subscribing to channels 

Explore additional concepts and features after understanding the [basics of subscribing](https://ably.com/docs/pub-sub.md#subscribe) to channels.

As a reminder, you can subscribe to all messages on a channel:

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

Or you can subscribe to messages with a specific name:

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

### Unsubscribe from a channel 

Unsubscribing from a channel removes previously registered listeners that were added when subscribing to it. You can remove all listeners, or listeners that were registered for only a single event.

Use the [`unsubscribe()`](https://ably.com/docs/api/realtime-sdk/channels.md#unsubscribe) method to remove previously registered listeners:

<Code>

#### Realtime Javascript

```
/* remove the listener registered for a single event */
channel.unsubscribe('myEvent', myListener);

/* remove the listener registered for all events */
channel.unsubscribe(myListener);
```

#### Realtime Nodejs

```
/* remove the listener registered for a single event */
channel.unsubscribe('myEvent', myListener);

/* remove the listener registered for all events */
channel.unsubscribe(myListener);
```

#### Realtime Java

```
/* remove a single listener */
channel.unsubscribe(myListener);

/* remove the listener registered for all events */
channel.unsubscribe("myEvent", myListener);
```

#### Realtime Csharp

```
/* remove a single listener */
channel.Unsubscribe(myHandler);

/* remove the listener registered for all events */
channel.Unsubscribe("myEvent", myHandler);
```

#### Realtime Ruby

```
# remove the listener proc registered for a single event
channel.unsubscribe("myEvent", &my_proc)

# remove the listener proc registered for all events
channel.unsubscribe(&my_proc)
```

#### Realtime Python

```
# remove the listener registered for a single event
channel.unsubscribe('event', listener)

# remove the listener registered for all events
channel.unsubscribe(listener)
```

#### Realtime Objc

```
// remove the listener registered for a single event
[channel unsubscribe:@"myEvent" listener:listener];

// remove the listener registered for all events
[channel unsubscribe:listener];
```

#### Realtime Swift

```
// remove the listener registered for a single event
channel.unsubscribe("myEvent", listener: listener)

// remove the listener registered for all events
channel.unsubscribe(listener)
```

#### Realtime Flutter

```
channelMessageSubscription.cancel();
```

#### Realtime Go

```
unsubscribe, err := channel.Subscribe(context.Background(), "test-event", func(msg *ably.Message) {
  log.Println("Received message:", msg)
})
if err != nil {
  log.Fatal(err)
}

unsubscribe()
```
</Code>

### Attaching versus subscribing 

Messages are streamed to clients as soon as they attach to a channel, as long as they have the `subscribe` [capability](https://ably.com/docs/auth/capabilities.md) for it. This is independent of whether or not they have subscribed to the channel.

Subscribing to a channel only registers a listener, or function, client-side that is called each time a message is received. This means that Ably is unaware of whether or not a client is subscribed to a channel.

Channels are not pre-configured or provisioned by Ably in advance. They are created on demand when clients [attach](https://ably.com/docs/channels/states.md#attach) to them, and remain active until there are no remaining clients attached. Attaching to a channel is an action that happens implicitly when a client subscribes to it.

The following is an example of implicitly attaching to a channel and then publishing a message:

<Code>

#### Realtime Javascript

```
const channel = realtime.channels.get('chatroom');
await channel.subscribe('action', (message) => { // implicit attach
  console.log('Message received ' + message.data);
});
await channel.publish('action', 'boom!');
```

#### Realtime Nodejs

```
const channel = realtime.channels.get('chatroom');
await channel.subscribe('action', (message) => { // implicit attach
  console.log('Message received ' + message.data);
});
await channel.publish('action', 'boom!');
```

#### Realtime Ruby

```
channel = realtime.channels.get('chatroom')
channel.subscribe('action') do |message| # implicit attach
  puts "Message received: #{message}";
end
channel.publish 'action', 'boom!'
```

#### Realtime Python

```
channel = realtime.channels.get('chatroom')
def listener(message):
  print('Message received: ' + message.data)
await channel.subscribe(listener)
await channel.publish('action', 'boom')
```

#### Realtime Java

```
Channel channel = realtime.channels.get("chatroom");
/* Implicit attach when subscribing */
channel.subscribe(new MessageListener() {
  @Override
  public void onMessage(Message message) {
    System.out.println("Message received: " + message.data);
  }
});
channel.publish("action", "boom!");
```

#### Realtime Csharp

```
IRealtimeChannel channel = realtime.Channels.Get("chatroom");
channel.Subscribe(message => Console.WriteLine("Message received: " + message.Data));
channel.Publish("action", "boom");
```

#### Realtime Objc

```
ARTRealtimeChannel *channel = [realtime.channels get:@"chatroom" options:options];
[channel subscribe:@"action" callback:^(ARTMessage *message) {
    NSLog(@"Message received: %@", message.data);
}]
[channel publish:@"action" data:@"boom!"];
```

#### Realtime Swift

```
let channel = realtime.channels.get("chatroom")
channel.subscribe("action") { message in
    print("Message received: \(message.data)")
}
channel.publish("action", data: "boom!")
```

#### Realtime Flutter

```
final channel = realtime.channels.get('chatroom');
/* Implicit attach when subscribing */
channel.subscribe(name: 'action').listen((ably.Message message) {
  print('Received: ${message.data}');
});
channel.publish(name: 'action', data: 'boom!');
```

#### Realtime Go

```
channel := realtime.Channels.Get("chatroom")
_, _ = channel.Subscribe(context.Background(), "action", func(msg *ably.Message) {
  fmt.Printf("Message received: '%v'\n", msg.Data)
})

_ = channel.Publish(context.Background(), "action", "boom!")
```
</Code>

Subscribing to a channel implicitly attaches a client. If a client subscribes to and then unsubscribes from a channel, the client remains attached. The client will continue to be sent published messages until they [`detach()`](https://ably.com/docs/api/realtime-sdk/channels.md#detach) from the channel.

<Aside data-type="note">
Any errors in attaching to a channel are received via the [`attach()`](https://ably.com/docs/api/realtime-sdk/channels.md#attach) callback. When attaching implicitly you can listen for [channel state changes](https://ably.com/docs/channels/states.md#attach) instead.
</Aside>

### Detaching versus unsubscribing 

Understanding the difference between detaching and unsubscribing from a channel is essential. Messages will continue to be sent to clients if they only call the [`unsubscribe()`](https://ably.com/docs/api/realtime-sdk/channels.md#unsubscribe) method.

The [`detach()`](https://ably.com/docs/api/realtime-sdk/channels.md#detach) method detaches a client from a channel. A client will no longer receive any messages published to the channel once they detach. `unsubscribe()` only removes message listeners for a channel and is a client-side operation. To reiterate, Ably is unaware of whether or not a client has subscribed or unsubscribed from a channel. Messages will continue to be streamed to the client until `detach()` is called.

[`subscribe()`](https://ably.com/docs/api/realtime-sdk/channels.md#subscribe) implicitly attaches a client to a channel. If you call `subscribe()` followed by `unsubscribe()`, the client remains attached to the channel and will continue to be streamed messages from Ably.

### Server subscriptions 

Subscribing to events server-side using the pub-sub pattern can be disadvantageous as it can increase latency, or duplicate events between multiple servers.

[Message queues](https://ably.com/docs/platform/integrations/queues.md) are more appropriate to use in this instance, as multiple worker servers enable Ably to distribute the load of messages received. This ensures that each message is only processed once, by any one of your worker servers.

<Aside data-type='usp'>
Even load distribution with consistent hashing.

Ably's message queues use [consistent hashing](https://ably.com/docs/platform/architecture/platform-scalability.md#consistent-hashing-for-workload-distribution) to distribute messages across worker servers, ensuring even load distribution and exactly-once processing.
</Aside>

### Subscription filters 

Subscription filters enable you to subscribe to a channel and only receive messages that satisfy a filter expression.

Messages are streamed to clients as soon as they [attach](https://ably.com/docs/channels/states.md#attach) to a channel, if they have the `subscribe` [capability](https://ably.com/docs/auth/capabilities.md) for it. Subscription filters apply server-side filtering to messages, meaning that a client will only ever receive the messages that they subscribe to.

Subscription filters are currently in preview status.

<Aside data-type="note">
Normal [limits](https://ably.com/docs/platform/pricing/limits.md) still apply when using subscription filters. As such, it is not recommended to publish all data to a single channel and rely solely on subscription filters. A level of partitioning at the channel level is still required for the majority of use cases.
</Aside>

#### Create a filter expression 

Filter expressions should be written using [JMESPath.](https://jmespath.org/) They can be constructed using the message name and `message.extras.headers` fields.

`message.extras.headers` optionally provides ancillary metadata to a message, as Ably can't inspect message payloads themselves. Adding suitable key-value pairs to messages will enable more complicated filter expressions to be constructed resulting in more effective message filtering.

The following is an example of publishing a message with additional metadata:

<Code>

##### Realtime Javascript

```
const channel = realtime.channels.get('scoops-kiosk');
await channel.publish({
    name: 'ice-cream',
    data: '...',
    extras: {
        headers: {
            flavor: 'strawberry',
            cost: 35,
            temp: 3
        }
    }
});
```

##### Realtime Java

```
Channel channel = realtime.channels.get("scoops-kiosk");

final JsonObject json = new JsonObject();
json.addProperty("flavor", "strawberry");
json.addProperty("cost", 35);
json.addProperty("temp", 3);

MessageExtras extras = new MessageExtras(json);

Message message = new Message();
message.name = "ice-cream";
message.data = "...";
message.extras = extras;

channel.publish(new Message[]{message});
```

##### Realtime Python

```
channel = realtime.channels.get('scoops-kiosk')
extras = {
  'headers': {
    'flavor': 'strawberry',
    'cost': 35,
    'temp': 3
  }
}

message = Message(name='ice-cream', data='test', extras=extras)
await channel.publish(message)
```

##### Realtime Go

```
realtime, err := ably.NewRealtime(
  ably.WithKey("your-api-key"))
if err != nil {
  log.Fatal(err)
}

channel := realtime.Channels.Get("scoops-kiosk")

message := &ably.Message{
  Name: "ice-cream",
  Data: "...",
  Extras: map[string]interface{}{
    "headers": map[string]interface{}{
      "flavor": "strawberry",
      "cost":   35,
      "temp":   3,
    },
  },
}

err = channel.Publish(context.Background(), "event", message)
```

##### Realtime Flutter

```
final channel = realtime.channels.get('scoops-kiosk');
final messageData = ably.Message(
  name: 'ice-cream',
  data: '...',
  extras: const ably.MessageExtras({
    'headers': {
      'flavor': 'strawberry',
      'cost': 35,
      'temp': 3,
    },
  }),
);

await channel.publish(message: messageData);
```

##### Rest Javascript

```
const channel = rest.channels.get('scoops-kiosk');
await channel.publish({
    name: 'ice-cream',
    data: '...',
    extras: {
        headers: {
            flavor: "strawberry",
            cost: 35,
            temp: 3
        }
    }
});
```

##### Rest Java

```
Channel channel = rest.channels.get("scoops-kiosk");

final JsonObject json = new JsonObject();
json.addProperty("flavor", "strawberry");
json.addProperty("cost", 35);
json.addProperty("temp", 3);

MessageExtras extras = new MessageExtras(json);

Message message = new Message();
message.name = "ice-cream";
message.data = "...";
message.extras = extras;

channel.publish(new Message[]{message});
```

##### Rest Python

```
channel = rest.channels.get('scoops-kiosk')
extras = {
  'headers': {
    'flavor': 'strawberry',
    'cost': 35,
    'temp': 3
  }
}

message = Message(name='ice-cream', data='test', extras=extras)
await channel.publish(message)
```

##### Rest Php

```
$channel = $rest->channels->get('scoops-kiosk');
$extras = [
    'headers' => [
        'flavor' => 'strawberry',
        'cost' => 35,
        'temp' => 3
    ]
];

$message = new \Ably\Models\Message();
$message->name = 'ice-cream';
$message->data = 'test';
$message->extras = $extras;

$channel->publish($message);
```

##### Rest Go

```
rest, err := ably.NewREST(
  ably.WithKey("your-api-key"))
if err != nil {
  log.Fatal(err)
}

channel := rest.Channels.Get("scoops-kiosk")

message := &ably.Message{
  Name: "ice-cream",
  Data: "...",
  Extras: map[string]interface{}{
    "headers": map[string]interface{}{
      "flavor": "strawberry",
      "cost":   35,
      "temp":   3,
    },
  },
}

err = channel.Publish(context.Background(), "event", message)
```

##### Rest Flutter

```
final channel = rest.channels.get('scoops-kiosk');
final messageData = ably.Message(
  name: 'ice-cream',
  data: '...',
  extras: const ably.MessageExtras({
    'headers': {
      'flavor': 'strawberry',
      'cost': 35,
      'temp': 3,
    },
  }),
);

await channel.publish(message: messageData);
```
</Code>

`message.extras.headers` must be a flat object. It cannot contain any further nesting or arrays.

The following is an example of a filter expression subscribing to messages with the name "ice-cream", a flavor of "strawberry" and a cost of less than 50:

<Code>

##### Text

```
name == `"ice-cream"` && headers.flavor == `"strawberry"` && headers.cost < `50`
```
</Code>

The following is an example of a filter expression subscribing to messages with a flavor of either "strawberry" or "chocolate":

<Code>

##### Text

```
headers.flavor == `"strawberry"` || headers.flavor == `"chocolate"`
```
</Code>

#### Subscribe with a filter 

In order to subscribe to a channel with a filter expression, you obtain a channel instance using the `getDerived()` method. This accepts a filter expression as a parameter.

The following is an example of subscribing to a channel using one of the previous example filters:

<Code>

##### Realtime Javascript

```
const channel = realtime.channels.getDerived('scoops-kiosk', {
  filter: 'name == `"ice-cream"` && headers.flavor == `"strawberry"` && headers.cost < `50`'
})
await channel.subscribe(...);
```

##### Realtime Go

```
filter := "name == `\"ice-cream\"` && headers.flavor == `\"strawberry\"` && headers.cost < `50`"
channel, _ := realtime.Channels.GetDerived("scoops-kiosk", ably.DeriveOptions{Filter: filter})

_, err = channel.Subscribe(context.Background(), "scoops-kiosk", func(msg *ably.Message) {
  fmt.Printf("Received message : '%v'\n", msg.Data)
})
```
</Code>

<Aside data-type="note">
Clients that are publishing to the same channel that they are subscribed to using a filter need to obtain a channel instance twice. Once with the filter expression using `getDerived()` for the subscription and once using [`get()`](https://ably.com/docs/api/realtime-sdk/channels.md#get) for publishing. Attempts to publish to a channel created or retrieved with a filter expression will fail.
</Aside>

The following example demonstrates publishing to a channel, but subscribing to only a subset of messages on it:

<Code>

##### Realtime Javascript

```
// Connect to Ably
const realtime = new Ably.Realtime({'your-api-key'});

// Create a channel instance to publish to
const pubChannel = realtime.channels.get('scoops-kiosk');

// Create a channel instance using the filter qualifier
const subChannel = realtime.channels.getDerived('scoops-kiosk', {
   filter: 'name == `"ice-cream"` && headers.flavor == `"strawberry"` && headers.cost < `50`'
});

// Subscribe to the channel using the filtered subscription
await subChannel.subscribe((message) => {
   alert('Ice cream update: ' + message.data);
 });

// Publish to the unfiltered channel instance
await pubChannel.publish({
   name: 'ice-cream',
   data: '...',
   extras: {
       headers: {
           flavor: 'strawberry',
           cost: 35,
           temp: 3
       }
   });
});
```
</Code>

#### Subscription filter capabilities 

Clients require the subscribe [capability](https://ably.com/docs/auth/capabilities.md) for one of the following resources in order to receive messages from a subscription filter:

* `[filter]<channel name>`
* `[*]<channel name>`
* `[*]*`

A client may also [attach](https://ably.com/docs/channels/states.md#attach) to the unfiltered instance of a channel for other operations, such as to subscribe to the [presence](https://ably.com/docs/presence-occupancy/presence.md) set. If clients attach to the unfiltered instance and have the subscribe capability for the channel itself, they will be sent all messages by Ably due to the [difference between attaching and subscribing](#attach-subscribe) to a channel.

The following features are not supported using subscription filters:

* [Presence](https://ably.com/docs/presence-occupancy/presence.md)
* [History](https://ably.com/docs/storage-history/history.md)
* [Deltas](https://ably.com/docs/channels/options/deltas.md)
* [Rewind](https://ably.com/docs/channels/options/rewind.md)

## Publish 

Several more advanced concepts are involved in publishing messages beyond the [basics of publishing](https://ably.com/docs/pub-sub.md#publish) messages.

As a reminder, to publish a message to a channel:


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

### Publish to multiple channels 

To publish a single message to multiple channels, make multiple [`publish()`](https://ably.com/docs/api/realtime-sdk/channels.md#publish) requests using the realtime interface of an SDK. These concurrent requests can be in-flight simultaneously, ensuring that a publish on one channel does not delay operations in other channels.

To publish to multiple channels in a single call, use the [batch publish](https://ably.com/docs/messages/batch.md#batch-publish) feature.

### Echoing messages 

By default, clients will receive their own messages if they are also subscribed to the channel. This is known as echoing.

Set the [`echoMessages`](https://ably.com/docs/api/realtime-sdk/types.md#client-options) property of `ClientOptions` to `false` to disable this behavior. This will stop clients from receiving the messages that they published themselves, but they will continue to receive messages published by others.

To suppress echo on individual channels rather than the entire connection, use the [`echo` channel param](https://ably.com/docs/channels/options/echo.md). This is useful when a connection needs echo on some channels but not others.

This property is only available using the realtime interface of an SDK, as it isn't possible to subscribe to messages using the REST interface.

### Transient publishing 

Transient publishing is when a client publishes messages without attaching to a channel. This is a feature of the realtime interface of [certain Ably SDKs](https://ably.com/docs/sdks.md). Transient publishing can be beneficial when publishing to many channels as it removes the need to attach to a channel each time you publish. It also prevents a client from subscribing to messages, avoiding redundant message delivery.

The following is an example of publishing without attaching to a channel:

<Code>

#### Realtime Javascript

```
const channel = realtime.channels.get('chatroom');
// The publish below will not attach you to the channel
await channel.publish('action', 'boom!');
```

#### Realtime Nodejs

```
const channel = realtime.channels.get('chatroom');
// The publish below will not attach you to the channel
await channel.publish('action', 'boom!');
```

#### Realtime Java

```
Channel channel = ably.channels.get("chatroom");
// The publish below will not attach you to the channel
channel.publish("action", "boom!");
```

#### Realtime Ruby

```
channel = realtime.channels.get('chatroom')
# The publish below will not attach you to the channel
channel.publish 'action', 'boom!'
```

#### Realtime Swift

```
let channel = realtime.channels.get("chatroom")
// The publish below will not attach you to the channel
channel.publish("action", data: "boom!")
```

#### Realtime Flutter

```
final channel = realtime.channels.get('your-channel-name');
// The publish below will not attach you to the channel
await channel.publish(name: 'example', data: 'message data');
```

#### Realtime Go

```
channel := realtime.Channels.Get("chatroom")
channel.Publish(context.Background(), "action", "boom!")
```
</Code>

### Ephemeral messages 

A message can be marked as *ephemeral* to exempt it from:
- being stored in [persisted history](https://ably.com/docs/storage-history/storage.md)
- being sent in [attachment rewinds](https://ably.com/docs/channels/options/rewind.md)
- being sent to clients [resuming over a period of disconnection](https://ably.com/docs/connect/states.md)
- being sent to [firehose, webhooks, and queue integrations](https://ably.com/docs/platform/integrations.md)

In other words, it will be exempt from everything except being delivered to currently-connected realtime connections.

Ephemeral messages are useful for events that are relevant only at the time they are published and have no value when stale; examples include streaming of continuously changing values such as realtime telemetry and position information. Since ephemeral messages can be interspersed with other non-ephemeral messages on a channel, you can use a single channel to convey all relevant events for an entity, including a mix that need to be persisted and others that are only ephemeral.

To mark a message as ephemeral, either include `ephemeral: true` in the message's extras object, or (for REST publishes) include `ephemeral: true` in the publish params.

The following is an example of publishing an ephemeral message:

<Code>

#### Realtime Javascript

```
const channel = realtime.channels.get('chatroom');
await channel.publish({name: 'emote', data: ':heart:', extras: { ephemeral: true }});
```

#### Rest Javascript

```
const channel = rest.channels.get('chatroom');
await channel.publish('emote', ':heart:', { ephemeral: true });
// or
await channel.publish({ name: 'emote', data: ':heart:' }, { ephemeral: true });
```
</Code>

Note that if using the form of publish that takes an array of messages to be published atomically, either all the messages must be marked ephemeral or none of them. If they are mixed, the publish will be rejected.

### Idempotent publishing 

Idempotency ensures that multiple publishes of the same message cannot result in duplicate messages.

When idempotent publishing is enabled, the Ably SDK will internally assign a unique ID to each message which ensures that subsequent retry attempts cannot result in duplicate messages. Idempotent publishing is enabled by default in all latest Ably SDKs. It can be disabled by setting the `idempotentRestPublishing` [`ClientOptions`](https://ably.com/docs/api/rest-sdk.md#client-options) to `false`.

#### When to use idempotent publishing 

Idempotent publishing is enabled by default in current Ably SDKs. It is especially important in these scenarios:

- Duplicate notifications degrade user trust. In notification systems, idempotent publishing ensures a notification is delivered exactly once even if the publisher retries after a network error.
- Duplicate bid confirmations, payment events, or trade notifications can cause incorrect state in financial transactions. The 2-minute deduplication window covers typical retry scenarios.
- Duplicate operations in a collaborative document can cause data corruption or conflicting states in collaborative editing.
- Duplicate commands to physical devices in IoT systems, such as "open valve" or "toggle switch", can have real-world consequences.

You may wish to set the unique message ID yourself to achieve idempotency in some cases, such as:

* To ensure idempotency when a publisher instance might be restarted, and continuous activity cannot be guaranteed.
* To integrate with an upstream system that uses message IDs, to ensure idempotency across an entire message processing pipeline.

When setting your own message IDs, note the restrictions on format when publishing messages atomically.

#### Client-specified message ID restrictions for multiple messages published atomically 

When publishing multiple messages in a single publish request (via REST or realtime), those messages are published atomically by Ably. They are bundled together, and will either all succeed or all fail.

##### Idempotency with atomic publishes

From the point of view of idempotency, there is only a single idempotency 'key' for the entire array of messages. Ably prevents you from including a different, unrelated `id` in each message to avoid the mistaken impression that the messages will be individually idempotent.

For example, if Ably permitted `publish([{ id: 'foo', data: 'first' },{ id: 'bar', data: 'second' }])`, it might seem like you could later call `publish([{ id: 'bar', data: 'second' }])` and the second publish would be ineffective due to idempotency; but that is not the case.

##### ID format requirements

For messages published atomically, all messages must have an `id` derived from a single base ID. Each message must contain an `id` of the form `<base id>:<idx>` where `idx` is a zero-based index into the array of messages.

For example, to publish 3 messages with a base ID of `foo`, the messages must have IDs `foo:0`, `foo:1`, `foo:2`. This emphasizes that the messages share a single 'idempotency key' (which will be `foo`).

##### Publishing messages with separate idempotency

If you want messages to be separately and individually idempotent, you should publish them non-atomically:

* Issue multiple `publish()` calls serially instead of a single `publish()` call with an array of messages.

* If publishing over REST and you want all publishes to happen with a single HTTP request, use the batch publishing API. Each message is contained in its own `batchspec` object. All messages in a single `batchspec` are published atomically (for each channel in that `batchspec`), so by specifying multiple `batchspecs`, you can publish messages non-atomically, allowing you to specify a different idempotency ID for each message.


<Aside data-type="note">
Ably can only detect duplicate messages within a 2-minute window after the original message, with the same ID, is published. If a message with the same ID is published after this 2-minute window, it will be treated as a new message.
</Aside>

The following is an example of specifying message IDs yourself when publishing:

<Code>

###### Realtime Javascript

```
const realtime = new Ably.Realtime('your-api-key');
const channel = realtime.channels.get('your-channel-name');
const message = [{ data: 'payload', id: 'unique123' }];
```

###### Realtime Nodejs

```
const realtime = new Ably.Realtime('your-api-key');
const channel = realtime.channels.get('your-channel-name');
const message = [{ data: 'payload', id: 'unique123' }];
```

###### Realtime Ruby

```
realtime = Ably::Realtime.new(key: 'your-api-key')
channel = realtime.channels.get('your-channel-name')
channel.publish(name: 'example', data: 'payload', id: 'unique123')
```

###### Realtime Python

```
realtime = AblyRealtime('your-api-key')
channel = realtime.channels.get('your-channel-name')
await channel.publish([{data: 'payload', id: 'unique123'}])
```

###### Realtime Java

```
ClientOptions options = new ClientOptions('your-api-key');
AblyRealtime ably = new AblyRealtime(options);
Channel channel = ably.channels.get('your-channel-name');

Message message = new Message();
message.data = "payload";
message.id = "unique123";
```

###### Realtime Csharp

```
AblyRealtime realtime = new AblyRealtime("your-api-key");
IRealtimeChannel channel = realtime.Channels.Get("your-channel-name");
var message = new Message { Name = "example", Data = "payload", Id = "unique123" };
channel.Publish(message);
```

###### Realtime Swift

```
let realtime = ARTRealtime(key: "your-api-key")
let channel = realtime.channels.get("your-channel-name")
channel.publish("example", data: "message data", id: "unique123")
```

###### Realtime Objc

```
ARTRealtime *realtime = [[ARTRealtime alloc] initWithKey:("your-api-key"));
ARTRealtimeChannel *channel = [realtime.channels get:("your-channel-name");
[channel.publish("example", data: "message data", id: "unique123")];
```

###### Realtime Flutter

```
final clientOptions = ably.ClientOptions(key: 'your-api-key');
final realtime = ably.Realtime(options: clientOptions);
final channel = realtime.channels.get('your-channel-name');
await message = ably.Message(data: 'payload', id: 'unique123');
```

###### Realtime Go

```
realtime, err := ably.NewRealtime(
  ably.WithKey("your-api-key"))
if err != nil {
  log.Fatalf("Error creating Ably client: %v", err)
}

channel := realtime.Channels.Get("your-channel-name")

message := &ably.Message{
  Data: "payload",
  ID:   "unique123",
}
```

###### Rest Javascript

```
  const rest = new Ably.Rest('your-api-key');
  const channel = rest.channels.get('your-channel-name');
  const message = [{ data: 'payload', id: 'unique123' }];
```

###### Rest Nodejs

```
  const rest = new Ably.Rest('your-api-key');
  const channel = rest.channels.get('your-channel-name');
  const message = [{ data: 'payload', id: 'unique123' }];
```

###### Rest Ruby

```
rest = Ably::Rest.new(key: 'your-api-key')
channel = rest.channels.get('your-channel-name')
channel.publish(name: 'example', data: 'payload', id: 'unique123')
```

###### Rest Python

```
rest = AblyRest('your-api-key')
channel = rest.channels.get('your-channel-name')
await channel.publish([{data: 'payload', id: 'unique123'}])
```

###### Rest Php

```
$rest = new Ably\AblyRest('your-api-key');
$channel = $rest->channels->get('your-channel-name')
$channel->publish([{data: 'payload', id: 'unique123'}]);
```

###### Rest Java

```
ClientOptions options = new ClientOptions('your-api-key');
AblyRest ably = new AblyRest(options);
Channel channel = ably.channels.get('your-channel-name');

Message message = new Message();
message.data = "payload";
message.id = "unique123";
```

###### Rest Csharp

```
AblyRest rest = new AblyRest("your-api-key");
IRestChannel channel = rest.Channels.Get("your-channel-name");
var message = new Message { Name = "example", Data = "payload", Id = "unique123" };
await channel.PublishAsync(message);
```

###### Rest Swift

```
let rest = ARTRest(key: "your-api-key")
var channel = rest.channels.get("your-channel-name")
channel.publish("example", data: "message data", id: "unique123")
```

###### Rest Objc

```
ARTRest *rest = [[ARTRest alloc] initWithKey:("your-api-key"));
ARTRestChannel *channel = [rest.channels get:("your-channel-name");
[channel.publish("example", data: "message data", id: "unique123")];
```

###### Rest Flutter

```
final clientOptions = ably.ClientOptions(key: 'your-api-key');
final rest = ably.Rest(options: clientOptions);
final channel = rest.channels.get('your-channel-name');
await message = ably.Message(data: 'payload', id: 'unique123');
```

###### Rest Go

```
rest, err := ably.NewREST(
  ably.WithKey("your-api-key"))
if err != nil {
  log.Fatalf("Error creating Ably client: %v", err)
}

channel := rest.Channels.Get("your-channel-name")

message := &ably.Message{
  Data: "payload",
  ID:   "unique123",
}
```
</Code>

#### Avoid common mistakes with custom message IDs 

When providing custom message IDs for cross-restart deduplication, the ID **must be deterministic across retries**. If a retry generates a different ID, deduplication fails.

<Aside data-type='important'>
Do not use non-deterministic values like `Date.now()`, `Math.random()`, or `crypto.randomUUID()` as message IDs if you intend to retry. These generate a different ID on each attempt, defeating deduplication entirely.
</Aside>

Instead, derive the ID from the message content or generate it once before the first publish attempt:

<Code>

##### Javascript

```
// Good: Generate ID once, reuse on retry
const messageId = crypto.randomUUID();
await channel.publish({ id: messageId, data: payload });

// Good: Derive from content (deterministic)
const messageId = `order-${orderId}-confirmed`;
await channel.publish({ id: messageId, data: payload });

// Bad: Non-deterministic -- different ID on each retry
await channel.publish({ id: Date.now().toString(), data: payload });
```
</Code>

<Aside data-type='important'>
When publishing an array of messages in a single `publish()` call, each message ID must follow the format `baseId:index`, where index is the zero-based position in the array. All messages in the batch share the same base ID. For example: `myBatchId:0`, `myBatchId:1`, `myBatchId:2`. Ably deduplicates the entire batch atomically using the base ID.
</Aside>

### Publishing on behalf of a realtime connection 

You can use the REST interface of an Ably SDK to publish messages on behalf of a realtime [connection](https://ably.com/docs/connect.md).

To publish on behalf of a realtime connection, the REST publisher requires the [`connectionKey`](https://ably.com/docs/api/realtime-sdk/connection.md#key) of the realtime client. The `connectionKey` is a secret of the client unless explicitly shared. The REST publisher can then set the `connectionKey` [in the root of the published message](https://ably.com/docs/api/rest-sdk/messages.md#connection-key).

If the realtime connection is [identified](https://ably.com/docs/auth/identified-clients.md) by being bound to a `clientId`, then the REST publish must include that same `clientId`. This can be included in [the message itself](https://ably.com/docs/api/rest-sdk/messages.md#client-id) to apply to only that message, in the case that the REST client is able to assume any `clientId`, or using a REST client bound to that specific `clientId`.

The publish attempt will fail in the following scenarios:

* the `connectionKey` is invalid
* the REST publisher is using a different Ably application to the realtime client
* the `clientId`s don't match between the realtime connection and the REST publish

## Related Topics

- [Basic pub-sub](https://ably.com/docs/pub-sub.md): Get a channel, subscribe clients to it, and publish messages to the channel.
- [React Hooks](https://ably.com/docs/getting-started/react-hooks.md): The React submodule enables you to use React Hooks to connect to Ably.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
