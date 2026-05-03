# React UI Kit setup

Use these instructions to install, configure and instantiate the Chat React UI Kit.

<Aside data-type='note'>
If you have any feedback or feature requests, [let us know](https://forms.gle/SmCLNFoRrYmkbZSf8)
</Aside>

## Install 

The React UI Kit is built on top of the Ably Chat SDK and requires both the Ably Pub/Sub SDK and the Chat SDK to be installed.

### NPM 

Install the required packages:

<Code>

#### Shell

```
  npm install ably @ably/chat @ably/chat-react-ui-kit
```
</Code>

Import the packages into your project:

<Code>

#### React

```
  import * as Ably from 'ably';
  import { ChatClient } from '@ably/chat';
  import { ChatClientProvider } from '@ably/chat/react';
  import { App, ChatWindow, Sidebar, ThemeProvider, AvatarProvider, ChatSettingsProvider } from '@ably/chat-react-ui-kit';
  import '@ably/chat-react-ui-kit/dist/style.css';
```
</Code>

## Configure the Chat SDK 

To use the React UI Kit, you need to configure the Ably Chat client. This involves creating an instance of the `ChatClient` and passing it to the `ChatClientProvider`.

For more information on how to configure the Ably Chat client, see the [Ably Chat SDK documentation](https://ably.com/docs/chat/setup.md).

## Setup providers 

The React UI Kit relies on several context providers to function properly. These providers manage state, theming, avatars, and chat settings.

### Basic provider setup 

Set up the required providers in your application's entry point:

<Code>

#### React

```
  import * as Ably from 'ably';
  import { ChatClient } from '@ably/chat';
  import { ChatClientProvider } from '@ably/chat/react';
  import { ThemeProvider, AvatarProvider, ChatSettingsProvider } from '@ably/chat-react-ui-kit';
  import '@ably/chat-react-ui-kit/dist/style.css';

  // Create Ably Realtime client
  const ablyClient = new Ably.Realtime({
    key: 'your-api-key', // Replace with your Ably API key
    clientId: '<clientId>',
  });

  const chatClient = new ChatClient(ablyClient);

  ReactDOM.createRoot(document.getElementById('root')).render(
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

## Next steps 

Now that you have set up the React UI Kit, you can:

* Learn more about the available [Components](https://ably.com/docs/chat/react-ui-kit/components.md)
* Explore the [Providers and Hooks](https://ably.com/docs/chat/react-ui-kit/providers.md) for managing state
* Check out the [getting started guide](https://ably.com/docs/chat/getting-started/react-ui-kit.md) for a complete example

## Related Topics

- [Overview](https://ably.com/docs/chat/react-ui-kit.md): Learn more about the Ably Chat React UI Kit and how to use it to quickly build chat interfaces in your React applications.
- [Providers and Hooks](https://ably.com/docs/chat/react-ui-kit/providers.md): Comprehensive documentation for the Ably Chat React UI Kits providers and hooks
- [Components](https://ably.com/docs/chat/react-ui-kit/components.md): Comprehensive documentation for the Ably Chat React UI Kit.
- [Customisation](https://ably.com/docs/chat/react-ui-kit/component-styling.md): A guide to styling components in the Ably Chat React UI Kit with and without Tailwind CSS.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
