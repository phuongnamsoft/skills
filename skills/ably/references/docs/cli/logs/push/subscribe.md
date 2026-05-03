# Logs push subscribe

Use the `ably logs push subscribe` command to stream logs from the push notifications meta channel.

## Synopsis

<Code>

### Shell

```
ably logs push subscribe [options]
```
</Code>

## Options

### `--rewind` 

The number of messages to rewind when subscribing. Defaults to `0`.

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

Subscribe to push notification logs:

<Code>

### Shell

```
ably logs push subscribe
```
</Code>

Subscribe with rewind to receive recent logs:

<Code>

### Shell

```
ably logs push subscribe --rewind 5
```
</Code>

Subscribe to push notification logs in JSON format:

<Code>

### Shell

```
ably logs push subscribe --json
```
</Code>

## See also

* [Logs](https://ably.com/docs/cli/logs.md) — Explore all `ably logs` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [history](https://ably.com/docs/cli/logs/push/history.md): Retrieve push notification log history using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
