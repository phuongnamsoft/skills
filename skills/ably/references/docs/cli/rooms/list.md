# Rooms list

Use the `ably rooms list` command to list active chat rooms.

## Synopsis

<Code>

### Shell

```
ably rooms list [options]
```
</Code>

## Options

### `--limit` 

The maximum number of rooms to return. Defaults to `100`.

### `--prefix | -p` 

Filter rooms by a name prefix.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

List all active chat rooms:

<Code>

### Shell

```
ably rooms list
```
</Code>

Filter rooms by prefix:

<Code>

### Shell

```
ably rooms list --prefix "game-"
```
</Code>

List rooms with a custom limit:

<Code>

### Shell

```
ably rooms list --limit 50
```
</Code>

List rooms in JSON format:

<Code>

### Shell

```
ably rooms list --json
```
</Code>

List rooms in formatted JSON output:

<Code>

### Shell

```
ably rooms list --pretty-json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
