# Auth revoke-token

Use the `ably auth revoke-token` command to revoke Ably tokens by client ID or revocation key. The Ably revocation API does not support revoking a single token by its string value, so you must target tokens using one of these specifiers. See [token revocation](https://ably.com/docs/auth/revocation.md) for details.

## Synopsis

<Code>

### Shell

```
ably auth revoke-token [options]
```
</Code>

<Aside data-type="important">
Token revocation is irreversible. All tokens matching the supplied target are revoked, and any clients using those tokens will need to obtain new ones.
</Aside>

## Options

You must provide either `--client-id` or `--revocation-key`. The two flags are mutually exclusive.

### `--app` 

The app ID or name the tokens belong to. Uses the currently selected app if not specified.

### `--client-id` 

Revoke all tokens issued to this client ID. Mutually exclusive with `--revocation-key`.

### `--revocation-key` 

Revoke all tokens matching this revocation key. Only applies to JWT tokens that include the `x-ably-revocation-key` claim. Mutually exclusive with `--client-id`.

### `--allow-reauth-margin` 

Delay enforcement of the revocation by 30 seconds, giving connected clients a grace period to obtain new tokens before being disconnected. Defaults to `false`.

### `--force | -f` 

Skip the confirmation prompt and revoke tokens immediately. Required when using `--json` or `--pretty-json`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Revoke all tokens for a specific client ID:

<Code>

### Shell

```
ably auth revoke-token --client-id "userClientId"
```
</Code>

Revoke tokens without the confirmation prompt:

<Code>

### Shell

```
ably auth revoke-token --client-id "userClientId" --force
```
</Code>

Revoke all JWT tokens that share a revocation key:

<Code>

### Shell

```
ably auth revoke-token --revocation-key group1
```
</Code>

Revoke tokens with a 30-second grace period for connected clients to reauthenticate:

<Code>

### Shell

```
ably auth revoke-token --client-id "userClientId" --allow-reauth-margin
```
</Code>

Revoke tokens and output the result in JSON format (requires `--force`):

<Code>

### Shell

```
ably auth revoke-token --client-id "userClientId" --json --force
```
</Code>

## See also

* [Token revocation](https://ably.com/docs/auth/revocation.md) — How Ably token revocation works.
* [Auth](https://ably.com/docs/cli/auth.md) — Explore all `ably auth` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [issue-ably-token](https://ably.com/docs/cli/auth/issue-ably-token.md): Create an Ably Token with specified capabilities using the CLI.
- [issue-jwt-token](https://ably.com/docs/cli/auth/issue-jwt-token.md): Create an Ably JWT token with specified capabilities using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
