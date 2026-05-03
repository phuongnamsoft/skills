# React Hooks

Leverage the power of Ably in your React applications using idiomatic, easy-to-use React Hooks. This package enables you to:

* Subscribe to messages on Ably [channels](https://ably.com/docs/channels.md).
* Publish messages using the channel instances provided by hooks.
* Enter the [presence set](https://ably.com/docs/presence-occupancy/presence.md) on channels.
* Subscribe to presence updates on channels.
* Trigger presence updates.

The following hooks are available:

| Hook | Description |
|------|-------------|
| **[useChannel](#useChannel)** | The `useChannel` hook subscribes to a channel and receives messages from it |
| **[usePresence](#usePresence)** | The `usePresence` hook enters clients into the presence set |
| **[usePresenceListener](#usePresenceListener)** | The `usePresenceListener` hook subscribes to presence events on a channel |
| **[useConnectionStateListener](#useConnectionStateListener)** | The `useConnectionStateListener` hook attaches a listener to be notified of connection state changes in the Ably client |
| **[useChannelStateListener](#useChannelStateListener)** | The `useChannelStateListener` hook attaches a listener to be notified of channel state changes |
| **[useAbly](#useAbly)** | The `useAbly` hook grants access to the Ably client instance provided by the AblyProvider context |

All hooks manage the lifecycle of Ably SDK instances for you, ensuring that you [subscribe](https://ably.com/docs/pub-sub.md#subscribe) and [unsubscribe](https://ably.com/docs/pub-sub/advanced.md#unsubscribe) to channels and events when your React components re-render.

## Install 

Ably JavaScript SDK versions >= 1.2.44 include React Hook functionality as standard. You don't need to install any additional packages.

<Code>

### Shell

```
npm install --save ably
```
</Code>

<Aside note-type='note'>
React version 16.8 or above is required.
</Aside>

## Authenticate 

An [API key](https://ably.com/docs/auth.md#api-keys) is required to authenticate with Ably. API keys are used either to authenticate directly with Ably using [basic authentication](https://ably.com/docs/auth/basic.md), or to generate tokens for untrusted clients using [token authentication](https://ably.com/docs/auth/token.md).

[Sign up](https://ably.com/sign-up) to Ably to create an API key in the [dashboard](https://ably.com/dashboard) or use the [Control API](https://ably.com/docs/platform/account/control-api.md) to create an API programmatically.

<Aside data-type='important'>
The examples use [basic authentication](https://ably.com/docs/auth/basic.md) to demonstrate usage for convenience. In your own applications, basic authentication should never be used on the client-side as it exposes your Ably API key. Instead use [token authentication.](https://ably.com/docs/auth/token.md)
</Aside>

## Usage 

### Setting up the Ably Provider 

<Aside data-type='updated'>
The `AblyProvider` was updated in version 2.0. See the [migration guide](https://github.com/ably/ably-js/blob/main/docs/migration-guides/v2/react-hooks.md#rename-optional-id-field-to-ablyid) for details on upgrading from a previous version.
</Aside>

Use the `AblyProvider` component to connect to Ably. This component should be placed high up in your component tree, wrapping every component that needs to access Ably.

You can create your own client and pass it to the context provider:

<Code>

#### React

```
import * as Ably from 'ably';
import { AblyProvider } from 'ably/react';
import { createRoot } from 'react-dom/client';

const container = document.getElementById('root')!;
const root = createRoot(container);

const client = new Ably.Realtime({ key: '<API-key>', clientId: '<client-ID>' });

root.render(
  <AblyProvider client={client}>
    <App />
  </AblyProvider>
);
```
</Code>

#### Multiple clients 

If you need to use multiple Ably clients on the same page, you can keep your clients in separate `AblyProvider` components. If nesting AblyProviders, you can pass a string ID for each client as a property to the provider.

<Code>

##### React

```
root.render(
  <AblyProvider client={client} ablyId={'providerOne'}>
    <AblyProvider client={client} ablyId={'providerTwo'}>
      <App />
    </AblyProvider>
  </AblyProvider>
);
```
</Code>

### Channel Provider 

<Aside data-type='new'>
The `ChannelProvider` was added in version 2.0. See the [migration guide](https://github.com/ably/ably-js/blob/main/docs/migration-guides/v2/react-hooks.md#use-new-channelprovider-component) for details on upgrading from a previous version.
</Aside>

Use the `ChannelProvider` to define the [channels](https://ably.com/docs/channels.md) you want to use in other hooks.

<Code>

#### React

```
  <ChannelProvider channelName="your-channel-name">
    <Component />
  </ChannelProvider>
```
</Code>

You can also set [channel options](https://ably.com/docs/channels/options.md) in the `ChannelProvider` component:

The following is an example of setting the [rewind](https://ably.com/docs/channels/options/rewind.md) channel option:

<Code>

#### React

```
  <ChannelProvider channelName="your-channel-name" options={{ params: { rewind: '1' } }}>
    <Component />
  </ChannelProvider>
```
</Code>

Use `deriveOptions` to set a [subscription filter](https://ably.com/docs/pub-sub/advanced.md#subscription-filters) and only receive messages that satisfy a filter expression:

<Code>

#### React

```
const deriveOptions = { filter: 'headers.email == `"rob.pike@domain.com"` || headers.company == `"domain"`' }

return (
  <ChannelProvider channelName="your-channel-name" options={{ ... }} deriveOptions={deriveOptions}>
    <Component />
  </ChannelProvider>
)
```
</Code>

<Aside type='note'>
Be aware that you can only subscribe to channels created or retrieved from a filter expression. You cannot publish to them. Use the `publish` function of the [useChannel](#useChannel) hook to publish messages.
</Aside>

### useChannel 

The `useChannel` hook enables you to [subscribe to a channel](https://ably.com/docs/pub-sub.md#subscribe) and receive its messages. It can be combined with the React `useState` hook to maintain a list of messages in your app state.

<Code>

#### React

```
const [messages, updateMessages] = useState([]);
const { channel } = useChannel('your-channel-name', (message) => {
    updateMessages((prev) => [...prev, message]);
});
```
</Code>

You can also filter messages by providing a message name to the `useChannel` function:

<Code>

#### React

```
const { channel } = useChannel('your-channel-name', 'messageName', (message) => {
    console.log(message);
});
```
</Code>

Use the `publish` function to publish messages to the channel:

<Code>

#### React

```
const { publish } = useChannel("your-channel-name")
publish("test-message", { text: "message text" });
```
</Code>

### usePresence 

<Aside>
The `usePresence` hook was updated in version 2.0. See the [migration guide](https://github.com/ably/ably-js/blob/main/docs/migration-guides/v2/react-hooks.md#update-usage-of-the-usepresence-hook-which-has-been-split-into-two-separate-hooks) for details on upgrading from a previous version.
</Aside>

The `usePresence` hook enables you to [enter the presence set](https://ably.com/docs/presence-occupancy/presence.md#member-data).

<Code>

#### React

```
const { updateStatus } = usePresence('your-channel-name');

// Optionally pass a second argument to 'usePresence' to set a client's initial member data
const { updateStatus } = usePresence('your-channel-name', 'initialStatus');

// The `updateStatus` function can be used to update the presence data for the current client
updateStatus('newStatus');
```
</Code>

### usePresenceListener 

<Aside data-type='new'>
The `usePresenceListener` hook was added in version 2.0. See the [migration guide](https://github.com/ably/ably-js/blob/main/docs/migration-guides/v2/react-hooks.md#update-usage-of-the-usepresence-hook-which-has-been-split-into-two-separate-hooks) for details on upgrading from a previous version.
</Aside>

The `usePresenceListener` hook enables you to [subscribe to presence](https://ably.com/docs/presence-occupancy/presence.md#subscribe) events on a channel, notifying you when a user enters or leaves the presence set, or updates their member data.

<Code>

#### React

```
const { presenceData } = usePresenceListener('your-channel-name');

// Convert presence data to list items to render
const peers = presenceData.map((msg, index) => <li key={index}>{msg.clientId}: {msg.data}</li>);
```
</Code>

<Aside type='note'>
Fetching presence members is executed as an effect. It will load after your component renders for the first time.
</Aside>

### useConnectionStateListener 

The `useConnectionStateListener` hook enables you to attach a listener to be notified of [connection state](https://ably.com/docs/connect/states.md) changes. This can be useful for detecting when a client has lost its connection.

<Code>

#### React

```
useConnectionStateListener((stateChange) => {
  console.log(stateChange.current);  // the new connection state
  console.log(stateChange.previous); // the previous connection state
  console.log(stateChange.reason);   // if applicable, an error indicating the reason for the connection state change
});
```
</Code>

You can also pass a filter to only listen for specific connection states:

<Code>

#### React

```
useConnectionStateListener('failed', listener); // the listener only gets called when the connection state becomes failed
useConnectionStateListener(['failed', 'suspended'], listener); // the listener only gets called when the connection state becomes failed or suspended
```
</Code>

### useChannelStateListener 

The `useChannelStateListener` hook enables you to attach a listener to be notified of [channel state](https://ably.com/docs/channels/states.md) changes. This can be useful for detecting when a channel error has occurred.

<Code>

#### React

```
useChannelStateListener((stateChange) => {
  console.log(stateChange.current);  // the new channel state
  console.log(stateChange.previous); // the previous channel state
  console.log(stateChange.reason);   // if applicable, an error indicating the reason for the channel state change
});
```
</Code>

Similar to [useConnectionStateListener](#useConnectionStateListener), you can also pass in a filter to only listen to specific channel states:

<Code>

#### React

```
useChannelStateListener('failed', listener); // the listener only gets called when the channel state becomes failed
useChannelStateListener(['failed', 'suspended'], listener); // the listener only gets called when the channel state becomes failed or suspended
```
</Code>

### useAbly 

The `useAbly` hook enables access to the Ably client used by the [AblyProvider](#ably-provider) context. This can be used to access APIs which aren't available through the React Hooks submodule.

<Code>

#### React

```
const client = useAbly();
client.authorize();
```
</Code>

## Error handling 

When using Ably React Hooks, you may encounter errors. The [useChannel](#useChannel) and [usePresence](#usePresence) hooks return connection and channel errors, enabling you to handle them in your components.

<Code>

### React

```
const { connectionError, channelError } = useChannel('your-channel-name', messageHandler);
```
</Code>

## Related Topics

- [Basic pub-sub](https://ably.com/docs/pub-sub.md): Get a channel, subscribe clients to it, and publish messages to the channel.
- [Advanced pub-sub](https://ably.com/docs/pub-sub/advanced.md): Utilize advanced pub-sub features, such as, subscription filters and idempotent publishing.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
