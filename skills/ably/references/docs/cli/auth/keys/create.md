# Auth keys create

Use the `ably auth keys create` command to create a new API key for an app.

## Synopsis

<Code>

### Shell

```
ably auth keys create <key-name> [options]
```
</Code>

## Arguments

### `key-name`  **(Required)**

The name for the new API key.

## Options

### `--app` 

The app ID to create the key for. Uses the currently selected app if not specified.

### `--capabilities` 

The [capabilities](https://ably.com/docs/auth/capabilities.md) for the key, specified as either a JSON object for per-channel capabilities or a comma-separated list applied to all channels. Defaults to `'{"*":["*"]}'`. Available operations are `subscribe`, `publish`, `presence`, `history`, `stats`, `channel-metadata`, `push-subscribe`, `push-admin`, `privileged-headers`, `object-subscribe`, `object-publish`, `annotation-subscribe`, `annotation-publish`, `message-update-own`, `message-update-any`, `message-delete-own`, and `message-delete-any`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Create a basic API key:

<Code>

### Shell

```
ably auth keys create "My New Key"
```
</Code>

Create a key with specific capabilities:

<Code>

### Shell

```
ably auth keys create "My New Key" --capabilities '{"my-channel":["publish"]}'
```
</Code>

Create an API key for a specific app:

<Code>

### Shell

```
ably auth keys create "My New Key" --app APP_ID
```
</Code>

Create a key with wildcard capabilities:

<Code>

### Shell

```
ably auth keys create "My New Key" --capabilities '{"*":["*"]}'
```
</Code>

Create a key with capabilities for multiple channels:

<Code>

### Shell

```
ably auth keys create "My New Key" --capabilities '{"channel1":["publish","subscribe"],"channel2":["history"]}'
```
</Code>

Create a key using a comma-separated list of capabilities applied to all channels:

<Code>

### Shell

```
ably auth keys create "My New Key" --capabilities "publish,subscribe"
```
</Code>

Create a key with namespace-scoped publish capability:

<Code>

### Shell

```
ably auth keys create "MyKey" --app APP_ID --capabilities '{"channel:*":["publish"]}'
```
</Code>

Create a key with mixed capabilities for a specific app:

<Code>

### Shell

```
ably auth keys create "MyOtherKey" --app APP_ID --capabilities '{"channel:chat-*":["subscribe"],"channel:updates":["publish"]}'
```
</Code>

Create a key and output the result in JSON format:

<Code>

### Shell

```
ably auth keys create "My New Key" --json
```
</Code>

Create a key and output the result in formatted JSON:

<Code>

### Shell

```
ably auth keys create "My New Key" --pretty-json
```
</Code>

## See also

* [Auth](https://ably.com/docs/cli/auth.md) — Explore all `ably auth` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [current](https://ably.com/docs/cli/auth/keys/current.md): Show the current API key for the selected Ably app using the CLI.
- [get](https://ably.com/docs/cli/auth/keys/get.md): Get details for a specific API key using the CLI.
- [list](https://ably.com/docs/cli/auth/keys/list.md): List all API keys for an Ably app using the CLI.
- [revoke](https://ably.com/docs/cli/auth/keys/revoke.md): Permanently revoke an API key using the CLI.
- [switch](https://ably.com/docs/cli/auth/keys/switch.md): Switch to a different API key for the current Ably app using the CLI.
- [update](https://ably.com/docs/cli/auth/keys/update.md): Update the name or capabilities of an API key using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
