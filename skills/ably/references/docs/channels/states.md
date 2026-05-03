# Channel states

Channels transition through multiple states throughout their lifecycle. Understanding under which conditions the state of a channel changes, and managing those changes, is important to ensure that your applications behave as expected.

## States 

A channel can exist in any of the following states:

| State | Description |
|-------|-------------|
| Initialized | The channel has been initialized, but no attach has been attempted yet. |
| Attaching | An attach has been initiated by sending a request to Ably. This is a transient state and will be followed either by a transition to attached, suspended, or failed. |
| Attached | An attach has succeeded. In the attached state a client can publish and subscribe to messages, and enter the presence set. |
| Detaching | A detach has been initiated on the attached channel by sending a request to Ably. This is a transient state and will be followed either by a transition to detached or failed. |
| Detached | The channel, having previously been attached, has been detached by the client. |
| Suspended | The channel having previously been attached, has lost continuity. This is normally due to the client being disconnected from Ably for more than two minutes. The client will automatically attempt to reattach as soon as connectivity is restored. |
| Failed | An indefinite failure condition. This state is entered if a channel error has been received from the Ably service, such as an attempt to attach without the necessary access rights. |

## Attach to a channel 

Attaching to a channel ensures that it is created in the Ably system and that all messages published on the channel are received by any channel listeners registered when [subscribing](https://ably.com/docs/pub-sub.md#subscribe). Channels are not pre-configured or provisioned by Ably in advance. They are created on demand when clients attach, and remain active until such time that there are no remaining attached clients.

A channel will automatically close when all of the following criteria are met:

* There are no more realtime clients attached to it
* Approximately one minute has passed since the last client detached
* Approximately one minute has passed since the last message was published to the channel

Although [`attach()`](https://ably.com/docs/api/realtime-sdk/channels.md#attach) can be called explicitly, it is more common for a client to [subscribe](https://ably.com/docs/pub-sub.md#subscribe) directly to a channel, which will automatically initiate the attach. This is also known as an implicit attachment.

The following example explicitly attaches to a channel, which results in the channel being provisioned in Ably's global realtime cluster. This channel will remain available globally until there are no more clients attached to the channel:

<Code>

### Realtime Javascript

```
const channel = realtime.channels.get('chatroom');
await channel.attach();
```

### Realtime Nodejs

```
const channel = realtime.channels.get('chatroom');
await channel.attach();
```

### Realtime Ruby

```
realtime.channels.get('chatroom').attach do |channel|
  puts "'chatroom' exists and is now available globally in every datacenter"
end
```

### Realtime Python

```
channel = realtime.channels.get('chatroom')
await channel.attach()
print("'chatroom' exists and is now available globally in every datacenter")
```

### Realtime Java

```
Channel channel = realtime.channels.get("chatroom");
channel.on(new ChannelStateListener() {
  @Override
  public void onChannelStateChanged(ChannelStateChange state) {
    switch (state.current) {
      case attached: {
        System.out.println("'chatroom' exists and is now available globally");
      }
    }
  }
});
```

### Realtime Csharp

```
IRealtimeChannel channel = realtime.Channels.Get("chatroom");
channel.Attach((success, error) => {
  Console.WriteLine("'chatroom' exists and is now available globally");
});
```

### Realtime Objc

```
[[realtime.channels get:@"chatroom" options:options] attach:^(ARTErrorInfo *error) {
  NSLog(@"'chatroom' exists and is now available globally in every datacenter");
}];
```

### Realtime Swift

```
realtime.channels.get("chatroom").attach { error in
  print("'chatroom' exists and is now available globally in every datacenter")
}
```

### Realtime Flutter

```
final channel = realtime.channels.get('your-channel-name');
final channelMessageSubscription = channel
    .on()
    .listen((ably.ChannelStateChange state) {
  switch (state.current) {
    case ably.ChannelState.attached: {
      print("'chatroom' exists and is now available globally");
      break;
    }
    default:
      break;
  }
});
```

### Realtime Go

```
channel := realtime.Channels.Get("channelName")
channel.Attach(context.Background())
```
</Code>

<Aside data-type="further-reading">
It is important to be aware of the difference between [attaching and subscribing](https://ably.com/docs/pub-sub/advanced.md#attach-subscribe) to a channel.
</Aside>

### Attach errors 

Normally, errors in attaching to a channel are communicated through the [`attach()`](https://ably.com/docs/api/realtime-sdk/channels.md#attach) callback. For implicit attaches, where a client only calls `subscribe()`, there is no callback.In these instances, listen for [channel state changes](#listen) to monitor errors.

This is also true in other cases where a channel is attached or re-attached automatically, for example, following the library reconnecting to Ably after a period of time in the `suspended` state.

### Detach from a channel 

A client can detach from a channel so that it no longer receives any messages published to it. Detaching is different to unsubscribing from a channel because [`unsubscribe()`](https://ably.com/docs/api/realtime-sdk/channels.md#unsubscribe) is a client-side operation. The Ably platform does not know that a client has unsubscribed and will continue to stream messages to that client until [`detach()`](https://ably.com/docs/api/realtime-sdk/channels.md#detach) is called.

The following is an example of detaching from a channel:

<Code>

#### Realtime Javascript

```
const channel = realtime.channels.get('chatroom');
await channel.detach();
```

#### Realtime Nodejs

```
const channel = realtime.channels.get('chatroom');
await channel.detach();
```

#### Realtime Ruby

```
channel.detach
channel.on(:detached) do |channel_state_change|
  puts "detached from the channel #{channel.name}"
end
```

#### Realtime Python

```
await channel.detach()
```

#### Realtime Java

```
channel.on(ChannelEvent.detached, new ChannelStateListener() {
    @Override
    public void onChannelStateChanged(ChannelStateChange stateChange) {
        System.out.println("Detached from the channel " + channel.name);
        if (stateChange.reason != null) {
            System.out.println(stateChange.reason.toString());
        }
    }
});

channel.detach();
```

#### Realtime Csharp

```
channel.Detach();
channel.On(ChannelEvent.Detached, stateChange => {
  Console.WriteLine("detached from the channel " + channel.Name);
});
```

#### Realtime Objc

```
[channel detach]
[channel on:ARTChannelEventDetached callback:^(ARTChannelStateChange *stateChange) {
  NSLog(@"detached from the channel ", channel.name);
}];
```

#### Realtime Swift

```
channel.detach()
channel.on(.detached) { stateChange in
  print("detached from the channel \(channel.name)")
}
```

#### Realtime Flutter

```
channel.detach();
final stateChangeListener = channel
    .on(ably.ChannelEvent.detached)
    .listen((ably.ChannelStateChange state) {
  print('detached from the channel ${channel.name}');
});
```

#### Realtime Go

```
channel := realtime.Channels.Get("channelName")
channel.Detach(context.Background())
```
</Code>

<Aside data-type="further-reading">
It is important to be aware of the difference between [detaching and unsubscribing](https://ably.com/docs/pub-sub/advanced.md#detach-unsubscribe) to a channel.
</Aside>

## Listen for state changes 

The `Channel` object is an `EventEmitter`. Events are emitted with a `name` that corresponds to the new channel state, whenever there is a change in the state of a channel.

Register a listener to monitor the current channel state. This can be a listener for the first occurrence, using [`once()`](https://ably.com/docs/api/realtime-sdk/channels.md#once), or for every change using [`on()`](https://ably.com/docs/api/realtime-sdk/channels.md#on).

Use the [`on()`](https://ably.com/docs/api/realtime-sdk/channels.md#on) method to register a listener for a specific channel state:

<Code>

### Realtime Javascript

```
channel.on('attached', (stateChange) => {
  console.log('channel ' + channel.name + ' is now attached');
  console.log('Message continuity on this channel ' + \
    (stateChange.resumed ? 'was' : 'was not') + ' preserved');
});
```

### Realtime Nodejs

```
channel.on('attached', (stateChange) => {
  console.log('channel ' + channel.name + ' is now attached');
  console.log('Message continuity on this channel ' + \
    (stateChange.resumed ? 'was' : 'was not') + ' preserved');
});
```

### Realtime Ruby

```
channel.on(:attached) do |channel_state_change|
  puts "channel #{channel.name} is now attached"
  puts "Message continuity #{channel_state_change.resumed ? 'was' : 'was not'} preserved"
end
```

### Realtime Python

```
def listener(state_change):
  print(f'{channel.name} is now {state_change.current}')
channel.on('attached', listener)
```

### Realtime Java

```
channel.on(ChannelEvent.attached, new ChannelStateListener() {
  @Override
  public void onChannelStateChanged(ChannelStateChange stateChange) {
    System.out.println("channel " + channel.name + " is now attached");
    if (stateChange.resumed) {
      System.out.println("Message continuity was preserved");
    } else {
      System.out.println("Message continuity was not preserved");
    }
  }
});
```

### Realtime Csharp

```
IRealtimeChannel channel = realtime.Channels.Get("chatroom");
channel.On(ChannelEvent.Attached, stateChange => {
  Console.WriteLine("channel " + channel.Name + " is now attached");
  if (stateChange.Resumed) {
    Console.WriteLine("Message continuity was preserved");
  } else {
    Console.WriteLine("Message continuity was not preserved");
  }
});
```

### Realtime Objc

```
[channel on:ARTChannelEventAttached callback:^(ARTChannelStateChange *stateChange) {
  NSLog(@"channel %@ is now attached", channel.name);
  if (stateChange.resumed) {
    NSLog(@"Message continuity was preserved");
  } else {
    NSLog(@"Message continuity was not preserved");
  }
}];
```

### Realtime Swift

```
channel.on(.attached) { stateChange in
  print("channel \(channel.name) is now attached")
  if (stateChange.resumed) {
    print("Message continuity was preserved")
  } else {
    print("Message continuity was not preserved")
  }
}
```

### Realtime Flutter

```
final stateChangeListener = channel
    .on(ably.ChannelEvent.attached)
    .listen((ably.ChannelStateChange state) {
  print('channel ${channel.name} is now attached');
  if (state.resumed) {
    print('Message continuity was preserved');
  } else {
    print('Message continuity was not preserved');
  }
});
```

### Realtime Go

```
channel.On(ably.ChannelEventAttached, func(stateChange ably.ChannelStateChange) {
  fmt.Printf("channel '%v' is now attached\n", channel.Name)
  if stateChange.Resumed {
    fmt.Printf("Message continuity on this channel was preserved\n")
  } else {
    fmt.Printf("Message continuity on this channel was not preserved\n")
  }
})
```
</Code>

You can also use the [`on()`](https://ably.com/docs/api/realtime-sdk/channels.md#on) method to register a listener for all channel state changes:

<Code>

### Realtime Javascript

```
const myListener = (stateChange) => {
  console.log('channel state is ' + stateChange.current);
  console.log('previous state was ' + stateChange.previous);
  if (stateChange.reason) {
    console.log('the reason for the state change was: ' + stateChange.reason.toString());
  }
});
channel.on(myListener);
```

### Realtime Nodejs

```
const myListener = (stateChange) => {
  console.log('channel state is ' + stateChange.current);
  console.log('previous state was ' + stateChange.previous);
  if (stateChange.reason) {
    console.log('the reason for the state change was: ' + stateChange.reason.toString());
  }
});
channel.on(myListener);
```

### Realtime Ruby

```
channel.on do |channel_state_change|
  puts "channel state is #{channel_state_change.current}"
end
```

### Realtime Python

```
def listener(state_change):
  print(f'{channel.name} is now {state_change.current}')
channel.on(listener)
```

### Realtime Java

```
channel.on(new ChannelStateListener() {
    @Override
    public void onChannelStateChanged(ChannelStateChange stateChange) {
        ChannelState currentState = stateChange.current;
        ErrorInfo reason = stateChange.reason;

        System.out.println("Channel state is " + currentState);
        if (reason != null) {
            System.out.println("Reason: " + reason.message);
        }
    }
});
```

### Realtime Csharp

```
channel.On(stateChange => Console.WriteLine("channel state is " + stateChange.Current));
```

### Realtime Objc

```
ARTEventListener *listener = [channel on:^(ARTChannelStateChange *stateChange) {
    NSLog(@"channel state is %@", stateChange.current);
}];
```

### Realtime Swift

```
let listener = channel.on { stateChange in
    print("channel state is \(stateChange.current)")
}
```

### Realtime Flutter

```
final stateChangeListener = channel
    .on()
    .listen((ably.ChannelStateChange stateChange) {
  print('channel state is ${stateChange.current.name}');
});
```

### Realtime Go

```
channel.OnAll(func(stateChange ably.ChannelStateChange) {
  fmt.Printf("channel state is '%v'", stateChange.Current)
  fmt.Printf("previous state was '%v'", stateChange.Previous)

  if stateChange.Reason != nil {
    fmt.Printf("the reason for the state change was: '%v'", stateChange.Reason)
  }
})
```
</Code>

Listeners are passed a [`ChannelStateChange`](https://ably.com/docs/api/realtime-sdk/channels.md#channel-state-change) object in the first argument. This object has the following properties:

* `current` / `previous`: the present and last state of the channel.
* `resumed`: a flag indicating whether message continuity on the channel is preserved since the last time the channel was attached.
* `reason`: the reason for the state change, if available.

`this` within the listener function is a reference to an event object whose `event` property is the name of the event that fired. This allows a listener to listen for all events with a single registration and still know which type of event is fired.

<Aside data-type='note'>
Be aware that when registering listeners for channel state changes, certain repeating states may add new listeners each time.
</Aside>

Use the [`off()`](https://ably.com/docs/api/realtime-sdk/channels.md#off) method to remove listeners:

<Code>

### Realtime Javascript

```
  /* remove the listener registered for a single event */
  channel.off('attached', myListener);

  /* remove the listener registered for all events */
  channel.off(myListener);
```

### Realtime Nodejs

```
  /* remove the listener registered for a single event */
  channel.off('attached', myListener);

  /* remove the listener registered for all events */
  channel.off(myListener);
```

### Realtime Ruby

```
  # remove the listener proc registered for a single event
  channel.off(:attached, &my_proc)

  # remove the listener proc registered for all events
  channel.off(&my_proc)
```

### Realtime Python

```
  # remove a single listener
  channel.off(listener)

  # remove all listeners
  channel.off()
```

### Realtime Java

```
  /* remove the listener registered for a single event */
  channel.off(ChannelEvent.attached, channelStateListener);

  /* remove the listener registered for all events */
  channel.off(channelStateListener);
```

### Realtime Csharp

```
  // remove the listener registered for a single event
  channel.Off(ChannelEvent.Attached, channelStateListener);

  // remove the listener registered for all events
  channel.Off(channelStateListener);
```

### Realtime Objc

```
  // remove the listener registered for a single event
  [channel off:ARTChannelEventAttached listener:listener];

  // remove the listener registered for all events
  [channel off:listener];
```

### Realtime Swift

```
  // remove the listener registered for a single event
  channel.off(.attached, listener: listener)

  // remove the listener registered for all events
  channel.off(listener)
```

### Realtime Flutter

```
    // cancel stream subscription on the listener to stop receiving the events
    stateChangeListener.cancel();
```

### Realtime Go

```
channel.Off(ably.ChannelEventAttached)
channel.OffAll()
```
</Code>

### Update events 

The `Channel` object can also emit one event that is not a state change; an `update` event.

This happens when there's a change to channel conditions for which the channel state doesn't change. For example, a partial loss of message continuity on a channel, typically after a [resume](https://ably.com/docs/connect/states.md#resume), for which the channel state remains `attached`. This leads to an `update` event being emitted, with both `current` and `previous` set to "`attached`", and the `resumed` flag set to `false`.

If you receive such an event, you'll know there may be messages you've missed on the channel, and if necessary you can use [history](https://ably.com/docs/api/realtime-sdk/channels.md#history) to retrieve them.

## Channel state and connection state 

[Connection state](https://ably.com/docs/connect/states.md) also impacts the state of a channel in the following ways:

* If the connection state becomes `CLOSED`, all channels will become `DETACHED`
* If the connection state becomes `FAILED`, all channels will become `FAILED`
* If the connection state becomes `SUSPENDED`, all previously-`ATTACHED` or `ATTACHING` channels will become `SUSPENDED`
* If the connection state becomes `CONNECTED`, any channels that were `SUSPENDED` will be automatically reattached

## Handle channel failures 

Channel attach and detach operations are asynchronous. After initiating an attach request, the client will wait for a response from Ably that confirms that the channel is established on the service and then trigger a [state change](#states) event.

Ably SDKs will attempt to automatically recover from non-fatal error conditions. However, you can handle them yourself if you prefer by subscribing to channel state changes, or <span lang="default">using the callbacks available</span><span lang="java,javascript,nodejs">waiting for a result</span> when explicitly calling [`attach()`](https://ably.com/docs/api/realtime-sdk/channels.md#attach).

<Code>

### Realtime Javascript

```
const channel = realtime.channels.get('private:chatroom');

channel.on('failed', (stateChange) => {
  console.log('Channel failed, reason: ', stateChange.reason);
});

await channel.attach();
```

### Realtime Nodejs

```
const channel = realtime.channels.get('private:chatroom');

channel.on('failed', (stateChange) => {
  console.log('Channel failed, reason: ', stateChange.reason);
});

await channel.attach();
```

### Realtime Ruby

```
deferrable = realtime.channels.get('private:chatroom').attach
deferrable.errback do |error|
  puts "Attach failed: #{error}"
end
```

### Realtime Python

```
channel = realtime.channels.get('private:chatroom')

# Attach to the channel
try:
    await channel.attach()
    print("Attached to channel successfully")
except Exception as err:
    print("Attach failed:", err)
```

### Realtime Java

```
Channel channel = realtime.channels.get("private:chatroom");
channel.on(new ChannelStateListener() {
    @Override
    public void onChannelStateChanged(ChannelStateChange stateChange) {
        switch (stateChange.current) {
            case failed:
                ErrorInfo reason = stateChange.reason;
                System.out.println("Attach failed: " + (reason != null ? reason.message : "Unknown reason"));
                break;
        }
    }
});

channel.attach();
```

### Realtime Csharp

```
IRealtimeChannel privateChannel = realtime.Channels.Get("private:chatroom");
privateChannel.Attach((_, error) => {
    if (error != null)
    {
        Console.WriteLine("Attach failed: " + error.Message);
    }
});
```

### Realtime Objc

```
[[realtime.channels get:@"private:chatroom"] attach:^(ARTErrorInfo *error) {
    if (error) {
        NSLog(@"Attach failed: %@", error);
    }
}];
```

### Realtime Swift

```
realtime.channels.get("private:chatroom").attach { error in
    if let error = error {
        print("Attach failed: \(error)")
    }
}
```

### Realtime Flutter

```
final channel = realtime.channels.get('private:chatroom');
channel
    .on()
    .listen((ably.ChannelStateChange stateChange) {
  switch (stateChange.current) {
    case ably.ChannelState.failed:
      print('Attach failed: ${stateChange.reason?.message}');
      break;
  // Add other cases if needed
    default:
      break;
  }
});

channel.attach();
```

### Realtime Go

```
channel := realtime.Channels.Get("private:chatroom")
channel.On(ably.ChannelEventFailed, func(stateChange ably.ChannelStateChange) {
  fmt.Printf("Channel failed, reason: '%v'", stateChange.Reason)
})
channel.Attach(context.Background())
```
</Code>

### Fatal channel errors 

Some classes of errors are fatal. These cause the channel to move to the `FAILED` state. Ably SDKs will not attempt any automatic recovery actions. For example, when attempting to attach to a channel, with a token that doesn't have the `subscribe` [capability](https://ably.com/docs/auth/capabilities.md) for that channel, will cause that channel to enter the `FAILED` state.

Whilst fatal errors won't get better on their own, they are fixable. For example, if a channel goes into the `FAILED` state due to the client not having the right capabilities to attach to it, that client could call [`authorize()`](https://ably.com/docs/api/realtime-sdk/authentication.md#authorize) to obtain a new token which does have the right capabilities, then call [`attach()`](https://ably.com/docs/api/realtime-sdk/channels.md#attach) on the channel. The library will not automatically reattach in the `FAILED` state, however explicit calls to [`attach()`](https://ably.com/docs/api/realtime-sdk/channels.md#attach) will make the client try again.

### Non-fatal errors 

Some types of errors are non-fatal. For example, a client may have network connectivity issues, or a channel may experience a loss of strict message continuity. Ably SDKs will automatically attempt to recover from these events. If channel continuity is lost in the process, the library will notify you through a `resumed` flag in the `ATTACHED` or `UPDATE` event, so that you can decide how to handle the failure.

For every channel `ATTACHED` and `UPDATE` event, the [`ChannelStateChange`](https://ably.com/docs/api/realtime-sdk/types.md#channel-state-change) object contains a `resumed` attribute. When `true`, there has been no loss of continuity from the last time the channel was attached. When `false`, there has been a loss of continuity.

For example:

* The first time a client attaches to a channel on a fresh connection, `resumed` will be `false`, as there was nothing to continue from.
* If a client successfully [recovers](https://ably.com/docs/connect/states.md) a connection and reattaches to its channels, the `resumed` flag on the `ATTACHED` events will tell it whether message continuity was preserved, or not. Any channel for which it's `true`, is guaranteed to receive every message it missed while the client was disconnected.
* If a client "resumes or [recovers](https://ably.com/docs/connect/states.md) a connection unsuccessfully continuity is lost and the client receives a fresh connection. This generally happens because the client was disconnected for more than two minutes, which is how long Ably holds connection state for. If the client were resuming, all the channels (which will have gone into the `SUSPENDED` state after two minutes) will still reattach automatically, and the client will receive `ATTACHED` events with `resumed` set to `false`.
* If Ably needs to signal a loss of message continuity on an attached channel, the client will receive an `UPDATE` event with `resumed` set to `false`. This occurs in situations such as a partially successful resume, where the client was disconnected for less than two minutes.


## Related Topics

- [Channel concepts](https://ably.com/docs/channels.md): Channels are used to organize message traffic within Ably.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
