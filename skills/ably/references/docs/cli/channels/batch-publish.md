# Channels batch-publish

Use the `ably channels batch-publish` command to publish a message to multiple Ably Pub/Sub channels at once.

## Synopsis

<Code>

### Shell

```
ably channels batch-publish [message] [options]
```
</Code>

## Arguments

### `message` 

The message to publish. This is optional when using the `--spec` option.

## Options

### `--channels` 

A comma-separated list of channel names to publish to. This option is mutually exclusive with `--channels-json` and `--spec`.

### `--channels-json` 

A JSON array of channel names to publish to. This option is mutually exclusive with `--channels` and `--spec`.

### `--spec` 

A complete batch spec as a JSON string. This option is mutually exclusive with `--channels` and `--channels-json`.

### `--encoding | -e` 

The encoding of the message, such as `json/utf-8`.

### `--name | -n` 

The event name for the message.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Publish to multiple channels:

<Code>

### Shell

```
ably channels batch-publish "Hello, everyone!" --channels "channel-1,channel-2,channel-3"
```
</Code>

Publish using a JSON array of channels:

<Code>

### Shell

```
ably channels batch-publish "Hello!" --channels-json '["channel-1", "channel-2"]'
```
</Code>

Publish using a complete batch spec:

<Code>

### Shell

```
ably channels batch-publish --spec '{"channels": ["channel-1", "channel-2"], "messages": [{"data": "Hello!"}]}'
```
</Code>

Batch publish with an event name:

<Code>

### Shell

```
ably channels batch-publish --channels channel1,channel2 --name event '{"text":"Hello World"}'
```
</Code>

Batch publish using an array of batch specs for different channels:

<Code>

### Shell

```
ably channels batch-publish --spec '[{"channels": "channel1", "messages": {"data": "First spec"}}, {"channels": "channel2", "messages": {"data": "Second spec"}}]'
```
</Code>

Batch publish and output the result in JSON format:

<Code>

### Shell

```
ably channels batch-publish --channels channel1,channel2 '{"data":"Message"}' --json
```
</Code>

Batch publish and output the result in formatted JSON:

<Code>

### Shell

```
ably channels batch-publish --channels channel1,channel2 '{"data":"Message"}' --pretty-json
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscribe](https://ably.com/docs/cli/channels/subscribe.md): Subscribe to messages on one or more Ably Pub/Sub channels using the CLI.
- [publish](https://ably.com/docs/cli/channels/publish.md): Publish a message to an Ably Pub/Sub channel using the CLI.
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
