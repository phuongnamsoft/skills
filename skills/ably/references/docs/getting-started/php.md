# Getting started: Pub/Sub in PHP

This guide will get you started with Ably Pub/Sub in PHP.

You'll learn how to connect to Ably using the REST SDK, generate JWTs for client authentication, and publish messages. You'll also implement presence to track other online clients, and learn how to retrieve message history.

<Aside data-type='note'>
This guide covers the Ably PHP SDK which provides RESTful functionality for publishing messages, retrieving history, and checking presence. If you need realtime features like subscribing to channels and receiving live updates, check out the [Ably Laravel broadcaster](https://github.com/ably/laravel-broadcaster) which integrates with Laravel's broadcasting system.
</Aside>

<Aside data-type='note'>
Using an AI coding assistant? [Teach it Ably](https://ably.com/docs/platform/ai-llms.md#agent-skills) with Agent Skills for all popular AI coding agents. Run `claude plugin add ably/agent-skills` or `npx skills add ably/agent-skills` to get started.
</Aside>

## Prerequisites 

1. [Sign up](https://ably.com/signup) for an Ably account.
2. Create a [new app](https://ably.com/accounts/any/apps/new), and create your first API key in the **API Keys** tab of the dashboard.
3. Your API key will need the `publish`, `presence`, and `history` capabilities.
4. Install [PHP](https://www.php.net/downloads.php) version 7.2 or greater.
5. Create a new project and install the Ably Pub/Sub PHP SDK:

<Code>

### Shell

```
# Create a new directory for your project
mkdir ably-php-quickstart
cd ably-php-quickstart

# Initialize Composer (if you don't have a composer.json yet)
composer init

# Install the Ably PHP SDK
composer require ably/ably-php
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

## Step 1: Configure the Ably Rest SDK client 

Clients can make REST API requests to Ably when they instantiate a REST SDK instance. This enables them to publish messages to channels and retrieve channel information.

Create a `get_started.php` file in your project and add the following code to instantiate the SDK and make requests to Ably. At the minimum you need to provide an authentication mechanism. Using an API key directly is fine for server-side environments like PHP where the key remains secure. However, for frontend clients, you should use [token authentication](https://ably.com/docs/auth/token.md) instead of exposing API keys. In this example, the [`clientId`](https://ably.com/docs/auth/identified-clients.md) will be the name of the client sending the message:

<Code>

### Php

```
<?php

require 'vendor/autoload.php';

use Ably\AblyRest;

$ably = new AblyRest(['key' => 'your-api-key', 'clientId' => 'my-first-client']);
```
</Code>

## Step 2: Generate a JWT 

The Ably PHP SDK provides token authentication for secure client connections. Authentication with a JWT is recommended over using API keys directly in production because they can be scoped to specific capabilities and have expiration times. This is essential when authenticating frontend clients where embedding API keys would expose them publicly. With PHP the API key would be considered secure as it's stored on the server.

This section will show you how to build a JWT with the Ably API key credentials embedded, which you can then return to your frontend clients, for example from an API endpoint.

First install the Firebase JWT library, which is used to create and verify JSON Web Tokens (JWTs):

<Code>

### Shell

```
composer require firebase/php-jwt
```
</Code>

Import the necessary classes at the top of your `get_started.php` file:

<Code>

### Php

```
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
```
</Code>

Then create a new JWT with the following code:

<Code>

### Php

```
$currentTime = time();
$payload = [
    'iat' => $currentTime,
    'exp' => $currentTime + 3600,
    'x-ably-capability' => '{"*":["*"]}'
];

$apiKeyCredentials = explode(':', 'your-api-key');
$jwt = JWT::encode(
    $payload,
    $apiKeyCredentials[1],
    'HS256',
    $apiKeyCredentials[0]
);

echo $jwt;
```
</Code>

To use this JWT for authenticating frontend clients, you would typically expose it through an API endpoint that your frontend application can call. For example, you might create an endpoint like `/get-auth-jwt` that returns this JWT. Your frontend clients, a JavaScript application in the example below, can then use this JWT when instantiating their Ably client:

<Code>

### Php

```
const realtime = new Ably.Realtime({ authUrl: '/get-auth-jwt' });
```
</Code>

This approach keeps your API key secure on the server while allowing frontend clients to authenticate with Ably using the generated JWT.

## Step 3: Publish a message to a channel 

Messages contain the data that a client is communicating, such as a short 'hello' from a colleague, or a financial update being broadcast to subscribers from a server. Ably uses channels to separate messages into different topics, so that clients only ever receive messages on the channels they are subscribed to. The PHP SDK can only publish messages to channels and cannot subscribe to them. To subscribe to channels you will make use of the Ably CLI.

Use the Ably CLI to subscribe to a channel. The message that your PHP client sends will be received by CLI instance.

<Code>

### Shell

```
ably channels subscribe my-first-channel
```
</Code>

Add the following lines to the bottom of your `get_started` file to create a channel instance and publish a message to the channel. Then run it with `php get_started.php`:

<Code>

### Php

```
$channel = $ably->channel('my-first-channel');
$channel->publish('myEvent', 'Hello!');
```
</Code>

The Ably CLI will receive the message.

## Step 4: Presence 

Presence enables clients to be aware of one another if they are present on the same channel. You can then show clients who else is online, provide a custom status update for each, and notify the channel when someone goes offline. With the PHP SDK you can retrieve the presence set but cannot enter it. This means you can see who is present on a channel, but you cannot announce your own presence from a PHP client.

Have a client join the presence set using the Ably CLI:

<Code>

### Shell

```
ably channels presence enter my-first-channel --data '{"status":"learning about Ably!"}'
```
</Code>

Add the following lines to your `get_started` function to retrieve the list of members in the presence set. Then run it with `php get_started.php`:

<Code>

### Php

```
$membersPage = $channel->presence->get(); // Returns a PaginatedResult
$memberIds = array_map(function($member) {
    return $member->clientId;
}, $membersPage->items);
echo "\nMembers in presence set:\n " . implode(', ', $memberIds) . "\n";
```
</Code>

## Step 5: Retrieve message history 

You can retrieve previously sent messages using the history feature. Ably stores all messages for 2 minutes by default in the event a client experiences network connectivity issues. You can [extend the storage period](https://ably.com/docs/storage-history/storage.md) of messages if required.

If more than 2 minutes has passed since you published a regular message (excluding the presence events), then you can publish some more before trying out history. You can use the Pub/Sub SDK, Ably CLI or the dev console to do this.

For example, using the Ably CLI to publish 5 messages:

<Code>

### Shell

```
ably channels publish --count 5 my-first-channel "Message number {{.Count}}" --name "myEvent"
```
</Code>

Add the following lines to your `get_started` function to retrieve any messages that were recently published to the channel. Then run it with `php get_started.php`:

<Code>

### Php

```
$history = $channel->history();

echo "\nMessage History:\n";
echo str_repeat("-", 50) . "\n";

foreach ($history->items as $index => $message) {
    echo " * " . ($message->data ?? 'null') . "\n";
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

Continue to explore the documentation with PHP as the selected language:

* Dive into [authenticating](https://ably.com/docs/auth/token/jwt.md) your frontend applications with your PHP backend.
* Explore more [advanced](https://ably.com/docs/pub-sub/advanced.md) Pub/Sub concepts.

You can also explore the [Ably CLI](https://www.npmjs.com/package/@ably/cli) further, or visit the Pub/Sub [API references](https://ably.com/docs/api/rest-sdk.md).

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
- [Objective C](https://ably.com/docs/getting-started/objective-c.md): A getting started guide for Ably Pub/Sub Objective-C that steps through some of the key features using Objective-C.
- [Laravel](https://ably.com/docs/getting-started/laravel.md): A getting started guide for Ably Pub/Sub Laravel 12 that steps through some of the key features using Laravel.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
