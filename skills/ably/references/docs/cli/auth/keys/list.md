# Auth keys list

Use the `ably auth keys list` command to list all API keys for an app.

## Synopsis

<Code>

### Shell

```
ably auth keys list [options]
```
</Code>

## Options

### `--app` 

The app ID to list keys for. Uses the currently selected app if not specified.

### `--limit` 

The maximum number of keys to return. Defaults to `100`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

List all API keys for the current app:

<Code>

### Shell

```
ably auth keys list
```
</Code>

List keys for a specific app:

<Code>

### Shell

```
ably auth keys list --app "aBcDeF"
```
</Code>

List API keys in JSON format:

<Code>

### Shell

```
ably auth keys list --json
```
</Code>

List API keys in formatted JSON output:

<Code>

### Shell

```
ably auth keys list --pretty-json
```
</Code>

## See also

* [Auth](https://ably.com/docs/cli/auth.md) — Explore all `ably auth` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/auth/keys/create.md): Create a new API key for an Ably app using the CLI.
- [current](https://ably.com/docs/cli/auth/keys/current.md): Show the current API key for the selected Ably app using the CLI.
- [get](https://ably.com/docs/cli/auth/keys/get.md): Get details for a specific API key using the CLI.
- [revoke](https://ably.com/docs/cli/auth/keys/revoke.md): Permanently revoke an API key using the CLI.
- [switch](https://ably.com/docs/cli/auth/keys/switch.md): Switch to a different API key for the current Ably app using the CLI.
- [update](https://ably.com/docs/cli/auth/keys/update.md): Update the name or capabilities of an API key using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
