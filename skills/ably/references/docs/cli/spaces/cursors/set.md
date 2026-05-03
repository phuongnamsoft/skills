# Spaces cursors set

Use the `ably spaces cursors set` command to set a cursor with position data in a space.

## Synopsis

<Code>

### Shell

```
ably spaces cursors set <space-name> [options]
```
</Code>

## Arguments

### `space-name`  **(Required)**

The name of the space to set the cursor in.

## Options

### `--x` 

The x coordinate of the cursor position.

### `--y` 

The y coordinate of the cursor position.

### `--data` 

JSON cursor data to associate with the cursor.

### `--simulate` 

Simulate random cursor movement. Defaults to `false`.

### `--duration | -D` 

The duration in seconds to maintain the cursor before automatically removing it.

### `--client-id` 

A client ID to use when setting the cursor.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Set a cursor position:

<Code>

### Shell

```
ably spaces cursors set my-space --x 100 --y 200
```
</Code>

Set a cursor with additional data:

<Code>

### Shell

```
ably spaces cursors set my-space --x 100 --y 200 --data '{"color": "red"}'
```
</Code>

Simulate random cursor movement:

<Code>

### Shell

```
ably spaces cursors set my-space --simulate --duration 30
```
</Code>

Simulate cursor movement starting from specific coordinates:

<Code>

### Shell

```
ably spaces cursors set my-space --simulate --x 500 --y 500
```
</Code>

Set a cursor position using a data payload:

<Code>

### Shell

```
ably spaces cursors set my-space --data '{"position": {"x": 100, "y": 200}}'
```
</Code>

Set a cursor position with user profile data:

<Code>

### Shell

```
ably spaces cursors set my-space --data '{"position": {"x": 100, "y": 200}, "data": {"name": "John", "color": "#ff0000"}}'
```
</Code>

Set a cursor position using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably spaces cursors set my-space --x 100 --y 200
```
</Code>

Set a cursor position and output in JSON format:

<Code>

### Shell

```
ably spaces cursors set my-space --x 100 --y 200 --json
```
</Code>

Set a cursor position and output in formatted JSON:

<Code>

### Shell

```
ably spaces cursors set my-space --x 100 --y 200 --pretty-json
```
</Code>

## See also

* [Spaces](https://ably.com/docs/cli/spaces.md) — Explore all `ably spaces` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [get](https://ably.com/docs/cli/spaces/cursors/get.md): Get all current cursors in an Ably Space using the CLI.
- [subscribe](https://ably.com/docs/cli/spaces/cursors/subscribe.md): Subscribe to cursor movements in an Ably Space using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
