# Channels delete

Use the `ably channels delete` command to delete a message on an Ably Pub/Sub channel.

## Synopsis

<Code>

### Shell

```
ably channels delete <channel-name> <message-serial> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel containing the message.

### `message-serial`  **(Required)**

The serial of the message to delete.

## Options

### `--description` 

A description for the deletion.

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
ably channels delete my-channel "msg-serial"
```
</Code>

Delete a message with a description:

<Code>

### Shell

```
ably channels delete my-channel "msg-serial" --description "Removed inappropriate content"
```
</Code>

Delete a message and output the result in JSON format:

<Code>

### Shell

```
ably channels delete my-channel "msg-serial" --json
```
</Code>

Delete a message and output the result in formatted JSON:

<Code>

### Shell

```
ably channels delete my-channel "msg-serial" --pretty-json
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
- [update](https://ably.com/docs/cli/channels/update.md): Update a message on an Ably Pub/Sub channel using the CLI.
- [list](https://ably.com/docs/cli/channels/list.md): List active channels using the Ably CLI.
- [inspect](https://ably.com/docs/cli/channels/inspect.md): Open the Ably dashboard to inspect a specific channel using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
