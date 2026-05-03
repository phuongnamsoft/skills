# Auth keys revoke

Use the `ably auth keys revoke` command to permanently revoke an API key.

## Synopsis

<Code>

### Shell

```
ably auth keys revoke <key-name-or-value> [options]
```
</Code>

## Arguments

### `key-name-or-value`  **(Required)**

The key name (`APP_ID.KEY_ID`) or full key value (`APP_ID.KEY_ID:KEY_SECRET`) of the API key to revoke.

## Options

### `--force | -f` 

Skip the confirmation prompt and revoke the key immediately. Required when using `--json`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Revoke an API key by key name:

<Code>

### Shell

```
ably auth keys revoke "aBcDeF.gHiJkL"
```
</Code>

Revoke an API key by full key value:

<Code>

### Shell

```
ably auth keys revoke "aBcDeF.gHiJkL:keySecret"
```
</Code>

Force revoke without confirmation:

<Code>

### Shell

```
ably auth keys revoke "aBcDeF.gHiJkL" --force
```
</Code>

Revoke a key and output the result in JSON format:

<Code>

### Shell

```
ably auth keys revoke "APP_ID.KEY_ID" --json
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
- [switch](https://ably.com/docs/cli/auth/keys/switch.md): Switch to a different API key for the current Ably app using the CLI.
- [update](https://ably.com/docs/cli/auth/keys/update.md): Update the name or capabilities of an API key using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
