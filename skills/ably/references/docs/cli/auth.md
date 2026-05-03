# Auth

Use the `ably auth` command group to manage authentication, API keys, and tokens. These commands enable you to issue and revoke tokens, and manage API keys for your apps.

## Token management commands 

Use the following commands to issue and revoke [Ably tokens and JWTs](https://ably.com/docs/auth.md). Tokens provide short-lived, scopeable access for client-side authentication:

| Command | Description |
| ------- | ----------- |
| [`ably auth issue-ably-token`](https://ably.com/docs/cli/auth/issue-ably-token.md) | Create an Ably Token with specified capabilities. |
| [`ably auth issue-jwt-token`](https://ably.com/docs/cli/auth/issue-jwt-token.md) | Create an Ably JWT token with specified capabilities. |
| [`ably auth revoke-token`](https://ably.com/docs/cli/auth/revoke-token.md) | Revoke Ably tokens by client ID or revocation key. |

## Key management commands 

Use the following commands to manage [API keys](https://ably.com/docs/platform/account/app/api.md) for your Ably apps. API keys control access to your account's resources through configurable capabilities such as publish, subscribe, and history:

| Command | Description |
| ------- | ----------- |
| [`ably auth keys create`](https://ably.com/docs/cli/auth/keys/create.md) | Create a new API key for an app. |
| [`ably auth keys current`](https://ably.com/docs/cli/auth/keys/current.md) | Show the current API key for the selected app. |
| [`ably auth keys get`](https://ably.com/docs/cli/auth/keys/get.md) | Get details for a specific API key. |
| [`ably auth keys list`](https://ably.com/docs/cli/auth/keys/list.md) | List all API keys for an app. |
| [`ably auth keys revoke`](https://ably.com/docs/cli/auth/keys/revoke.md) | Permanently revoke an API key. |
| [`ably auth keys switch`](https://ably.com/docs/cli/auth/keys/switch.md) | Switch to a different API key for the current app. |
| [`ably auth keys update`](https://ably.com/docs/cli/auth/keys/update.md) | Update an API key's properties. |

## See also

* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
