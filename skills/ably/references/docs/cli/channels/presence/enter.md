# Channels presence enter

Use the `ably channels presence enter` command to enter presence on a channel and remain present until terminated.

## Synopsis

<Code>

### Shell

```
ably channels presence enter <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel to enter presence on.

## Options

### `--data` 

JSON data to associate with the presence member.

### `--show-others` 

Display presence events from other members on the channel. Defaults to `false`.

### `--sequence-numbers` 

Display sequence numbers for presence events. Defaults to `false`.

### `--duration | -D` 

The duration in seconds to remain present before automatically leaving.

### `--client-id` 

A client ID to use when entering presence.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Enter presence on a channel:

<Code>

### Shell

```
ably channels presence enter my-channel
```
</Code>

Enter presence with data:

<Code>

### Shell

```
ably channels presence enter my-channel --data '{"status": "online"}'
```
</Code>

Enter presence and show other members' events:

<Code>

### Shell

```
ably channels presence enter my-channel --show-others
```
</Code>

Enter presence with a specific client ID:

<Code>

### Shell

```
ably channels presence enter my-channel --client-id "client123"
```
</Code>

Enter presence with a client ID and status data:

<Code>

### Shell

```
ably channels presence enter my-channel --client-id "client123" --data '{"name":"John","status":"online"}'
```
</Code>

Enter presence for a specific duration:

<Code>

### Shell

```
ably channels presence enter my-channel --duration 30
```
</Code>

Enter presence and output events in JSON format:

<Code>

### Shell

```
ably channels presence enter my-channel --json
```
</Code>

Enter presence and output events in formatted JSON:

<Code>

### Shell

```
ably channels presence enter my-channel --pretty-json
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [get](https://ably.com/docs/cli/channels/presence/get.md): Get all current presence members on an Ably Pub/Sub channel using the CLI.
- [subscribe](https://ably.com/docs/cli/channels/presence/subscribe.md): Subscribe to presence events on an Ably Pub/Sub channel using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
