# Channels occupancy get

Use the `ably channels occupancy get` command to get the current occupancy for an Ably Pub/Sub channel.

## Synopsis

<Code>

### Shell

```
ably channels occupancy get <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel to get occupancy for.

## Options

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Get the current occupancy for a channel:

<Code>

### Shell

```
ably channels occupancy get my-channel
```
</Code>

Get occupancy in JSON format:

<Code>

### Shell

```
ably channels occupancy get my-channel --json
```
</Code>

Get occupancy in formatted JSON output:

<Code>

### Shell

```
ably channels occupancy get my-channel --pretty-json
```
</Code>

Get occupancy using an API key environment variable:

<Code>

### Shell

```
ABLY_API_KEY="YOUR_API_KEY" ably channels occupancy get my-channel
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscribe](https://ably.com/docs/cli/channels/occupancy/subscribe.md): Subscribe to occupancy updates on an Ably Pub/Sub channel using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
