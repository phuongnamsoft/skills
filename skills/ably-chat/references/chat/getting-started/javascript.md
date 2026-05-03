# Getting started: Chat in JavaScript / TypeScript

This guide will get you started with Ably Chat using TypeScript.

You'll learn how to create chat rooms, send and edit messages, and implement realtime features like typing indicators and presence. You'll also cover message history, reactions, and proper connection management.

<Aside data-type='note'>
Using an AI coding assistant? [Teach it Ably](https://ably.com/docs/platform/ai-llms.md#agent-skills) with Agent Skills for all popular AI coding agents. Run `claude plugin add ably/agent-skills` or `npx skills add ably/agent-skills` to get started.
</Aside>

## Prerequisites 

1. Sign up for an Ably account.

2. Create a [new app](https://ably.com/accounts/any/apps/new), and get your first API key. You can use the root API key that is provided by default, within the **API Keys** tab to get started.

3. Install any current LTS version of [Node.js](https://nodejs.org/en) and create a new project:

<Code>

### Shell

```
npm init -y && npm pkg set type=module
```
</Code>

4. Install [@ably/chat](https://github.com/ably/ably-chat-js), [typescript](https://www.npmjs.com/package/typescript) to compile TypeScript files and make Ably Chat connections.

<Code>

### Shell

```
npm install @ably/chat typescript -D @types/node
```
</Code>

5. Create a default TypeScript configuration in your project

<Code>

### Shell

```
npx tsc --init
```
</Code>

6. Update `tsconfig.json` to have `types` containing `node`:

<Code>

### Json

```
   "types": ["node"],
```
</Code>

7. Create a `.env` file in your project root and add your API key:

<Code>

### Shell

```
echo "ABLY_API_KEY=your-api-key" > .env
```
</Code>

### (Optional) Install Ably CLI 

Use the [Ably CLI](https://github.com/ably/cli) as an additional client to quickly test chat features. It can simulate other users by sending messages, entering presence, and acting as another user typing a message.

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

Clients establish a connection with Ably when they instantiate an SDK. This enables them to send and receive messages in realtime across channels.

Create an `index.ts` file in your project and add the following function to instantiate a realtime client with the Pub/Sub SDK and then pass that client into the Chat SDK constructor. Provide an API key and a [`clientId`](https://ably.com/docs/auth/identified-clients.md) to identify the client. In production, use [token authentication](https://ably.com/docs/auth/token.md) so that your API keys are not exposed publicly.

<Code>

### Javascript

```
import * as Ably from 'ably';
import { ChatClient } from '@ably/chat';
import type { ChatMessageEvent  } from '@ably/chat';

async function getStarted() {
  const apiKey = process.env.ABLY_API_KEY;
  if (!apiKey) {
    throw new Error('ABLY_API_KEY environment variable is required');
  }

  const realtimeClient = new Ably.Realtime({ key: apiKey, clientId: 'my-first-client' });

  const chatClient = new ChatClient(realtimeClient);

  chatClient.connection.onStatusChange((change) => console.log(`Connection status is currently ${change.current}!`));

};

getStarted();
```
</Code>

You can monitor the lifecycle of clients' connections by registering a listener that will emit an event every time the connection state changes. For now, run the function with `npx tsx --env-file=.env index.ts` to log a message to the console to know that the connection attempt was successful. You'll see a message saying `Connection status is currently connected!` printed to your console.

## Step 2: Create a room and send a message 

Messages are how your clients interact with one another. Use rooms to separate and organize clients and messages into different topics, or 'chat rooms'. Rooms are the entry object into Chat, providing access to all of its features, such as messages, presence and reactions.

Add the following lines to your `getStarted()` function to create an instance of a room, attach to the room instance, and then register a listener to subscribe to messages sent to the room. You then also send your first message. Afterwards, run it with `npx tsx --env-file=.env index.ts`:

<Code>

### Javascript

```
const room = await chatClient.rooms.get('my-first-room');

await room.attach();

room.messages.subscribe((messageEvent: ChatMessageEvent) => {
  console.log(`Received message: ${ messageEvent.message.text }`);
});

const myFirstMessage = await room.messages.send({ text: 'My first message!' });
```
</Code>

Use the Ably CLI to send a message to your first room. The message will be received by the client you've subscribed to the room, and be logged to the console:

<Code>

### Shell

```
ably rooms messages send my-first-room 'Hello!'
```
</Code>

## Step 3: Edit a message 

If your client makes a typo, or needs to update their original message then they can edit it.

Add the following line to your `getStarted()` function. Now, when you run the function again and send another message, that message will be updated and you should see both in your terminal. Run it with `npx tsx --env-file=.env index.ts`.

<Code>

### Javascript

```
const updatedMessage = myFirstMessage.copy({text: "My 2nd message! (edited)"})
await room.messages.update(myFirstMessage.serial, updatedMessage);
```
</Code>

## Step 4: Message history and continuity 

Ably Chat provides a method for retrieving messages that have been previously sent in a room, up until the point that a client joins (attaches) to it. This enables clients joining a room part way through a conversation to receive the context of what has happened, and what is being discussed, without having to ask another client for context.

Use the Ably CLI to send some additional messages to your room, for example:

<Code>

### Shell

```
ably rooms messages send my-first-room 'Old message #1'
```
</Code>

Create a new `clientTwo.ts` file in your project, and run the following in a separate terminal instance. It imitates a second client, `my-second-client` joining the room and receiving the context of the previous 10 messages. Run it with `npx tsx --env-file=.env clientTwo.ts`

<Code>

### Javascript

```
import * as Ably from 'ably';
import { ChatClient } from '@ably/chat';

async function getStartedLate() {
  const apiKey = process.env.ABLY_API_KEY;
  if (!apiKey) {
    throw new Error('ABLY_API_KEY environment variable is required');
  }

  const realtimeClient = new Ably.Realtime({ key: apiKey, clientId: 'my-second-client' });
  const chatClient = new ChatClient(realtimeClient);

  const room = await chatClient.rooms.get('my-first-room');

  await room.attach();

  const { historyBeforeSubscribe } = room.messages.subscribe(() => {
    console.log('New message received');
  });


  const historicalMessages = await historyBeforeSubscribe({ limit: 10 });
    console.log(historicalMessages.items.map((message) => `${message.clientId}: ${message.text}`));

};

getStartedLate();
```
</Code>

## Step 5: Show who is typing a message 

Typing indicators enable you to display messages to clients when someone is currently typing. An event is emitted when someone starts typing, when they press a keystroke, and then another event is emitted after a configurable amount of time has passed without a key press.

In practice the `typing.keystroke()` method would be called on keypress, however for demonstration purposes we will call it and wait for the default period of time to pass for a stop event to be emitted. Using your original client, add the following lines to `getStarted()` to subscribe to typing events and emit one, then run it with `npx tsx --env-file=.env index.ts`:

<Code>

### Javascript

```
room.typing.subscribe((typingEvent) => {
  if (typingEvent.currentlyTyping.size === 0) {
    console.log('No one is currently typing');
  } else {
    console.log(`${Array.from(typingEvent.currentlyTyping).join(", ")} is typing`);
  }
});

await room.typing.keystroke()
// A client types
await room.typing.stop()
```
</Code>

Use the Ably CLI to subscribe to typing events. You will see that the client using the SDK starts to type after re-running `getStarted()`, with the message `my-first-client is typing...`:

<Code>

### Shell

```
ably rooms typing subscribe my-first-room
```
</Code>

## Step 6: Display online status 

Display the online status of clients using the presence feature. This enables clients to be aware of one another if they are present in the same room. You can then show clients who else is online, provide a custom status update for each, and notify the room when someone enters it, or leaves it, such as by going offline.

Add the following lines to your `getStarted()` function to subscribe to, and join, the presence set of the room. It also sets a short wait before leaving the presence set. Run it with `npx tsx --env-file=.env index.ts`:

<Code>

### Javascript

```
room.presence.subscribe((event) => {
  const {clientId, data} = event.member;
  console.log(`Event type: ${event.type} from  ${clientId} with the data ${JSON.stringify(data)}`)});

await room.presence.enter("I'm here!");

setTimeout( () => {
  room.presence.leave("I'm leaving!");
}, 3000);
```
</Code>

You can have another client join the presence set using the Ably CLI:

<Code>

### Shell

```
ably rooms presence enter my-first-room --data '{"status":"learning about Ably!"}'
```
</Code>

## Step 7: Send a room reaction 

Clients can send an ephemeral reaction to a room to show their sentiment for what is happening, such as a point being scored in a sports game.

Add the following lines to your `getStarted()` function to subscribe to room reactions. Then run it with `npx tsx --env-file=.env index.ts`:

<Code>

### Javascript

```
room.reactions.subscribe((event) => {
  console.log(`${event.reaction.clientId}: ${ event.reaction.name } to that!`)
});
```
</Code>

Use the Ably CLI to send some reactions to the room, such as:

<Code>

### Shell

```
ably rooms reactions send my-first-room 👍
```
</Code>

## Step 8: Close the connection 

Connections are automatically closed approximately 2 minutes after no heartbeat is detected by Ably. Explicitly closing connections when they are no longer needed is good practice to help save costs. It will also remove all listeners that were registered by the client.

Connections to Ably are handled by the underlying Pub/Sub SDK. To close the connection you need to call `connection.close()` on the original realtime client instance.

Add the following to `getStarted()` to close the connection after a simulated 10 seconds. Run it with `npx tsx --env-file=.env index.ts`:

<Code>

### Javascript

```
setTimeout(() => realtimeClient.close(), 10000);
```
</Code>

## Next steps 

Continue to explore the documentation with JavaScript as the selected language:

* Understand [token authentication](https://ably.com/docs/auth/token.md) before going to production.
* Read more about using [rooms](https://ably.com/docs/chat/rooms.md) and sending [messages](https://ably.com/docs/chat/rooms/messages.md).
* Find out more regarding [presence](https://ably.com/docs/chat/rooms/presence.md).
* Read into pulling messages from [history](https://ably.com/docs/chat/rooms/history.md) and providing context to new joiners.

Explore the [Ably CLI](https://www.npmjs.com/package/@ably/cli) further, or visit the Chat [API references](https://ably.com/docs/chat/api/javascript/chat-client.md).

## Related Topics

- [Overview](https://ably.com/docs/chat/getting-started.md): Getting started with Ably Chat in your language or framework of choice. Learn how to send and receive messages, track online presence, fetch message history, implement typing indicators, among other features.
- [React](https://ably.com/docs/chat/getting-started/react.md): A getting started guide for Ably Chat React that steps through some of the key features using React and Vite.
- [React Native](https://ably.com/docs/chat/getting-started/react-native.md): A getting started guide for Ably Chat React Native that steps through some of the key features using React Native.
- [Kotlin (Android)](https://ably.com/docs/chat/getting-started/android.md): A getting started guide for Ably Chat Android that steps through some of the key features using Jetpack Compose.
- [Kotlin (JVM)](https://ably.com/docs/chat/getting-started/jvm.md): A getting started guide for Ably Chat JVM that steps through some of the key features using Kotlin.
- [Swift](https://ably.com/docs/chat/getting-started/swift.md): A getting started guide for Ably Chat iOS that steps through some of the key features using SwiftUI with callback-based subscriptions.
- [Swift (AsyncSequence)](https://ably.com/docs/chat/getting-started/swift-async-sequence.md): A getting started guide for Ably Chat iOS that steps through some of the key features using SwiftUI with AsyncSequence for handling realtime events.
- [React UI Kit](https://ably.com/docs/chat/getting-started/react-ui-kit.md): Step-by-step quick-start for ably-chat-react-ui-kit using React and Vite.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
