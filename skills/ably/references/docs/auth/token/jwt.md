# JSON Web Tokens (JWTs)

JSON Web Token (JWT) is the recommended token format for most applications. Your clients request a JWT from your server, which creates and signs it using your Ably API key. No Ably SDK is required on the server — any JWT library works.

<Aside data-type='note'>
Use native [Ably Tokens](https://ably.com/docs/auth/token/ably-tokens.md) when:
- Your capability list is too large and exceeds JWT size limits. JWTs must fit within HTTP header limits, typically around 8 KB.
- You need to keep your capability list confidential, as JWTs can be decoded by clients.
- You already have a JWT-based auth system and want to embed Ably tokens within your existing JWTs. See [Embedded Token JWT](https://ably.com/docs/auth/token.md#embedded).
</Aside>

## Server setup 

### Creating JWTs 

Your server creates JWTs signed with your Ably API key secret. No Ably SDK is required. Any JWT library works.

<If lang="javascript">
To generate JWTs in Node.js, install the [`jsonwebtoken`](https://github.com/auth0/node-jsonwebtoken) package.
</If>

<If lang="python">
To generate JWTs in Python, install the [`PyJWT`](https://pyjwt.readthedocs.io/) package.
</If>

<If lang="java">
To generate JWTs in Java, install the [`java-jwt`](https://github.com/auth0/java-jwt) library.
</If>

<If lang="go">
To generate JWTs in Go, use the [`golang-jwt`](https://github.com/golang-jwt/jwt) package.
</If>

<If lang="ruby">
To generate JWTs in Ruby, install the [`ruby-jwt`](https://github.com/jwt/ruby-jwt) gem.
</If>

<If lang="php">
To generate JWTs in PHP, install the [`firebase/php-jwt`](https://github.com/firebase/php-jwt) package.
</If>

<If lang="csharp">
To generate JWTs in C#, use the [`System.IdentityModel.Tokens.Jwt`](https://www.nuget.org/packages/System.IdentityModel.Tokens.Jwt) NuGet package.
</If>

<If lang="flutter">
To generate JWTs in Flutter, install the [`crypto`](https://pub.dev/packages/crypto) package.
</If>

<If lang="swift">
To generate JWTs in Swift, use a library such as [`SwiftJWT`](https://github.com/Kitura/Swift-JWT).
</If>

<Code>

#### Javascript

```
  var header = {
    "typ":"JWT",
    "alg":"HS256",
    "kid": "{{API_KEY_NAME}}"
  }
  var currentTime = Math.round(Date.now()/1000);
  var claims = {
    "iat": currentTime, /* current time in seconds */
    "exp": currentTime + 3600, /* time of expiration in seconds */
    "x-ably-capability": "{\"*\":[\"*\"]}"
  }
  var base64Header = btoa(header);
  var base64Claims = btoa(claims);
  /* Apply the hash specified in the header */
  var signature = hash((base64Header + "." + base64Claims), "{{API_KEY_SECRET}}");
  var ablyJwt = base64Header + "." + base64Claims + "." + signature;
```

#### Python

```
  import jwt
  import time

  def createAblyJwt(ably_api_key: str):
      # Split the API key into key ID and secret
      parts = ably_api_key.split(":")
      kid = parts[0]

      # Prepare JWT headers
      headers = {
          "typ": "JWT",
          "alg": "HS256",
          "kid": kid
      }

      # Prepare JWT claims
      claims = {
          "iat": int(time.time()),  # Issued at time
          "exp": int(time.time()) + 120,  # Expiration time (2 minutes from now)
          "x-ably-capability": "{\"*\":[\"*\"]}"  # Full capability
      }

      # Encode the JWT
      jwtToken = jwt.encode(headers=headers, payload=claims, key=parts[1])
      return jwtToken
```

#### Java

```
Map<String, Object> headerClaims = new HashMap<>();
headerClaims.put("typ", "JWT");
headerClaims.put("alg", "HS256");
headerClaims.put("kid", "{{API_KEY_NAME}}");

// Define the current time
long currentTimeInSeconds = System.currentTimeMillis() / 1000;

// Define the claims
Map<String, Object> claims = new HashMap<>();
claims.put("iat", currentTimeInSeconds);
claims.put("exp", currentTimeInSeconds + 3600);
claims.put("x-ably-capability", "{\"*\":[\"*\"]}");

// Create the JWT
Algorithm algorithm = Algorithm.HMAC256("{{API_KEY_SECRET}}");
String token = JWT.create()
        .withHeader(headerClaims)
        .withPayload(claims)
        .sign(algorithm);
```

#### Php

```
$header = [
    'typ' => 'JWT',
    'alg' => 'HS256',
    'kid' => '{{API_KEY_NAME}}'
];
$currentTime = time();
$claims = [
    'iat' => $currentTime, /* current time in seconds */
    'exp' => $currentTime + 3600, /* time of expiration in seconds (an hour) */
    'x-ably-capability' => '{\"*\":[\"*\"]}'
];
$base64Header = base64_encode(json_encode($header));
$base64Claims = base64_encode(json_encode($claims));
$signature = hash_hmac(
    'sha256',
    $base64Header . '.' . $base64Claims,
    '{{API_KEY_SECRET}}',
    true
);
$jwt = $base64Header . '.' . $base64Claims . '.' . $signature;
```

#### Go

```
  // Create JWT header
  header := map[string]string{
    "typ": "JWT",
    "alg": "HS256",
    "kid": "{{API_KEY_NAME}}",
  }

  // Get current time in seconds
  currentTime := time.Now().Unix()

  // Create JWT claims
  claims := map[string]interface{}{
    "iat":               currentTime,        // current time in seconds
    "exp":               currentTime + 3600, // time of expiration in seconds
    "x-ably-capability": "{\"*\":[\"*\"]}",
  }

  // Encode header to base64
  headerJSON, err := json.Marshal(header)
  if err != nil {
    log.Fatalf("Failed to marshal header: %v", err)
  }
  base64Header := base64.RawURLEncoding.EncodeToString(headerJSON)

  // Encode claims to base64
  claimsJSON, err := json.Marshal(claims)
  if err != nil {
    log.Fatalf("Failed to marshal claims: %v", err)
  }
  base64Claims := base64.RawURLEncoding.EncodeToString(claimsJSON)

  // Create the signature
  dataToSign := base64Header + "." + base64Claims
  h := hmac.New(sha256.New, []byte("{{API_KEY_SECRET}}"))
  h.Write([]byte(dataToSign))
  signature := base64.RawURLEncoding.EncodeToString(h.Sum(nil))

  // Combine the parts to form the final JWT
  ablyJwt := base64Header + "." + base64Claims + "." + signature
  log.Println("Ably JWT:", ablyJwt)
```

#### Flutter

```
final header = {
  "typ": "JWT",
  "alg": "HS256",
  "kid": "{{API_KEY_NAME}}"
};

final currentTime = (DateTime.now().millisecondsSinceEpoch / 1000).round();
final claims = {
  "iat": currentTime, /* current time in seconds */
  "exp": currentTime + 3600, /* time of expiration in seconds */
  "x-ably-capability": "{\"*\":[\"*\"]}"
};

final base64Header = base64UrlEncode(utf8.encode(json.encode(header)));
final base64Claims = base64UrlEncode(utf8.encode(json.encode(claims)));
final hmacSha256 = Hmac(sha256, utf8.encode("$base64Header.$base64Claims"));
final digest = hmacSha256.convert(utf8.encode("{{API_KEY_SECRET}}"));
final signature = base64UrlEncode(digest.bytes);
final ablyJwt = "$base64Header.$base64Claims.$signature";
```
</Code>

Ably does not support asymmetric signatures based on a key pair belonging to a third party.

### JWT claims 

| Claim | Required | Description |
|-------|----------|-------------|
| `x-ably-capability` | Yes | JSON string defining [capabilities](https://ably.com/docs/auth/capabilities.md) |
| `x-ably-clientId` | No | Sets a trusted [client ID](https://ably.com/docs/auth/identified-clients.md) |
| `exp` | Yes | Expiration time (Unix timestamp) |
| `iat` | Yes | Issued at time (Unix timestamp) |

## Client setup

`authUrl` is useful for web-based clients that can pass cookies automatically. For non-web clients, `authCallback` provides more control.

### authCallback 

Use `authCallback` to fetch JWTs from your server. The SDK automatically calls this function when connecting and when the token is near expiry.

<Code>

#### Realtime Javascript

```
const realtime = new Ably.Realtime({
  authCallback: async (tokenParams, callback) => {
    try {
      const response = await fetch('/api/ably-token', {
        credentials: 'include',
      });
      if (!response.ok) throw new Error('Auth failed');
      callback(null, await response.text());
    } catch (error) {
      callback(error, null);
    }
  },
});
```

#### Realtime Python

```
import aiohttp

async def get_ably_jwt(*args, **kwargs):
    async with aiohttp.ClientSession() as session:
        async with session.get('/api/ably-token') as response:
            if response.status != 200:
                raise Exception(f"Auth failed: {response.status}")
            return await response.text()

realtime = AblyRealtime(auth_callback=get_ably_jwt)
```

#### Realtime Java

```
ClientOptions options = new ClientOptions();
options.authCallback = new Auth.TokenCallback() {
    @Override
    public Object getTokenRequest(Auth.TokenParams params) throws AblyException {
        // Make HTTP request to your auth server and return JWT string
        return fetchJwtFromServer();
    }
};
AblyRealtime realtime = new AblyRealtime(options);
```

#### Realtime Kotlin

```
val options = ClientOptions()
options.authCallback = Auth.TokenCallback { params ->
    // Make HTTP request to your auth server and return JWT string
    fetchJwtFromServer()
}
val realtime = AblyRealtime(options)
```

#### Realtime Swift

```
let options = ARTClientOptions()
options.authCallback = { tokenParams, callback in
    fetchAblyJwt { result in
        switch result {
        case .success(let jwt):
            callback(jwt as ARTTokenDetailsCompatible, nil)
        case .failure(let error):
            callback(nil, error)
        }
    }
}
let realtime = ARTRealtime(options: options)
```

#### Realtime Objc

```
ARTClientOptions *options = [[ARTClientOptions alloc] init];
options.authCallback = ^(ARTTokenParams *tokenParams, void (^callback)(id<ARTTokenDetailsCompatible>, NSError *)) {
    [self fetchAblyJwt:^(NSString *jwt, NSError *error) {
        if (error) {
            callback(nil, error);
        } else {
            callback(jwt, nil);
        }
    }];
};
ARTRealtime *realtime = [[ARTRealtime alloc] initWithOptions:options];
```

#### Realtime Csharp

```
ClientOptions options = new ClientOptions();
options.AuthCallback = async tokenParams =>
{
    // Make HTTP request to your auth server and return JWT string
    return await FetchJwtFromServerAsync();
};
AblyRealtime realtime = new AblyRealtime(options);
```

#### Realtime Go

```
client, err := ably.NewRealtime(
    ably.WithAuthCallback(func(ctx context.Context, params ably.TokenParams) (ably.Tokener, error) {
        // Fetch JWT from your auth server
        jwt, err := fetchJwtFromServer()
        if err != nil {
            return nil, err
        }
        return ably.TokenString(jwt), nil
    }))
```

#### Realtime Ruby

```
realtime = Ably::Realtime.new(auth_callback: -> (token_params) {
  # Fetch JWT from your auth server
  fetch_jwt_from_server()
})
```

#### Realtime Flutter

```
final clientOptions = ably.ClientOptions(
    authCallback: (tokenParams) async {
        // Fetch JWT from your auth server
        return await fetchJwtFromServer();
    },
);
final realtime = ably.Realtime(options: clientOptions);
```
</Code>

The [`tokenParams`](https://ably.com/docs/api/realtime-sdk/authentication.md#token-params) argument is available for convenience but should not be trusted. Your auth endpoint should authenticate clients separately using cookies, headers, or request body.

### authUrl 

You can specify an `authUrl` as an alternative to `authCallback`. The SDK makes an HTTP request to this URL to obtain a JWT.

<Code>

#### Realtime Javascript

```
const realtime = new Ably.Realtime({ authUrl: '/auth' });
```

#### Realtime Ruby

```
realtime = Ably::Realtime.new(auth_url: '/auth')
```

#### Realtime Python

```
  realtime = AblyRealtime(auth_url='/auth')
```

#### Realtime Java

```
ClientOptions options = new ClientOptions();
options.authUrl = "/auth";
AblyRealtime realtime = new AblyRealtime(options);
```

#### Realtime Objc

```
ARTClientOptions *options = [[ARTClientOptions alloc] init];
options.authUrl = [NSURL URLWithString:@"/auth"];
ARTRealtime *realtime = [[ARTRealtime alloc] initWithOptions:options];
```

#### Realtime Swift

```
let options = ARTClientOptions()
options.authUrl = NSURL(string: "/auth")
let realtime = ARTRealtime(options: options)
```

#### Realtime Csharp

```
ClientOptions options = new ClientOptions();
options.AuthUrl = new Uri("/auth");
AblyRealtime realtime = new AblyRealtime(options);
```

#### Realtime Go

```
client, err := ably.NewRealtime(ably.WithAuthURL("/auth"))
```

#### Realtime Kotlin

```
val options = ClientOptions()
options.authUrl = "/auth"
val realtime = AblyRealtime(options)
```

#### Realtime Flutter

```
final clientOptions = ably.ClientOptions(
    authUrl: '/auth'
);
final realtime = ably.Realtime(options: clientOptions);
```

#### Rest Javascript

```
  const rest = new Ably.Rest({ authUrl: '/auth' });
```

#### Rest Ruby

```
  rest = Ably::Rest.new(auth_url: '/auth')
```

#### Rest Python

```
  rest = AblyRest(auth_url='/auth')
```

#### Rest Php

```
  $rest = new Ably\AblyRest(['authUrl' => '/auth']);
```

#### Rest Java

```
  ClientOptions options = new ClientOptions();
  options.authUrl = "/auth";
  AblyRest rest = new AblyRest(options);
```

#### Rest Kotlin

```
  val options = ClientOptions()
  options.authUrl = "/auth"
  val rest = AblyRest(options)
```

#### Rest Csharp

```
  AblyRest rest = new AblyRest(new ClientOptions { AuthUrl = new Uri("/auth") });
```

#### Rest Objc

```
  ARTClientOptions *options = [[ARTClientOptions alloc] init];
  options.authUrl = [NSURL URLWithString:@"/auth"];
  ARTRest *rest = [[ARTRest alloc] initWithOptions:options];
```

#### Rest Swift

```
  let options = ARTClientOptions()
  options.authUrl = NSURL(string: "/auth")
  let rest = ARTRest(options: options)
```

#### Rest Go

```
  client, err := ably.NewREST(ably.WithAuthURL("/auth"))
```

#### Rest Flutter

```
final clientOptions = ably.ClientOptions(
    authUrl: '/auth'
);
final rest = ably.Rest(options: clientOptions);
```
</Code>

### AuthOptions 

Use properties set with [`AuthOptions`](https://ably.com/docs/api/realtime-sdk/authentication.md#auth-options) to customize authentication behavior:

- `authMethod` - when `authUrl` is called, the default `GET` method will be used, unless `POST` is specified.
- `authHeaders` - pass additional headers as required.
- `authParams` - pass additional query parameters.

<Code>

#### Realtime Javascript

```
const realtime = new Ably.Realtime({
  authUrl: "/auth",
  authMethod: "POST",
  authParams: {p1: param1, b: param2},
  authHeaders: {h1: header1, h2: header2}
});
```

#### Realtime Python

```
realtime = AblyRealtime(auth_url='/auth',
                        auth_method="GET",
                        auth_headers={'h1': 'v1'},
                        auth_params={'param1': 'param2'})
```

#### Realtime Go

```
headers := http.Header{}
headers.Set("h1", "header1")
headers.Set("h2", "header2")

client, err := ably.NewRealtime(
  ably.WithAuthURL("/auth"),
  ably.WithAuthMethod("GET"),
  ably.WithAuthHeaders(headers),
  ably.WithAuthParams(url.Values{
    "p1": {"param1"},
    "p2": {"param2"},
  }))
if err != nil {
  panic(err)
}
```

#### Realtime Flutter

```
final clientOptions = ably.ClientOptions(
  authUrl: '/auth',
  authMethod: 'GET',
  authParams: {
    'p1': 'param1',
    'b': 'param2',
  },
  authHeaders: {
    'h1': 'header1',
    'h2': 'header2',
  },
);
final realtime = ably.Realtime(options: clientOptions);
```

#### Realtime Java

```
ClientOptions options = new ClientOptions();
options.authUrl = "/auth";
options.authMethod = "POST";
options.authParams = new Param[]{
        new Param("p1", "param1"),
        new Param("p2", "param2")
};
options.authHeaders = new Param[]{
        new Param("h1", "header1"),
        new Param("h2", "header2")
};

AblyRealtime realtime = new AblyRealtime(options);
```

#### Rest Javascript

```
const rest = new Ably.Rest({
  authUrl: "/auth",
  authMethod: "POST",
  authParams: {p1: param1, b: param2},
  authHeaders: {h1: header1, h2: header2}
});
```

#### Rest Python

```
rest = AblyRest(auth_url='/auth',
                    auth_method="GET",
                    auth_headers={'h1': 'v1'},
                    auth_params={'param1': 'param2'})
```

#### Rest Go

```
headers := http.Header{}
headers.Set("h1", "header1")
headers.Set("h2", "header2")

client, err := ably.NewREST(
  ably.WithAuthURL("/auth"),
  ably.WithAuthMethod("GET"),
  ably.WithAuthHeaders(headers),
  ably.WithAuthParams(url.Values{
    "p1": {"param1"},
    "p2": {"param2"},
  }))
if err != nil {
  panic(err)
}
```

#### Rest Flutter

```
final clientOptions = ably.ClientOptions(
  authUrl: '/auth',
  authMethod: 'GET',
  authParams: {
    'p1': 'param1',
    'b': 'param2',
  },
  authHeaders: {
    'h1': 'header1',
    'h2': 'header2',
  },
);
final rest = ably.Rest(options: clientOptions);
```

#### Rest Java

```
ClientOptions options = new ClientOptions();
options.authUrl = "/auth";
options.authMethod = "POST";
options.authParams = new Param[]{
        new Param("p1", "param1"),
        new Param("p2", "param2")
};
options.authHeaders = new Param[]{
        new Param("h1", "header1"),
        new Param("h2", "header2")
};

AblyRest rest = new AblyRest(options);
```
</Code>

## JWT features

JWTs support features not available with other token mechanisms.

### Channel-scoped claims 

Embed trusted metadata in JWTs that other clients can read. Use the `ably.channel.*` claim pattern:

<Code>

#### Javascript

```
const ablyJwt = jwt.sign(
  {
    'x-ably-capability': JSON.stringify({
      'chat:*': ['publish', 'subscribe', 'presence'],
    }),
    'x-ably-clientId': userId,
    // Channel-scoped claim - other clients can read this
    'ably.channel.chat:lobby': JSON.stringify({
      role: 'moderator',
      displayName: 'Alice',
    }),
  },
  keySecret,
  { algorithm: 'HS256', keyid: keyName, expiresIn: '1h' }
);
```
</Code>

Other clients can read these claims from presence or message metadata, providing trusted user information without additional server calls.

### Per-connection rate limits 

Restrict how fast specific clients can publish messages using the `ably.limits.publish.*` claim:

<Code>

#### Javascript

```
const ablyJwt = jwt.sign(
  {
    'x-ably-capability': JSON.stringify({ '*': ['publish', 'subscribe'] }),
    'x-ably-clientId': userId,
    // Per-connection rate limit - max 10 messages per second
    'ably.limits.publish.perAttachment.maxRate.*': 10,
  },
  keySecret,
  { algorithm: 'HS256', keyid: keyName, expiresIn: '1h' }
);
```
</Code>

<Aside data-type='important'>
**JWT-only features:** Channel-scoped claims and per-connection rate limits are only available with JWTs. If you use [Ably Tokens](https://ably.com/docs/auth/token/ably-tokens.md), you will not have access to these features.
</Aside>

## Token lifecycle

Token refresh, TTL limits, and dynamic access control apply to all token types. See [token authentication](https://ably.com/docs/auth/token.md#refresh) for details.

For a comparison of JWT, TokenRequest, and Ably Token mechanisms, see [choosing a token mechanism](https://ably.com/docs/auth/token.md#choosing).

## Related Topics

- [Overview](https://ably.com/docs/auth/token.md): Token authentication allows clients to authenticate with Ably, without exposing the Ably API key and secret.
- [Ably Tokens](https://ably.com/docs/auth/token/ably-tokens.md): Ably Tokens are an alternative to JWTs when you need to keep capabilities confidential or when your capability list is very large.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
