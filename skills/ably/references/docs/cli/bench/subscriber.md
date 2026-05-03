# Bench subscriber

Use the `ably bench subscriber` command to run a subscriber benchmark test on an Ably channel.

## Synopsis

<Code>

### Shell

```
ably bench subscriber <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel to subscribe to.

## Options

### `--duration | -D` 

The duration of the subscriber benchmark in seconds.

### `--client-id` 

The client ID to use for the benchmark.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Run a basic subscriber benchmark:

<Code>

### Shell

```
ably bench subscriber my-channel
```
</Code>

Run a subscriber benchmark and output results in JSON format:

<Code>

### Shell

```
ably bench subscriber my-channel --json
```
</Code>

## See also

* [Bench](https://ably.com/docs/cli/bench.md) — Explore all `ably bench` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [publisher](https://ably.com/docs/cli/bench/publisher.md): Run a publisher benchmark test using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
