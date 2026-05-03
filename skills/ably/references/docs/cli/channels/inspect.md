# Channels inspect

Use the `ably channels inspect` command to open the Ably dashboard to inspect a specific channel.

## Synopsis

<Code>

### Shell

```
ably channels inspect <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel to inspect.

## Options

### `--app` 

The app ID or name to inspect the channel for. Overrides the currently selected app.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Inspect a channel in the Ably dashboard:

<Code>

### Shell

```
ably channels inspect my-channel
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
- [delete](https://ably.com/docs/cli/channels/delete.md): Delete a message on an Ably Pub/Sub channel using the CLI.
- [list](https://ably.com/docs/cli/channels/list.md): List active channels using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
