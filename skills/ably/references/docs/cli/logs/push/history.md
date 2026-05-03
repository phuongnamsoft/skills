# Logs push history

Use the `ably logs push history` command to retrieve push notification log history.

## Synopsis

<Code>

### Shell

```
ably logs push history [options]
```
</Code>

## Options

### `--direction` 

The direction to retrieve logs in. Options are `backwards` or `forwards`. Defaults to `backwards`.

### `--limit` 

The maximum number of log entries to retrieve. Defaults to `100`.

### `--start` 

The start of the time range to retrieve logs from. Accepts ISO 8601, Unix milliseconds, or relative time formats.

### `--end` 

The end of the time range to retrieve logs from. Accepts ISO 8601, Unix milliseconds, or relative time formats.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Retrieve recent push notification logs:

<Code>

### Shell

```
ably logs push history
```
</Code>

Retrieve logs within a time range:

<Code>

### Shell

```
ably logs push history --start "2025-01-01T00:00:00Z" --end "2025-01-02T00:00:00Z"
```
</Code>

Retrieve a limited number of push notification logs:

<Code>

### Shell

```
ably logs push history --limit 20
```
</Code>

Retrieve push notification logs in forwards direction:

<Code>

### Shell

```
ably logs push history --direction forwards
```
</Code>

Retrieve push notification logs from the last hour:

<Code>

### Shell

```
ably logs push history --start 1h
```
</Code>

Retrieve push notification logs in JSON format:

<Code>

### Shell

```
ably logs push history --json
```
</Code>

Retrieve push notification logs in formatted JSON:

<Code>

### Shell

```
ably logs push history --pretty-json
```
</Code>

## See also

* [Logs](https://ably.com/docs/cli/logs.md) — Explore all `ably logs` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscribe](https://ably.com/docs/cli/logs/push/subscribe.md): Stream logs from the push notifications meta channel using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
