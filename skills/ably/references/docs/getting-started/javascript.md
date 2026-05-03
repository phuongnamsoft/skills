# Getting started: Pub/Sub in JavaScript

This guide will get you started with Ably Pub/Sub in JavaScript.

You'll establish a realtime connection to Ably and learn to publish and subscribe to messages. You'll also implement presence to track other online clients, and learn how to retrieve message history.

<Aside data-type='note'>
Using an AI coding assistant? [Teach it Ably](https://ably.com/docs/platform/ai-llms.md#agent-skills) with Agent Skills for all popular AI coding agents. Run `claude plugin add ably/agent-skills` or `npx skills add ably/agent-skills` to get started.
</Aside>

## Prerequisites 

1. [Sign up](https://ably.com/signup) for an Ably account.

2. Create a [new app](https://ably.com/accounts/any/apps/new), and create your first API key in the **API Keys** tab of the dashboard.

3. Your API key will need the `publish`, `subscribe`, `presence` and `history` capabilities.

4. Create an HTML file in your project directory where you'll include the Ably JavaScript SDK via a CDN.

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

Create an `index.html` file in your project and add the following HTML to include the Ably JavaScript SDK via CDN and establish a connection to Ably. At the minimum you need to provide an authentication mechanism. Use an API key for simplicity, but you should use [JWT authentication](https://ably.com/docs/auth/token/jwt.md) in a production app. A [`clientId`](https://ably.com/docs/auth/identified-clients.md) ensures the client is identified, which is required to use certain features, such as presence:

<Code>

### Html

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ably JavaScript Getting Started</title>
</head>
<body>
    <h1>Ably JavaScript Getting Started</h1>
    <div id="output"></div>

    <script src="https://cdn.ably.com/lib/ably.min-2.js"></script>
    <script>
        const output = document.getElementById('output');

        function log(message) {
            output.innerHTML += '<p>' + message + '</p>';
            console.log(message);
        }

        async function getStarted() {
            const realtimeClient = new Ably.Realtime({
                key: 'your-api-key',
                clientId: 'my-first-client'
            });

            await realtimeClient.connection.once('connected');
            log('Made my first connection!');
        }

        getStarted();
    </script>
</body>
</html>
```
</Code>

You can monitor the lifecycle of clients' connections by registering a listener that will emit an event every time the connection state changes. Open the HTML file in your browser to see the connection message, and you can also inspect the connection event in the dev console of your app.

## Step 2: Subscribe to a channel and publish a message 

Messages contain the data that a client is communicating, such as a short 'hello' from a colleague, or a financial update being broadcast to subscribers from a server. Ably uses channels to separate messages into different topics, so that clients only ever receive messages on the channels they are subscribed to.

Add the following lines to your `getStarted()` function to create a channel instance and register a listener to subscribe to the channel:

<Code>

### Javascript

```
const channel = realtimeClient.channels.get('my-first-channel');

await channel.subscribe((message) => {
    log(`Received message: ${message.data}`);
});
```
</Code>

Use the Ably CLI to publish a message to your first channel. The message will be received by the client you've subscribed to the channel, and be logged to the console and displayed on the page.

<Code>

### Shell

```
ably channels publish my-first-channel 'Hello!'
```
</Code>

In a new terminal tab, subscribe to the same channel using the CLI:

<Code>

### Shell

```
ably channels subscribe my-first-channel
```
</Code>

Publish another message using the CLI and you will see that it's received instantly by the client you have running in your browser, as well as the subscribed terminal instance.

To publish a message in your code, you can add the following line to your `getStarted` method after subscribing to the channel:

<Code>

### Javascript

```
await channel.publish('example', 'A message sent from my first client!');
```
</Code>

## Step 3: Join the presence set 

Presence enables clients to be aware of one another if they are present on the same channel. You can then show clients who else is online, provide a custom status update for each, and notify the channel when someone goes offline.

Add the following lines to your `getStarted()` function to subscribe to, and join, the presence set of the channel:

<Code>

### Javascript

```
await channel.presence.subscribe((member) => {
    log(`Event type: ${member.action} from ${member.clientId} with the data ${JSON.stringify(member.data)}`);
});

await channel.presence.enter("I'm here!");
```
</Code>

In the [dev console](https://ably.com/accounts/any/apps/any/console) of your first app, attach to `my-first-channel`. Enter a `clientId`, such as `my-dev-console`, and then join the presence set of the channel. You'll see that `my-first-client` is already present in the channel. In the console of your browser you'll see that an event was received when the dev console client joined the channel.

You can have another client join the presence set using the Ably CLI:

<Code>

### Shell

```
ably channels presence enter my-first-channel --data '{"status":"learning about Ably!"}'
```
</Code>

## Step 4: Retrieve message history 

You can retrieve previously sent messages using the history feature. Ably stores all messages for 2 minutes by default in the event a client experiences network connectivity issues. You can [extend the storage period](https://ably.com/docs/storage-history/storage.md) of messages if required.

If more than 2 minutes has passed since you published a regular message (excluding the presence events), then you can publish some more before trying out history. You can use the Pub/Sub SDK, Ably CLI or the dev console to do this.

For example, using the Ably CLI to publish 5 messages:

<Code>

### Shell

```
ably channels publish --count 5 my-first-channel "Message number {{.Count}}"
```
</Code>

Add the following lines to your `getStarted()` function to retrieve any messages that were recently published to the channel:

<Code>

### Javascript

```
const history = await channel.history();
const messages = history.items.map((message) => message.data);
log('Message history:');
messages.forEach((message, index) => {
  log(`  ${index + 1}: ${JSON.stringify(message)}`);
});
```
</Code>

The output will look similar to the following:

<Code>

### Json

```
[
  "Message number 5",
  "Message number 4",
  "Message number 3",
  "Message number 2",
  "Message number 1"
]
```
</Code>

## Next steps 

Continue to explore the documentation with JavaScript as the selected language:

* Understand [token authentication](https://ably.com/docs/auth/token.md) before going to production.
* Understand how to effectively [manage connections](https://ably.com/docs/connect.md#close?lang=javascript).
* Explore more [advanced](https://ably.com/docs/pub-sub/advanced.md) Pub/Sub concepts.

You can also explore the [Ably CLI](https://www.npmjs.com/package/@ably/cli) further, or visit the Pub/Sub [API references](https://ably.com/docs/api/realtime-sdk.md).

## Related Topics

- [Overview](https://ably.com/docs/getting-started.md): Getting started with Ably Pub/Sub in your language or framework of choice. Learn how to publish, subscribe, track presence, fetch message history, and manage realtime connections.
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
- [Objective C](https://ably.com/docs/getting-started/objective-c.md): A getting started guide for Ably Pub/Sub Objective-C that steps through some of the key features using Objective-C.
- [PHP](https://ably.com/docs/getting-started/php.md): A getting started guide for Ably Pub/Sub PHP that steps through some of the key features using PHP.
- [Laravel](https://ably.com/docs/getting-started/laravel.md): A getting started guide for Ably Pub/Sub Laravel 12 that steps through some of the key features using Laravel.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
