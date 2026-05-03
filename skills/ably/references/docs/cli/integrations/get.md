# Integrations get

Use the `ably integrations get` command to retrieve the details of an integration rule by its ID.

## Synopsis

<Code>

### Shell

```
ably integrations get <integration-id> [options]
```
</Code>

## Arguments

### `integration-id`  **(Required)**

The ID of the integration rule to retrieve.

## Options

### `--app` 

The app ID that the integration rule belongs to. If not specified, the currently selected app is used.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Get an integration rule:

<Code>

### Shell

```
ably integrations get aBcDe1
```
</Code>

Get an integration rule in JSON format:

<Code>

### Shell

```
ably integrations get aBcDe1 --json
```
</Code>

Get an integration rule for a specific app in formatted JSON:

<Code>

### Shell

```
ably integrations get rule123 --app "My App" --pretty-json
```
</Code>

## See also

* [Integrations](https://ably.com/docs/cli/integrations.md) — Explore all `ably integrations` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/integrations/create.md): Create an integration rule using the Ably CLI.
- [delete](https://ably.com/docs/cli/integrations/delete.md): Delete an integration rule using the Ably CLI.
- [list](https://ably.com/docs/cli/integrations/list.md): List all integration rules using the Ably CLI.
- [update](https://ably.com/docs/cli/integrations/update.md): Update an integration rule using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
