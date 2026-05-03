# Logs channel-lifecycle subscribe

Use the `ably logs channel-lifecycle subscribe` command to stream logs from the [meta]channel.lifecycle meta channel.

## Synopsis

<Code>

### Shell

```
ably logs channel-lifecycle subscribe [options]
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

Subscribe to channel lifecycle events:

<Code>

### Shell

```
ably logs channel-lifecycle subscribe
```
</Code>

Subscribe with rewind to receive recent events:

<Code>

### Shell

```
ably logs channel-lifecycle subscribe --rewind 5
```
</Code>

Subscribe to channel lifecycle events and output in JSON format:

<Code>

### Shell

```
ably logs channel-lifecycle subscribe --json
```
</Code>

## See also

* [Logs](https://ably.com/docs/cli/logs.md) — Explore all `ably logs` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
