# Channels presence get

Use the `ably channels presence get` command to get all current presence members on a channel.

## Synopsis

<Code>

### Shell

```
ably channels presence get <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel to get presence members for.

## Options

### `--limit` 

The maximum number of presence members to return. Defaults to `100`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Get all presence members on a channel:

<Code>

### Shell

```
ably channels presence get my-channel
```
</Code>

Get presence members with a limit:

<Code>

### Shell

```
ably channels presence get my-channel --limit 10
```
</Code>

Get presence members in JSON format:

<Code>

### Shell

```
ably channels presence get my-channel --json
```
</Code>

Get presence members in formatted JSON output:

<Code>

### Shell

```
ably channels presence get my-channel --pretty-json
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [enter](https://ably.com/docs/cli/channels/presence/enter.md): Enter presence on an Ably Pub/Sub channel using the CLI.
- [subscribe](https://ably.com/docs/cli/channels/presence/subscribe.md): Subscribe to presence events on an Ably Pub/Sub channel using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
