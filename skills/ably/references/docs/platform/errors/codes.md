# Error codes

Use the error codes provided, which include descriptions, possible causes, and solutions, to troubleshoot issues effectively.

<Aside data-type='note'>
The following code examples are written in JavaScript, but the same principles apply across all Ably SDKs.
</Aside>

## 500: Internal error 

This error occurs when there is an issue within Ably's system.

## 50000: Internal error 

This error occurs when there is an issue within Ably's system.

## 10000: No error 

This error code indicates that the attempted action was successful and no issues occurred; there will be additional info in the `message` property about the successful action.

## 20000: General error code 

This error code is a generic response used when the Ably [protocol](https://ably.com/docs/protocols.md) requires an `errorInfo` object, even though no actual issue has occurred. The message property may contain additional details about the successful action.

## 40000: Bad request 

This error occurs when Ably cannot understand the request due to a malformed structure or other issues with the request format.

An example of this error is when a message is published while the connection is in a [suspended state](https://ably.com/docs/connect/states.md#connection-states).

## 40001: Invalid request body 

This error occurs when a request contains invalid content, such as incorrect [data types](https://ably.com/docs/api/realtime-sdk/types.md#data-types) or missing required objects. It is most likely caused by missing required fields or incorrect data formats when sending a request to Ably.

An example of this error is a missing field, such as a `keyName` in a [token request](https://ably.com/docs/api/token-request-spec.md#tokenrequest-format).

## 40003: Invalid parameter value 

This error occurs when an invalid value is sent in the request. It may be caused by either user input or the SDK sending incorrect parameters.

Additional examples of the `40003` error code output include:

* **40003: Excessive value for TTL**
This error occurs when the [TTL](https://ably.com/docs/api/rest-sdk/authentication.md#token-request) set for a token parameter exceeds the maximum allowed value of 24 hours.
* **40003: Excessive value for TTL (revocation is enabled on this key)**
This error occurs when [revocation](https://ably.com/docs/auth/revocation.md#revocable-tokens) is enabled, revocable tokens are limited to a TTL of 1 hour instead of 24 hours.

## 40005: Invalid credentials 

This error occurs when the [API key](https://ably.com/docs/auth.md#api-keys) or [token](https://ably.com/docs/auth/token.md) used to initialize the library is invalid.
Resolution: The following steps can help resolve this issue:

* API key initialization:
** Ensure you are the account's **admin** or **owner**.
** In your [Ably dashboard](https://ably.com/accounts/any) to the **API keys** tab.
** Use one of these API keys instead of your current one or create a [new API key](https://ably.com/docs/platform/account/app/api.md#create) with the necessary permissions and privileges and use that to instance the SDK.
* Token initialization:
**  If you are using [token authentication](https://ably.com/docs/auth/token.md), ensure you are correctly requesting a valid token before using it with Ably.

## 40006: Invalid connectionId 

This error occurs when a message is published with an invalid or mismatched [`connectionId`](https://ably.com/docs/messages.md#properties).

Examples of this error are when:
* A client attempts to publish a message using a malformed `connectionId`.
* A client publishes a realtime message with a `connectionId` that does not match the currently active connection.
* A connection is identified, but the resolved `clientId` is missing or incorrect (due to authentication issues or an explicitly provided, but incorrect, `clientId`).

## 40009: Maximum message length exceeded 

This error occurs when the message being published exceeds the maximum size allowed set by the [limits](https://ably.com/docs/platform/pricing/limits.md#app-limits) for your current [package](https://ably.com/docs/platform/pricing.md#packages).

## 40010: Invalid channel name 

This error occurs when a [channel name](https://ably.com/docs/channels.md#use) does not meet the required format or contains invalid characters.

## 40011: Stale ring state 

This error occurs when using the channel [enumeration](https://ably.com/docs/api/rest-api.md#enumeration-rest) API and the state of the cluster changes between successive calls, causing a pagination sequence to become invalid. Note: This issue does not occur if the enumeration request is fully satisfied within the first response page.

## 40012: Invalid `clientId` 

This error occurs when a `clientId` is invalid due to disallowed characters or a mismatch between the `clientId` specified in the request and the one assigned in the authentication [token](https://ably.com/docs/auth/token.md).

Examples of this error are when:

* The client attempts to use `*` as a `clientId`, which is not allowed because `*` is used as a [wildcard](https://ably.com/docs/auth/capabilities.md#wildcards) in capability expressions.
* A client tries to assume an ID of `foo` for an operation, but the token they are using specifies an ID of `bar`.

## 40013: Invalid message data or encoding 

This error occurs when the SDK is unable to encode the [message payload](https://ably.com/docs/messages.md) due to an unsupported data type.

An example of this error is when a client attempts to publish a payload that includes something that isn't serializable by an Ably SDK.

Resolution: Try marshalling the payload as JSON or MsgPack before publishing.

## 40015: Invalid deviceId 

This error occurs when the ID property in a [DeviceDetails](https://ably.com/docs/api/rest-sdk/push-admin.md#device-details) object, sent during a push notification registration request, is invalid. The ID must be a string.

## 40016: Invalid message name 

This error occurs when the `name` [property](https://ably.com/docs/messages.md#properties) of a message is not a string. The `name` field is used to categorize messages within channels, and it must always be a string.

## 40017: Unsupported protocol version or Invalid API version specified 

This error occurs when a request does not specify a protocol version or provides an invalid version in the request parameters of a [Server-Sent Events (SSE)](https://ably.com/docs/protocols/sse.md) request. This error also occurs when a WebSocket connection to Ably specifies an invalid API version in the request parameters.

**Resolution**: Ensure that the request specifies a valid protocol version. Note: You will not see this error when using an Ably SDK, as SDKs automatically use valid versions.

## 40020: Partial failure in batch operation requests 

This error occurs when a [batch](https://ably.com/docs/api/rest-api.md#batch) request partially fails, meaning that some operations succeed while others fail.

This error can occur for the following endpoints:

* Revoking tokens: [`POST/revokeTokens`](https://ably.com/docs/api/rest-api.md#revoke-tokens)
* Publishing messages: [`POST/messages`](https://ably.com/docs/api/rest-api.md#batch-publish)
* Retrieving presence data: [`GET/presence`](https://ably.com/docs/api/rest-api.md#batch-presence)

The following example is a batch operation response that includes partial failures. The `error` field indicates that some requests within the batch were unsuccessful, while the `batchResponse` contains individual results for each operation:

<Code>

### Json

```
{
  "error": "new ErrorInfo('Batched response includes errors', 40020, 400)",
  "batchResponse": "results"
}
```
</Code>

## 40022: Invalid resource 

This error occurs when the requested resource is invalid or already exists. It is typically returned by requests to the [Control API](https://ably.com/docs/platform/account/control-api.md).

Examples of this error include attempting to create a resource that already exists or providing an invalid resource name.

Resolution: The following steps can help resolve this issue:
* Ensure that an app with the requested name does not already exist in your account. If it does, use a different name.
* Verify that the [capabilities](https://ably.com/docs/auth/capabilities.md#capability-operations) listed in the request are valid when creating an API key.

## 40023: Action requires a newer protocol version 

This error occurs when the requested operation is only available in a newer version of the Ably protocol than the one specified in the request. This can happen if the client is using an older version of the Ably SDK that does not support the requested operation.

Examples of this error include attempting to use [channel objects](https://ably.com/docs/liveobjects.md) or message annotations, updates, deletes, and appends from an Ably SDK that does not support protocol version 2.

Resolution: The following steps can help resolve this issue:
* Upgrade the Ably SDK to a version that supports the requested operation.

## 40030: Invalid publish request (unspecified) 

This error occurs when a [publish request](https://ably.com/docs/pub-sub.md#publish) is malformed.

## 40032: Invalid publish request (impermissible extras field) 

This error occurs when a published message contains arbitrary fields in the [`extras`](https://ably.com/docs/api/realtime-sdk/messages.md#extras) payload that are not allowed by the Ably service. The `extras` field is reserved for specific objects related to Ably.

Resolution: Place any additional data inside the `headers` field within `extras`. The `headers` field must be a flat object (`map<string, string>` or equivalent) with no nested structures. If using unenveloped Reactor rules, ensure that header names are in `ASCII`, as they will be converted into HTTP, AMQP, or other protocol headers.

The following example is a valid `extras` object:

<Code>

### Javascript

```
const extras = {
  headers: {
    header1: 'value1',
    header2: 'value2'
  }
};
```
</Code>

## 40100: Unauthorized 

This error occurs when an action cannot be performed due to a lack of [authentication](https://ably.com/docs/auth.md). There will be additional info in the `message` property about the reason the action could not be performed.

## 40101: Invalid credentials 

This error occurs when [authentication](https://ably.com/docs/auth.md) credentials are invalid. The specific error message may provide further details about the cause.

An example of this error is when a signed token request is invalid due to a mismatched cryptographic signature (MAC does not match) or when the `clientId` specified in the Ably SDK does not match the `clientId` in the access token.

Resolution: Review your authentication setup and token request implementation. Ensure the following:

* The cryptographic signature (MAC) is correct - If a signed token request is invalid, Ably will reject it.
* The API key used to generate the token request is accurate - Double-check for missing or extra characters.
* The token request JSON is correctly formatted and unaltered, including:
** `keyName`: Must match the API key used in the request.
** `clientId`: If provided, it must match the one in the client constructor.
** `ttl`: Must be an integer in milliseconds.
** `timestamp`: Must be an integer in milliseconds.
** `capability`: Must be stringified JSON, not raw JSON.
** `nonce`: Must be a randomly generated string value.
** `mac`: Must be correctly generated using the secret key.
* The `clientId` in the SDK matches the one in the token. If a `clientId` is provided in the token, it must align with the `clientId` set in the Ably client options.
* A `clientId` cannot be changed on an existing connection. Ensure consistency in authentication.
* For JWT authentication, confirm that `clientId` is correctly set in `x-ably-clientId`.

## 40102: Incompatible credentials 

This error occurs when [authentication](https://ably.com/docs/auth.md) credentials do not match the existing connection, causing the connection to enter the [failed state](https://ably.com/docs/connect/states.md).

Examples of this error include:

* Attempting to authenticate with an API key from a different app than the one used for the original connection
* Resuming a connection using credentials tied to a different app
* Calling `auth.authorize` with an API key that differs from the one originally used to establish the connection

## 40103: Invalid use of Basic auth over non-TLS transport 

This error occurs when an API key is used over a non-TLS (unencrypted) connection, which is not permitted due to security risks. API keys are long-lived credentials, making them more vulnerable if exposed. Unlike short-lived tokens, API keys remain valid indefinitely, meaning a compromised key presents a significant security risk.

Non-TLS transports can be inspected by network devices routing traffic between the client and Ably. Ably does not allow API key authentication over non-TLS connections. However, Ably supports [basic authentication](https://ably.com/docs/auth/basic.md) over TLS and [token authentication](https://ably.com/docs/auth/token.md) over non-TLS connections.

Resolution: Select the appropriate [authentication mechanism](https://ably.com/docs/auth.md#selecting-auth) for your use case.

## 40104: Timestamp not current 

This error occurs when a signed token request sent to Ably is too old. Ably enforces timestamp validation to ensure [`TokenRequest`](https://ably.com/docs/auth/token/ably-tokens.md#token-request) remain valid for a limited time, reducing the risk of interception and misuse.

Resolutions: The following steps can help resolve this issue:
* Ensure that the authentication servers clock is accurate when generating signed token requests.
* If time synchronization is unreliable, set the `queryTime` [ClientOptions](https://ably.com/docs/api/rest-sdk/types.md#client-options) object to true when initializing the Ably client. This ensures Ably's server time is used.
* Do not cache signed token requests on the authentication server or client. Each token request must be freshly generated and used immediately.
* If using Next.js 13, prevent caching issues by setting revalidate to 0 or changing the request method from `GET` to `POST` using the `authMethod` [ClientOption](https://ably.com/docs/api/rest-sdk/types.md#client-options).

## 40105: Nonce value replayed 

This error occurs when a signed [token request](https://ably.com/docs/api/realtime-sdk/types.md#token-request) has been used more than once. Ably enforces nonce (number used once) checks to ensure that each signed token request is unique, as a security measure.

Examples of this error include:
* A client sends a signed token request to Ably but does not receive the response due to network issues. If the client automatically retries the HTTP request in a fallback data center, Ably detects the duplicate nonce and rejects it.
* An authentication server caches and reuses signed token requests instead of generating a unique one for each request.
* A misconfigured [`authCallback`](https://ably.com/docs/auth/token/jwt.md#auth-callback) function reuses the same token request on every invocation instead of generating a fresh one.
* The `tokenRequest` is not renewed. A new token request should be requested from your server at this point:

<Code>

### Javascript

```
var tokenRequest = "<new-token-request>";
var ably = new Ably.Realtime({
  authCallback: function(tokenParams, callback) {
    // This is a mistake. The tokenRequest is not renewed.
       A new token request should be requested from your server at this point */
    callback(null, tokenRequest);
  }
});
```
</Code>

Resolution: The following steps can help resolve this issue:
* Ensure that each token request is unique and never cached by the authentication server or client.
* Always generate a new token request each time authCallback is invoked.
* If retrieving a token request over HTTP, prevent caching by using the Cache-Control header (no-cache, no-store, must-revalidate) or by adding a cache-busting query string parameter, where the number is regenerated for every request, for example, `?rnd=73849275`.
* If network issues are suspected, check logs and debug the token request process to confirm proper request handling.

## 40106: Unable to obtain credentials from given parameters 

This error occurs when invalid [authentication](https://ably.com/docs/auth.md) options (key or token) are provided to the Ably SDK, preventing successful authentication.

An example of this error is when no [API key](https://ably.com/docs/auth.md#api-keys) or [token](https://ably.com/docs/auth/token.md) is supplied, or when an authentication request is made using a token to request another token, instead of an API key.

## 40111: Connection limits exceeded 

This error occurs when the peak [connection limit](https://ably.com/docs/platform/pricing/limits.md#connection) for your account has been exceeded, preventing new connections from being established until existing ones disconnect.

## 40112: Account blocked (message limits exceeded) 

This error occurs when your account has exceeded the allocated [message limit](https://ably.com/docs/platform/pricing/limits.md#message) based on your [package](https://ably.com/docs/platform/pricing.md#packages). Once this limit is reached, further message publishing is blocked.

## 40114: Account-wide peak channel limit exceeded 

This error occurs when your account has exceeded the concurrent [channel limit](https://ably.com/docs/platform/pricing/limits.md#channel), preventing additional channels from being created.

Examples of this error are when the application attempts to open more channels than the account allows, causing new channel creation to be blocked. Also, during development, an implementation error or bug causes unintended channel creation, leading to the limit being reached.

Resolution: Detach unused channels to free up space for new ones.

## 40115: Account restricted (request limit exceeded) 

This error occurs when your account has exceeded the allocated [limits](https://ably.com/docs/platform/pricing/limits.md) based on your [package](https://ably.com/docs/platform/pricing.md#packages).

## 40125: Maximum number of rules per application exceeded 

This error occurs when the application has reached the maximum number of [integration rules](https://ably.com/docs/platform/integrations.md) set by the [limits](https://ably.com/docs/platform/pricing/limits.md#app-limits) for your current package.

## 40127: Maximum number of keys per application exceeded 

This error occurs when the application has reached the maximum number of [API keys](https://ably.com/docs/platform/account/app/api.md) set by the [limits](https://ably.com/docs/platform/pricing/limits.md#app-limits) for your current package.

## 40131: Key revoked 

This error occurs when the [Ably API key](https://ably.com/docs/auth.md#api-keys) used to initialize the SDK is no longer valid because it has been [revoked](https://ably.com/docs/auth/revocation.md) by an admin of the application.

Resolution: The following steps can help resolve this issue:
* If you are an admin, go to the [API keys tab](https://ably.com/docs/platform/account/app/api.md) in the Ably dashboard to check for valid keys. Use an existing valid key or create a new one with the necessary permissions.
* If you are not an admin, request a new API key from an administrator or obtain a token request generated with a valid key.

## 40133: Wrong key; cannot revoke tokens with a different key than the one that issued them 

This error occurs when the [Ably API key](https://ably.com/docs/auth.md#api-keys) used to authorize a token [revocation](https://ably.com/docs/auth/revocation.md) request does not match the key that originally issued the token.

Resolution: The following steps can help resolve this issue:
* Ensure that the public API key ID used in the request matches the key that originally issued the token.
* Verify that the `keyname` in the request path corresponds with the API key used for authentication.

## 40141: Token revoked 

This error occurs when attempting to authenticate with a [token](https://ably.com/docs/auth/token.md) that has been [revoked](https://ably.com/docs/auth/revocation.md) and is no longer valid.

Resolution: Ensure that you are using a valid, [non-revoked](https://ably.com/docs/auth/revocation.md). token for authentication. If needed, generate a new token and use it for authorization.

## 40142: Token expired 

This error occurs when the authentication [token](https://ably.com/docs/auth/token/jwt.md#refresh) has expired and is no longer valid for use.

An example of this error is when a client attempts to authenticate with a token that has exceeded its time-to-live (TTL).

Resolution: The following steps can help resolve this issue:
* Use [`authUrl`](https://ably.com/docs/auth/token/jwt.md#auth-url) or [`authCallback`](https://ably.com/docs/auth/token/jwt.md#auth-callback) in your client configuration to enable automatic token renewal.
* If `authUrl` or `authCallback` is correctly configured, the client SDK will automatically renew the token when needed, so you may see this error temporarily before renewal occurs.

## 40143: Token unrecognized 

This error occurs when the provided token is not recognized as a valid Ably [token](https://ably.com/docs/auth/token/ably-tokens.md), Ably [JWT](https://ably.com/docs/auth/token/jwt.md), or a JWT containing a valid Ably token.

An example of this error is when a JWT is incorrectly formatted or when an Ably token does not follow the expected structure, for example: `<appId>.<randomBytes>`. Any token that does not adhere to the correct format will not be recognized.

Resolution: Validate the token format before using it for authentication. If creating a [JWT](https://ably.com/docs/auth/token/jwt.md), use a standard JWT library to ensure correct generation. If using an Ably token, verify that it matches the expected format as returned from the [`requestToken`](https://ably.com/docs/api/token-request-spec.md#examples) endpoint.

## 40144: Unexpected error decoding JWT; decode exception 

This error occurs when the [JWT](https://ably.com/docs/auth/token/jwt.md). provided for authentication cannot be validated by Ably due to incorrect formatting, missing claims, or unsupported configurations.

This error occurs when the [JWT](https://ably.com/docs/auth/token/jwt.md) provided for authentication cannot be validated by Ably. The specific reason for the failure will be available in the reason property of a [`ConnectionStateChange`](https://ably.com/docs/api/realtime-sdk/types.md#connection-state-change) object or in an error response from a REST request.

Examples of this error include:
* Missing or invalid payload claims, such as iat (issued at) or exp (expiration).
* Using a deprecated or unsupported signing algorithm.
* Providing an empty string for `x-ably-capability`.
* Using an empty string or non-string value for [`x-ably-revocation-key`](https://ably.com/docs/auth/revocation.md#revocation-key).
* Missing kid (Key ID) when using [JWT authentication with an API key](https://ably.com/docs/api/realtime-sdk/authentication.md#ably-jwt).

## 40160: Action not permitted 

This error occurs when the client does not have permission to perform the requested action.

An example of this error is when a token request includes an empty [capability object](https://ably.com/docs/auth/capabilities.md#capabilities-token), for example: `({})`, meaning the client has no assigned permissions, or when the requested [resource](https://ably.com/docs/auth/capabilities.md#wildcards) does not match the API key's allowed capabilities.

Resolution: Ensure the [API key](https://ably.com/docs/auth.md#api-keys) supports the required [capabilities](https://ably.com/docs/auth/capabilities.md#capabilities-key) for the requested action.

## 40161: Access denied to channel: namespace requires identified clients 

This error occurs when a [non-identified client](https://ably.com/docs/auth/identified-clients.md) attempts to access a channel that requires an identified client. Each application's channel namespaces configuration can be found in its application settings. By default, the identified namespace requires a client to be identified.

## 40170: Error from client token callback 

This error occurs when an authentication attempt using [`authUrl`](https://ably.com/docs/auth/token/jwt.md#auth-url) or [`authCallback`](https://ably.com/docs/auth/token/jwt.md#auth-callback) fails due to a timeout, network issue, invalid token format, or another authentication error condition.

Examples of this error include when a `TokenRequest` callback times out after the default 10-second limit. Also, when he `authUrl` response is missing a Content-Type header has an unsupported Content-Type.

Resolution: The following steps can help resolve this issue:
* Check for network latency between the client and the authentication server.
* Ensure the authentication server returns a valid Content-Type header and one of the supported content types:
** `application/json`
** `text/plain`
** `application/jwt`
* Additional error details can be found in the `error.message` field.

## 40171: No means provided to renew auth token 

This error occurs when no [`authUrl`](https://ably.com/docs/auth/token/jwt.md#auth-url) or [`authCallback`](https://ably.com/docs/auth/token/jwt.md#auth-callback) is provided in [`clientOptions`](https://ably.com/docs/getting-started.md#options) when initializing the Ably REST or Realtime SDK.

Tokens have a set expiration time, and once expired, they are no longer valid for communication with Ably. If `authUrl` or `authCallback` is configured, the SDK will automatically request a new token before expiration, ensuring uninterrupted operation.

Resolution: Ensure that `authUrl` or `authCallback` is set in your client configuration. This allows the SDK to automatically request a new token before the current one expires.

## 40300: Forbidden 

This error occurs when a requested action is not permitted. It serves as the default response for forbidden actions and can be triggered by various issues.

The following are example for this error:
* Mismatched SDK versions, occurring if an application uses multiple versions of the Ably SDK, leading to inconsistencies in connections.
* A disabled account, indicating that the app belongs to an account that has been manually disabled by Ably.
* An incorrect URL for a private cluster.

## 40311: Operation requires TLS connection 

By default, Ably apps require [TLS](https://ably.com/docs/platform/account/app/settings.md#channel-rule-configuration) for connections. This error occurs when a realtime SDK attempts to connect with TLS disabled (tls: false) while using token authentication.

Resolution: The following steps can help resolve this issue:
* Ensure that the `tls` [`ClientOption`](https://ably.com/docs/api/realtime-sdk.md#client-options) is set to true when connecting.
* If using [API key](https://ably.com/docs/platform/account/app/api.md#create) authentication, note that this scenario will result in a [`40103`](#40103) error instead.

## 40330: Unable to activate account due to placement constraint (unspecified) 

This error occurs when an app belonging to a dedicated (private) [cluster](https://ably.com/docs/platform/account/enterprise-customization.md#dedicated-and-isolated-clusters) is accessed using an incorrect endpoint. [Enterprise](https://ably.com/docs/platform/pricing/enterprise.md) customers with private clusters receive [custom](https://ably.com/docs/platform/account/enterprise-customization.md#setting-up-a-custom-environment) environment endpoints specific to their deployment.

An example of this error is when an app configured for a private cluster tries to connect via the default global endpoint.

Resolution: Check your custom environment settings for all connecting clients to ensure they point to the correct private cluster endpoints.

## 40331: Unable to activate account due to placement constraint (incompatible environment) 

This error occurs when an app that belongs to a dedicated (private) [cluster](https://ably.com/docs/platform/account/enterprise-customization.md#dedicated-and-isolated-clusters) is accessed using an incorrect URL. This often happens when the correct environment is not specified when initializing a client library. [Enterprise](https://ably.com/docs/platform/pricing/enterprise.md) customers with private clusters receive [custom](https://ably.com/docs/platform/account/enterprise-customization.md#setting-up-a-custom-environment) environment endpoints specific to their deployment.

If a request arrives at an unexpected dedicated cluster or incorrect region, the account in that scope may be disabled, triggering this error.

An example of this error is when a client intended for a dedicated environment, such as acme, connects to the default global endpoint (`main.realtime.ably.net`) instead of the correct dedicated cluster endpoint (`acme.realtime.ably.net`). If the expected environment is not configured, requests may be rejected.

Resolution: Verify that all connecting clients are configured with the correct custom environment settings to ensure they are pointing to the intended dedicated cluster.

## 40332: Unable to activate account due to placement constraint (incompatible site) 

This error occurs when attempting to connect to an app for an account restricted to a specific region.

An example of this error is when a client attempts to connect to an Ably app restricted to the EU region but does not specify the EU environment in the SDK configuration.

Resolution: The following steps can help resolve this issue:
* Ensure you are configured with the correct environment for your [region-restricted](https://faqs.ably.com/do-you-have-an-option-to-keep-my-data-in-europe-or-the-united-states) account.
* If your account has a regional constraint, you should have been provided with a [custom](https://ably.com/docs/platform/account/enterprise-customization.md#setting-up-a-custom-environment) environment to pass to the [`ClientOptions`](https://ably.com/docs/getting-started.md#options).
* Verify that your connection settings match the region assigned to your account.

## 40400: Not found 

This error occurs when the requested resource does not exist. This can apply to an Ably app, client, device, connection, API key, or token. The accompanying error message provides more details about the missing resource.

Examples of this error include:
* Attempting to authenticate using an Ably API key or token, but the specified appId cannot be found. This may happen if:
** The appId is incorrect.
** The appId does not exist in the current environment (especially in a custom deployment).
* Attempting to authenticate with an incorrect API key ID, which may be due to:
* An invalid API key ID.
* The key not being found in the specified environment.
* Incorrect formatting, particularly case sensitivity issues.

## 42910: Rate limit exceeded; request rejected 

This error occurs when a [limit](https://ably.com/docs/platform/pricing/limits.md) on your account has been reached, preventing further requests until the limit resets. The duration of the limit depends on the type of rate limit:

* Instantaneous rate limits typically last up to six seconds before allowing message publishing to resume.
* Other limits may apply on an hourly or monthly basis.

An example of this error is when a client exceeds the maximum allowed message rate on a channel.

In the following example, the metric `channel.maxRate` represents the maximum rate of messages allowed to be published on a channel per second. The permitted rate is 5000 messages per second, but the client is attempting to publish 5015 messages per second, triggering the limit.

<Code>

### Text

```
Rate limit exceeded; request rejected (nonfatal);
metric = channel.maxRate;
interval = 2018-01-05:10:10:3;
permitted rate = 5000;
current rate = 5015;
scope = channel:[YOUR APP ID]:[YOUR CHANNEL]
(status: 429, code: 42910) (code: 42910, http status: 429)
```
</Code>

Resolution: Wait for the rate limit period to reset before retrying. Optimize your message publishing to stay within allowed limits. Upgrade your package if higher throughput is required. Review your account limits to determine which restriction has been hit.

## 42911: Maximum account-wide instantaneous messages rate exceeded 

This error occurs when the number of [messages](https://ably.com/docs/platform/pricing/limits.md#message) sent per second exceeds the limit imposed on an account. To maintain service reliability for all users, Ably enforces usage limits at different levels, including monthly, hourly, and per-second thresholds.

## 42912: Channel iteration call already in progress 

This error occurs when multiple concurrent [metadata REST requests](https://ably.com/docs/metadata-stats/metadata.md#rest) are made to retrieve a list of active channels. The API is rate-limited, allowing only one in-flight call at a time. Additional concurrent requests will be rejected with this error.

Resolution: The following steps can help resolve this issue:
* Ensure that only one request is in progress at any given time.
* Implement request queuing or backoff strategies to avoid sending concurrent calls.
* If you require enhanced channel [enumeration capabilities](https://ably.com/docs/api/rest-api.md#enumeration-rest), visit this page to request access to the preview API.

## 42922: Rate limit exceeded; too many requests 

This error occurs when a client has made too many requests within a 5-minute time window, causing the request to be rejected. The [limit](https://ably.com/docs/platform/pricing/limits.md#hitting) remains in effect for up to 30 seconds but may persist longer if request volume remains above the threshold from the same IP address.

This rate limit is in place to protect the Ably platform and is not expected during normal use.

## 50001: Internal channel error 

This error occurs when there is an internal issue on an Ably channel.

## 50002: Internal connection error 

This error occurs when there is an internal connection issue.

## 50003: Timeout error 

This error occurs when a [connection](https://ably.com/docs/connect.md) request to Ably times out.

An example of this error is when a client attempts to publish a message to a channel, but the operation fails to complete within the allowed time.

Examples of this error include:
* Poor network conditions affecting connectivity.
* Improper usage of the Ably SDKs leading to unexpected delays.
* Temporary Ably server issues impacting response times.

## 50305: Ably's routing layer was unable to service this request 

This error occurs as a result of a request not being handled due to an internal routing error within the Ably service.

## 61002: Activation failed: Present clientId is not compatible with existing device registration 

This error occurs when you previously [activated](https://ably.com/docs/push/configure/device.md#activate-devices) a device for push notifications with a specific `clientId`, but then changed the `clientId` used for authentication. The mismatch causes the error because the push notification setup tracks the `clientId` and other details to prevent accidental changes between app launches. The `clientId` is linked to registrations, such as subscribing by `clientId`.

Resolution: If you need to change your client's `clientId`, deactivate and reactivate the device. This process triggers an internal `device.reset()` call, which clears and resets the old device details.

## 70001: Reactor operation failed (POST operation failed) 

This error occurs when a Reactor rule fails due to an issue with the configured endpoint. Ably attempts to send a POST request, but the response is unexpected or unsuccessful.

## 70002: Reactor operation failed (POST operation returned unexpected code) 

This error occurs when Ably sends a webhook to your server, but the server refuses or returns an unexpected response code. While Ably will retry the request multiple times, repeated failures indicate an issue on the server side.

## 72000: Ingress operation failed 

This error occurs due to an internal error with the ingress worker. It is an unexpected issue that happens when the worker attempts to execute a rule but encounters an error during the process.

## 72002: Ingress table is unhealthy 

This error occurs when the rule worker is unable to access or retrieve data from either the [outbox](https://ably.com/docs/livesync/postgres.md#outbox-table) or [nodes](https://ably.com/docs/livesync/postgres.md#nodes-table) table in the database as expected.

An example of this error is misconfigurations in the database setup or inconsistencies between the provided configuration and the actual database schema or table names.

Resolution: The following steps can help resolve this issue:
* Verify the configuration of the outbox and nodes tables in the database to ensure they are correctly set up and match the rule definition.
* Check for database connectivity issues and confirm that the database is accessible.
* Ensure that the schema and table names align with the expected configuration.

## 72004: Ingress cannot identify channel, no _ablyChannel field 

This error occurs when a [MongoDB Change Stream](https://www.mongodb.com/docs/manual/changeStreams/#change-streams) event does not contain the required `_ablyChannel` field after being processed through the Change Stream pipeline. This field is essential for identifying the channel where the change event message will be published.

Resolution: The following steps can help resolve this issue:
* Ensure that the `_ablyChannel` field is present at the root level of the change event.
* Avoid nesting it inside other sections, such as `$fullDocument._ablyChannel`.
* The field must be part of the main structure of the change event to allow proper identification.

## 72005: Ingress invalid pipeline 

This error occurs when the [MongoDB Change Stream](https://www.mongodb.com/docs/manual/changeStreams/#change-streams) fails to start due to an invalid pipeline. An example of this error is when the pipeline syntax does not conform to MongoDB's requirements or contains unrecognized operators.

Resolution: The following steps can help resolve this issue:
* Review the pipeline syntax for errors and ensure all operators are valid.
* Adjust the pipeline to match MongoDB's accepted structure and syntax guidelines.

## 72006: Unable to resume from change stream 

This error occurs when the [MongoDB Change Stream](https://www.mongodb.com/docs/manual/changeStreams/#change-streams) cannot be resumed because the resume token document stored in MongoDB is not in the correct format.

Resolution: The following steps can help resolve this issue:
* Verify the format of the stored resume token document in MongoDB.
* Ensure the token meets the expected structure and format required for MongoDB Change Stream resumption.
* Refer to the MongoDB documentation for guidelines on properly storing and using resume tokens.

## 72007: Unable to store change stream resume token 

This error occurs when the [MongoDB Change Stream](https://www.mongodb.com/docs/manual/changeStreams/#change-streams) resume token cannot be stored in the `ably` collection of the database.

Resolution: The following steps can help resolve this issue:
* Verify that the integration rule and MongoDB connection string are correctly configured.
* Ensure the database user has the necessary read and write permissions for the `ably` collection.
* Adjust permissions if needed to allow the token to be successfully stored.

## 80000: Connection failed 

This error occurs when the SDK is having trouble [connecting](https://ably.com/docs/connect/states.md#connection-states) to Ably, likely due to client-side network connectivity issues. Note: The SDK will automatically retry the connection after 30 seconds.

## 80002: Connection suspended 

This error occurs when the SDK is having trouble [connecting](https://ably.com/docs/connect/states.md#connection-states) to Ably. This is likely due to client-side network connectivity issues, and has failed to establish a connection within 2 minutes. Note: The SDK will automatically retry the connection after 15 seconds.

## 80003: Generic disconnection error 

This error occurs when the SDK is having trouble [connecting](https://ably.com/docs/connect/states.md#connection-states) to Ably, likely due to client-side network connectivity issues. Note: The SDK will automatically retry the connection after 15 seconds.

## 80008: Unable to recover connection (connection expired) 

This error occurs when a [connection](https://ably.com/docs/connect/states.md#connection-states) resume attempt fails because the original connection has expired. This typically happens when the [`resume`](https://ably.com/docs/connect/states.md#resume) attempt occurs after the two-minute window has passed.

If this error occurs, the client establishes a new connection instead of resuming the old one. Any messages sent during the gap will be missed, unless channel persistence is enabled.

Resolution: Ensure that resume attempts occur within the two-minute window to successfully recover a connection. If message loss is a concern, use [history](https://ably.com/docs/api/realtime-sdk/history.md) to retrieve missed messages.

## 80014: Connection timed out 

This error occurs when a realtime [connection](https://ably.com/docs/connect/states.md#connection-states) times out after waiting for the default 10-second `realtimeRequestTimeout` in certain Ably SDKs.

The request will be automatically retried by the SDK.

Resolution: If the client never connects to the [primary or fallback endpoints](https://faqs.ably.com/routing-around-network-and-dns-issues), check any firewall rules that may be blocking access to Ably's [endpoints](https://faqs.ably.com/if-i-need-to-whitelist-ablys-servers-from-a-firewall-which-ports-ips-and/or-domains-should-i-add).


## 80016: Operation on superseded connection 

This error occurs when a browser [connection](https://ably.com/docs/connect/states.md#connection-states) upgrades from an HTTP (Comet) transport to WebSockets. It is logged by the client library when operations are performed on the older transport.

Resolution: the following steps can help resolve this issue:
* If this error only appears in logs, it is harmless and does not affect your application. No action is needed.
* If you receive this error as a response to a request, contact Ably support with relevant logs and details, and they will investigate the issue.

## 80017: Connection closed 

This error occurs when a [connection](https://ably.com/docs/connect/states.md#connection-states) has been closed and an operation is attempted on it, such as calling a channel or presence method, for example, `channel.presence.update` while the connection is still in a closed state.

Resolution: The following steps can help resolve this issue:
* Check the client's connection state before performing operations to ensure the connection is active.
* If the connection is closed, reconnect before making requests to avoid this error.

## 80018: Invalid connection ID (invalid format) 

This error occurs when an invalid `connectionId` is supplied.

Resolution: If you are seeing resumes failing in ably-js, this was a known bug in ably-js versions 1.2.30 through 1.2.33. Upgrading to the latest version of ably-js should resolve the issue.

## 80019: Auth server rejecting request 

This error occurs when the client library fails to obtain a token using the client-supplied [`authUrl`](https://ably.com/docs/auth/token/jwt.md#auth-url) or [`authCallback`](https://ably.com/docs/auth/token/jwt.md#auth-callback). It is raised when the request to the authentication server fails due to an error or exception in the callback.

## 80020: Continuity loss due to maximum subscribe message rate exceeded 

This error occurs when a client exceeds the [outbound](https://ably.com/docs/platform/pricing/limits.md#connection) subscribe message rate on a realtime connection.

Resolution: The subscriber will receive an `UPDATE` [channel state change](https://ably.com/docs/api/realtime-sdk/channels.md#channel-state-change) event, indicating that continuity is lost. Use the [`resume`](https://ably.com/docs/connect/states.md#resume) flag to determine whether to recover missing messages or handle the failure accordingly.

## 80021: Max new connections rate exceeded 

This error occurs when the maximum allowed rate of new connections for an account has been [exceeded](https://ably.com/docs/platform/pricing/limits.md#hitting).

## 80022: Unable to find connection 

This error can occur when using the Comet transport, where a `send` or `recv` request is sent to the system but reaches a different frontend instance than the one hosting the connection. This can happen due to a disruption on a frontend instance.

Resolution: This is a non-fatal error, and no action is required. The transport will automatically drop and be re-initiated without any need for manual intervention.

## 80023: Unable to resume connection from a different site 

This error occurs when a disconnected client attempts to resume a [connection](https://ably.com/docs/connect.md) from a different site than the original connection. This typically happens when a client tries to [`resume`](https://ably.com/docs/connect/states.md#resume) via a fallback host.

Resolution: Channel message continuity will not be possible in this scenario. Any messages sent while the client was disconnected will need to be retrieved using [history](https://ably.com/docs/storage-history/history.md).

## 90001: Channel operation failed (invalid channel state) 

This error occurs when an application attempts to perform an operation on a channel that is in a [state](https://ably.com/docs/channels/states.md#connection-state) that does not permit it.

An example of this error is when an application tries to [publish](https://ably.com/docs/pub-sub.md#publish) a message or attach to a channel that is in a failed state due to a prior error. As a result, the operation fails because actions cannot be performed on a channel in this state.

Resolution: The following steps can help resolve this issue:
* Ensure the channel is in an appropriate state before performing any operations.
* Use an Ably SDK to listen for channel state changes and handle operations accordingly.
* Implement state change callbacks to trigger the intended operation when the channel is in a valid [state](https://ably.com/docs/channels/states.md).

## 90004: Unable to recover channel (message limit exceeded) 

This error occurs when using the rewind feature with a specified time period, and the total number of messages within the selected timeframe exceeds the maximum [limit](https://ably.com/docs/channels/options/rewind.md#limits) that can be retrieved in a single request.

## 90007: Channel didn't attach within 00:00:10 

This error occurs when a channel fails to [attach](https://ably.com/docs/channels/states.md#attach) within the default 10-second timeout. It is most commonly encountered by clients with poor internet connections, where the `ACK` response to an `ATTACH` request does not return within the expected timeframe.

Note: In older versions of the ably-java SDK, this error was incorrectly assigned to error code `91200`.

Resolution: Adjust the `realtimeRequestTimeout` or `channelRetryTimeout` (depending on the SDK) to a higher value to allow more time for the attachment process.

## 90010: Maximum number of channels per connection exceeded 

This error occurs when a Realtime client [attaches](https://ably.com/docs/channels/states.md#attach) to more channels than the account allows on a single connection. This happens when channels are attached but never explicitly detached, causing the limit to be reached.

Resolution: Review your channel [limits](https://ably.com/docs/platform/pricing/limits.md#channel) and ensure that channels are explicitly detached when no longer needed.

## 90021: Max channel creation rate exceeded 

This error occurs when the [maximum](https://ably.com/docs/platform/pricing/limits.md#channel) rate of channel creation has been exceeded, across an account. Until the rate returns below the limit, new channels may not be created immediately. The Ably SDK will automatically retry every 10 seconds until the request succeeds.

## 91000: Unable to enter presence channel (no clientId) 

This error occurs when a client attempts to [enter](https://ably.com/docs/chat/rooms/presence.md#set) the [presence](https://ably.com/docs/presence-occupancy/presence.md) set of a channel without specifying a `clientId`.

A client can be identified in several ways:
* If using [token](https://ably.com/docs/auth/token.md) authentication, ensure the token is associated with a `clientId` by setting the `clientId` field in `tokenParams` when creating a token request or requesting a token.
* If using basic authentication or token authentication with a wildcard `clientId`, set the `clientId` in the client options when initializing the Ably SDK.
* Specify a `clientId` at the time of entering presence using [`enterClient()`](https://ably.com/docs/api/realtime-sdk/presence.md#enterclient).

## 91003: Maximum member limit exceeded 

This error occurs when the [maximum](https://ably.com/docs/platform/pricing/limits.md#hitting) number of clients in the [presence](https://ably.com/docs/presence-occupancy/presence.md) set for a channel has been reached, preventing additional clients from joining.

## 91005: Presence state is out of sync 

This is a client-side issue that occurs when an up-to-date [presence](https://ably.com/docs/presence-occupancy/presence.md) set cannot be retrieved due to connection issues. It typically happens when calling `presence.get()` while the channel is in a suspended state, often caused by an interruption in the client's internet connection.

Resolution: The following steps can help resolve this issue:
* Ensure the client has an active connection before calling `presence.get()`.
* If an outdated presence set is acceptable, set `waitForSync` to `false` to retrieve the presence data even when out of sync.

## 92000: Invalid object message 

This error occurs when an object message used to represent [operations](https://ably.com/docs/liveobjects/concepts/operations.md) and [objects](https://ably.com/docs/liveobjects/concepts/objects.md) is malformed or contains invalid data that cannot be processed.

* If this error occurs when using the REST API, the error response will include additional details about how to correctly construct your request.
* If this error occurs when using a Realtime SDK, it likely indicates a bug in the client. Please raise an issue in the GitHub repository for the SDK you are using with relevant logs and details.

## 92001: Objects limit exceeded 

This error occurs when the maximum number of [objects](https://ably.com/docs/liveobjects.md) on the channel has exceeded the allowed [limit](https://ably.com/docs/platform/pricing/limits.md#channel) for the account or application.

Resolution:
* Remove any unnecessary objects from the channel to free up space, for example by [removing](https://ably.com/docs/liveobjects/map.md#remove) any references to them.
* [Upgrade](https://ably.com/docs/platform/pricing.md) your package to increase the [limit](https://ably.com/docs/platform/pricing/limits.md#channel) on the allowed number of objects on the channel.

## 92002: Unable to submit operation on tombstone object 

This error occurs when attempting to perform an [operation](https://ably.com/docs/liveobjects/concepts/operations.md) on a [tombstone](https://ably.com/docs/liveobjects/concepts/objects.md#tombstones) object (an object that has been marked as deleted).

Resolution:
* Retry the operation on an object that is not a tombstone and is [reachable](https://ably.com/docs/liveobjects/concepts/objects.md#reachability) from the [root object](https://ably.com/docs/liveobjects/concepts/objects.md#root-object) .

## 92003: Unable to fetch object tree with tombstone object as root 

This error occurs when attempting to fetch an [object](https://ably.com/docs/liveobjects/concepts/objects.md) tree where the specified object is a [tombstone](https://ably.com/docs/liveobjects/concepts/objects.md#tombstones) object (an object that has been marked as deleted).

You may encounter this error when [fetching objects](https://ably.com/docs/liveobjects/rest-api-usage.md#fetching-objects-get-children) via the REST API using the `children` query parameter, or if using the [compact](https://ably.com/docs/liveobjects/rest-api-usage.md#fetching-objects-compact) endpoint.

Resolution:
* Retry the operation on an object that is not a tombstone and is [reachable](https://ably.com/docs/liveobjects/concepts/objects.md#reachability) from the [root object](https://ably.com/docs/liveobjects/concepts/objects.md#root-object) .

## 92004: Object not found 

This error occurs when attempting to access an [object](https://ably.com/docs/liveobjects/concepts/objects.md) that does not exist.

You may encounter this error when using the [REST API](https://ably.com/docs/liveobjects/rest-api-usage.md) or if calling methods on a [LiveMap](https://ably.com/docs/liveobjects/map.md) or [LiveCounter](https://ably.com/docs/liveobjects/map.md) instance that has been deleted.

Resolution:
* Listen for [lifecycle events](https://ably.com/docs/liveobjects/lifecycle.md) on object instances to be notified when an object is deleted.
* Retry the REST API request with a valid [object ID](https://ably.com/docs/liveobjects/rest-api-usage.md#updating-objects-by-id) or [path](https://ably.com/docs/liveobjects/rest-api-usage.md#updating-objects-by-path) that corresponds to an existing object.

## 92005: No objects found matching operation path 

This error occurs when no objects are found that match the specified [path](https://ably.com/docs/liveobjects/rest-api-usage.md#updating-objects-by-path) when using the REST or Realtime Objects API. This may happen either because no object exists at that path, or because one or more path segments refer to a non-collection object type.

Resolution:
* Ensure that the `path` is correctly specified and corresponds to an existing object.

## 92006: Unable to perform operation without objectId or path 

This error occurs when attempting to perform an operation without providing either an [object ID](https://ably.com/docs/liveobjects/rest-api-usage.md#updating-objects-by-id) or [path](https://ably.com/docs/liveobjects/rest-api-usage.md#updating-objects-by-path) to identify the target object when using the REST API.

Resolution:
* Ensure that the request includes either an `objectId` or a `path` parameter to specify the target object for the operation.

## 92007: Operation not processable on path 

This error occurs when the requested operation cannot be processed for the object located at the specified [path](https://ably.com/docs/liveobjects/rest-api-usage.md#updating-objects-by-path) when using the REST or Realtime Objects API.

You may encounter this error when the type of the object located at the specified path does not support the specified operation (e.g. publishing a `COUNTER_INC` operation on a [LiveMap](https://ably.com/docs/liveobjects/map.md) instance).

Resolution:
* Ensure that the operation is valid for the type of object at the specified path.

## 92008: Unable to apply objects operation; objects sync did not complete 

This error occurs when a LiveObjects mutation operation has been successfully published to the server, but the operation could not be applied locally because the channel entered the `DETACHED`, `SUSPENDED`, or `FAILED` state while waiting for the objects sync to complete. The operation will still take effect on the server, but the local state may not reflect it until the channel is re-attached and the objects are re-synced.

## 93001: Attempt to add an annotation listener without having requested the annotation_subscribe channel mode 

This error occurs when attempting to [subscribe to individual annotations](https://ably.com/docs/messages/annotations.md#subscribe-individual-annotations) without having requested the `annotation_subscribe` [channel mode](https://ably.com/docs/channels/options.md#modes) .

**Resolution:**
* Ensure that `annotation_subscribe` mode is specified in the client [channel options](https://ably.com/docs/channels/options.md) before subscribing to individual annotations.

## 93002: Annotations are only supported on channels with message annotations, updates, deletes, and appends enabled 

This error occurs when attempting to use [message annotations](https://ably.com/docs/messages/annotations.md) on a channel that does not have them enabled.

**Resolution:**
* Create a [rule](https://ably.com/docs/channels.md#rules) for the channel or channel namespace with **Message annotations, updates, deletes, and appends** enabled.

## 101000: Space name missing 

This error occurs when calling [`spaces.get()`](https://ably.com/docs/spaces/space.md#options) without specifying a space name. The name parameter is required to retrieve a space.

Resolution: Ensure that a valid space name is provided when calling `spaces.get()`:

<Code>

### Javascript

```
const space = await spaces.get('mySpaceName');
```
</Code>

## 101001: Not entered space 

This error occurs when calling a function that requires the client to be [entered](https://ably.com/docs/spaces/space.md#enter) into a space, but the client has not yet done so.

Resolution: Ensure that `space.enter()` is called before performing operations that require the client to be inside the space:

<Code>

### Javascript

```
const space = await spaces.get('mySpace');
space.enter({
  username: 'Claire Lemons',
  avatar: 'https://slides-internal.com/users/clemons.png',
});
```
</Code>

## 101002: Lock request exists 

This error occurs when an existing [lock request](https://ably.com/docs/spaces/locking.md#states) is still pending or locked. Nested locks are not supported, so a new lock cannot be requested until the previous one is resolved.

## 101003: Lock is locked 

This error occurs when a lock is already in the [locked state](https://ably.com/docs/spaces/locking.md#states), and a pending request did not override or release the lock.

## 101004: Lock invalidated 

This error occurs when a [lock request](https://ably.com/docs/spaces/locking.md#states) invalidates an existing lock that was already in the locked state.

## Related Topics

- [Support tickets](https://ably.com/docs/platform/support.md): Learn more about Ably's AI Transport and the features that enable you to quickly build functionality into new and existing applications.
- [Debugging](https://ably.com/docs/platform/errors.md): Debugging in Ably supported apps, including troubleshooting techniques, logging options, and tools for error analysis.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
