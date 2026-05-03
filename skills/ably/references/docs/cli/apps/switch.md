# Apps switch

Use the `ably apps switch` command to switch to a different Ably application. The selected app is used as the default for subsequent commands.

## Synopsis

<Code>

### Shell

```
ably apps switch [app-name-or-id] [options]
```
</Code>

## Arguments

### `app-name-or-id` 

The app name or ID to switch to. If not specified, the CLI will display an interactive prompt to select an app.

## Options

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Switch to an app using the interactive prompt:

<Code>

### Shell

```
ably apps switch
```
</Code>

Switch to a specific app by name:

<Code>

### Shell

```
ably apps switch "My App"
```
</Code>

Switch to a specific app by ID:

<Code>

### Shell

```
ably apps switch "my-app-id"
```
</Code>

## See also

* [Apps](https://ably.com/docs/cli/apps.md) — Explore all `ably apps` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/apps/create.md): Create a new Ably application using the CLI.
- [current](https://ably.com/docs/cli/apps/current.md): Show the currently selected Ably application using the CLI.
- [delete](https://ably.com/docs/cli/apps/delete.md): Permanently delete an Ably application using the CLI.
- [list](https://ably.com/docs/cli/apps/list.md): List all Ably applications in the current account using the CLI.
- [update](https://ably.com/docs/cli/apps/update.md): Update the name or TLS setting of an Ably application using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
