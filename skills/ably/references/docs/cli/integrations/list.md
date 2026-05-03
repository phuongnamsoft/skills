# Integrations list

Use the `ably integrations list` command to list all integration rules for an application.

## Synopsis

<Code>

### Shell

```
ably integrations list [options]
```
</Code>

## Options

### `--app` 

The app ID to list integration rules for. If not specified, the currently selected app is used.

### `--limit` 

The maximum number of integration rules to return. The default value is `100`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

List all integration rules:

<Code>

### Shell

```
ably integrations list
```
</Code>

List integration rules for a specific app:

<Code>

### Shell

```
ably integrations list --app aBcDe1
```
</Code>

List integration rules for a specific app in formatted JSON:

<Code>

### Shell

```
ably integrations list --app "My App" --pretty-json
```
</Code>

## See also

* [Integrations](https://ably.com/docs/cli/integrations.md) — Explore all `ably integrations` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/integrations/create.md): Create an integration rule using the Ably CLI.
- [delete](https://ably.com/docs/cli/integrations/delete.md): Delete an integration rule using the Ably CLI.
- [get](https://ably.com/docs/cli/integrations/get.md): Get an integration rule by ID using the Ably CLI.
- [update](https://ably.com/docs/cli/integrations/update.md): Update an integration rule using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
