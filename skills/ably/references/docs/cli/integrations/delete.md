# Integrations delete

Use the `ably integrations delete` command to delete an integration rule.

## Synopsis

<Code>

### Shell

```
ably integrations delete <integration-id> [options]
```
</Code>

## Arguments

### `integration-id`  **(Required)**

The ID of the integration rule to delete.

## Options

### `--app` 

The app ID that the integration rule belongs to. If not specified, the currently selected app is used.

### `--force | -f` 

Skip the confirmation prompt and delete the integration rule immediately. Required when using `--json`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Delete an integration rule by ID:

<Code>

### Shell

```
ably integrations delete aBcDe1
```
</Code>

Delete an integration rule without a confirmation prompt:

<Code>

### Shell

```
ably integrations delete aBcDe1 --force
```
</Code>

Delete an integration rule for a specific app:

<Code>

### Shell

```
ably integrations delete integration123 --app "My App"
```
</Code>

Delete an integration rule and output the result in JSON format:

<Code>

### Shell

```
ably integrations delete integration123 --json
```
</Code>

## See also

* [Integrations](https://ably.com/docs/cli/integrations.md) — Explore all `ably integrations` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/integrations/create.md): Create an integration rule using the Ably CLI.
- [get](https://ably.com/docs/cli/integrations/get.md): Get an integration rule by ID using the Ably CLI.
- [list](https://ably.com/docs/cli/integrations/list.md): List all integration rules using the Ably CLI.
- [update](https://ably.com/docs/cli/integrations/update.md): Update an integration rule using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
