# Spaces cursors get

Use the `ably spaces cursors get` command to get all current cursors in a space.

## Synopsis

<Code>

### Shell

```
ably spaces cursors get <space-name>
```
</Code>

## Arguments

### `space-name`  **(Required)**

The name of the space to get cursors for.

## Options

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Get all cursors in a space:

<Code>

### Shell

```
ably spaces cursors get my-space
```
</Code>

Get cursors in JSON format:

<Code>

### Shell

```
ably spaces cursors get my-space --json
```
</Code>

Get cursors in formatted JSON output:

<Code>

### Shell

```
ably spaces cursors get my-space --pretty-json
```
</Code>

## See also

* [Spaces](https://ably.com/docs/cli/spaces.md) — Explore all `ably spaces` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [set](https://ably.com/docs/cli/spaces/cursors/set.md): Set a cursor with position data in an Ably Space using the CLI.
- [subscribe](https://ably.com/docs/cli/spaces/cursors/subscribe.md): Subscribe to cursor movements in an Ably Space using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
