# Channels update

Use the `ably channels update` command to update a message on an Ably Pub/Sub channel.

## Synopsis

<Code>

### Shell

```
ably channels update <channel-name> <message-serial> <message> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel containing the message.

### `message-serial`  **(Required)**

The serial of the message to update.

### `message`  **(Required)**

The new message content. This can be plain text or JSON.

## Options

### `--description` 

A description for the update.

### `--encoding | -e` 

The encoding of the message, such as `json/utf-8`.

### `--name | -n` 

The event name for the updated message.

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
ably channels update my-channel "msg-serial" "Updated message content"
```
</Code>

Update a message with a description:

<Code>

### Shell

```
ably channels update my-channel "msg-serial" '{"key": "new-value"}' --description "Fixed typo"
```
</Code>

Update a message with plain text content:

<Code>

### Shell

```
ably channels update my-channel "msg-serial" "Updated plain text"
```
</Code>

Update a message and set an event name:

<Code>

### Shell

```
ably channels update my-channel "msg-serial" '{"data":"updated"}' --name event-name
```
</Code>

Update a message and output the result in JSON format:

<Code>

### Shell

```
ably channels update my-channel "msg-serial" '{"data":"updated"}' --json
```
</Code>

Update a message and output the result in formatted JSON:

<Code>

### Shell

```
ably channels update my-channel "msg-serial" '{"data":"updated"}' --pretty-json
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscribe](https://ably.com/docs/cli/channels/subscribe.md): Subscribe to messages on one or more Ably Pub/Sub channels using the CLI.
- [publish](https://ably.com/docs/cli/channels/publish.md): Publish a message to an Ably Pub/Sub channel using the CLI.
- [batch-publish](https://ably.com/docs/cli/channels/batch-publish.md): Publish a message to multiple Ably Pub/Sub channels at once using the CLI.
- [history](https://ably.com/docs/cli/channels/history.md): Retrieve message history for an Ably Pub/Sub channel using the CLI.
- [append](https://ably.com/docs/cli/channels/append.md): Append data to a message on an Ably Pub/Sub channel using the CLI.
- [delete](https://ably.com/docs/cli/channels/delete.md): Delete a message on an Ably Pub/Sub channel using the CLI.
- [list](https://ably.com/docs/cli/channels/list.md): List active channels using the Ably CLI.
- [inspect](https://ably.com/docs/cli/channels/inspect.md): Open the Ably dashboard to inspect a specific channel using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
