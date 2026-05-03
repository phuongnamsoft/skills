# Channels occupancy subscribe

Use the `ably channels occupancy subscribe` command to subscribe to occupancy updates on an Ably Pub/Sub channel.

## Synopsis

<Code>

### Shell

```
ably channels occupancy subscribe <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel to subscribe to occupancy updates on.

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

Subscribe to occupancy updates:

<Code>

### Shell

```
ably channels occupancy subscribe my-channel
```
</Code>

Subscribe for a specific duration:

<Code>

### Shell

```
ably channels occupancy subscribe my-channel --duration 60
```
</Code>

Subscribe to occupancy using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably channels occupancy subscribe my-channel
```
</Code>

Subscribe to occupancy updates in JSON format:

<Code>

### Shell

```
ably channels occupancy subscribe my-channel --json
```
</Code>

Subscribe to occupancy updates in formatted JSON:

<Code>

### Shell

```
ably channels occupancy subscribe my-channel --pretty-json
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [get](https://ably.com/docs/cli/channels/occupancy/get.md): Get current occupancy for an Ably Pub/Sub channel using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
