# Rooms occupancy get

Use the `ably rooms occupancy get` command to get the current occupancy metrics for a chat room.

## Synopsis

<Code>

### Shell

```
ably rooms occupancy get <room-name> [options]
```
</Code>

## Arguments

### `room-name`  **(Required)**

The name of the chat room to get occupancy for.

## Options

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Get current occupancy for a room:

<Code>

### Shell

```
ably rooms occupancy get my-room
```
</Code>

Get occupancy in JSON format:

<Code>

### Shell

```
ably rooms occupancy get my-room --json
```
</Code>

Get room occupancy using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably rooms occupancy get my-room
```
</Code>

Get room occupancy in formatted JSON output:

<Code>

### Shell

```
ably rooms occupancy get my-room --pretty-json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscribe](https://ably.com/docs/cli/rooms/occupancy/subscribe.md): Subscribe to real-time occupancy metrics for an Ably Chat room using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
