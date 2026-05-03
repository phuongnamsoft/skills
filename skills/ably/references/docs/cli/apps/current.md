# Apps current

Use the `ably apps current` command to display information about the currently selected Ably application.

## Synopsis

<Code>

### Shell

```
ably apps current
```
</Code>

## Options

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Show the currently selected app:

<Code>

### Shell

```
ably apps current
```
</Code>

Show the currently selected app in JSON format:

<Code>

### Shell

```
ably apps current --json
```
</Code>

Show the currently selected app in formatted JSON output:

<Code>

### Shell

```
ably apps current --pretty-json
```
</Code>

## See also

* [Apps](https://ably.com/docs/cli/apps.md) — Explore all `ably apps` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/apps/create.md): Create a new Ably application using the CLI.
- [delete](https://ably.com/docs/cli/apps/delete.md): Permanently delete an Ably application using the CLI.
- [list](https://ably.com/docs/cli/apps/list.md): List all Ably applications in the current account using the CLI.
- [switch](https://ably.com/docs/cli/apps/switch.md): Switch to a different Ably application using the CLI.
- [update](https://ably.com/docs/cli/apps/update.md): Update the name or TLS setting of an Ably application using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
