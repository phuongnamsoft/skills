# Rooms typing subscribe

Use the `ably rooms typing subscribe` command to subscribe to typing indicators in an Ably Chat room.

## Synopsis

<Code>

### Shell

```
ably rooms typing subscribe <room-name> [options]
```
</Code>

## Arguments

### `room-name`  **(Required)**

The name of the chat room to subscribe to typing indicators in.

## Options

### `--duration | -D` 

The duration in seconds to subscribe for before automatically unsubscribing.

### `--client-id` 

A client ID to use for the subscription.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Subscribe to typing indicators in a room:

<Code>

### Shell

```
ably rooms typing subscribe my-room
```
</Code>

Subscribe for a specific duration:

<Code>

### Shell

```
ably rooms typing subscribe my-room --duration 60
```
</Code>

Subscribe to typing indicators using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably rooms typing subscribe my-room
```
</Code>

Subscribe to typing indicators in JSON format:

<Code>

### Shell

```
ably rooms typing subscribe my-room --json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [keystroke](https://ably.com/docs/cli/rooms/typing/keystroke.md): Send a typing indicator in an Ably Chat room using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
