# Auth keys get

Use the `ably auth keys get` command to get details for a specific API key.

## Synopsis

<Code>

### Shell

```
ably auth keys get <key-name-or-value> [options]
```
</Code>

## Arguments

### `key-name-or-value`  **(Required)**

The key name (`APP_ID.KEY_ID`) or full key value (`APP_ID.KEY_ID:KEY_SECRET`) to get details for.

## Options

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Get a key by its key name:

<Code>

### Shell

```
ably auth keys get "aBcDeF.gHiJkL"
```
</Code>

Get a key by its full key value:

<Code>

### Shell

```
ably auth keys get "aBcDeF.gHiJkL:keySecret"
```
</Code>

Get a key and output in JSON format:

<Code>

### Shell

```
ably auth keys get "APP_ID.KEY_ID" --json
```
</Code>

## See also

* [Auth](https://ably.com/docs/cli/auth.md) — Explore all `ably auth` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/auth/keys/create.md): Create a new API key for an Ably app using the CLI.
- [current](https://ably.com/docs/cli/auth/keys/current.md): Show the current API key for the selected Ably app using the CLI.
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
