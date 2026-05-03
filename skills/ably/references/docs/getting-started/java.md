# Getting started: Pub/Sub in Java

This guide will get you started with Ably Pub/Sub in Java.

You'll establish a realtime connection to Ably and learn to publish and subscribe to messages. You'll also implement presence to track other online clients, and learn how to retrieve message history.

<Aside data-type='note'>
Using an AI coding assistant? [Teach it Ably](https://ably.com/docs/platform/ai-llms.md#agent-skills) with Agent Skills for all popular AI coding agents. Run `claude plugin add ably/agent-skills` or `npx skills add ably/agent-skills` to get started.
</Aside>

## Prerequisites 

1. [Sign up](https://ably.com/sign-up) for an Ably account.
2. Create a [new app](https://ably.com/accounts/any/apps/new), and create your first API key in the **API Keys** tab of the dashboard.
3. Your API key will need the `publish`, `subscribe`, `presence` and `history` [capabilities](https://ably.com/docs/auth/capabilities.md).
4. Install [Java Development Kit (JDK)](https://adoptium.net/) version 8 or greater.
5. Create a new project and add the Ably [Pub/Sub Java SDK](https://github.com/ably/ably-java) as a dependency.

  For Maven, add the following to your `pom.xml`:

  <Code>

### Java

```
  <dependency>
      <groupId>io.ably</groupId>
      <artifactId>ably-java</artifactId>
      <version>1.2.52</version>
  </dependency>
  <dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-simple</artifactId>
    <version>2.0.7</version>
  </dependency>
  ```
  </Code>

  For Gradle, add the following to your `build.gradle`:

  <Code>

### Java

```
  implementation 'io.ably:ably-java:1.2.52'
  implementation 'org.slf4j:slf4j-simple:2.0.7'
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

Replace the contents of your `App.java` file with functionality to instantiate the SDK and establish a connection to Ably. At the minimum you need to provide an authentication mechanism. Use an API key for simplicity, but you should use [token authentication](https://ably.com/docs/auth/token.md) in production environments. A [`clientId`](https://ably.com/docs/auth/identified-clients.md) ensures the client is identified, which is required to use certain features, such as presence:

<Code>

### Java

```
package ably.java.quickstart;

import io.ably.lib.realtime.AblyRealtime;
import io.ably.lib.realtime.Channel;
import io.ably.lib.realtime.ConnectionEvent;
import io.ably.lib.types.AblyException;
import io.ably.lib.types.ClientOptions;
import io.ably.lib.types.ErrorInfo;
import io.ably.lib.types.Message;
import io.ably.lib.types.PaginatedResult;

public class App {
    public static void main(String[] args) {
        try {
            // Initialize the Ably Realtime client
            ClientOptions options = new ClientOptions("your-api-key");
            options.clientId = "my-first-client";
            AblyRealtime realtime = new AblyRealtime(options);

            // Wait for the connection to be established
            realtime.connection.on(ConnectionEvent.connected, connectionStateChange -> {
                System.out.println("Made my first connection!");
            });

            // Keep the program running
            Thread.sleep(2000);

        } catch (AblyException e) {
            e.printStackTrace();
        }
    }
}
```
</Code>

You can monitor the lifecycle of clients' connections by registering a listener that will emit an event every time the connection state changes. For now, run the program with `./gradlew run` to log a message to the console to know that the connection attempt was successful. You'll see the message printed to your console, and you can also inspect the connection event in the dev console of your app.

## Step 2: Subscribe to a channel and publish a message 

Messages contain the data that a client is communicating, such as a short 'hello' from a colleague, or a financial update being broadcast to subscribers from a server. Ably uses channels to separate messages into different topics, so that clients only ever receive messages on the channels they are subscribed to.

Add the following lines to your `main` method, above the line `// Keep the program running`, to create a channel instance and register a listener to subscribe to the channel. Then run it with `./gradlew run`:

<Code>

### Java

```
// Get a channel instance
Channel channel = realtime.channels.get("my-first-channel");

// Subscribe to messages on the channel
channel.subscribe(message -> {
    System.out.println("Received message: " + message.data);
});
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

To publish a message in your code, you can add the following line to your `main` method, above the line `// Keep the program running`, after subscribing to the channel:

<Code>

### Java

```
channel.publish("myEvent", "A message sent from my first client!");
```
</Code>

## Step 3: Join the presence set 

Presence enables clients to be aware of one another if they are present on the same channel. You can then show clients who else is online, provide a custom status update for each, and notify the channel when someone goes offline.

Add the following lines to your `main` method, above the line `// Keep the program running`, to subscribe to, and join, the presence set of the channel. Then run it with `./gradlew run`:

<Code>

### Java

```
// Subscribe to presence events on the channel
channel.presence.subscribe(presenceMessage -> {
    System.out.println("Event type: " + presenceMessage.action.name() +
                      " from " + presenceMessage.clientId +
                      " with the data " + presenceMessage.data);
});

// Enter the presence set
channel.presence.enter("I'm here!", null);
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

Add the following lines to your `main` method, above the line `// Keep the program running`, to retrieve any messages that were recently published to the channel. Then run it with `./gradlew run`:

<Code>

### Java

```
// Retrieve message history
PaginatedResult<Message> resultPage = channel.history(null);
Message[] messages = resultPage.items();
if (messages.length > 0) {
    System.out.println("Message History:");
    for (Message message : messages) {
        System.out.println(message.data);
    }
} else {
    System.out.println("No messages in history.");
}
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

Continue to explore the documentation with Java as the selected language:

* Understand [token authentication](https://ably.com/docs/auth/token.md) before going to production.
* Understand how to effectively [manage connections](https://ably.com/docs/connect.md#close?lang=java).
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
- [Go](https://ably.com/docs/getting-started/go.md): Get started with Pub/Sub in Go using Ably. Learn how to publish, subscribe, track presence, fetch message history, and manage realtime connections.
- [Python](https://ably.com/docs/getting-started/python.md): A getting started guide for Ably Pub/Sub Python that steps through some of the key features using Python.
- [Ruby](https://ably.com/docs/getting-started/ruby.md): A getting started guide for Ably Pub/Sub Ruby that steps through some of the key features using Ruby.
- [C# .NET](https://ably.com/docs/getting-started/dotnet.md): A getting started guide for Ably Pub/Sub C# .NET that steps through some of the key features using C# and .NET.
- [Objective C](https://ably.com/docs/getting-started/objective-c.md): A getting started guide for Ably Pub/Sub Objective-C that steps through some of the key features using Objective-C.
- [PHP](https://ably.com/docs/getting-started/php.md): A getting started guide for Ably Pub/Sub PHP that steps through some of the key features using PHP.
- [Laravel](https://ably.com/docs/getting-started/laravel.md): A getting started guide for Ably Pub/Sub Laravel 12 that steps through some of the key features using Laravel.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
