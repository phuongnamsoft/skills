# Stats account

Use the `ably stats account` command to get account-level statistics with optional live updates.

## Synopsis

<Code>

### Shell

```
ably stats account [options]
```
</Code>

## Options

### `--start` 

The start of the time range to retrieve stats from. Accepts ISO 8601, Unix milliseconds, or relative time formats.

### `--end` 

The end of the time range to retrieve stats from. Accepts ISO 8601, Unix milliseconds, or relative time formats.

### `--unit` 

The unit of time for the stats interval. Options are `minute`, `hour`, `day`, or `month`. Defaults to `minute`.

### `--limit` 

The maximum number of stats records to retrieve. Defaults to `10`.

### `--live` 

Subscribe to live stats updates at minute intervals. Defaults to `false`.

### `--interval` 

The polling interval in seconds for live mode. Defaults to `6`.

### `--debug` 

Show debug information for live polling. Defaults to `false`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Retrieve recent account stats:

<Code>

### Shell

```
ably stats account
```
</Code>

Retrieve hourly stats:

<Code>

### Shell

```
ably stats account --unit hour
```
</Code>

Retrieve stats within a time range:

<Code>

### Shell

```
ably stats account --start "2025-01-01T00:00:00Z" --end "2025-01-02T00:00:00Z"
```
</Code>

Subscribe to live stats updates:

<Code>

### Shell

```
ably stats account --live
```
</Code>

Subscribe to live stats with a custom polling interval:

<Code>

### Shell

```
ably stats account --live --interval 10
```
</Code>

Retrieve account stats from the last hour using relative time:

<Code>

### Shell

```
ably stats account --start 1h
```
</Code>

Retrieve a limited number of account stats entries:

<Code>

### Shell

```
ably stats account --limit 10
```
</Code>

Retrieve account stats in JSON format:

<Code>

### Shell

```
ably stats account --json
```
</Code>

Retrieve account stats in formatted JSON output:

<Code>

### Shell

```
ably stats account --pretty-json
```
</Code>

## Output

The `ably accounts stats` command displays statistics for each time period:

| Metric | Description |
| ------ | ----------- |
| Connections | Peak, minimum, mean connections, plus opened, refused, and active counts |
| Channels | Peak, minimum, mean channels, plus opened, refused, and active counts |
| Messages | Total, published, delivered message counts and data volume |
| API Requests | Succeeded, failed, refused, and total request counts |
| Token Requests | Succeeded, failed, and refused token request counts |
| Peak Rates | Maximum rates per second for messages, connections, channels, API requests, and token requests |

## See also

* [Stats](https://ably.com/docs/cli/stats.md) — Explore all `ably stats` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [app](https://ably.com/docs/cli/stats/app.md): Get app-level statistics with optional live updates using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
