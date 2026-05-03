# Auth keys update

Use the `ably auth keys update` command to update the name or capabilities of an API key.

## Synopsis

<Code>

### Shell

```
ably auth keys update <key-name-or-value> [options]
```
</Code>

## Arguments

### `key-name-or-value`  **(Required)**

The key name (`APP_ID.KEY_ID`) or full key value (`APP_ID.KEY_ID:KEY_SECRET`) of the API key to update.

## Options

### `--name` 

The new name for the API key.

### `--capabilities` 

New [capabilities](https://ably.com/docs/auth/capabilities.md) for the key, specified as either a JSON object for per-channel capabilities or a comma-separated list applied to all channels. Available operations are `subscribe`, `publish`, `presence`, `history`, `stats`, `channel-metadata`, `push-subscribe`, `push-admin`, `privileged-headers`, `object-subscribe`, `object-publish`, `annotation-subscribe`, `annotation-publish`, `message-update-own`, `message-update-any`, `message-delete-own`, and `message-delete-any`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Rename an API key:

<Code>

### Shell

```
ably auth keys update "aBcDeF.gHiJkL" --name "New Name"
```
</Code>

Update a key using its full key value:

<Code>

### Shell

```
ably auth keys update "aBcDeF.gHiJkL:keySecret" --name "New Name"
```
</Code>

Update the capabilities for a key using a JSON object for per-channel control:

<Code>

### Shell

```
ably auth keys update "APP_ID.KEY_ID" --capabilities '{"channel1":["publish"],"channel2":["subscribe"]}'
```
</Code>

Update key capabilities using a comma-separated list:

<Code>

### Shell

```
ably auth keys update "APP_ID.KEY_ID" --capabilities "publish,subscribe,history"
```
</Code>

Update a key and output the result in JSON format:

<Code>

### Shell

```
ably auth keys update "APP_ID.KEY_ID" --name "New Name" --capabilities "publish,subscribe" --json
```
</Code>

## See also

* [Auth](https://ably.com/docs/cli/auth.md) — Explore all `ably auth` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/auth/keys/create.md): Create a new API key for an Ably app using the CLI.
- [current](https://ably.com/docs/cli/auth/keys/current.md): Show the current API key for the selected Ably app using the CLI.
- [get](https://ably.com/docs/cli/auth/keys/get.md): Get details for a specific API key using the CLI.
- [list](https://ably.com/docs/cli/auth/keys/list.md): List all API keys for an Ably app using the CLI.
- [revoke](https://ably.com/docs/cli/auth/keys/revoke.md): Permanently revoke an API key using the CLI.
- [switch](https://ably.com/docs/cli/auth/keys/switch.md): Switch to a different API key for the current Ably app using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
