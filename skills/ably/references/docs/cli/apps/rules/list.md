# Apps rules list

Use the `ably apps rules list` command to list all [channel rules](https://ably.com/docs/channels.md#rules) configured for an Ably application.

## Synopsis

<Code>

### Shell

```
ably apps rules list [options]
```
</Code>

## Options

### `--app` 

The app ID to list rules for. Uses the currently selected app if not specified.

### `--limit` 

The maximum number of results to return. Defaults to `100`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

List all channel rules for the current app:

<Code>

### Shell

```
ably apps rules list
```
</Code>

List channel rules for a specific app:

<Code>

### Shell

```
ably apps rules list --app aBcDe1
```
</Code>

List all channel rules in JSON format:

<Code>

### Shell

```
ably apps rules list --json
```
</Code>

List all channel rules in formatted JSON output:

<Code>

### Shell

```
ably apps rules list --pretty-json
```
</Code>

## Output

The `ably apps channel-rules list` command displays:

| Property | Description |
| -------- | ----------- |
| **Rule Count** | Total number of channel rules found |
| **Channel Rule ID** | The unique identifier for each rule |
| **Persisted** | Whether messages are persisted for channels matching this rule |
| **Push Enabled** | Whether push notifications are enabled |
| **Authenticated** | Whether clients must be authenticated |
| **Persist Last Message** | Whether only the last message is persisted |
| **Populate Channel Registry** | Whether to populate the channel registry |
| **Batching Enabled** | Whether message batching is enabled |
| **Conflation Enabled** | Whether message conflation is enabled |
| **TLS Only** | Whether TLS is enforced |
| **Created** | When the rule was created |
| **Updated** | When the rule was last updated |

## See also

* [Apps](https://ably.com/docs/cli/apps.md) — Explore all `ably apps` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/apps/rules/create.md): Create a channel rule for an Ably application using the CLI.
- [delete](https://ably.com/docs/cli/apps/rules/delete.md): Delete a channel rule from an Ably application using the CLI.
- [update](https://ably.com/docs/cli/apps/rules/update.md): Update a channel rule for an Ably application using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
