# Connections overview

Clients establish and maintain a connection to the Ably service using the most efficient transport available, typically [WebSockets](https://ably.com/topic/websockets).

## Connection multiplexing 

Ably SDKs operate and multiplex all [channel](https://ably.com/docs/channels.md) traffic over a single connection. This means you can publish and subscribe to messages on any number of channels simultaneously using just one transport connection. This approach:

* Maximizes throughput by efficiently utilizing the available connection.
* Minimizes bandwidth consumption by avoiding multiple connection overhead.
* Reduces power usage by maintaining fewer active connections.

All Ably client libraries support multiplexing by default when using the realtime interface. You can dynamically subscribe and unsubscribe from channels at any time without needing to establish new connections.

Once connected, clients can monitor and manage their [connection state](https://ably.com/docs/connect/states.md).

<Aside data-type="note">
Connections can only be established using the realtime interface of an Ably SDK. See [About Pub/Sub](https://ably.com/docs/basics.md) for further information on the differences between the REST and realtime interface.
</Aside>

## Create a connection 

Ably SDKs open and maintain a connection to the Ably realtime servers on instantiation, which can be interacted with by using the `Connection` object. The lifecycle of connections are reported by different [connection states](https://ably.com/docs/connect/states.md#connection-states) to simplify monitoring and managing connections.

This example relies on the default auto-connect behavior of the SDK, checking for when the connection state is `connected` event:

<Code>

### Realtime Javascript

```
// Using callbacks
const ably = new Ably.Realtime({ 'your-api-key' });
ably.connection.on('connected', () => {
  console.log('Connected to Ably!');
});

// Using promises
const Ably = require('ably');
const ably = new Ably.Realtime('your-api-key');
await ably.connection.once('connected');
console.log('Connected to Ably!');
```

### Realtime Nodejs

```
// Using callbacks
const Ably = require('ably');
const ably = new Ably.Realtime({ 'your-api-key' });
ably.connection.on('connected', () => {
  console.log('Connected to Ably!');
});

// Using promises
const Ably = require('ably');
const ably = new Ably.Realtime('your-api-key');
await ably.connection.once('connected');
console.log('Connected to Ably!');
```

### Realtime Ruby

```
ably = Ably::Realtime.new('your-api-key')
ably.connection.on(:connected) do
  puts "Connected to Ably!"
end
```

### Realtime Python

```
ably = AblyRealtime('your-api-key')
await ably.connection.once_async('connected')
print('Connected to Ably')
```

### Realtime Java

```
AblyRealtime ably = new AblyRealtime("your-api-key");
ably.connection.on(ConnectionEvent.connected, new ConnectionStateListener() {
  @Override
  public void onConnectionStateChanged(ConnectionStateChange change) {
    System.out.println("Connected to Ably!");
  }
});
```

### Realtime Csharp

```
AblyRealtime ably = new AblyRealtime("your-api-key");
ably.Connection.On(ConnectionEvent.Connected, args => {
  Console.WriteLine("Connected to Ably!");
});
```

### Realtime Objc

```
ARTRealtime *ably = [[ARTRealtime alloc] initWithKey:@"your-api-key"];
[ably.connection on:ARTRealtimeConnectionEventConnected callback:^(ARTConnectionStateChange *change) {
    NSLog(@"Connected to Ably!");
}];
```

### Realtime Swift

```
let realtime = ARTRealtime(key: "your-api-key")
realtime.connection.on(.connected) { change in
    print("Connected to Ably!")
}
```

### Realtime Flutter

```
final realtime = ably.Realtime(key: 'your-api-key');
realtime.connection
  .on(ably.ConnectionEvent.connected)
  .listen((ably.ConnectionStateChange stateChange) {
    print('Connected to Ably!');
  }
);
```

### Realtime Go

```
	realtime, err := ably.NewRealtime(ably.WithKey("your-api-key"))
	if err != nil {
		log.Fatalf("Error creating Ably client: %v", err)
	}

	// Subscribe to the 'connected' event
	realtime.Connection.On(ably.ConnectionEventConnected, func(stateChange ably.ConnectionStateChange) {
		log.Println("Connected to Ably!")
	})
```
</Code>

If you're not using the SDK's auto-connect feature you can also connect with [`connect()`](https://ably.com/docs/api/realtime-sdk/connection.md#connect) to manually connect unless the state is already `connected` or `connecting`.

Explicitly calling connect is unnecessary unless the ClientOptions attribute autoConnect is false. Unless already connected or connecting, this method causes the connection to open, entering the connecting state. To manually attempt to open a connection you call the [`connect()`](https://ably.com/docs/api/realtime-sdk/connection.md#connect) function: `ably.connect()`.

## Monitor connections to an app 

Connection monitoring allows you to view and manage the [states of connections](https://ably.com/docs/connect/states.md) to Ably, showing events for individual people connecting and disconnecting. The developer console in your Ably account also shows these events.

This feature is intended for debugging, so once the number of new connections exceeds the number of messages per second permitted by the lifecycle channel, new events will be dropped. This means if you want a definitive list of everyone using your app you'd be best using [token authentication](https://ably.com/docs/auth/token.md) to create your own 'auth server'.

The Ably dashboard contains a developer console. In the developer console you can view connection events.

<Aside data-type="note">
It isn't possible to share a connection between browser tabs. This is because browser security models ensure that each tab is effectively sandboxed from the others. If a user has three tabs open, each with a connection to Ably, then this will count as three separate connections.
</Aside>

### Connection IDs 

A connection ID is a unique identifier given to a connection, allowing for identifying and specifying particular connections.

An active connection ID is guaranteed to be unique in the Ably system whilst it is active, i.e. no other connection will share that connection ID. However, Ably reserves the right to generate a new connection ID later that may be the same as a previously discarded connection ID (once the connection is closed). Therefore customers are advised to not use the connection ID as a perpetual unique identifier as it is possible that a connection ID may be used many times.

### Connection metachannels 

[Metachannels](https://ably.com/docs/metadata-stats/metadata/subscribe.md) are a namespace of channels beginning with the [meta] qualifier, distinguishing them from regular channels. For connections there is a specific `[meta]connection.lifecycle` channel that publishes messages about the lifecycle of realtime connections. The connection lifecycle consists of a number of [connection states](https://ably.com/docs/connect/states.md#available-connection-states) that can be observed and interacted with using methods available on the connection object.

## Heartbeats 

Heartbeats enable Ably to identify clients that abruptly disconnect from the service, such as where an internet connection drops out or a client changes networks.

Ably sends a heartbeat to connected clients every 15 seconds. If a client goes more than 25 seconds without seeing any server activity from Ably, it assumes that something has gone wrong with the connection and the [connection state](https://ably.com/docs/connect/states.md) will become `disconnected`. The 25 seconds the client waits is the heartbeat interval plus a 10 second margin of error to allow for network delays.

Ably also uses this mechanism to detect dropped client connections, though some details vary depending on the transport used.

It is important to note that this mechanism is only used when something disrupts communication and does not properly terminate the TCP connection. It isn't used when a connection is deliberately closed or disconnected, for example by calling the [`close()` method](https://ably.com/docs/api/realtime-sdk/connection.md#close) or being disconnected by the server.

The 15 second interval between heartbeats is used to strike a balance between optimizing battery usage for client devices and the time it takes to identify a dropped or unstable connection.

The interval between heartbeats can be customized if your app requires increased battery preservation or to identify dropped connections more quickly. Set a value between 5000 and 1800000 milliseconds (5 seconds and 30 minutes) using the `heartbeatInterval` parameter within the `transportParams` property of the [`clientOptions`](https://ably.com/docs/api/realtime-sdk.md#client-options) object.

Using a higher `heartbeatInterval` can increase the time taken for the Ably service and the client itself to identify a connection has dropped when an abrupt disconnect occurs. The number of [concurrent connections](https://ably.com/docs/platform/pricing/limits.md#connection) may also appear higher as it can take longer to terminate dropped connections. Although `heartbeatInterval` can be set as high as 30 minutes, Ably does not recommend setting it this high.

You can also call [`ping()`](https://ably.com/docs/api/realtime-sdk/connection.md#ping) to send a heartbeat ping to Ably, which can be useful for measuring the true round-trip latency to the Ably server.

The following example code demonstrates establishing a connection to Ably with a `heartbeatInterval` of 10 seconds:

<Code>

### Realtime Javascript

```
const ably = new Ably.Realtime(
  {
    key: 'your-api-key',
    transportParams: { heartbeatInterval: 10000 }
  }
);
```

### Realtime Nodejs

```
const ably = new Ably.Realtime(
  {
    key: 'your-api-key',
    transportParams: { heartbeatInterval: 10000 }
  }
);
```

### Realtime Go

```
ably, err := ably.NewRealtime(
  ably.WithKey("your-api-key"),
  ably.WithTransportParams(url.Values{
    "heartbeatInterval": {"10000"},
  }),
)
```

### Realtime Java

```
ClientOptions options = new ClientOptions("your-api-key");
options.transportParams = new Param[]{
        new Param("heartbeatInterval", "10000")
};
AblyRealtime ably = new AblyRealtime(options);
```
</Code>

<If lang="javascript,nodejs">
## Browser page unload behavior 
In browser environments, ably-js automatically handles page unload events to ensure connections are properly closed when users navigate away or close pages.
### Default `beforeunload` behavior
By default, the Ably Pub/Sub JavaScript SDK adds a listener for the `beforeunload` event to cleanly close connections before a page is closed. This provides orderly behavior where:
* Connections are seen as having closed immediately by Ably servers.
* Presence members associated with the connection are seen by all users as having left immediately.

If a connection to Ably is not explicitly closed when there is a page unload event, then the connection state is preserved by Ably for 2 minutes. Preserving connection state for 2 minutes when there is an unexpectedly dropped connection provides the opportunity for the client to reconnect and resume the connection without losing any messages.

<Aside data-type='usp'>
Transparent edge network failover.

Ably's SDKs automatically resolve [edge network failures](https://ably.com/docs/platform/architecture/edge-network.md) within 30 seconds, keeping your users connected even during datacenter outages.
</Aside>

### Reliability considerations
The `beforeunload` event can be unreliable and is not guaranteed to fire under certain circumstances:
* The event may fire but the page is subsequently not disposed of (navigation can be cancelled).
* The handler in ably-js that closes a connection on a `beforeunload` event is hazardous unless the application developer is certain that there is no case where `beforeunload` fires, but the page is subsequently not unloaded.
* Recent releases of Chrome (version 108+) have introduced a Memory Saver feature that can cause pages to be discarded without firing `beforeunload` events.

### Chrome Memory Saver impact
Chrome's Memory Saver feature assists with controlling the browser's memory footprint by discarding inactive tabs. This significantly increases the frequency of pages being discarded, which:
* Causes JavaScript execution to stop without opportunity to intercept the event.
* Prevents connections from closing immediately since `beforeunload` doesn't fire.
* Results in longer delays before Ably recognizes the connection has closed.
* Affects presence members leaving immediately.

### Managing connection lifecycle
To ensure predictable connection closure behavior, consider these options:

Set `closeOnUnload:false` in [`ClientOptions`](https://ably.com/docs/api/realtime-sdk.md#client-options) when initializing the library:
<Code>

#### Realtime Javascript

```
const ably = new Ably.Realtime({
  key: 'your-api-key',
  closeOnUnload: false
});
```
#### Realtime Nodejs

```
const ably = new Ably.Realtime({
  key: 'your-api-key',
  closeOnUnload: false
});
```
</Code>
Manage connection lifecycle explicitly by calling [`close()`](https://ably.com/docs/api/realtime-sdk/connection.md#close) on the Ably realtime instance when it's no longer needed:
<Code>

#### Realtime Javascript

```
// When your application determines the connection should close
ably.close();
```
#### Realtime Nodejs

```
// When your application determines the connection should close
ably.close();
```
</Code>
Disable Chrome Memory Saver globally or on a site-by-site basis in browser settings if the feature is impacting your application's behavior.
</If>

## Close a connection 

A connection to Ably should be closed once it is no longer needed. Note that there is a 2 minute delay before a connection is closed, if the [`close()`](https://ably.com/docs/api/realtime-sdk/connection.md#close) method hasn't been explicitly called. This is important to consider in relation to the number of [concurrent connections](https://ably.com/docs/platform/pricing/limits.md#connection) to your account.

The following code sample explicitly closes the connection to Ably by calling the `close()` method and prints the message `Closed the connection to Ably`:

<Code>

### Realtime Javascript

```
ably.close(); // runs synchronously
console.log('Closed the connection to Ably.');
```

### Realtime Nodejs

```
ably.close(); // runs synchronously
console.log('Closed the connection to Ably.');
```

### Realtime Java

```
ably.connection.close();
ably.connection.on(ConnectionEvent.closed, new ConnectionStateListener() {
  @Override
  public void onConnectionStateChanged(ConnectionStateChange state) {
    System.out.println("New state is " + state.current.name());
    switch (state.current) {
      case closed: {
        // Connection closed
        System.out.println("Closed the connection to Ably.");
        break;
      }
      case failed: {
        // Failed to close connection
        break;
      }
    }
  }
});
```

### Realtime Python

```
await ably.close()
print('Closed the connection to Ably.')
```

### Realtime Ruby

```
ably.connection.close
ably.connection.on(:closed) do
  puts "Closed the connection to Ably!"
end
```

### Realtime Swift

```
ably.connection.close()
ably.connection.on { stateChange in
    let stateChange = stateChange
    switch stateChange.current {
    case .closed:
        print("Closed the connection to Ably.")
    case .failed:
        print("Failed to close connection to Ably.")
    default:
        break
    }
}
```

### Realtime Csharp

```
ably.Connection.Close();
ably.Connection.On(ConnectionEvent.Closed, args =>
{
  Console.Out.WriteLine("Closed the connection to Ably.");
});
```

### Realtime Objc

```
[ably.connection close];
[ably.connection on:ARTRealtimeConnectionEventClosed callback:^(ARTConnectionStateChange *stateChange) {
    NSLog(@"Closed the connection to Ably.");
}];
```

### Realtime Flutter

```
realtime.connection.close();
realtime.connection
    .on(ably.ConnectionEvent.closed)
    .listen((ably.ConnectionStateChange stateChange) async {
  print('New state is: ${stateChange.current}');
  switch (stateChange.current) {
    case ably.ConnectionState.closed:
    // Connection closed
      print('Closed the connection to Ably.');
      break;
    case ably.ConnectionState.failed:
    // Failed to close connection
      break;
    default:
      break;
  }
});
```

### Realtime Go

```
client.Connection.On(ably.ConnectionEventClosed, func(change ably.ConnectionStateChange) {
    fmt.Println("Closed the connection to Ably.")
})
client.Close()
```
</Code>

<Aside data-type="important">
It is important to understand the difference between unsubscribing from a [channel](https://ably.com/docs/channels.md) and closing a connection, compared to calling the `off()` method for a channel or connection.

The [`unsubscribe()`](https://ably.com/docs/api/realtime-sdk/channels.md#unsubscribe) method removes message listeners for a channel.

The [`close()`](https://ably.com/docs/api/realtime-sdk/connection.md#close) method closes a realtime connection.

The `off()` method for a [channel](https://ably.com/docs/api/realtime-sdk/channels.md#off) or [connection](https://ably.com/docs/api/realtime-sdk/connection.md#off) removes [`ChannelEvent`](https://ably.com/docs/channels.md#listen-for-state) or [`ConnectionEvent`](https://ably.com/docs/connect/states.md#listen) listeners that are listening for state changes on a channel or for a connection.
</Aside>

## Related Topics

- [Connection state and recovery](https://ably.com/docs/connect/states.md): Establish and maintain a persistent connection to Ably using the Realtime SDK.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
