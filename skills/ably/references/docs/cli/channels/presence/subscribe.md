# Channels presence subscribe

Use the `ably channels presence subscribe` command to subscribe to presence events on a channel.

## Synopsis

<Code>

### Shell

```
ably channels presence subscribe <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel to subscribe to presence events on.

## Options

### `--duration | -D` 

The duration in seconds to subscribe for before automatically unsubscribing.

### `--client-id` 

A client ID to use when subscribing.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Subscribe to presence events:

<Code>

### Shell

```
ably channels presence subscribe my-channel
```
</Code>

Subscribe for a specific duration:

<Code>

### Shell

```
ably channels presence subscribe my-channel --duration 60
```
</Code>

Subscribe to presence events using a specific client ID:

<Code>

### Shell

```
ably channels presence subscribe my-channel --client-id "filter123"
```
</Code>

Subscribe to presence using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably channels presence subscribe my-channel
```
</Code>

Subscribe to presence events in JSON format:

<Code>

### Shell

```
ably channels presence subscribe my-channel --json
```
</Code>

Subscribe to presence events in formatted JSON:

<Code>

### Shell

```
ably channels presence subscribe my-channel --pretty-json
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [enter](https://ably.com/docs/cli/channels/presence/enter.md): Enter presence on an Ably Pub/Sub channel using the CLI.
- [get](https://ably.com/docs/cli/channels/presence/get.md): Get all current presence members on an Ably Pub/Sub channel using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
