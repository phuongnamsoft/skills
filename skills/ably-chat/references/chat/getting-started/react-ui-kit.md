# Getting started: Chat UI Kit for React

This guide shows you how to add the Ably Chat React UI Kit to a brand-new React app built with Vite.

You'll create Ably clients, install the UI component package, and build a complete chat interface. You'll also cover customizing the look and feel with your own styles, settings, and avatars.

<Aside data-type='note'>
Using an AI coding assistant? [Teach it Ably](https://ably.com/docs/platform/ai-llms.md#agent-skills) with Agent Skills for all popular AI coding agents. Run `claude plugin add ably/agent-skills` or `npx skills add ably/agent-skills` to get started.
</Aside>

## Prerequisites 

1. Sign up for an Ably account.

2. Create a [new app](https://ably.com/accounts/any/apps/new), and get your first API key. You can use the root API key that is provided by default, within the **API Keys** tab to get started.

### Create a new project 

1. Scaffold a **React + TypeScript** project with Vite:

<Code>

#### Shell

```
  npm create vite@latest my-chat-ui-app -- --template react-ts
  cd my-chat-ui-app
  ```
</Code>

2. (Optional) Add Tailwind CSS if you want utility classes elsewhere in your app. The UI Kit itself ships pre-compiled CSS, so Tailwind isn't required:

<Code>

#### Shell

```
  npm install -D tailwindcss postcss autoprefixer
  npx tailwindcss init -p
  ```
</Code>

Follow the Tailwind Vite guide to configure the generated files.

3. Install the Chat UI Kit and its peers:

<Code>

#### Shell

```
  npm install ably @ably/chat @ably/chat-react-ui-kit

  # Ensure React 19 is present (Vite template already has these)
  npm install react react-dom
  ```
</Code>

4. Create a `.env` file in your project root and add your API key:

<Code>

#### Shell

```
echo "ABLY_API_KEY=your-api-key" > .env
```
</Code>

That's all the setup you need—the kit's CSS is automatically bundled by Vite alongside the rest of your styles.

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

## Usage 

The components and their stylesheet can be imported into your React applications like so:

<Code>

### React

```
  // App.tsx
  import { App, ChatWindow, Sidebar, RoomInfo, AppLayout } from '@ably/chat-react-ui-kit';
  import '@ably/chat-react-ui-kit/dist/style.css';
  ```
</Code>

The `@ably/chat-react-ui-kit/dist/style.css` file contains all the necessary styles for the components, compiled from the Tailwind utility classes used in the component code.

### Providers setup 

ably-chat-react-ui-kit relies on the same React context providers as the underlying Chat SDK, plus a few extras for theming and avatars.

#### Basic provider setup 

In your main entry file (e.g. `main.tsx`), replace the content with the following code to set up the providers:

<Code>

##### React

```
  // main.tsx
  import * as Ably from 'ably';
  import { ChatClient } from '@ably/chat';
  import { ChatClientProvider } from '@ably/chat/react';
  import { ThemeProvider, AvatarProvider, ChatSettingsProvider } from '@ably/chat-react-ui-kit';
  import '@ably/chat-react-ui-kit/dist/style.css';

  // Create Ably Realtime client
  const ablyClient = new Ably.Realtime({
    key: process.env.ABLY_API_KEY,
    clientId: 'your-chat-client-id',
  });

  const chatClient = new ChatClient(ablyClient);

  ReactDOM.createRoot(document.querySelector('#root') || document.createElement('div')).render(
    <React.StrictMode>
      <ThemeProvider>
        <AvatarProvider>
          <ChatSettingsProvider>
            <ChatClientProvider client={chatClient}>
              {/* Your components will go here */}
            </ChatClientProvider>
          </ChatSettingsProvider>
        </AvatarProvider>
      </ThemeProvider>
    </React.StrictMode>
  );
  ```
</Code>

The components you make throughout this guide will be wrapped in these providers to ensure they have access to the necessary context.

In production, you should use [token authentication](https://ably.com/docs/auth/token.md) to avoid exposing your API keys publicly, the [`clientId`](https://ably.com/docs/auth/identified-clients.md) is used to identify the client.

### Provider responsibilities 

* **`ChatClientProvider`** – supplies the Ably Chat client so child components can publish, subscribe, and manage rooms
* **`ThemeProvider`** – toggles light/dark mode and optionally stores the preference (`persist: true`)
* **`AvatarProvider`** – generates and caches user / room avatars
* **`ChatSettingsProvider`** – provides a place to store and retrieve chat settings that control the UI, such as enabling message editing or reactions
* **`ChatRoomProvider`** – provides the chat room context for components that operate on a specific room, such as the `ChatWindow`, `TypingIndicators` and `RoomInfo` components

## Building your chat interface 

Let's build up a complete chat interface step by step, starting with individual components and working up to a full application.

### ChatWindow component 

The `ChatWindow` component provides the main chat interface for a room.
It handles everything related to messages - display, editing, deletion, reactions, history and realtime updates.

**Features:**
- Message display with history loading and infinite scroll
- Message editing, deletion, and reactions
- Typing indicators and presence awareness
- Custom header and footer content areas
- Discontinuity recovery on reconnection
- Configurable message window size for performance

**Requirements:** Must be wrapped in `ChatRoomProvider`, `AvatarProvider`, and `ChatSettingsProvider`. The settings provider controls which message actions (update/delete/react) are available.

Create a simple file called `App.tsx` with the following content:

<Code>

// App.tsx
  #### React

```
  import { ChatWindow } from '@ably/chat-react-ui-kit';
  import { ChatRoomProvider } from '@ably/chat/react';

  export function ChatApp() {
    return (
      <div className="bg-gray-50 rounded-lg border">
        <div
          className="overflow-hidden border rounded-lg flex"
          style={{ width: '70vw', height: '70vh' }}
        >
          <ChatRoomProvider name="my-first-room">
            <ChatWindow roomName="my-first-room" enableTypingIndicators={true} />
          </ChatRoomProvider>
        </div>
      </div>
    );
  }
  ```
</Code>

Now import the `ChatApp` component in your `main.tsx` file and render it within the providers:

<Code>

#### React

```
  // main.tsx
  import React from 'react';
  import ReactDOM from 'react-dom/client';
  import * as Ably from 'ably';
  import { ChatClient } from '@ably/chat';
  import { ChatClientProvider } from '@ably/chat/react';
  import { ThemeProvider, AvatarProvider, ChatSettingsProvider } from '@ably/chat-react-ui-kit';
  import '@ably/chat-react-ui-kit/dist/style.css';
  import { ChatApp } from './App.tsx'; // Assuming your app.tsx is in the same directory

  const ablyClient = new Ably.Realtime({
    key: process.env.ABLY_API_KEY,
    clientId: 'your-chat-client-id',
  });

  const chatClient = new ChatClient(ablyClient);

  ReactDOM.createRoot(document.querySelector('#root') || document.createElement('div')).render(
    <React.StrictMode>
      <ThemeProvider>
        <AvatarProvider>
          <ChatSettingsProvider>
            <ChatClientProvider client={chatClient}>
              <ChatApp />
            </ChatClientProvider>
          </ChatSettingsProvider>
        </AvatarProvider>
      </ThemeProvider>
    </React.StrictMode>
  );
  ```
</Code>

Typing indicators are enabled by default, but you can disable them by setting `enableTypingIndicators={false}`.

Try sending a message to the room, use the following command:

<Code>

#### Shell

```
ably rooms messages send my-first-room "Hello, world!" --clientId your-chat-client-id
  ```
</Code>

To simulate typing in the room, use the following command:

<Code>

#### Shell

```
ably rooms typing keystroke my-first-room --clientId your-chat-client-id
  ```
</Code>

![Chat window simple screenshot](https://raw.githubusercontent.com/ably/docs/main/src/images/content/chat/ui-component-chat-window-simple.png)

### Adding Room Information 

The `RoomInfo` component displays comprehensive information about a chat room. It shows the room avatar, live presence count, participant details, and typing indicators.

**Features:**
- Room avatar display with automatic generation.
- Live presence count badge showing active participants.
- Interactive hover tooltip with participant preview.
- Expandable participant list with detailed user information.
- In-place avatar with color and image customization via the `AvatarProvider`.
- Typing indicators built-in.
- Accessibility support with ARIA roles and keyboard navigation.

**Requirements:** Must be wrapped in both `ChatRoomProvider` and `AvatarProvider`.

Let's add the RoomInfo component to our chat window's header section, replace the content in `App.tsx` with the following code:

<Code>

#### React

```
  // App.tsx
  import { ChatWindow, RoomInfo } from '@ably/chat-react-ui-kit';
  import { ChatRoomProvider } from '@ably/chat/react';

  export function ChatApp() {
    return (
      <div className="bg-gray-50 rounded-lg border">
        <div
          className="overflow-hidden border rounded-lg flex"
          style={{ width: '70vw', height: '70vh' }}>
          <ChatRoomProvider name="my-first-room">
            <ChatWindow
              roomName="my-first-room"
              customHeaderContent={<RoomInfo />}
            />
          </ChatRoomProvider>
        </div>
      </div>
    );
  }
  ```
</Code>

The `RoomInfo` component will automatically display the room avatar, participant count, and typing indicators. You can customize its appearance by passing props like `roomAvatar`, `position`, and `className`.

<Code>

#### React

```
  <RoomInfo
    // Optional custom avatar data (overrides AvatarProvider)
    roomAvatar={{
      displayName: 'VIP Lounge',
      color: 'bg-green-500',
      initials: 'VL',
      src: 'https://example.com/vip-avatar.jpg',
    }}
    // Position for dropdown menus
    position={{ top: 60, left: 250 }}
    // Custom styling
    className="p-4 bg-blue-400 rounded-lg shadow-sm"
  />
  ```
</Code>

For now we will just use the defaults for the `RoomInfo` component.

Try using the Ably CLI to enter the rooms presence set, you should see this reflected in the RoomInfo component:

<Code>

#### Shell

```
  ably rooms presence enter my-first-room --clientId your-chat-client-id
  ```
</Code>

You can also use the CLI to simulate typing in the room too, which will show up in the RoomInfo component's typing indicators:

<Code>

#### Shell

```
 ably rooms typing keystroke my-first-room --clientId your-chat-client-id
  ```
</Code>

![Chat window with room info screenshot](https://raw.githubusercontent.com/ably/docs/main/src/images/content/chat/ui-component-chat-window-with-header.png)

### Adding Room Reactions 

The chat window also supports custom footer content, which can be used for additional controls like reactions. You can pass any React component as `customFooterContent`, e.g., the `RoomReaction` component.

To add the `RoomReaction` component, update your `App.tsx` file as follows:

<Code>

#### React

```
  // App.tsx
  import { ChatWindow, RoomInfo, RoomReaction } from '@ably/chat-react-ui-kit';
  import { ChatRoomProvider } from '@ably/chat/react';

  export function ChatApp() {
    return (
      <div className="bg-gray-50 rounded-lg border">
        <div
          className="overflow-hidden border rounded-lg flex"
          style={{ width: '70vw', height: '70vh' }}>
          <ChatRoomProvider name="my-first-room">
            <ChatWindow
              roomName="my-first-room"
              customHeaderContent={<RoomInfo />}
              customFooterContent={<RoomReaction />}
            />
          </ChatRoomProvider>
        </div>
      </div>
    );
  }
  ```
</Code>

Now try sending a thumbs up reaction to the room using the Ably CLI:

<Code>

#### Shell

```
  ably rooms reactions send my-first-room 👍 --clientId your-chat-client-id
  ```
</Code>

You should see the reaction appear on the screen as a small explosion animation.

![Chat window with room room reactions screenshot](https://raw.githubusercontent.com/ably/docs/main/src/images/content/chat/ui-component-chat-window-with-header-and-footer.png)

### Adding a Sidebar 

Now let's add a Sidebar component to our chat application. The Sidebar provides room navigation and management, allowing users to create, join, and leave rooms. It can be placed next to the ChatWindow to provide a complete chat interface.

**Features:**
- Collapsible interface with avatar-only mode
- Room creation and management
- Theme toggle integration
- Active room highlighting
- Room count display
- Automatic room attachment/detachment

The sidebar automatically manages room connections as users navigate. It also uses occupancy events to provide context about connected and present users in each room.

To add the Sidebar component, update your `App.tsx` file as follows:

<Code>

#### React

```
  // App.tsx
  import { ChatWindow, RoomInfo, RoomReaction, Sidebar } from '@ably/chat-react-ui-kit';
  import { ChatRoomProvider } from '@ably/chat/react';
  import { type RoomOptions } from '@ably/chat';
  import { useState, useCallback } from 'react';

  const DEFAULT_ROOM_OPTIONS: RoomOptions = {
    occupancy: { enableEvents: true },
  };

  export function ChatApp() {
    const [roomNames, setRoomNames] = useState<string[]>(['my-first-room', 'general', 'random']);
    const [activeRoom, setActiveRoom] = useState<string | undefined>('my-first-room');
    const [isSidebarCollapsed, setIsSidebarCollapsed] = useState(false);

    const addRoom = useCallback((name: string) => {
      setRoomNames((prev) => (prev.includes(name) ? prev : [...prev, name]));
      setActiveRoom(name);
    }, []);

    const leaveRoom = useCallback(
      (name: string) => {
        setRoomNames((prev) => {
          const next = prev.filter((n) => n !== name);
          if (next.length === 0) {
            setActiveRoom('');
          } else if (name === activeRoom) {
            setActiveRoom(next[0]);
          }
          return next;
        });
      },
      [activeRoom],
    );

    return (
      <div className="bg-gray-50 rounded-lg border">
        <div className="overflow-hidden border rounded-lg flex" style={{width: '70vw', height: '70vh'}}>
          {/* Sidebar */}
          <div className={`flex-shrink-0 ${isSidebarCollapsed ? 'w-16' : 'w-64'}`}>
            <Sidebar
              roomNames={roomNames}
              activeRoomName={activeRoom}
              addRoom={addRoom}
              defaultRoomOptions={DEFAULT_ROOM_OPTIONS}
              setActiveRoom={setActiveRoom}
              leaveRoom={leaveRoom}
              isCollapsed={isSidebarCollapsed}
              onToggleCollapse={() => setIsSidebarCollapsed(prev => !prev)}
            />
          </div>

          {/* Chat Window */}
          <div className="flex-1 overflow-hidden">
            {activeRoom ? (
              <ChatRoomProvider
                key={activeRoom}
                name={activeRoom}
                attach={false}
                release={false}
                options={DEFAULT_ROOM_OPTIONS}
              >
                <ChatWindow
                  roomName={activeRoom}
                  customHeaderContent={<RoomInfo />}
                  customFooterContent={<RoomReaction />}
                />
              </ChatRoomProvider>
            ) : (
              <div className="flex items-center justify-center h-full">
                <p>Select a room to start chatting</p>
              </div>
            )}
          </div>
        </div>
      </div>
    );
  }
  ```
</Code>

<Aside data-type="note">
  When using ChatWindow with Sidebar, set `attach={false}` and `release={false}` on the ChatRoomProvider. This prevents conflicts since the Sidebar automatically manages room connections. This limitation will be removed in a future update when RoomProviders become aware of shared references.
</Aside>

Now we have a complete chat interface with a sidebar for room navigation and a chat window for messaging.

![Chat window with sidebar screenshot](https://raw.githubusercontent.com/ably/docs/main/src/images/content/chat/ui-component-chat-window-with-sidebar.png)

### App component 

Finally, if you prefer a ready-to-use solution, the library provides an `App` component that combines all the components above with sensible defaults. This is great if you need to prototype quickly or see how everything fits together.

**Features:**
- Manages room state (adding, leaving, selecting rooms)
- Shows loading state when not connected
- Renders layout with Sidebar and ChatWindow
- Includes RoomInfo in header and RoomReaction in footer
- Handles connection status and error states

To use the `App` component, import it in your `main.tsx` file and render it within the providers:

<Code>

#### React

```
  // main.tsx
  import * as Ably from 'ably';
  import { ChatClient } from '@ably/chat';
  import { ChatClientProvider } from '@ably/chat/react';
  import React from 'react';
  import ReactDOM from 'react-dom/client';
  import {
    App,
    ThemeProvider,
    AvatarProvider,
    ChatSettingsProvider
  } from '@ably/chat-react-ui-kit';
  import '@ably/chat-react-ui-kit/dist/style.css';

  // Create Ably Realtime client
  const ablyClient = new Ably.Realtime({
    key: process.env.ABLY_API_KEY,
    clientId: 'your-chat-client-id',
  });

  const chatClient = new ChatClient(ablyClient);

  ReactDOM.createRoot(document.querySelector('#root') || document.createElement('div')).render(
    <React.StrictMode>
      <ThemeProvider options={{ persist: true, defaultTheme: 'light' }}>
        <AvatarProvider>
          <ChatSettingsProvider>
            <ChatClientProvider client={chatClient}>
              <App initialRoomNames={"my-first-room"}/>
            </ChatClientProvider>
          </ChatSettingsProvider>
        </AvatarProvider>
      </ThemeProvider>
    </React.StrictMode>
  );
  ```
</Code>

You should now see a fully functional chat application with a sidebar, chat window, room info, and reactions and an initial room already created.

![App component screenshot](https://raw.githubusercontent.com/ably/docs/main/src/images/content/chat/ui-component-app.png)

## Summary 

The kit is designed to be flexible and composable, allowing you to mix and match components as needed. You can also customize appearance and behavior using the context providers like `ThemeProvider`, `AvatarProvider`, and `ChatSettingsProvider`.

You can use the individual components like `RoomInfo`, `ChatWindow`, and `Sidebar` to create custom layouts and functionality, or you can use the complete `App` component for rapid prototyping of a full chat application.

The UI Kit is experimental and highly likely to change in future releases.

## Next steps 

Continue to explore the documentation with React as the selected language:

* Understand [token authentication](https://ably.com/docs/auth/token.md) before going to production.
* Read more about using [rooms](https://ably.com/docs/chat/rooms.md) and sending [messages](https://ably.com/docs/chat/rooms/messages.md).
* Find out more regarding [presence](https://ably.com/docs/chat/rooms/presence.md).
* Read into pulling messages from [history](https://ably.com/docs/chat/rooms/history.md) and providing context to new joiners.

Explore the [Ably CLI](https://www.npmjs.com/package/@ably/cli) further, or check out the [Chat JS API references](https://sdk.ably.com/builds/ably/ably-chat-js/main/typedoc/modules/chat-js.html) for additional functionality.

## Related Topics

- [Overview](https://ably.com/docs/chat/getting-started.md): Getting started with Ably Chat in your language or framework of choice. Learn how to send and receive messages, track online presence, fetch message history, implement typing indicators, among other features.
- [JavaScript](https://ably.com/docs/chat/getting-started/javascript.md): Get started with Ably's JavaScript Chat SDK. Build scalable, realtime chat applications using live chat APIs and realtime messaging.
- [React](https://ably.com/docs/chat/getting-started/react.md): A getting started guide for Ably Chat React that steps through some of the key features using React and Vite.
- [React Native](https://ably.com/docs/chat/getting-started/react-native.md): A getting started guide for Ably Chat React Native that steps through some of the key features using React Native.
- [Kotlin (Android)](https://ably.com/docs/chat/getting-started/android.md): A getting started guide for Ably Chat Android that steps through some of the key features using Jetpack Compose.
- [Kotlin (JVM)](https://ably.com/docs/chat/getting-started/jvm.md): A getting started guide for Ably Chat JVM that steps through some of the key features using Kotlin.
- [Swift](https://ably.com/docs/chat/getting-started/swift.md): A getting started guide for Ably Chat iOS that steps through some of the key features using SwiftUI with callback-based subscriptions.
- [Swift (AsyncSequence)](https://ably.com/docs/chat/getting-started/swift-async-sequence.md): A getting started guide for Ably Chat iOS that steps through some of the key features using SwiftUI with AsyncSequence for handling realtime events.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
