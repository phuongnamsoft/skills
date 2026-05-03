# Rooms reactions send

Use the `ably rooms reactions send` command to send a reaction in a chat room.

## Synopsis

<Code>

### Shell

```
ably rooms reactions send <room-name> <emoji> [options]
```
</Code>

## Arguments

### `room-name`  **(Required)**

The name of the chat room to send the reaction in.

### `emoji`  **(Required)**

The emoji reaction to send.

## Options

### `--metadata` 

A JSON string of metadata to attach to the reaction.

### `--client-id` 

A client ID to use when sending the reaction.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Send a reaction in a room:

<Code>

### Shell

```
ably rooms reactions send my-room "heart"
```
</Code>

Send a reaction with metadata:

<Code>

### Shell

```
ably rooms reactions send my-room "thumbsup" --metadata '{"context": "great idea"}'
```
</Code>

Send a room reaction using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably rooms reactions send my-room heart
```
</Code>

Send a room reaction and output the result in JSON format:

<Code>

### Shell

```
ably rooms reactions send my-room heart --json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscribe](https://ably.com/docs/cli/rooms/reactions/subscribe.md): Subscribe to reactions in an Ably Chat room using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
