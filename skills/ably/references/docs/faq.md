# Pub/Sub FAQs

Answers to the most commonly asked questions about using Ably's platform and SDKs.

## SDK configuration 

FAQs related to SDK configuration and setup issues.

### How do I configure request timeouts? 

<If lang="javascript,nodejs">

The `realtimeRequestTimeout` option is implemented in the Ably Pub/Sub JavaScript SDK and functions as expected. However, the TypeScript declaration is missing in version 1.2.17, which means:

- The option won't appear in editor autocomplete
- TypeScript users will see a compiler error when attempting to use it

If you are using TypeScript, there are two solutions:

1. Cast your options to the `Types.ClientOptions` type:

<If lang="javascript">

<Code>

#### Javascript

```
import * as Ably from 'ably';

const client = new Ably.Realtime({
  realtimeRequestTimeout: 10000,
} as Ably.Types.ClientOptions);
```
</Code>

</If>
<If lang="nodejs">

<Code>

#### Nodejs

```
import * as Ably from 'ably';

const client = new Ably.Realtime({
  realtimeRequestTimeout: 10000,
} as Ably.Types.ClientOptions);
```
</Code>

</If>

If you are not using TypeScript, use the `realtimeRequestTimeout` option as normal. It may not appear in auto-completion but will work as expected.

2. Augment the `Ably.Types.ClientOptions` type (more scalable):

<If lang="javascript">

<Code>

#### Javascript

```
import * as Ably from 'ably';

// Place this in a separate .d.ts file or anywhere in your project
declare module 'ably' {
  namespace Types {
    interface ClientOptions {
      realtimeRequestTimeout: number;
    }
  }
}

const client = new Ably.Realtime({
  realtimeRequestTimeout: 10000,
});
```
</Code>

</If>
<If lang="nodejs">

<Code>

#### Nodejs

```
import * as Ably from 'ably';

// Place this in a separate .d.ts file or anywhere in your project
declare module 'ably' {
  namespace Types {
    interface ClientOptions {
      realtimeRequestTimeout: number;
    }
  }
}

const client = new Ably.Realtime({
  realtimeRequestTimeout: 10000,
});
```
</Code>

</If>

</If>

<If lang="java">

You can configure request timeouts using the `ClientOptions` when initializing the Ably client:

<Code>

#### Java

```
import io.ably.lib.realtime.AblyRealtime;
import io.ably.lib.types.ClientOptions;

ClientOptions options = new ClientOptions("your-api-key");
options.httpRequestTimeout = 10000; // 10 seconds in milliseconds
options.httpOpenTimeout = 4000;     // 4 seconds for connection establishment

AblyRealtime ably = new AblyRealtime(options);
```
</Code>

Available timeout options:
- `httpRequestTimeout`: Total request timeout including retries
- `httpOpenTimeout`: Connection establishment timeout
- `httpRetryTimeout`: Timeout for individual retry attempts

</If>

### Can I change my connection's clientId after connecting? 

A connection's [`clientId`](https://ably.com/docs/auth/identified-clients.md) is immutable once set.

