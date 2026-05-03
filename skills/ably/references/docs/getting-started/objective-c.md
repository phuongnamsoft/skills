# Getting started: Pub/Sub in Objective-C

<Aside data-type='important'>
Objective-C is not recommended for new projects. This guide is provided for maintaining existing apps. For new apps targeting Apple platforms, use the [Swift getting started guide](https://ably.com/docs/getting-started/swift.md).
</Aside>

This guide will get you started with Ably Pub/Sub in Objective-C.

You'll establish a realtime connection to Ably and learn to publish and subscribe to messages. You'll also implement presence to track other online clients, and learn how to retrieve message history.

<Aside data-type='note'>
Using an AI coding assistant? [Teach it Ably](https://ably.com/docs/platform/ai-llms.md#agent-skills) with Agent Skills for all popular AI coding agents. Run `claude plugin add ably/agent-skills` or `npx skills add ably/agent-skills` to get started.
</Aside>

## Prerequisites 

1. [Sign up](https://ably.com/sign-up) for an Ably account.
2. Create a [new app](https://ably.com/accounts/any/apps/new), and create your first API key in the **API Keys** tab of the dashboard.
3. Your API key will need the `publish`, `subscribe`, `presence` and `history` [capabilities](https://ably.com/docs/auth/capabilities.md).
4. Install Xcode and create a new Objective-C project.
5. Add the Ably [Pub/Sub Objective-C SDK](https://github.com/ably/ably-cocoa) as a dependency.

For CocoaPods, add the following to your `Podfile`:

<Code>

### Text

```
pod 'Ably'
```
</Code>

For Swift Package Manager, add the following URL:

<Code>

### Text

```
https://github.com/ably/ably-cocoa
```
</Code>

### (Optional) Install Ably CLI 

Use the [Ably CLI](https://github.com/ably/cli) as an additional client to quickly test Pub/Sub features. It can simulate other clients by publishing messages, subscribing to channels, and managing presence states.

1. Install the Ably CLI:

<Code>

#### Shell

```
npm install -g @ably/cli
```
</Code>

2. Run the following to log in to your Ably account and set the default app and API key:

<Code>

#### Shell

```
ably login
```
</Code>

<If loggedIn={false}>
  <Aside data-type='note'>
  The code examples in this guide include a demo API key. If you wish to interact with the Ably CLI and view outputs within your Ably account, ensure that you replace them with your own API key.
  </Aside>
</If>

## Step 1: Connect to Ably 

Clients establish a connection with Ably when they instantiate an SDK instance. This enables them to send and receive messages in realtime across channels.

Open up the [dev console](https://ably.com/accounts/any/apps/any/console) of your first app before instantiating your client so that you can see what happens.

Replace the contents of your `main.m` file with functionality to instantiate the SDK and establish a connection to Ably. At the minimum you need to provide an authentication mechanism. Use an API key for simplicity, but you should use [token authentication](https://ably.com/docs/auth/token.md) in production environments. A [`clientId`](https://ably.com/docs/auth/identified-clients.md) ensures the client is identified, which is required to use certain features, such as presence:

<Code>

### Objc

```
#import <Foundation/Foundation.h>
#import <Ably/Ably.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Initialize the Ably Realtime client
        ARTClientOptions *options = [[ARTClientOptions alloc] initWithKey:@"your-api-key"];
        options.clientId = @"my-first-client";
        ARTRealtime *realtime = [[ARTRealtime alloc] initWithOptions:options];

        // Wait for the connection to be established
        [realtime.connection on:ARTRealtimeConnectionEventConnected callback:^(ARTConnectionStateChange *stateChange) {
            NSLog(@"Made my first connection!");
        }];

        // Keep the program running
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}
```
</Code>

You can monitor the lifecycle of clients' connections by registering a listener that will emit an event every time the connection state changes. For now, run the program to log a message to the console to know that the connection attempt was successful. You'll see the message printed to your console, and you can also inspect the connection event in the dev console of your app.

## Step 2: Subscribe to a channel and publish a message 

Messages contain the data that a client is communicating, such as a short 'hello' from a colleague, or a financial update being broadcast to subscribers from a server. Ably uses channels to separate messages into different topics, so that clients only ever receive messages on the channels they are subscribed to.

Add the following lines to your `main` function, above the line `// Keep the program running`, to create a channel instance and register a listener to subscribe to the channel:

<Code>

### Objc

```
// Get a channel instance
ARTRealtimeChannel *channel = [realtime.channels get:@"my-first-channel"];

// Subscribe to messages on the channel
[channel subscribe:^(ARTMessage *message) {
    NSLog(@"Received message: %@", message.data);
}];
```
</Code>

Use the Ably CLI to publish a message to your first channel. The message will be received by the client you've subscribed to the channel, and be logged to the console.

<Code>

### Shell

```
ably channels publish my-first-channel 'Hello!' --name "myEvent"
```
</Code>

In a new terminal tab, subscribe to the same channel using the CLI:

<Code>

### Shell

```
ably channels subscribe my-first-channel
```
</Code>

Publish another message using the CLI and you will see that it's received instantly by the client you have running locally, as well as the subscribed terminal instance.

To publish a message in your code, you can add the following line to your `main` function, above the line `// Keep the program running`, after subscribing to the channel:

<Code>

### Objc

```
[channel publish:nil data:@"A message sent from my first client!"];
```
</Code>

## Step 3: Join the presence set 

Presence enables clients to be aware of one another if they are present on the same channel. You can then show clients who else is online, provide a custom status update for each, and notify the channel when someone goes offline.

Add the following lines to your `main` function, above the line `// Keep the program running`, to subscribe to, and join, the presence set of the channel:

<Code>

### Objc

```
// Subscribe to presence events on the channel
[channel.presence subscribe:^(ARTPresenceMessage *presenceMessage) {
    NSLog(@"Event type: %@ from %@ with the data %@",
          ARTPresenceActionToStr(presenceMessage.action),
          presenceMessage.clientId,
          presenceMessage.data);
}];

// Enter the presence set
[channel.presence enter:@"I'm here!" callback:nil];
```
</Code>

You can have another client join the presence set using the Ably CLI:

<Code>

### Shell

```
ably channels presence enter my-first-channel --data '{"status":"learning about Ably!"}'
```
</Code>

## Step 4: Retrieve message history 

You can retrieve previously sent messages using the history feature. Ably stores all messages for 2 minutes by default in the event a client experiences network connectivity issues. You can [extend the storage period](https://ably.com/docs/storage-history/storage.md) of messages if required.

If more than 2 minutes has passed since you published a regular message (excluding the presence events), then publish some more before trying out history. You can use the Pub/Sub SDK, Ably CLI or the dev console to do this.

For example, using the Ably CLI to publish 5 messages:

<Code>

### Shell

```
ably channels publish --count 5 my-first-channel "Message number {{.Count}}" --name "myEvent"
```
</Code>

Add the following lines to your `main` function, above the line `// Keep the program running`, to retrieve any messages that were recently published to the channel:

<Code>

### Objc

```
// Retrieve message history
[channel history:nil callback:^(ARTPaginatedResult<ARTMessage *> *result, ARTErrorInfo *error) {
    if (error) {
        NSLog(@"Error retrieving history: %@", error.message);
        return;
    }

    if (result.items.count > 0) {
        NSLog(@"Message History:");
        for (ARTMessage *message in result.items) {
            NSLog(@"%@", message.data);
        }
    } else {
        NSLog(@"No messages in history.");
    }
}];
```
</Code>

The output will look similar to the following:

<Code>

### Json

```
[
  'Message number 5',
  'Message number 4',
  'Message number 3',
  'Message number 2',
  'Message number 1'
]
```
</Code>

## Next steps 

Continue to explore the documentation with Objective-C as the selected language:

* Understand [token authentication](https://ably.com/docs/auth/token.md) before going to production.
* Understand how to effectively [manage connections](https://ably.com/docs/connect.md#close?lang=objc).
* Explore more [advanced](https://ably.com/docs/pub-sub/advanced.md) Pub/Sub concepts.

You can also explore the [Ably CLI](https://www.npmjs.com/package/@ably/cli) further, or visit the Pub/Sub [API references](https://ably.com/docs/api/realtime-sdk.md).

## Related Topics

- [Overview](https://ably.com/docs/getting-started.md): Getting started with Ably Pub/Sub in your language or framework of choice. Learn how to publish, subscribe, track presence, fetch message history, and manage realtime connections.
- [JavaScript](https://ably.com/docs/getting-started/javascript.md): Get started with Pub/Sub in vanilla JavaScript using Ably. Learn how to publish, subscribe, track presence, fetch message history, and manage realtime connections.
- [Node.js](https://ably.com/docs/getting-started/node.md): Get started with Pub/Sub in JavaScript using Ably. Learn how to publish, subscribe, track presence, fetch message history, and manage realtime connections.
- [React](https://ably.com/docs/getting-started/react.md): A getting started guide for Ably Pub/Sub React that steps through some of the key features using React and Vite.
- [React Native](https://ably.com/docs/getting-started/react-native.md): A getting started guide for Ably Pub/Sub React Native that steps through some of the key features using React Native with Expo.
- [Kotlin](https://ably.com/docs/getting-started/kotlin.md): Get started with Pub/Sub in Kotlin using Ably. Learn how to publish, subscribe, track presence, fetch message history, and manage realtime connections.
- [Swift](https://ably.com/docs/getting-started/swift.md): Get started with Pub/Sub in Swift using Ably. Learn how to publish, subscribe, track presence, fetch message history, and manage realtime connections.
- [Flutter](https://ably.com/docs/getting-started/flutter.md): A getting started guide for Ably Pub/Sub Flutter that steps through some of the key features using Flutter.
- [Java](https://ably.com/docs/getting-started/java.md): A getting started guide for Ably Pub/Sub Java that steps through some of the key features using Java.
- [Go](https://ably.com/docs/getting-started/go.md): Get started with Pub/Sub in Go using Ably. Learn how to publish, subscribe, track presence, fetch message history, and manage realtime connections.
- [Python](https://ably.com/docs/getting-started/python.md): A getting started guide for Ably Pub/Sub Python that steps through some of the key features using Python.
- [Ruby](https://ably.com/docs/getting-started/ruby.md): A getting started guide for Ably Pub/Sub Ruby that steps through some of the key features using Ruby.
- [C# .NET](https://ably.com/docs/getting-started/dotnet.md): A getting started guide for Ably Pub/Sub C# .NET that steps through some of the key features using C# and .NET.
- [PHP](https://ably.com/docs/getting-started/php.md): A getting started guide for Ably Pub/Sub PHP that steps through some of the key features using PHP.
- [Laravel](https://ably.com/docs/getting-started/laravel.md): A getting started guide for Ably Pub/Sub Laravel 12 that steps through some of the key features using Laravel.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
