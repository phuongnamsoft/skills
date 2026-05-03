# Logs subscribe

Use the `ably logs subscribe` command to subscribe to live app logs.

## Synopsis

<Code>

### Shell

```
ably logs subscribe [options]
```
</Code>

## Options

### `--type` 

Filter logs by type. Options are `channel.lifecycle`, `channel.occupancy`, `channel.presence`, `connection.lifecycle`, and `push.publish`.

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

Subscribe to all app logs:

<Code>

### Shell

```
ably logs subscribe
```
</Code>

Filter by log type:

<Code>

### Shell

```
ably logs subscribe --type channel.lifecycle
```
</Code>

Subscribe with rewind to receive recent logs:

<Code>

### Shell

```
ably logs subscribe --rewind 10
```
</Code>

Subscribe to application logs for a specific duration:

<Code>

### Shell

```
ably logs subscribe --duration 30
```
</Code>

Subscribe to application logs in JSON format:

<Code>

### Shell

```
ably logs subscribe --json
```
</Code>

Subscribe to application logs in formatted JSON:

<Code>

### Shell

```
ably logs subscribe --pretty-json
```
</Code>

## See also

* [Logs](https://ably.com/docs/cli/logs.md) — Explore all `ably logs` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [history](https://ably.com/docs/cli/logs/history.md): Retrieve application log history using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
