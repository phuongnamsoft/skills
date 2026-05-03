# Rooms messages send

Use the `ably rooms messages send` command to send a message to an Ably Chat room.

## Synopsis

<Code>

### Shell

```
ably rooms messages send <room-name> <text> [options]
```
</Code>

<Aside data-type='note'>
The `text` argument supports `{{.Count}}` and `{{.Timestamp}}` interpolation when sending multiple messages.
</Aside>

## Arguments

### `room-name`  **(Required)**

The name of the chat room to send the message to.

### `text`  **(Required)**

The text content of the message.

## Options

### `--count | -c` 

The number of messages to send. Defaults to `1`.

### `--delay | -d` 

The delay between messages in milliseconds when sending multiple messages. Defaults to `40`.

### `--metadata` 

A JSON string of metadata to attach to the message.

### `--client-id` 

A client ID to use when sending the message.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Send a message to a chat room:

<Code>

### Shell

```
ably rooms messages send my-room "Hello, world!"
```
</Code>

Send multiple messages with interpolation:

<Code>

### Shell

```
ably rooms messages send my-room "Message {{.Count}} at {{.Timestamp}}" --count 10
```
</Code>

Send a message with metadata:

<Code>

### Shell

```
ably rooms messages send my-room "Hello" --metadata '{"priority": "high"}'
```
</Code>

Send messages at a controlled rate with timestamps:

<Code>

### Shell

```
ably rooms messages send --count 10 --delay 1000 my-room "Message at {{.Timestamp}}"
```
</Code>

Send a room message using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably rooms messages send my-room "Welcome to the chat!"
```
</Code>

Send a room message and output the result in JSON format:

<Code>

### Shell

```
ably rooms messages send my-room "Hello World!" --json
```
</Code>

Send a room message and output the result in formatted JSON:

<Code>

### Shell

```
ably rooms messages send my-room "Hello World!" --pretty-json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscribe](https://ably.com/docs/cli/rooms/messages/subscribe.md): Subscribe to messages in one or more Ably Chat rooms using the CLI.
- [history](https://ably.com/docs/cli/rooms/messages/history.md): Get historical messages from an Ably Chat room using the CLI.
- [update](https://ably.com/docs/cli/rooms/messages/update.md): Update a message in an Ably Chat room using the CLI.
- [delete](https://ably.com/docs/cli/rooms/messages/delete.md): Delete a message in an Ably Chat room using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
