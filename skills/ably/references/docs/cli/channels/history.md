# Channels history

Use the `ably channels history` command to retrieve message history for an Ably Pub/Sub channel.

## Synopsis

<Code>

### Shell

```
ably channels history <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel to retrieve history for.

## Options

### `--cipher` 

A decryption key to use for decrypting messages in the history.

### `--direction` 

The direction to retrieve messages in. Options are `backwards` or `forwards`. Defaults to `backwards`.

### `--start` 

The start of the time range to retrieve messages from. Accepts ISO 8601, Unix milliseconds, or relative time formats.

### `--end` 

The end of the time range to retrieve messages from. Accepts ISO 8601, Unix milliseconds, or relative time formats.

### `--limit` 

The maximum number of messages to retrieve. Defaults to `50`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Retrieve message history for a channel:

<Code>

### Shell

```
ably channels history my-channel
```
</Code>

Retrieve history within a time range:

<Code>

### Shell

```
ably channels history my-channel --start "2025-01-01T00:00:00Z" --end "2025-01-02T00:00:00Z"
```
</Code>

Retrieve a limited number of messages:

<Code>

### Shell

```
ably channels history my-channel --limit 10
```
</Code>

Retrieve history in forwards direction:

<Code>

### Shell

```
ably channels history my-channel --direction forwards
```
</Code>

Retrieve history from the last hour using relative time:

<Code>

### Shell

```
ably channels history my-channel --start 1h
```
</Code>

Retrieve message history in JSON format:

<Code>

### Shell

```
ably channels history my-channel --json
```
</Code>

Retrieve message history in formatted JSON output:

<Code>

### Shell

```
ably channels history my-channel --pretty-json
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscribe](https://ably.com/docs/cli/channels/subscribe.md): Subscribe to messages on one or more Ably Pub/Sub channels using the CLI.
- [publish](https://ably.com/docs/cli/channels/publish.md): Publish a message to an Ably Pub/Sub channel using the CLI.
- [batch-publish](https://ably.com/docs/cli/channels/batch-publish.md): Publish a message to multiple Ably Pub/Sub channels at once using the CLI.
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
