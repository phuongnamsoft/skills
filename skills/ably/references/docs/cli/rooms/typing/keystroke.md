# Rooms typing keystroke

Use the `ably rooms typing keystroke` command to send a typing indicator in an Ably Chat room.

## Synopsis

<Code>

### Shell

```
ably rooms typing keystroke <room-name> [options]
```
</Code>

## Arguments

### `room-name`  **(Required)**

The name of the chat room to send the typing indicator in.

## Options

### `--auto-type` 

Keep the typing indicator active continuously. Defaults to `false`.

### `--duration | -D` 

The duration in seconds to keep the typing indicator active.

### `--client-id` 

A client ID to use when sending the typing indicator.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Send a typing indicator:

<Code>

### Shell

```
ably rooms typing keystroke my-room
```
</Code>

Keep the typing indicator active continuously:

<Code>

### Shell

```
ably rooms typing keystroke my-room --auto-type
```
</Code>

Send a typing indicator using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably rooms typing keystroke my-room
```
</Code>

Send a typing indicator and output in JSON format:

<Code>

### Shell

```
ably rooms typing keystroke my-room --json
```
</Code>

Send a typing indicator and output in formatted JSON:

<Code>

### Shell

```
ably rooms typing keystroke my-room --pretty-json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscribe](https://ably.com/docs/cli/rooms/typing/subscribe.md): Subscribe to typing indicators in an Ably Chat room using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
