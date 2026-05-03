# Rooms messages delete

Use the `ably rooms messages delete` command to delete a message in an Ably Chat room.

## Synopsis

<Code>

### Shell

```
ably rooms messages delete <room-name> <message-serial> [options]
```
</Code>

## Arguments

### `room-name`  **(Required)**

The name of the chat room containing the message.

### `message-serial`  **(Required)**

The serial identifier of the message to delete.

## Options

### `--description` 

A description of the reason for deleting the message.

### `--client-id` 

A client ID to use when deleting the message.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Delete a message:

<Code>

### Shell

```
ably rooms messages delete my-room "msg-serial"
```
</Code>

Delete a message with a description:

<Code>

### Shell

```
ably rooms messages delete my-room "msg-serial" --description "Removed inappropriate content"
```
</Code>

Delete a room message and output the result in JSON format:

<Code>

### Shell

```
ably rooms messages delete my-room "msg-serial" --json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [send](https://ably.com/docs/cli/rooms/messages/send.md): Send a message to an Ably Chat room using the CLI.
- [subscribe](https://ably.com/docs/cli/rooms/messages/subscribe.md): Subscribe to messages in one or more Ably Chat rooms using the CLI.
- [history](https://ably.com/docs/cli/rooms/messages/history.md): Get historical messages from an Ably Chat room using the CLI.
- [update](https://ably.com/docs/cli/rooms/messages/update.md): Update a message in an Ably Chat room using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
