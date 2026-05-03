# Rooms messages subscribe

Use the `ably rooms messages subscribe` command to subscribe to messages in one or more Ably Chat rooms.

## Synopsis

<Code>

### Shell

```
ably rooms messages subscribe <room-names> [options]
```
</Code>

## Arguments

### `room-names`  **(Required)**

The names of the chat rooms to subscribe to.

## Options

### `--show-metadata` 

Display metadata attached to messages. Defaults to `false`.

### `--duration | -D` 

The duration in seconds to subscribe for before automatically unsubscribing.

### `--sequence-numbers` 

Display sequence numbers for messages. Defaults to `false`.

### `--client-id` 

A client ID to use for the subscription.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Subscribe to messages in a single room:

<Code>

### Shell

```
ably rooms messages subscribe my-room
```
</Code>

Subscribe to messages in multiple rooms:

<Code>

### Shell

```
ably rooms messages subscribe my-room another-room
```
</Code>

Subscribe and show metadata:

<Code>

### Shell

```
ably rooms messages subscribe my-room --show-metadata
```
</Code>

Subscribe to room messages for a specific duration:

<Code>

### Shell

```
ably rooms messages subscribe my-room --duration 30
```
</Code>

Subscribe to room messages using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably rooms messages subscribe my-room
```
</Code>

Subscribe to room messages in JSON format:

<Code>

### Shell

```
ably rooms messages subscribe my-room --json
```
</Code>

Subscribe to room messages in formatted JSON:

<Code>

### Shell

```
ably rooms messages subscribe my-room --pretty-json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [send](https://ably.com/docs/cli/rooms/messages/send.md): Send a message to an Ably Chat room using the CLI.
- [history](https://ably.com/docs/cli/rooms/messages/history.md): Get historical messages from an Ably Chat room using the CLI.
- [update](https://ably.com/docs/cli/rooms/messages/update.md): Update a message in an Ably Chat room using the CLI.
- [delete](https://ably.com/docs/cli/rooms/messages/delete.md): Delete a message in an Ably Chat room using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
