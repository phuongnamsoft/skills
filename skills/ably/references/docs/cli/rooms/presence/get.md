# Rooms presence get

Use the `ably rooms presence get` command to get all current presence members in a chat room.

## Synopsis

<Code>

### Shell

```
ably rooms presence get <room-name> [options]
```
</Code>

## Arguments

### `room-name`  **(Required)**

The name of the chat room to get presence members for.

## Options

### `--limit` 

The maximum number of presence members to return. Defaults to `100`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Get all presence members in a room:

<Code>

### Shell

```
ably rooms presence get my-room
```
</Code>

Get presence members with a limit:

<Code>

### Shell

```
ably rooms presence get my-room --limit 10
```
</Code>

Get room presence members in JSON format:

<Code>

### Shell

```
ably rooms presence get my-room --json
```
</Code>

Get room presence members in formatted JSON output:

<Code>

### Shell

```
ably rooms presence get my-room --pretty-json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [enter](https://ably.com/docs/cli/rooms/presence/enter.md): Enter presence in an Ably Chat room using the CLI.
- [subscribe](https://ably.com/docs/cli/rooms/presence/subscribe.md): Subscribe to presence events in an Ably Chat room using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
