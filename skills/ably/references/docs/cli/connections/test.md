# Connections test

Use the `ably connections test` command to test your connection to Ably using different transport protocols.

## Synopsis

<Code>

### Shell

```
ably connections test [options]
```
</Code>

## Options

### `--transport` 

The transport protocol to test. Valid options are `ws` (WebSocket), `xhr` (HTTP), or `all`. The default value is `all`.

### `--client-id` 

The client ID to use for the connection test.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Test all transport protocols:

<Code>

### Shell

```
ably connections test
```
</Code>

Test WebSocket connectivity only:

<Code>

### Shell

```
ably connections test --transport ws
```
</Code>

Test HTTP connectivity only:

<Code>

### Shell

```
ably connections test --transport xhr
```
</Code>

Test connectivity and output results in JSON format:

<Code>

### Shell

```
ably connections test --json
```
</Code>

## See also

* [Connections](https://ably.com/docs/cli/connections.md) — Explore all `ably connections` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
