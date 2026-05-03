# Logs history

Use the `ably logs history` command to retrieve application log history.

## Synopsis

<Code>

### Shell

```
ably logs history [options]
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

Retrieve recent application logs:

<Code>

### Shell

```
ably logs history
```
</Code>

Retrieve logs within a time range:

<Code>

### Shell

```
ably logs history --start "2025-01-01T00:00:00Z" --end "2025-01-02T00:00:00Z"
```
</Code>

Retrieve logs in forwards direction:

<Code>

### Shell

```
ably logs history --direction forwards
```
</Code>

Retrieve a limited number of application logs:

<Code>

### Shell

```
ably logs history --limit 20
```
</Code>

Retrieve application logs from the last hour:

<Code>

### Shell

```
ably logs history --start 1h
```
</Code>

Retrieve application logs in JSON format:

<Code>

### Shell

```
ably logs history --json
```
</Code>

Retrieve application logs in formatted JSON:

<Code>

### Shell

```
ably logs history --pretty-json
```
</Code>

## See also

* [Logs](https://ably.com/docs/cli/logs.md) — Explore all `ably logs` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscribe](https://ably.com/docs/cli/logs/subscribe.md): Subscribe to live app logs using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
