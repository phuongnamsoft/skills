# Capabilities

API keys and Ably-compatible tokens, have a set of capabilities assigned to them that specify which operations (such as subscribe or publish) can be performed on which channels.

API keys are long-lived, secret and typically not shared with clients. API key capabilities are configured using the [dashboard](https://ably.com/dashboard), or using the [Control API](https://ably.com/docs/platform/account/control-api.md).

Ably-compatible tokens are designed to be shared with untrusted clients, are short-lived, and can be configured and issued programmatically. For restricting client access to channels, tokens provide far more flexibility and security than API key capabilities. See [selecting an authentication mechanism](https://ably.com/docs/auth.md#selecting-auth) to understand why token authentication is the preferred option in most scenarios.

### Capability changes and existing connections 

<Aside data-type='important'>
When you change a key's capabilities in the dashboard, existing connections using that key do **not** receive the updated capabilities immediately. Connections must be closed and re-opened to pick up the new capabilities.
</Aside>

Once created, it's best to think of keys and tokens as being immutable. To modify the permissions granted to existing connections, the recommended approach is to use [token authentication](https://ably.com/docs/auth/token.md) and issue the client a new token with the updated permissions you want them to have.

The one exception is if a key is revoked entirely, in which case all connections using that key (or a token derived from that key) will be forcibly terminated. See [token revocation](https://ably.com/docs/auth/revocation.md) for more information.

## Resource names and wildcards 

Capabilities are a map from resources to a list of [operations](#capability-operations). Each resource can match a single channel, for example, `channel`, or multiple channels using wildcards (`*`).

Wildcards can only replace whole segments (segments are delimited by `:`) of the resource name. A wildcard at the end of the name can arbitrarily replace many segments. For example:

* A resource of `*` will match any channel, but not queues and metachannels.
* A resource of `namespace:*` will match any channel in the `namespace` namespace, including `namespace:channel`, and `namespace:channel:other`.
* A resource of `foo:*:baz` will match `foo:bar:baz`, but not `foo:bar:bam:baz`.
* A resource of `foo:*` will match expressions such as `foo:bar`, `foo:bar:bam`, `foo:bar:bam:baz`, as the wildcard is at the end.
* A resource of `foo*` (without a colon) will only match the single channel literally called `foo*`.

A resource can also be a queue, in which case it will start with `[queue]`, for example `[queue]appid-queuename`. This is unambiguous as channel names may not begin with a `[`. Similar wildcard rules apply, for example `[queue]*` will match all queues.

A resource can also be a metachannel, in which case it will start with `[meta]`, for example `[meta]metaname`. This is unambiguous as channel names may not begin with a `[`.  `[meta]*` will match all metachannels. Just `*` on its own will not: it will match all possible normal channels, but no metachannels.

You can also have a resource name of `[*]*`, which will match all queues, all metachannels, and all channels.

Wildcards are also supported for [operations](#capability-operations), by requesting an operations list of `['*']`.

## Capability operations 

The following capability operations are available for API keys and issued tokens:

| Operation | Description |
|-----------|-------------|
| **subscribe** | Can subscribe to messages, objects, and presence state change messages on channels, and get the presence set of a channel |
| **publish** | Can publish messages to channels |
| **presence** | Can register presence on a channel (enter, update and leave) |
| **object-subscribe** | Can subscribe to updates to objects on a channel |
| **object-publish** | Can update objects on a channel |
| **annotation-subscribe** | Can subscribe to individual annotations on a channel |
| **annotation-publish** | Can publish annotations to messages on a channel |
| **message-update-own** | Can [update messages](https://ably.com/docs/messages/updates-deletes.md) where the original publisher's `clientId` matches the updater's `clientId` |
| **message-update-any** | Can [update any message](https://ably.com/docs/messages/updates-deletes.md) on the channel |
| **message-delete-own** | Can [delete messages](https://ably.com/docs/messages/updates-deletes.md) where the original publisher's `clientId` matches the deleter's `clientId` |
| **message-delete-any** | Can [delete any message](https://ably.com/docs/messages/updates-deletes.md) on the channel |
| **history** | Can retrieve message and presence state history on channels |
| **stats** | Can retrieve current and historical usage statistics for an app |
| **push-subscribe** | Can subscribe devices for push notifications |
| **push-admin** | Can manage device registrations and push subscriptions for all devices in an app |
| **channel-metadata** | Can get metadata for a channel, and enumerate channels |
| **privileged-headers** | Can set data in the privileged section of the [message extras](https://ably.com/docs/api/realtime-sdk/messages.md#extras) |

Although most capabilities need to be enabled for the resource you're using them with, there are exceptions. The `stats` permission only does something when attached to the wildcard resource `'*'`, or a resource that contains that as a subset, such as `'[*]*'`, since stats are app-wide.

## Channel access control 

Ably does not provide numeric limits on channel access. Control channel access using token authentication and capabilities.

Channel access is controlled through:

* [Token authentication](https://ably.com/docs/auth/token.md) to restrict access by issuing tokens with specific capabilities to authorized users.
* Specific `clientId` values in tokens to ensure only certain users can access particular channels.
* Granting or restricting specific operations (`subscribe`, `publish`, `presence`) on channels through capability configurations.

For private messaging or group chats, design channel naming strategies and use token authentication to ensure users receive tokens with access only to relevant channels.

The `channel-metadata` permission works both ways. When associated with a specific channel or set of channels it allows you to [query the metadata of a channel](https://ably.com/docs/metadata-stats/metadata/rest.md) to request its status. When associated with the wildcard resource `'*'` it takes on an additional meaning: as well as allowing channel status requests for all channels, it also allows you to [enumerate all active channels](https://ably.com/docs/metadata-stats/metadata/rest.md#enumerate).

<Aside data-type='note'>
[Channel mode flags](https://ably.com/docs/channels/options.md#modes) enable a client to specify a subset of the capabilities granted by their token or API key as channel options.

Channel mode flags offer the ability for clients to use different capabilities for different channels, however, as they are flags and not permissions, they cannot be enforced by an authentication server. Channel mode flags also enable clients to be present on a channel without subscribing to presence events.
</Aside>

## API key capabilities 

An [Ably API key](https://ably.com/docs/auth.md#api-key) can have a single set of permissions, applied to any number of [channels](https://ably.com/docs/channels.md) or [queues](https://ably.com/docs/platform/integrations/queues.md).

You can also choose whether to restrict the API key to only channels, only [queues](https://ably.com/docs/platform/integrations/queues.md), or to match a set of channel or queue names. If you've chosen to restrict the API key to *selected channels and queues*, you can use a comma separated list of resources the API key can access, making use of wildcards to provide access to areas of your app. It is worth noting an API key will provide the same permissions to all resources it has access to.

To view the capabilities for an existing API key:

1. Sign into your [Ably dashboard](https://ably.com/dashboard).
2. Select the **API Keys** tab.
3. Click the **Settings** button for the key you want to check the capabilities for.

## Token capabilities 

Ably Tokens and JWTs are issued from an existing API key and their capabilities can, at most, match the capabilities of the issuing API key.

If an API key must be shared with a third party, then it is recommended that [the principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege) is considered, assigning only the capabilities needed by that third party. Thus, any Ably requests authenticated using that API key or Ably-compatible tokens associated with that API key, will be restricted to the capabilities assigned to the API key.

JWTs are the recommended approach for setting token capabilities. Use a TokenRequest as an alternative when your capability list is very large or must remain confidential.

#### Using JWT 

Set capabilities in a JWT using the `x-ably-capability` claim. No Ably SDK is required:

<Code>

##### Javascript

```
// Server-side: Create JWT with capabilities using any JWT library
import jwt from 'jsonwebtoken';

const [keyName, keySecret] = process.env.ABLY_API_KEY.split(':');

const ablyJwt = jwt.sign(
  {
    'x-ably-capability': JSON.stringify({
      'your-namespace:*': ['publish', 'subscribe', 'presence'],
      'notifications': ['subscribe'],
    }),
    'x-ably-clientId': userId,
  },
  keySecret,
  { algorithm: 'HS256', keyid: keyName, expiresIn: '1h' }
);
```

##### Python

```
# Server-side: Create JWT with capabilities using any JWT library
import jwt
import json
import time
import os

key_name, key_secret = os.environ['ABLY_API_KEY'].split(':')

now = int(time.time())
ably_jwt = jwt.encode(
    {
        'iat': now,
        'exp': now + 3600,
        'x-ably-capability': json.dumps({
            'your-namespace:*': ['publish', 'subscribe', 'presence'],
            'notifications': ['subscribe'],
        }),
        'x-ably-clientId': user_id,
    },
    key_secret,
    algorithm='HS256',
    headers={'kid': key_name}
)
```

##### Java

```
// Server-side: Create JWT with capabilities using any JWT library
Map<String, Object> headerClaims = new HashMap<>();
headerClaims.put("typ", "JWT");
headerClaims.put("alg", "HS256");
headerClaims.put("kid", keyName);

long currentTimeInSeconds = System.currentTimeMillis() / 1000;

Map<String, Object> claims = new HashMap<>();
claims.put("iat", currentTimeInSeconds);
claims.put("exp", currentTimeInSeconds + 3600);
claims.put("x-ably-capability", "{\"your-namespace:*\":[\"publish\",\"subscribe\",\"presence\"],\"notifications\":[\"subscribe\"]}");
claims.put("x-ably-clientId", userId);

Algorithm algorithm = Algorithm.HMAC256(keySecret);
String token = JWT.create()
        .withHeader(headerClaims)
        .withPayload(claims)
        .sign(algorithm);
```

##### Ruby

```
# Server-side: Create JWT with capabilities using any JWT library
require 'jwt'

key_name, key_secret = ENV['ABLY_API_KEY'].split(':')

now = Time.now.to_i
payload = {
  'iat' => now,
  'exp' => now + 3600,
  'x-ably-capability' => '{"your-namespace:*":["publish","subscribe","presence"],"notifications":["subscribe"]}',
  'x-ably-clientId' => user_id
}

ably_jwt = JWT.encode(payload, key_secret, 'HS256', { 'kid' => key_name })
```

##### Php

```
// Server-side: Create JWT with capabilities using any JWT library
$header = [
    'typ' => 'JWT',
    'alg' => 'HS256',
    'kid' => $keyName
];
$currentTime = time();
$claims = [
    'iat' => $currentTime,
    'exp' => $currentTime + 3600,
    'x-ably-capability' => '{"your-namespace:*":["publish","subscribe","presence"],"notifications":["subscribe"]}',
    'x-ably-clientId' => $userId
];
$base64Header = base64_encode(json_encode($header));
$base64Claims = base64_encode(json_encode($claims));
$signature = hash_hmac('sha256', $base64Header . '.' . $base64Claims, $keySecret, true);
$jwt = $base64Header . '.' . $base64Claims . '.' . base64_encode($signature);
```

##### Go

```
// Server-side: Create JWT with capabilities using any JWT library
header := map[string]string{
    "typ": "JWT",
    "alg": "HS256",
    "kid": keyName,
}

currentTime := time.Now().Unix()
claims := map[string]interface{}{
    "iat":                currentTime,
    "exp":                currentTime + 3600,
    "x-ably-capability":  `{"your-namespace:*":["publish","subscribe","presence"],"notifications":["subscribe"]}`,
    "x-ably-clientId":    userId,
}

// Sign using HS256 with your API key secret
```

##### Csharp

```
// Server-side: Create JWT with capabilities using any JWT library
var header = new Dictionary<string, object>
{
    { "typ", "JWT" },
    { "alg", "HS256" },
    { "kid", keyName }
};

var currentTime = DateTimeOffset.UtcNow.ToUnixTimeSeconds();
var claims = new Dictionary<string, object>
{
    { "iat", currentTime },
    { "exp", currentTime + 3600 },
    { "x-ably-capability", "{\"your-namespace:*\":[\"publish\",\"subscribe\",\"presence\"],\"notifications\":[\"subscribe\"]}" },
    { "x-ably-clientId", userId }
};

// Sign using HS256 with your API key secret
```
</Code>

#### Using TokenRequest 

Use a TokenRequest when your capability list is very large (JWTs must fit within HTTP header limits, typically around 8 KB) or when capabilities need to be kept confidential (JWTs can be decoded by clients):

<Code>

##### Javascript

```
// Server-side with Ably SDK
const ably = new Ably.Rest(process.env.ABLY_API_KEY);
const tokenRequest = await ably.auth.createTokenRequest({
  clientId: 'user-123',
  capability: JSON.stringify({
    'your-namespace:*': ['publish', 'subscribe'],
  }),
});
```

##### Python

```
# Server-side with Ably SDK
ably = AblyRest(os.environ['ABLY_API_KEY'])
token_request = await ably.auth.create_token_request({
    'client_id': 'user-123',
    'capability': json.dumps({
        'your-namespace:*': ['publish', 'subscribe'],
    }),
})
```

##### Java

```
// Server-side with Ably SDK
ClientOptions options = new ClientOptions("your-api-key");
AblyRest rest = new AblyRest(options);

Auth.TokenParams tokenParams = new Auth.TokenParams();
tokenParams.clientId = "user-123";
tokenParams.capability = "{\"your-namespace:*\":[\"publish\",\"subscribe\"]}";

Auth.TokenRequest tokenRequest = rest.auth.createTokenRequest(tokenParams, null);
```

##### Ruby

```
# Server-side with Ably SDK
rest = Ably::Rest.new(key: 'your-api-key')

token_request = rest.auth.create_token_request(
  client_id: 'user-123',
  capability: { 'your-namespace:*' => ['publish', 'subscribe'] }
)
```

##### Php

```
// Server-side with Ably SDK
$rest = new Ably\AblyRest(
    ['key' => 'your-api-key']
);

$tokenRequest = $rest->auth->createTokenRequest([
    'clientId' => 'user-123',
    'capability' => '{"your-namespace:*":["publish","subscribe"]}'
]);
```

##### Go

```
// Server-side with Ably SDK
rest, err := ably.NewREST(
  ably.WithKey("your-api-key"))
if err != nil {
  log.Fatalf("Error creating Ably client: %v", err)
}

capabilitiesJSON, _ := json.Marshal(map[string][]string{
  "your-namespace:*": {"publish", "subscribe"},
})

tokenParams := &ably.TokenParams{
  ClientID:   "user-123",
  Capability: string(capabilitiesJSON),
}
tokenRequest, _ := rest.Auth.CreateTokenRequest(tokenParams)
```

##### Flutter

```
// Server-side with Ably SDK
final clientOptions = ably.ClientOptions(
  key: 'your-api-key',
);
final rest = ably.Rest(options: clientOptions);
final tokenRequest = rest.auth.createTokenRequest(
  tokenParams: ably.TokenParams(
    clientId: 'user-123',
    capability: '{"your-namespace:*":["publish","subscribe"]}',
  ),
);
```
</Code>

### Token capability determination 

The capabilities of the resulting token are the intersection of the requested capabilities and those of the issuing API key. The token request will fail if the intersection is empty (the token would have no rights).

Note that a successful token request doesn't guarantee all requested capabilities were granted. If the issuing key's capabilities aren't known, verify the token has all required capabilities after creation.

#### Ably Token without capabilities 

If no capability is specified in an Ably `TokenRequest`, then the [Ably Token](https://ably.com/docs/auth/token/ably-tokens.md) will be given the full set of capabilities assigned to the issuing key.

Using the following example, an API key exists with the listed capabilities. If an Ably Token is requested without specifying any capabilities then the `TokenRequest` is treated as requesting all capabilities, i.e. `{"[*]*":["*"]}`. This will result in the Ably Token receiving all the capabilities of the API key.

<Code>

##### Javascript

```
  // API key capabilities:
  {
    'your-namespace': ['publish', 'subscribe', 'presence'],
    'notifications': ['subscribe']
  }

  // Token request that doesn't specify any capabilities:
  await auth.requestToken(tokenCallback)

  // Resulting token capabilities:
  {
    'your-namespace': ['publish', 'subscribe', 'presence'],
    'notifications': ['subscribe']
  }
```

##### Python

```
# API key capabilities:
# {
#   "your-namespace": ["publish", "subscribe", "presence"],
#   "notifications": ["subscribe"]
# }

# Token request that doesn't specify any capabilities:
token = await ably.auth.create_token_request(
{
    "clientId": "client@example.com",
    'ttl': 3600 * 1000, # ms
})

# Resulting token capabilities:
# {
# "your-namespace": ["publish", "subscribe", "presence"],
# "notifications": ["subscribe"]
# }
```

##### Go

```
// API key capabilities:
// {
//   "your-namespace": ["publish", "subscribe", "presence"],
//   "notifications": ["subscribe"]
// }

rest, _ := ably.NewREST(
  ably.WithKey("your-api-key"))

// Define the token parameters
tokenParams := &ably.TokenParams{
  ClientID: "client@example.com",
  TTL:      3600 * 1000, /* time of expiration in ms (an hour) */
}

// Create a token request
tokenRequest, err := rest.Auth.CreateTokenRequest(tokenParams)
if err != nil {
  log.Fatalf("Failed to create token request: %v", err)
}

// Resulting token capabilities:
// {
// "your-namespace": ["publish", "subscribe", "presence"],
// "notifications": ["subscribe"]
// }
```
</Code>

#### Ably Token with intersection of capabilities 

If a set of capabilities are requested, then the Ably Token will be assigned the intersection of the requested capability and the capability of the issuing key.

Using the following example, an API key exists with the listed capabilities. If an [Ably Token](https://ably.com/docs/auth/token/ably-tokens.md) is requested and specifies a set of capabilities, then the resulting token will only receive those capabilities that intersect. The capabilities of a token cannot exceed those of the issuing API key.

<Code>

##### Javascript

```
  // API key capabilities:
  {
    'your-namespace:*': ['publish', 'subscribe', 'presence'],
    'notifications': ['subscribe', 'history'],
    'alerts': ['subscribe']
  }

  // Token request that specifies capabilities:
  const tokenDetails = await auth.requestToken({ capability: {
    'your-namespace:user-123': ['subscribe'], // only 'subscribe' intersects
    'notifications': ['*'], // '*'' intersects with 'subscribe'
    'private': ['publish', 'subscribe'] // key does not have access to 'private' channel
  }});

  // Resulting token capabilities:
  {
    'your-namespace:user-123': ['subscribe'],
    'notifications': ['subscribe', 'history']
  }
```

##### Python

```
# API key capabilities:
# {
#   "your-namespace:*": ["publish", "subscribe", "presence"],
#   "notifications": ["subscribe", "history"],
#   "alerts": ["subscribe"]
# }

# Token request that specifies capabilities:
capabilities = {
    "your-namespace:user-123": ["subscribe"],  # only "subscribe" intersects
    "notifications": ["*"],  # "*" intersects with "subscribe"
    "private": ["publish", "subscribe"]  # key does not have access to "private" channel
}

token_details = await ably_rest.auth.request_token({
    'capability': json.dumps(capabilities)
})

# Resulting token capabilities:
# {
#   "your-namespace:user-123": ["subscribe"],
#   "notifications": ["subscribe", "history"]
# }
```

##### Go

```
// API key capabilities:
// {
//   "your-namespace:*": ["publish", "subscribe", "presence"],
//   "notifications": ["subscribe", "history"],
//   "alerts": ["subscribe"]
// }

// Token request that specifies capabilities:
rest, _ := ably.NewREST(
  ably.WithKey("your-api-key"))

// Define the capabilities
capabilities := map[string][]string{
  "your-namespace:user-123": {"subscribe"},
  "notifications":           {"*"},
  "private":                 {"publish", "subscribe"},
}

capabilitiesJSON, err := json.Marshal(capabilities)
if err != nil {
  log.Fatalf("Failed to marshal capabilities: %v", err)
}

// Define the token parameters
tokenParams := &ably.TokenParams{
  Capability: string(capabilitiesJSON),
}

// Request a token
tokenDetails, err := rest.Auth.RequestToken(context.Background(), tokenParams)
if err != nil {
  log.Fatalf("Failed to request token: %v", err)
}

// Resulting token capabilities:
// {
//   "your-namespace:user-123": ["subscribe"],
//   "notifications": ["subscribe", "history"]
// }
```
</Code>

#### Ably Token with incompatible capabilities 

If a set of capabilities are requested, and the intersection between those and the API key's capabilities is empty, then the `TokenRequest` will result in an error.

Using the following example, an API key exists with the listed capabilities. If an [Ably Token](https://ably.com/docs/auth/token/ably-tokens.md) is requested that specifies a set of capabilities, and there is no intersection between the capabilities of the issuing API key and requested token, then the token request will be rejected. In the following example, the callback will be returned with an error.

<Code>

##### Javascript

```
  // API key capabilities:
  {
    'your-namespace': ['*']
  }

  // Token request that specifies capabilities:
  const tokenDetails = await auth.requestToken({ capability: {
    'other-namespace': ['*']
  }});
```

##### Python

```
# API key capabilities:
# {
#   "your-namespace": ["*"]
# }

token_details = await ably_rest.auth.request_token({
    'capability': json.dumps({
        "other-namespace": ["*"]
    })
})
```

##### Go

```
// API key capabilities:
// {
//   "your-namespace": ["*"]
// }

rest, _ := ably.NewREST(
  ably.WithKey("your-api-key"))

// Define the capabilities
capabilities := map[string][]string{
  "other-namespace": {"*"},
}

capabilitiesJSON, err := json.Marshal(capabilities)
if err != nil {
  log.Fatalf("Failed to marshal capabilities: %v", err)
}

// Define the token parameters
tokenParams := &ably.TokenParams{
  Capability: string(capabilitiesJSON),
}

// Request a token
tokenDetails, err := rest.Auth.RequestToken(context.Background(), tokenParams)
if err != nil {
  log.Fatalf("Failed to request token: %v", err)
}
```
</Code>

#### Ably JWT capability determination 

Capabilities are determined for [JWTs](https://ably.com/docs/auth/token/jwt.md) in the following way:

* The capabilities granted to an Ably JWT will be the intersection of the capabilities within the Ably JWT and the capabilities of the associated API key.
* If the set of capabilities within the Ably JWT have no intersection with the capabilities of the API key, then an error will instead be returned.

## Channel-scoped user claims 

JWTs can contain channel-scoped user claims for trusted metadata that other clients can read. See [JWT authentication — channel-scoped claims](https://ably.com/docs/auth/token/jwt.md#channel-claims) for details and examples.

## Per-connection publish rate limits 

JWTs can specify per-connection publish rate limits to restrict how many messages a client can send. See [JWT authentication — rate limits](https://ably.com/docs/auth/token/jwt.md#rate-limits) for details and examples.

## Related Topics

- [Overview](https://ably.com/docs/auth.md): Ably supports two main authentication schemes: basic authentication and token authentication. Token authentication can be implemented using JWTs, Ably tokens, and Ably token requests.
- [Basic auth](https://ably.com/docs/auth/basic.md): Basic authentication allows you to authenticate a secure server using an Ably API key and secret.
- [Token revocation](https://ably.com/docs/auth/revocation.md): Token revocation is a mechanism that enables an app to invalidate authentication tokens.
- [Identified clients](https://ably.com/docs/auth/identified-clients.md): Clients can be allocated a client ID to help control their operations and interactions with Ably channels.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
