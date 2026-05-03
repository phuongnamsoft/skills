# Basic auth

Basic authentication is the simplest way to authenticate with Ably. It requires passing an [API key](https://ably.com/docs/auth.md#api-key) when instancing an SDK.

<Aside data-type='important'>
Private API keys should never be shared with untrusted parties, and as such, should only be used by your trusted secure servers when authenticating with Ably.
</Aside>

The following is an example of using basic authentication:

<Code>

#### Realtime Javascript

```
const realtime = new Ably.Realtime({
  key: 'your-api-key'
});
```

#### Rest Javascript

```
var rest = new Ably.Rest({ key: 'your-api-key' });
```

#### Realtime Nodejs

```
const realtime = new Ably.Realtime({
  key: 'your-api-key'
});
```

#### Rest Nodejs

```
var rest = new Ably.Rest({ key: 'your-api-key' });
```

#### Realtime Ruby

```
realtime = Ably::Realtime.new(key: 'your-api-key')
```

#### Rest Ruby

```
rest = Ably::Rest.new(key: 'your-api-key')
```

#### Realtime Python

```
realtime = AblyRealtime(key='your-api-key')
```

#### Rest Python

```
rest = AblyRest(key='your-api-key')
```

#### Realtime Java

```
ClientOptions options = new ClientOptions();
options.key = "your-api-key";
AblyRealtime realtime = new AblyRealtime(options);
```

#### Rest Java

```
ClientOptions options = new ClientOptions();
options.key = "your-api-key";
AblyRest rest = new AblyRest(options);
```

#### Realtime Swift

```
let realtime = ARTRealtime(key: "your-api-key")
```

#### Rest Swift

```
let rest = ARTRest(key: "your-api-key")
```

#### Realtime Objc

```
ARTRealtime *realtime = [[ARTRealtime alloc] initWithKey:@"your-api-key"];
```

#### Rest Objc

```
ARTRest *rest = [[ARTRest alloc] initWithKey:@"your-api-key"];
```

#### Realtime Csharp

```
AblyRealtime realtime = new AblyRealtime("your-api-key");
```

#### Rest Csharp

```
AblyRest rest = new AblyRest("your-api-key");
```

#### Realtime Go

```
client, err := ably.NewRealtime(ably.WithKey("your-api-key"))
```

#### Rest Go

```
client, err := ably.NewREST(ably.WithKey("your-api-key"))
```

#### Realtime Flutter

```
final clientOptions = ably.ClientOptions(
  key: 'your-api-key'
);
final realtime = ably.Realtime(options: clientOptions);
```

#### Rest Flutter

```
final clientOptions = ably.ClientOptions(
  key: 'your-api-key'
);
ably.Rest rest = ably.Rest(options: clientOptions);
```

#### Rest Php

```
$rest = new Ably\AblyRest(['key' => 'your-api-key']);
```
</Code>

## Basic auth architecture 

The process used by Ably SDKs to authenticate with Ably using basic authentication is illustrated in the following diagram:

![Basic authentication process diagram](https://raw.githubusercontent.com/ably/docs/main/src/images/content/diagrams/Ably-API-Auth1.png)

## When to use basic auth 

Ably recommends that basic authentication is only used server-side because of the following potential issues:

* The secret is passed directly by the client to Ably, so it is only permitted for connections that are over TLS, to prevent the key secret being intercepted.
* All of the configured [capabilities](https://ably.com/docs/auth/capabilities.md) of the key are implicitly possible in any request, and clients that legitimately obtain this key may then abuse the rights for that key.
* A client that authenticates using an API key can claim any client ID it chooses. Therefore this client ID cannot be trusted to represent the genuine identity of the client. Client IDs should be assigned by the server, once the client's credentials have been authenticated.

<Aside data-type='note'>
When selecting an Ably SDK for implementing basic authentication with Ably, you don't need to use the realtime interface.

As basic authentication is primarily designed for authenticating a secure server, it is more efficient to use the REST interface of an Ably SDK. This is because the overhead associated with maintaining a realtime connection is not required. However, this is only true when the server is used solely for authentication.
</Aside>

## Related Topics

- [Overview](https://ably.com/docs/auth.md): Ably supports two main authentication schemes: basic authentication and token authentication. Token authentication can be implemented using JWTs, Ably tokens, and Ably token requests.
- [Token revocation](https://ably.com/docs/auth/revocation.md): Token revocation is a mechanism that enables an app to invalidate authentication tokens.
- [Identified clients](https://ably.com/docs/auth/identified-clients.md): Clients can be allocated a client ID to help control their operations and interactions with Ably channels.
- [Capabilities](https://ably.com/docs/auth/capabilities.md): Capabilities define which operations can be carried out on which channels by a client.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
