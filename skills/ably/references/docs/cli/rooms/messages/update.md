# Rooms messages update

Use the `ably rooms messages update` command to update a message in an Ably Chat room.

## Synopsis

<Code>

### Shell

```
ably rooms messages update <room-name> <message-serial> <text> [options]
```
</Code>

## Arguments

### `room-name`  **(Required)**

The name of the chat room containing the message.

### `message-serial`  **(Required)**

The serial identifier of the message to update.

### `text`  **(Required)**

The new text content for the message.

## Options

### `--description` 

A description of the update.

### `--headers` 

A JSON string of headers to attach to the update.

### `--metadata` 

A JSON string of metadata to attach to the updated message.

### `--client-id` 

A client ID to use when updating the message.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Update a message:

<Code>

### Shell

```
ably rooms messages update my-room "msg-serial" "Updated message text"
```
</Code>

Update a message with a description:

<Code>

### Shell

```
ably rooms messages update my-room "msg-serial" "Fixed typo" --description "Corrected spelling"
```
</Code>

Update a message with metadata:

<Code>

### Shell

```
ably rooms messages update my-room "msg-serial" "Edited message" --metadata '{"edited": true}'
```
</Code>

Update a room message with custom headers:

<Code>

### Shell

```
ably rooms messages update my-room "msg-serial" "Updated text" --headers '{"source":"cli"}'
```
</Code>

Update a room message and output the result in JSON format:

<Code>

### Shell

```
ably rooms messages update my-room "msg-serial" "Updated text" --json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [send](https://ably.com/docs/cli/rooms/messages/send.md): Send a message to an Ably Chat room using the CLI.
- [subscribe](https://ably.com/docs/cli/rooms/messages/subscribe.md): Subscribe to messages in one or more Ably Chat rooms using the CLI.
- [history](https://ably.com/docs/cli/rooms/messages/history.md): Get historical messages from an Ably Chat room using the CLI.
- [delete](https://ably.com/docs/cli/rooms/messages/delete.md): Delete a message in an Ably Chat room using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
