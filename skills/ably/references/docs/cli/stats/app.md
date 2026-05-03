# Stats app

Use the `ably stats app` command to get app-level statistics with optional live updates.

## Synopsis

<Code>

### Shell

```
ably stats app [app-name-or-id] [options]
```
</Code>

## Arguments

### `app-name-or-id` 

The app name or ID to retrieve stats for. If not provided, the currently selected app is used.

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

Retrieve stats for the current app:

<Code>

### Shell

```
ably stats app
```
</Code>

Retrieve stats for a specific app:

<Code>

### Shell

```
ably stats app app-id
```
</Code>

Retrieve stats for an app by name:

<Code>

### Shell

```
ably stats app "My App"
```
</Code>

Retrieve hourly stats:

<Code>

### Shell

```
ably stats app --unit hour
```
</Code>

Subscribe to live stats updates:

<Code>

### Shell

```
ably stats app --live
```
</Code>

Retrieve hourly stats for a specific app:

<Code>

### Shell

```
ably stats app app-id --unit hour
```
</Code>

Retrieve stats for a specific app within a time range:

<Code>

### Shell

```
ably stats app app-id --start "2023-01-01T00:00:00Z" --end "2023-01-02T00:00:00Z"
```
</Code>

Retrieve stats for a specific app from the last hour:

<Code>

### Shell

```
ably stats app app-id --start 1h
```
</Code>

Retrieve a limited number of stats entries for a specific app:

<Code>

### Shell

```
ably stats app app-id --limit 10
```
</Code>

Retrieve stats for an app by name with options:

<Code>

### Shell

```
ably stats app "My App" --start 1h --limit 10
```
</Code>

Subscribe to live stats for a specific app:

<Code>

### Shell

```
ably stats app app-id --live
```
</Code>

Subscribe to live stats with a custom polling interval:

<Code>

### Shell

```
ably stats app --live --interval 15
```
</Code>

Retrieve app stats in JSON format:

<Code>

### Shell

```
ably stats app app-id --json
```
</Code>

Retrieve app stats in formatted JSON output:

<Code>

### Shell

```
ably stats app app-id --pretty-json
```
</Code>

## See also

* [Stats](https://ably.com/docs/cli/stats.md) — Explore all `ably stats` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [account](https://ably.com/docs/cli/stats/account.md): Get account-level statistics with optional live updates using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
