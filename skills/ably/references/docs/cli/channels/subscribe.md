# Channels subscribe

Use the `ably channels subscribe` command to subscribe to messages on one or more Ably Pub/Sub channels.

## Synopsis

<Code>

### Shell

```
ably channels subscribe <channel-names> [options]
```
</Code>

## Arguments

### `channel-names`  **(Required)**

One or more channel names to subscribe to.

## Options

### `--cipher` 

A decryption key to use for decrypting messages on the channel.

### `--delta` 

Enable delta compression for messages. Defaults to `false`.

### `--sequence-numbers` 

Display sequence numbers for messages. Defaults to `false`.

### `--duration | -D` 

The duration in seconds to subscribe for before automatically unsubscribing.

### `--rewind` 

The number of messages to rewind when subscribing. Defaults to `0`.

### `--client-id` 

A client ID to use when subscribing.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Subscribe to a single channel:

<Code>

### Shell

```
ably channels subscribe my-channel
```
</Code>

Subscribe to multiple channels:

<Code>

### Shell

```
ably channels subscribe my-channel another-channel
```
</Code>

Subscribe for a specific duration:

<Code>

### Shell

```
ably channels subscribe my-channel --duration 60
```
</Code>

Subscribe with rewind to receive recent messages:

<Code>

### Shell

```
ably channels subscribe my-channel --rewind 10
```
</Code>

Subscribe with a cipher key for encrypted messages:

<Code>

### Shell

```
ably channels subscribe my-channel --cipher "my-secret-key"
```
</Code>

Subscribe with delta compression for bandwidth-efficient updates:

<Code>

### Shell

```
ably channels subscribe --delta my-channel
```
</Code>

Subscribe using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably channels subscribe my-channel
```
</Code>

Subscribe and output messages in JSON format:

<Code>

### Shell

```
ably channels subscribe my-channel --json
```
</Code>

Subscribe and output messages in formatted JSON:

<Code>

### Shell

```
ably channels subscribe my-channel --pretty-json
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [publish](https://ably.com/docs/cli/channels/publish.md): Publish a message to an Ably Pub/Sub channel using the CLI.
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
