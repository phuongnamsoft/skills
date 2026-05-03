# Authentication overview

All interactions between a client and the Ably service must be authenticated.

## Recommended authentication 

| Environment | Recommended Method | Details |
|-------------|-------------------|---------|
| Client-side (browsers, mobile apps) | [Token authentication](https://ably.com/docs/auth/token.md) | Your server issues tokens ([JWT](https://ably.com/docs/auth/token/jwt.md) recommended); clients use `authCallback` to fetch them |
| Server-side (Node.js, Python, etc.) | [Basic authentication](https://ably.com/docs/auth/basic.md) | Use your API key directly in trusted environments |

<Aside data-type='important'>
Never use API keys in client-side code (that is, code that is not running in a server, but a client device such as a mobile or web app). API keys don't expire; once compromised, they grant indefinite access. Use [token authentication](https://ably.com/docs/auth/token.md) with tokens that have narrowly-scoped capabilities, are short-lived, and can be revoked.
</Aside>

## Ably API keys 

Every Ably app can have one or more API keys associated with it. API keys authenticate directly with Ably or are used to issue tokens.

Keys can have different [capabilities](https://ably.com/docs/auth/capabilities.md), and tokens issued from a key can only request a subset of those capabilities.

### API key format 

An Ably API key string has the following format: `I2E_JQ.OqUdfg:EVKVTCBlzLBPYJiCZTsIW_pqylJ9WVRB5K9P19Ap1y0`

The API key has three parts:

1. `I2E_JQ` - the public app ID
2. `OqUdfg` - the public key ID (`I2E_JQ.OqUdfg` together form the public API key ID)
3. `EVKVTCBlzLBPYJiCZTsIW_pqylJ9WVRB5K9P19Ap1y0` - the API key secret (never share this)

### Create an API key 

API keys are created in the [Ably dashboard](https://ably.com/dashboard) or programmatically via the [Control API](https://ably.com/docs/platform/account/control-api.md).

To create an API key in the dashboard:

1. Click the **API Keys** tab in your [dashboard](https://ably.com/accounts/any/apps/any/app_keys).
2. Click **Create a new API key**.
3. Enter a name to identify the key.
4. Select the [capabilities](https://ably.com/docs/auth/capabilities.md) to apply.
5. Optionally enable [token revocation](https://ably.com/docs/auth/revocation.md).
6. Optionally restrict scope to specific channels or queues.

<Aside data-type="note">
Code samples in this documentation use basic authentication for convenience. In production, never use basic authentication client-side as it exposes your API key.
</Aside>

## Selecting an authentication mechanism 

Ably supports two authentication mechanisms:

1. **[Token authentication](https://ably.com/docs/auth/token.md)**: Short-lived Ably Tokens that expire and can be revoked. Recommended for clients. Use [JWTs](https://ably.com/docs/auth/token/jwt.md) for most applications, or native [Ably Tokens](https://ably.com/docs/auth/token/ably-tokens.md) when JWTs aren't suitable.
2. **[Basic authentication](https://ably.com/docs/auth/basic.md)**: Uses your API key directly. Use only on trusted servers.

When deciding which method to use, apply the [principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege): a client should only possess the credentials and rights it needs. If credentials are compromised, the damage is minimized.

Many applications use a mixed strategy: trusted servers use basic authentication to issue tokens, while browsers and devices use those tokens.

| Scenario | Recommended | Details |
|----------|-------------|---------|
| Client-side (browsers, mobile) | JWT | Use [JWT authentication](https://ably.com/docs/auth/token/jwt.md). No Ably SDK needed on your server |
| Server-side (trusted environment) | Basic auth | Use your [API key](https://ably.com/docs/auth.md#api-keys) directly |
| Fine-grained per-user access control | JWT or Ably Token | Set [capabilities](https://ably.com/docs/auth/capabilities.md) per token |
| Time-limited or revocable access | JWT or Ably Token | Tokens expire and can be [revoked](https://ably.com/docs/auth/revocation.md) |
| Channel-scoped user claims | JWT only | Embed trusted metadata via [channel-scoped claims](https://ably.com/docs/auth/token/jwt.md#channel-claims) |
| Per-connection rate limits | JWT only | Restrict publish rates via [rate limit claims](https://ably.com/docs/auth/token/jwt.md#rate-limits) |
| Large capability list or confidential capabilities | Ably Token | JWTs have size limits and can be decoded by clients. Use [Ably Tokens](https://ably.com/docs/auth/token/ably-tokens.md) |
| Users must be identified | JWT or Ably Token | Set `clientId` server-side. See [identified clients](https://ably.com/docs/auth/identified-clients.md) |

## Related Topics

- [Basic auth](https://ably.com/docs/auth/basic.md): Basic authentication allows you to authenticate a secure server using an Ably API key and secret.
- [Token revocation](https://ably.com/docs/auth/revocation.md): Token revocation is a mechanism that enables an app to invalidate authentication tokens.
- [Identified clients](https://ably.com/docs/auth/identified-clients.md): Clients can be allocated a client ID to help control their operations and interactions with Ably channels.
- [Capabilities](https://ably.com/docs/auth/capabilities.md): Capabilities define which operations can be carried out on which channels by a client.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
