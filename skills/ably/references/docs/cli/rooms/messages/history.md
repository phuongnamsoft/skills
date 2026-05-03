# Rooms messages history

Use the `ably rooms messages history` command to get historical messages from an Ably Chat room.

## Synopsis

<Code>

### Shell

```
ably rooms messages history <room-name> [options]
```
</Code>

## Arguments

### `room-name`  **(Required)**

The name of the chat room to retrieve history from.

## Options

### `--limit | -l` 

The maximum number of messages to return. Defaults to `50`.

### `--order` 

The order in which to return messages. Options are `newestFirst` or `oldestFirst`. Defaults to `newestFirst`.

### `--show-metadata` 

Display metadata attached to messages. Defaults to `false`.

### `--start` 

The start of the time range to query. Accepts ISO 8601, Unix timestamp, or relative time formats.

### `--end` 

The end of the time range to query. Accepts ISO 8601, Unix timestamp, or relative time formats.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Get recent message history for a room:

<Code>

### Shell

```
ably rooms messages history my-room
```
</Code>

Get history with a limit:

<Code>

### Shell

```
ably rooms messages history my-room --limit 10
```
</Code>

Get history within a time range:

<Code>

### Shell

```
ably rooms messages history my-room --start "2025-01-01T00:00:00Z" --end "2025-01-02T00:00:00Z"
```
</Code>

Get history in oldest-first order:

<Code>

### Shell

```
ably rooms messages history my-room --order oldestFirst
```
</Code>

Retrieve history starting from a specific time:

<Code>

### Shell

```
ably rooms messages history my-room --start "2025-01-01T00:00:00Z"
```
</Code>

Retrieve history from the last hour using relative time:

<Code>

### Shell

```
ably rooms messages history my-room --start 1h
```
</Code>

Retrieve room message history with metadata displayed:

<Code>

### Shell

```
ably rooms messages history --show-metadata my-room
```
</Code>

Retrieve room message history using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably rooms messages history my-room
```
</Code>

Retrieve room message history in JSON format:

<Code>

### Shell

```
ably rooms messages history my-room --json
```
</Code>

Retrieve room message history in formatted JSON:

<Code>

### Shell

```
ably rooms messages history my-room --pretty-json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [send](https://ably.com/docs/cli/rooms/messages/send.md): Send a message to an Ably Chat room using the CLI.
- [subscribe](https://ably.com/docs/cli/rooms/messages/subscribe.md): Subscribe to messages in one or more Ably Chat rooms using the CLI.
- [update](https://ably.com/docs/cli/rooms/messages/update.md): Update a message in an Ably Chat room using the CLI.
- [delete](https://ably.com/docs/cli/rooms/messages/delete.md): Delete a message in an Ably Chat room using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
