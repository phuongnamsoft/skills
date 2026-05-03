# About Chat

Ably Chat is a product dedicated to making it quick and easy to build chat functionality into new and existing applications. Use Ably Chat to build things such as a 1:1 customer support feature, or add a chat component to a livestreaming platform that serves hundreds of thousands of users.

The Chat SDK contains a set of purpose-built APIs that abstract away the complexities involved in how you would architect chat features. It utilizes Ably's platform to benefit from all of the same performance guarantees and scaling potential.

* [Getting started: Chat in JavaScript / TypeScript](https://ably.com/docs/chat/getting-started/javascript.md)
* [Getting started: Chat in React](https://ably.com/docs/chat/getting-started/react.md)
* [Getting started: Chat UI Kit in React](https://ably.com/docs/chat/getting-started/react-ui-kit.md)
* [Getting started: Chat in React Native](https://ably.com/docs/chat/getting-started/react-native.md)
* [Getting started: Chat in Android](https://ably.com/docs/chat/getting-started/android.md)
* [Getting started: Chat in Kotlin (JVM)](https://ably.com/docs/chat/getting-started/jvm.md)
* [Getting started: Chat in Swift](https://ably.com/docs/chat/getting-started/swift.md)

## Chat features 

Ably Chat provides the following key features:

* [Rooms and messages](#rooms)
* [Presence](#presence)
* [Message reactions](#message-reactions)
* [Typing indicators](#typing)
* [Room reactions](#reactions)
* [AI Moderation](#moderation)
* [React UI Kit](#react-ui-kit)
* [React Hooks](#react-hooks)

### Rooms and messages 

[Rooms](https://ably.com/docs/chat/rooms.md) are used to organize and separate your users and chat messages into 'chat rooms'. They are the entry object into chat and provide access to all other chat features, such as messages, online status, and typing indicators.

Each room can represent a 1:1 chat between an agent and a customer, a private message between two users in a chat application, a group conversation, or the chat section of a livestream with thousands of users.

[Messages](https://ably.com/docs/chat/rooms/messages.md) enable users to communicate with one another in the room. Messages sent by users are received by all those who have subscribed to receive them within that room.

### Presence 

[Presence](https://ably.com/docs/chat/rooms/presence.md) enables you to display who is currently online in a chat room. Users can also set additional information about their profile such as a status message, profile picture, display name, and more.

### Message reactions 

[Message reactions](https://ably.com/docs/chat/rooms/message-reactions.md) enable users to send reactions to messages, such as 👍 or ❤. Users can also see which other users reacted to a message.

### Typing indicators 

[Typing indicators](https://ably.com/docs/chat/rooms/typing.md) let users see when others start and stop typing a message. They enable you to display a message such as *John is typing...* or when too many users are typing, something like *Multiple people are typing...* or *12 people are typing...*.

### Room reactions 

[Room reactions](https://ably.com/docs/chat/rooms/reactions.md) enable users to broadcast ephemeral sentiments using emojis, such as 👍 or ❤. Room reactions are used to broadcast a general sentiment to the entire room rather than reacting to a single message. A common use case is sports fans all sending a heart when their team scores.

### Moderation 

[AI Moderation](https://ably.com/docs/chat/moderation.md) enables you to automatically detect and handle inappropriate content in chat messages. Using AI-powered content filtering, you can identify potentially harmful messages, spam, or content that violates your community guidelines, and take appropriate action either before they reach other users, or retroactively.

You can integrate seamlessly in minutes with a number of third-party moderation providers to take advantage of powerful AI models, or bring your own infrastructure via integrations with the likes of AWS Lambda to customize your experience.

### React UI Kit 

[React UI Kit](https://ably.com/docs/chat/getting-started/react-ui-kit.md) provide pre-built, customizable React components that make it even faster to add chat functionality to your applications. These components handle the presentation layer and user interactions, allowing you to focus on your application logic rather than building chat UI from scratch.

The UI Kit includes components for message lists, input fields, user avatars, typing indicators, and more. They're designed to be flexible and themeable to match your application's design system. They are fully [open-source](https://github.com/ably/ably-chat-react-ui-kit), so you can easily take the code as a starting point to further customize your own components.

### React Hooks 

[React Hooks](https://ably.com/docs/chat/getting-started/react.md) provide a set of custom hooks that integrate seamlessly with React applications. These hooks manage the state and lifecycle of chat features, making it simple to build reactive chat interfaces that automatically update when new messages arrive or user presence changes.

## Demo

Take a look at a [livestream basketball game](https://ably-livestream-chat-demo.vercel.app) with some simulated users chatting built using the Chat SDK. The [source code](https://github.com/ably/ably-chat-js/tree/main/demo) is available in GitHub.

## Next steps 

* Read the [JavaScript / TypeScript getting started guide](https://ably.com/docs/chat/getting-started/javascript.md)
* Read the [React UI Kit getting started guide](https://ably.com/docs/chat/getting-started/react-ui-kit.md)
* Read more about using [rooms](https://ably.com/docs/chat/rooms.md) and sending [messages](https://ably.com/docs/chat/rooms/messages.md).
* Read into pulling messages from [history](https://ably.com/docs/chat/rooms/history.md) and providing context to new joiners.
* Learn about how to add [chat moderation](https://ably.com/docs/chat/moderation.md).
* Understand [token authentication](https://ably.com/docs/auth/token.md) before going to production.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
