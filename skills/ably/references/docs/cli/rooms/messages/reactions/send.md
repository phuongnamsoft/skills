# Rooms messages reactions send

Use the `ably rooms messages reactions send` command to send a reaction to a message in a chat room.

## Synopsis

<Code>

### Shell

```
ably rooms messages reactions send <room-name> <message-serial> <reaction> [options]
```
</Code>

## Arguments

### `room-name`  **(Required)**

The name of the chat room containing the message.

### `message-serial`  **(Required)**

The serial identifier of the message to react to.

### `reaction`  **(Required)**

The emoji reaction to send.

## Options

### `--type` 

The type of reaction. Options are `unique`, `distinct`, or `multiple`.

### `--count` 

The number of reactions to send. Only applicable when `--type` is set to `multiple`.

### `--client-id` 

A client ID to use when sending the reaction.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Send a reaction to a message:

<Code>

### Shell

```
ably rooms messages reactions send my-room "msg-serial" "thumbsup"
```
</Code>

Send a reaction with a specific type:

<Code>

### Shell

```
ably rooms messages reactions send my-room "msg-serial" "heart" --type unique
```
</Code>

Send multiple reactions:

<Code>

### Shell

```
ably rooms messages reactions send my-room "msg-serial" "clap" --type multiple --count 5
```
</Code>

Send a reaction using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably rooms messages reactions send my-room "msg-serial" heart
```
</Code>

Send a reaction and output the result in JSON format:

<Code>

### Shell

```
ably rooms messages reactions send my-room "msg-serial" thumbsup --json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscribe](https://ably.com/docs/cli/rooms/messages/reactions/subscribe.md): Subscribe to message reactions in an Ably Chat room using the CLI.
- [remove](https://ably.com/docs/cli/rooms/messages/reactions/remove.md): Remove a reaction from a message in an Ably Chat room using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
