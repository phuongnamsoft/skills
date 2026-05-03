# Rooms messages reactions remove

Use the `ably rooms messages reactions remove` command to remove a reaction from a message in a chat room.

## Synopsis

<Code>

### Shell

```
ably rooms messages reactions remove <room-name> <message-serial> <reaction> [options]
```
</Code>

## Arguments

### `room-name`  **(Required)**

The name of the chat room containing the message.

### `message-serial`  **(Required)**

The serial identifier of the message to remove the reaction from.

### `reaction`  **(Required)**

The emoji reaction to remove.

## Options

### `--type` 

The type of reaction to remove. Options are `unique`, `distinct`, or `multiple`.

### `--client-id` 

A client ID to use when removing the reaction.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Remove a reaction from a message:

<Code>

### Shell

```
ably rooms messages reactions remove my-room "msg-serial" "thumbsup"
```
</Code>

Remove a reaction with a specific type:

<Code>

### Shell

```
ably rooms messages reactions remove my-room "msg-serial" "heart" --type unique
```
</Code>

Remove a reaction using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably rooms messages reactions remove my-room "msg-serial" heart
```
</Code>

Remove a reaction and output the result in JSON format:

<Code>

### Shell

```
ably rooms messages reactions remove my-room "msg-serial" thumbsup --json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [send](https://ably.com/docs/cli/rooms/messages/reactions/send.md): Send a reaction to a message in an Ably Chat room using the CLI.
- [subscribe](https://ably.com/docs/cli/rooms/messages/reactions/subscribe.md): Subscribe to message reactions in an Ably Chat room using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
