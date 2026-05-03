# Bench publisher

Use the `ably bench publisher` command to run a publisher benchmark test on an Ably channel.

## Synopsis

<Code>

### Shell

```
ably bench publisher <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel to publish messages to.

## Options

### `--message-size` 

The size of each message in bytes. The default value is `100`.

### `--messages | -m` 

The number of messages to publish. The default value is `1000`. The maximum value is `10000`.

### `--rate | -r` 

The rate of messages per second. The default value is `15`. The maximum value is `20`.

### `--transport | -t` 

The transport protocol to use for publishing. Valid options are `rest` or `realtime`. The default value is `realtime`.

### `--wait-for-subscribers` 

Wait for subscribers to connect before publishing. The default value is `false`.

### `--client-id` 

The client ID to use for the benchmark.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Run a basic publisher benchmark:

<Code>

### Shell

```
ably bench publisher my-channel
```
</Code>

Run a benchmark with custom message count and rate:

<Code>

### Shell

```
ably bench publisher my-channel --messages 5000 --rate 20
```
</Code>

Run a benchmark using the REST transport:

<Code>

### Shell

```
ably bench publisher my-channel --transport rest
```
</Code>

Run a benchmark using the realtime transport:

<Code>

### Shell

```
ably bench publisher --transport realtime my-channel
```
</Code>

Run a publisher benchmark and output results in JSON format:

<Code>

### Shell

```
ably bench publisher my-channel --json
```
</Code>

## See also

* [Bench](https://ably.com/docs/cli/bench.md) — Explore all `ably bench` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscriber](https://ably.com/docs/cli/bench/subscriber.md): Run a subscriber benchmark test using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
