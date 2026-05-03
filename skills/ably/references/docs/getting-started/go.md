# Getting started: Pub/Sub in Go

This guide will get you started with Ably Pub/Sub in Go.

You'll establish a realtime connection to Ably and learn to publish and subscribe to messages. You'll also implement presence to track other online clients, and learn how to retrieve message history.

<Aside data-type='note'>
Using an AI coding assistant? [Teach it Ably](https://ably.com/docs/platform/ai-llms.md#agent-skills) with Agent Skills for all popular AI coding agents. Run `claude plugin add ably/agent-skills` or `npx skills add ably/agent-skills` to get started.
</Aside>

## Prerequisites 

1. [Sign up](https://ably.com/signup) for an Ably account.
2. Create a [new app](https://ably.com/accounts/any/apps/new), and create your first API key in the **API Keys** tab of the dashboard.
3. Your API key will need the `publish`, `subscribe`, `presence` and `history` capabilities.
4. Install [Go](https://go.dev/dl/) version 1.18 or greater.
5. Create a new project in your IDE and install the Ably Pub/Sub Go SDK:

<Code>

### Shell

```
mkdir ably-go-quickstart
cd ably-go-quickstart
go mod init ably-go-quickstart

go get -u github.com/ably/ably-go/ably
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

Create a `main.go` file in your project and add the following function to instantiate the SDK and establish a connection to Ably. At the minimum you need to provide an authentication mechanism. Use an API key for simplicity, but you should use [token authentication](https://ably.com/docs/auth/token.md) in production environments. A [`clientId`](https://ably.com/docs/auth/identified-clients.md) ensures the client is identified, which is required to use certain features, such as presence:

<Code>

### Go

```
package main

import (
	"context"
	"fmt"
	"log"

	"github.com/ably/ably-go/ably"
)

func main() {
	client, err := ably.NewRealtime(
		ably.WithKey("your-api-key"),
		ably.WithClientID("my-first-client"),
	)
	if err != nil {
		log.Fatal(err)
	}
	defer client.Close()

	// Wait for the connection to be connected
	connStateChan := make(chan ably.ConnectionStateChange, 1)
	client.Connection.On(ably.ConnectionEventConnected, func(change ably.ConnectionStateChange) {
		connStateChan <- change
	})
	select {
	case <-connStateChan:
		fmt.Println("Made my first connection!")
	case <-context.Background().Done():
		log.Fatal("Context cancelled before connection established")
	}

	// Keep the program running
	select {}
}
```
</Code>

You can monitor the lifecycle of clients' connections by registering a listener that will emit an event every time the connection state changes. For now, run the function with `go run main.go` to log a message to the console to know that the connection attempt was successful. You'll see the message printed to your console, and you can also inspect the connection event in the dev console of your app.

## Step 2: Subscribe to a channel and publish a message 

Messages contain the data that a client is communicating, such as a short 'hello' from a colleague, or a financial update being broadcast to subscribers from a server. Ably uses channels to separate messages into different topics, so that clients only ever receive messages on the channels they are subscribed to.

In your `main()` function, before the line `// Keep the program running`, add the following to create a channel instance and register a listener to subscribe to the channel. Then run it with `go run main.go`:

<Code>

### Go

```
channel := client.Channels.Get("my-first-channel")

// Subscribe to messages
unsubscribe, err := channel.SubscribeAll(context.Background(), func(msg *ably.Message) {
  fmt.Printf("Received message: %s\n", msg.Data)
})

if err != nil {
  log.Fatal(err)
}
defer unsubscribe()
```
</Code>

Use the Ably CLI to publish a message to your first channel. The message will be received by the client you've subscribed to the channel, and be logged to the console.

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

Publish another message using the CLI and you will see that it's received instantly by the client you have running locally, as well as the subscribed terminal instance.

To publish a message in your code, you can add the following line to your `main` function after subscribing to the channel:

<Code>

### Go

```
err = channel.Publish(context.Background(), "example", "A message sent from my first client!")
if err != nil {
	log.Fatal(err)
}
```
</Code>

## Step 3: Join the presence set 

Presence enables clients to be aware of one another if they are present on the same channel. You can then show clients who else is online, provide a custom status update for each, and notify the channel when someone goes offline.

In your `main()` function, before the line `// Keep the program running`, add the following to subscribe to, and join, the presence set of the channel. Then run it with `go run main.go`:

<Code>

### Go

```
// Subscribe to presence events
presenceUnsubscribe, err := channel.Presence.Subscribe(context.Background(), ably.PresenceActionEnter, func(msg *ably.PresenceMessage) {
  fmt.Printf("Event type: %s from %s with the data %v\n", msg.Action, msg.ClientID, msg.Data)
})
if err != nil {
  log.Fatal(err)
}
defer presenceUnsubscribe()

// Enter the presence set
err = channel.Presence.Enter(context.Background(), "I'm here!")
if err != nil {
  log.Fatal(err)
}
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

If more than 2 minutes has passed since you published a regular message (excluding the presence events), then you can publish some more before trying out history. You can use the Pub/Sub SDK, Ably CLI or the dev console to do this.

For example, using the Ably CLI to publish 5 messages:

<Code>

### Shell

```
ably channels publish --count 5 my-first-channel "Message number {{.Count}}"
```
</Code>

Update your `main()` function to retrieve any messages that were recently published to the channel. Then run it with `go run main.go`:

<Code>

### Go

```
// Add this after channel subscription
pages, err := channel.History().Pages(context.Background())
if err != nil {
	log.Fatal(err)
}

var messages []string
for pages.Next(context.Background()) {
	for _, msg := range pages.Items() {
		messages = append(messages, fmt.Sprintf("%v", msg.Data))
	}
}
if err := pages.Err(); err != nil {
	log.Fatal(err)
}

// Print messages in reverse order (newest first)
for i := len(messages) - 1; i >= 0; i-- {
	fmt.Println(messages[i])
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

Continue to explore the documentation with Go as the selected language:

* Understand [token authentication](https://ably.com/docs/auth/token.md) before going to production.
* Understand how to effectively [manage connections](https://ably.com/docs/connect.md#close?lang=go).
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
