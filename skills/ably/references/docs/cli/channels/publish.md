# Channels publish

Use the `ably channels publish` command to publish a message to an Ably Pub/Sub channel.

## Synopsis

<Code>

### Shell

```
ably channels publish <channel-name> <message> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel to publish to.

### `message`  **(Required)**

The message to publish. This can be plain text or JSON. Supports `{{.Count}}` and `{{.Timestamp}}` interpolation when publishing multiple messages.

## Options

### `--count | -c` 

The number of messages to publish. Defaults to `1`.

### `--delay | -d` 

The delay between messages in milliseconds when publishing multiple messages. Defaults to `40`.

### `--encoding | -e` 

The encoding of the message, such as `json/utf-8`.

### `--name | -n` 

The event name for the message.

### `--transport` 

The transport to use for publishing. Options are `rest` or `realtime`.

### `--client-id` 

A client ID to use when publishing the message.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Publish a plain text message:

<Code>

### Shell

```
ably channels publish my-channel "Hello, world!"
```
</Code>

Publish a JSON message:

<Code>

### Shell

```
ably channels publish my-channel '{"key": "value"}'
```
</Code>

Publish multiple messages with interpolation:

<Code>

### Shell

```
ably channels publish my-channel "Message {{.Count}} at {{.Timestamp}}" --count 10
```
</Code>

Publish with an event name:

<Code>

### Shell

```
ably channels publish my-channel "Hello" --name greeting
```
</Code>

Publish using the realtime transport:

<Code>

### Shell

```
ably channels publish my-channel "Hello" --transport realtime
```
</Code>

Publish with an event name using the --name option before the channel:

<Code>

### Shell

```
ably channels publish --name event my-channel '{"text":"Hello World"}'
```
</Code>

Publish messages at a controlled rate with timestamps:

<Code>

### Shell

```
ably channels publish --count 10 --delay 1000 my-channel "Message at {{.Timestamp}}"
```
</Code>

Publish a message with push notification extras:

<Code>

### Shell

```
ably channels publish my-channel '{"data":"Push notification","extras":{"push":{"notification":{"title":"Hello","body":"World"}}}}'
```
</Code>

Publish a message using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably channels publish my-channel '{"data":"Simple message"}'
```
</Code>

Publish a message and output the result in JSON format:

<Code>

### Shell

```
ably channels publish my-channel "Hello World" --json
```
</Code>

Publish a message and output the result in formatted JSON:

<Code>

### Shell

```
ably channels publish my-channel "Hello World" --pretty-json
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscribe](https://ably.com/docs/cli/channels/subscribe.md): Subscribe to messages on one or more Ably Pub/Sub channels using the CLI.
- [batch-publish](https://ably.com/docs/cli/channels/batch-publish.md): Publish a message to multiple Ably Pub/Sub channels at once using the CLI.
- [history](https://ably.com/docs/cli/channels/history.md): Retrieve message history for an Ably Pub/Sub channel using the CLI.
- [append](https://ably.com/docs/cli/channels/append.md): Append data to a message on an Ably Pub/Sub channel using the CLI.
- [update](https://ably.com/docs/cli/channels/update.md): Update a message on an Ably Pub/Sub channel using the CLI.
- [delete](https://ably.com/docs/cli/channels/delete.md): Delete a message on an Ably Pub/Sub channel using the CLI.
- [list](https://ably.com/docs/cli/channels/list.md): List active channels using the Ably CLI.
- [inspect](https://ably.com/docs/cli/channels/inspect.md): Open the Ably dashboard to inspect a specific channel using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