However, late initialization of `clientId` is possible. For instance, if the library is instantiated with an [`authCallback`](https://ably.com/docs/auth/token/jwt.md#auth-callback), the `clientId` may only be known after the callback completes. Similarly, if the library uses an opaque token string, it learns the `clientId` only after the server processes the token. In both cases, the "immutable" requirement is satisfied because the `clientId` is set during the client's first interaction with the server.

## Connection and network issues 

FAQs related to connection problems and network troubleshooting.

### How should I monitor for errors in my Ably application? 

Ably SDKs provide mechanisms to notify you of errors, primarily through [connection state changes](https://ably.com/docs/connect/states.md) and [channel state changes](https://ably.com/docs/channels/states.md). The connection emits an event when its state changes. If it enters the `disconnected` or `failed` state, the change event includes a reason explaining the cause. In the `disconnected` state, the client automatically retries after 15 seconds. Channel states work analogously. Additionally, client libraries emit logs at the [ERROR level](https://ably.com/docs/platform/errors.md#format), which can usually be accessed programmatically via a custom log handler.

<If lang="javascript,nodejs">

The following example shows how to monitor for errors:

<If lang="javascript">

<Code>

#### Javascript

```
const ably = new Ably.Realtime('your-api-key');

// Monitor connection state changes
ably.connection.on('failed', (stateChange) => {
  console.error('Connection failed:', stateChange.reason);
  // Handle connection failure
});

ably.connection.on('disconnected', (stateChange) => {
  console.warn('Connection lost:', stateChange.reason);
  // Connection will automatically retry
});

// Monitor channel errors
const channel = ably.channels.get('my-channel');
channel.on('failed', (stateChange) => {
  console.error('Channel failed:', stateChange.reason);
});
```
</Code>

</If>
<If lang="nodejs">

<Code>

#### Nodejs

```
const ably = new Ably.Realtime('your-api-key');

// Monitor connection state changes
ably.connection.on('failed', (stateChange) => {
  console.error('Connection failed:', stateChange.reason);
  // Handle connection failure
});

ably.connection.on('disconnected', (stateChange) => {
  console.warn('Connection lost:', stateChange.reason);
  // Connection will automatically retry
});

// Monitor channel errors
const channel = ably.channels.get('my-channel');
channel.on('failed', (stateChange) => {
  console.error('Channel failed:', stateChange.reason);
});
```
</Code>

</If>

</If>

<If lang="java">

The following example shows how to monitor for errors:

<Code>

#### Java

```
import io.ably.lib.realtime.AblyRealtime;
import io.ably.lib.realtime.ConnectionStateListener;
import io.ably.lib.types.ConnectionState;
import io.ably.lib.types.ErrorInfo;

AblyRealtime ably = new AblyRealtime("your-api-key");

// Monitor connection state changes
ably.connection.on(new ConnectionStateListener() {
    @Override
    public void onConnectionStateChanged(ConnectionStateChange stateChange) {
        if (stateChange.current == ConnectionState.failed) {
            System.err.println("Connection failed: " + stateChange.reason);
            // Handle connection failure
        } else if (stateChange.current == ConnectionState.disconnected) {
            System.out.println("Connection lost: " + stateChange.reason);
            // Connection will automatically retry
        }
    }
});

// Monitor channel errors
Channel channel = ably.channels.get("my-channel");
channel.on(new ChannelStateListener() {
    @Override
    public void onChannelStateChanged(ChannelStateChange stateChange) {
        if (stateChange.current == ChannelState.failed) {
            System.err.println("Channel failed: " + stateChange.reason);
        }
    }
});
```
</Code>

</If>

A non-2xx status code on an HTTP request is not a reliable error indicator. Many factors, such as imperfect network connections, can cause HTTP errors, and only a small fraction represent actual problems.

For example, when using Comet, if a token expires and cannot reauthenticate online in time, the recv stream closes with a 401 status code and an `errorinfo` body with code [40142](https://ably.com/docs/platform/errors/codes.md#40142). This is expected behavior: it simply triggers the library to obtain a new token and resume the connection. Conversely, many actual problems (errors sent as protocol messages over a `WebSocket`) do not appear as non-2xx HTTP requests.

The protocol uses the most semantically appropriate status code for each response (like 401 for an expired token) rather than avoiding non-2xx responses.

Do not monitor HTTP status codes to detect problems. Instead, use the SDKs' built-in mechanisms, particularly connection state changes.

### Why are my concurrent connection counts higher than expected? 

This FAQ addresses common reasons for higher-than-expected concurrent connections:

The following are potential issues you may encounter:
- Using the Realtime library server-side instead of the REST library.
- Accidentally instantiating multiple Realtime client library instances.
- Browser tab sandboxing causing separate connections per tab.

If you encounter problems, try the following troubleshooting steps:
- Monitor connections using the developer console.
- Contact support with diagnostic information.

Be aware that significantly exceeding package limits may result in account blocking.

### SSL certificate issues communicating with Ably 

If you're experiencing SSL/TLS certificate validation errors when connecting to Ably's services, this is often related to outdated certificate stores or network configuration.

Some common errors you might see include:
- `cURL error: SSL certificate problem: self signed certificate in certificate chain`
- `SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed`
- `SSL: CERTIFICATE_VERIFY_FAILED certificate verify failed: unable to get local issuer certificate`


### Debugging slow REST requests 

If you experience slow REST requests, consider the following causes:

Latency-based routing may occasionally direct requests to the wrong datacenter.

To investigate, run `curl http://rest.ably.io/404` on the affected machine. The 404 error will include the server ID and AWS region. Check if the region is geographically close.

Establishing a TLS connection involves a three-way handshake, which can compound high latency.

To investigate, run the following curl command to measure timing:

<Code>

#### Shell

```
curl -o /dev/null -s -w "time_namelookup: %{time_namelookup}
time_connect: %{time_connect}
time_appconnect: %{time_appconnect}
time_pretransfer: %{time_pretransfer}
time_redirect: %{time_redirect}
time_starttransfer: %{time_starttransfer}
time_total: %{time_total}" \
https://rest.ably.io/time
```
</Code>

Repeat with `http://rest.ably.io/time` (non-SSL). The `time_appconnect` result indicates the SSL handshake duration. Note that client libraries use HTTP keep-alive, so the handshake occurs only once for multiple requests in close proximity.

Publishing to a previously inactive channel requires a handshake with other regions, adding latency. The `quickAck` option can help by not waiting for channel creation.

REST publishes have higher latency than realtime publishes because they authenticate and check capabilities for every request.

For lower latency, use a realtime client library. Realtime libraries maintain a persistent WebSocket connection, performing handshakes and capability checks only once.

## Message handling 

FAQs related to message publishing, subscribing, and duplication issues.

### Why am I seeing every message multiple times? 

If your message listener is called multiple times for every message, it is likely due to one of two causes:

You may be instantiating the Realtime library more than once on a single page and subscribing to the same [channels](https://ably.com/docs/channels.md) with both. You should typically have a single library instance per app, as one connection can multiplex hundreds of channels. Ensure you instantiate the library once and share the reference.

You may be calling [`channel#subscribe`](https://ably.com/docs/pub-sub.md#subscribe) multiple times with the same listener. For example, if you call `subscribe()` inside a connected event listener, it will execute every time the connection state becomes connected (which may happen repeatedly on unstable networks).

<If lang="javascript,nodejs">

The following example shows incorrect code:

<If lang="javascript">
<Code>

#### Javascript

```
// WRONG
realtime.connection.on('connected', () => {
  channel.subscribe(msg => console.log('received: ' + msg.name))
});
```
</Code>
</If>
<If lang="nodejs">
<Code>

#### Nodejs

```
// WRONG
realtime.connection.on('connected', () => {
  channel.subscribe(msg => console.log('received: ' + msg.name))
});
```
</Code>
</If>

The following example shows the correct approach using `once`:

<If lang="javascript">
<Code>

#### Javascript

```
// BETTER
realtime.connection.once('connected', () => {
  channel.subscribe(msg => console.log('received: ' + msg.name))
});
```
</Code>
</If>
<If lang="nodejs">
<Code>

#### Nodejs

```
// BETTER
realtime.connection.once('connected', () => {
  channel.subscribe(msg => console.log('received: ' + msg.name))
});
```
</Code>
</If>

Alternatively, call `subscribe()` at the top level instead of inside an on-connected callback.

</If>

<If lang="java">

The following Java example shows incorrect code:

<Code>

#### Java

```
// WRONG
ably.connection.on(new ConnectionStateListener() {
    @Override
    public void onConnectionStateChanged(ConnectionStateChange stateChange) {
        if (stateChange.current == ConnectionState.connected) {
            channel.subscribe(new MessageListener() {
                @Override
                public void onMessage(Message message) {
                    System.out.println("Received: " + message.name);
                }
            });
        }
    }
});
```
</Code>

Java - Correct Code (subscribe outside connection listener):

<Code>

#### Java

```
// BETTER
channel.subscribe(new MessageListener() {
    @Override
    public void onMessage(Message message) {
        System.out.println("Received: " + message.name);
    }
});
```
</Code>

Or use a flag to ensure single subscription:

<Code>

#### Java

```
// ALTERNATIVE
private boolean isSubscribed = false;

ably.connection.on(new ConnectionStateListener() {
    @Override
    public void onConnectionStateChanged(ConnectionStateChange stateChange) {
        if (stateChange.current == ConnectionState.connected && !isSubscribed) {
            channel.subscribe(new MessageListener() {
                @Override
                public void onMessage(Message message) {
                    System.out.println("Received: " + message.name);
                }
            });
            isSubscribed = true;
        }
    }
});
```
</Code>

</If>

Be aware that a bug in the Ably Pub/Sub Java SDK (v1.2.34 to 1.2.47) caused message duplication when using the rewind channel option.

### What is the difference between 'failed' and 'refused' message statistics? 

Refused messages are actively rejected by Ably. This is typically due to breaching a rate limit, a malformed message, or the client lacking permissions to publish to the channel.

Failed messages fail for reasons other than active rejection. Examples include service issues or rejection by an external target (Integrations or Push notifications).

All rejections from external systems appear as failed statistics, as Ably cannot distinguish between expected and unexpected external rejections.

## Platform-specific issues 

FAQs related to specific platforms and environments.

### Can I use Ably with a state manager? 

You can create and manage the Ably client external to your application, and use a state management solution like [Redux](https://redux.js.org/) to emit events. While this is probably more complicated, you could [subscribe to channels](https://ably.com/docs/pub-sub.md#subscribe), and raise events in your state management store, and have the store cascade these events to the other components in your application that are connected to the store.

<If lang="javascript">

### How do I fix CORB errors when using the Ably Pub/Sub JavaScript SDK in Chrome extensions? 

<If lang="javascript,nodejs">

Chrome 73 changed how cross-origin requests from content scripts are handled. While intended to align content scripts with their parent pages, the implementation enforces stricter rules. Requests from content scripts do not trigger a `CORS` preflight for cross-origin requests, whereas the same request from the page would. This causes `CORB` to block the main request.

You can resolve this in two ways:

1. Run the Ably library in the background script instead of the content script.

2. If you must run the library in the content script, request the background page to handle REST requests ([token authentication](https://ably.com/docs/api/realtime-sdk/authentication.md)). Instead of using `authUrl`, supply an `authCallback` that asks the background page to request a token. Ensure your auth server calls `requestToken` rather than `createTokenRequest` to avoid the library attempting a REST request.

Specify `transports: ['web_socket']` in the client options, as the default XHR transport may fail.

The following example demonstrates this configuration:

<If lang="javascript">

<Code>

#### Javascript

```
// Example: Chrome extension configuration
const ably = new Ably.Realtime({
  key: 'your-api-key',
  transports: ['web_socket'], // Avoid XHR transport
  authCallback: async (tokenParams, callback) => {
    // Proxy auth through background script
    chrome.runtime.sendMessage({
      action: 'getAblyToken',
      tokenParams: tokenParams
    }, (response) => {
      callback(null, response.token);
    });
  }
});
```
</Code>

</If>
<If lang="nodejs">

<Code>

#### Nodejs

```
// Example: Chrome extension configuration
const ably = new Ably.Realtime({
  key: 'your-api-key',
  transports: ['web_socket'], // Avoid XHR transport
  authCallback: async (tokenParams, callback) => {
    // Proxy auth through background script
    chrome.runtime.sendMessage({
      action: 'getAblyToken',
      tokenParams: tokenParams
    }, (response) => {
      callback(null, response.token);
    });
  }
});
```
</Code>

</If>

</If>

### Can I ignore the 'long timer' warning with the Ably Pub/Sub JavaScript SDK in React Native Android? 

The Ably Pub/Sub JavaScript SDK uses timers of up to two minutes (for connection state recovery). Some React Native versions on Android warn about timers longer than 60 seconds because Android may not call JavaScript timers when the activity is in the background. React Native uses a heuristic that suggests long timers might be critical (alarms) and should fire even in the background.


### Why do Ably connections timeout immediately in React Native? 

If a realtime connection immediately transitions from connecting to disconnected with the reason "Connection to server temporarily unavailable", the device time may be incorrect. This often occurs in emulators or debug mode, where `setTimeout` can break.

To diagnose this issue:
Run `setTimeout(() => console.log("done"), 10000)`. If it prints "done" immediately instead of after 10 seconds, you have this issue.

### How do I fix 'Cannot read properties of undefined' in Next.js? 

This issue is documented in [Next.js issue 58623](https://github.com/vercel/next.js/issues/58623). Resolve it by upgrading Next.js to version 14.0.4.

</If>


<If lang="java">

### How do I handle network changes on Android? 

Android devices frequently change networks (WiFi to mobile data, etc.). The Ably Pub/Sub Java SDK handles this automatically, but you may want to monitor network state changes:

<Code>

#### Java

```
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

public class NetworkStateReceiver extends BroadcastReceiver {
    private AblyRealtime ably;

    public NetworkStateReceiver(AblyRealtime ably) {
        this.ably = ably;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        ConnectivityManager cm = (ConnectivityManager)
            context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo activeNetwork = cm.getActiveNetworkInfo();

        if (activeNetwork != null && activeNetwork.isConnected()) {
            // Network is available - Ably will automatically reconnect
            Log.d("Ably", "Network available");
        } else {
            // Network lost - connection will be handled by Ably SDK
            Log.d("Ably", "Network lost");
        }
    }
}

// Register the receiver in your Activity
IntentFilter filter = new IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION);
NetworkStateReceiver receiver = new NetworkStateReceiver(ably);
registerReceiver(receiver, filter);
```
</Code>

### How do I handle ProGuard obfuscation issues? 

When using `ProGuard` with the Ably Android SDK, certain classes need to be preserved from obfuscation:

<Code>

#### Java

```
# Ably SDK ProGuard rules
-keep class io.ably.lib.** { *; }
-keep class org.msgpack.core.** { *; }

# If using push notifications
-keep class com.google.firebase.** { *; }
-keep class io.ably.lib.push.** { *; }

# Preserve WebSocket classes
-keep class okhttp3.** { *; }
-keep class okio.** { *; }
```
</Code>

</If>

## Installation and build issues 

FAQs related to installation and build problems.

<If lang="javascript,nodejs">

### How do I fix git errors when installing the Ably Pub/Sub JavaScript SDK with npm? 

If you encounter this error when installing the Ably Pub/Sub JavaScript SDK with npm: `Error while executing: /usr/bin/git ls-remote -h -t https://github.com/ably-forks/msgpack-js.git`

First, test which git protocol works by running these commands:

<Code>

#### Shell

```
git ls-remote -h -t git://github.com/ably-forks/msgpack-js.git
git ls-remote -h -t https://github.com/ably-forks/msgpack-js.git
```
</Code>

If the first command succeeds but the second fails, configure git to use the git protocol instead of HTTPS:

<Code>

#### Shell

```
git config --global url."git://".insteadOf https://
```
</Code>

After configuring git, retry the SDK installation.

### How do I resolve webpack/bundler issues with Ably Pub/Sub JavaScript SDK? 

Configure your bundler to handle Node.js dependencies that the Ably SDK requires.

If you're using Webpack 5, add the following configuration:

<If lang="javascript">

<Code>

#### Javascript

```
// webpack.config.js
module.exports = {
  resolve: {
    fallback: {
      "buffer": require.resolve("buffer/"),
      "url": require.resolve("url/"),
      "util": require.resolve("util/")
    }
  },
  plugins: [
    new webpack.ProvidePlugin({
      Buffer: ['buffer', 'Buffer'],
    }),
  ]
};
```
</Code>

</If>
<If lang="nodejs">

<Code>

#### Nodejs

```
// webpack.config.js
module.exports = {
  resolve: {
    fallback: {
      "buffer": require.resolve("buffer/"),
      "url": require.resolve("url/"),
      "util": require.resolve("util/")
    }
  },
  plugins: [
    new webpack.ProvidePlugin({
      Buffer: ['buffer', 'Buffer'],
    }),
  ]
};
```
</Code>

</If>

If you're using Vite, use this configuration:

<If lang="javascript">

<Code>

#### Javascript

```
// vite.config.js
import { defineConfig } from 'vite'

export default defineConfig({
  define: {
    global: 'globalThis',
  }
})
```
</Code>

</If>
<If lang="nodejs">

<Code>

#### Nodejs

```
// vite.config.js
import { defineConfig } from 'vite'

export default defineConfig({
  define: {
    global: 'globalThis',
  }
})
```
</Code>

</If>

</If>

<If lang="java">

### ClassNotFoundException when using Proguard with ably-java 

When using Proguard with the Java client library, use the following flags to avoid `ClassNotFoundException` issues:

<Code>

#### Java

```
-keep class io.ably.lib.** { *; }
-keep class org.msgpack.core.** { *; }
```
</Code>

### How do I resolve Gradle build issues? 

Common Gradle build issues with the Ably Android SDK can often be resolved with the following configurations.

The following configuration resolves dependency conflicts:

<Code>

#### Java

```
// In your app's build.gradle
android {
    packagingOptions {
        pickFirst '**/libc++_shared.so'
        pickFirst '**/libjsc.so'
    }
}

dependencies {
    implementation 'io.ably:ably-android:1.2.0'

    // If you have conflicts with WebSocket libraries
    configurations.all {
        exclude group: 'org.java-websocket', module: 'Java-WebSocket'
    }
}
```
</Code>

The following configuration addresses MultiDex issues:

<Code>

#### Java

```
// Enable MultiDex if you hit the 64K method limit
android {
    defaultConfig {
        multiDexEnabled true
    }
}

dependencies {
    implementation 'androidx.multidex:multidex:2.0.1'
}
```
</Code>

</If>

## Related Topics

- [Push notifications](https://ably.com/docs/faq/push-faqs.md): Frequently asked questions about Ably's push notification service, including debugging, configuration, and troubleshooting guides.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
