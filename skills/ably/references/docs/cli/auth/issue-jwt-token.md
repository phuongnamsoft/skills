# Auth issue-jwt-token

Use the `ably auth issue-jwt-token` command to create an Ably JWT token with specified capabilities.

## Synopsis

<Code>

### Shell

```
ably auth issue-jwt-token [options]
```
</Code>

## Options

### `--app` 

The app ID to issue the token for. Uses the currently selected app if not specified.

### `--capability` 

A JSON string specifying the [capabilities](https://ably.com/docs/auth/capabilities.md) for the token. Defaults to `'{"*":["*"]}'`. Available operations are `subscribe`, `publish`, `presence`, `history`, `stats`, `channel-metadata`, `push-subscribe`, `push-admin`, `privileged-headers`, `object-subscribe`, `object-publish`, `annotation-subscribe`, `annotation-publish`, `message-update-own`, `message-update-any`, `message-delete-own`, and `message-delete-any`.

### `--client-id` 

The client ID to associate with the token. Use `"none"` to issue a token with no client ID.

### `--ttl` 

The time to live for the token in seconds. Defaults to `3600`.

### `--token-only` 

Output only the token string, without any additional information.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Issue a default Ably JWT token:

<Code>

### Shell

```
ably auth issue-jwt-token
```
</Code>

Issue a JWT token with specific capabilities:

<Code>

### Shell

```
ably auth issue-jwt-token --capability '{"my-channel":["publish","subscribe"]}'
```
</Code>

Output only the token string:

<Code>

### Shell

```
ably auth issue-jwt-token --token-only
```
</Code>

Issue a JWT with multiple channel capabilities and a custom TTL:

<Code>

### Shell

```
ably auth issue-jwt-token --capability '{"chat:*":["publish","subscribe"], "status:*":["subscribe"]}' --ttl 3600
```
</Code>

Issue a JWT with a specific client ID and 24-hour TTL:

<Code>

### Shell

```
ably auth issue-jwt-token --client-id client123 --ttl 86400
```
</Code>

Use a JWT inline to publish a message to a channel:

<Code>

### Shell

```
ABLY_TOKEN="$(ably auth issue-jwt-token --token-only)" ably channels publish my-channel "Hello"
```
</Code>

Issue a JWT and output the full result in JSON format:

<Code>

### Shell

```
ably auth issue-jwt-token --json
```
</Code>

Issue a JWT and output the full result in formatted JSON:

<Code>

### Shell

```
ably auth issue-jwt-token --pretty-json
```
</Code>

## See also

* [Auth](https://ably.com/docs/cli/auth.md) — Explore all `ably auth` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [issue-ably-token](https://ably.com/docs/cli/auth/issue-ably-token.md): Create an Ably Token with specified capabilities using the CLI.
- [revoke-token](https://ably.com/docs/cli/auth/revoke-token.md): Revoke Ably tokens by client ID or revocation key using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
