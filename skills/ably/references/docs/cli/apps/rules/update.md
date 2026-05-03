# Apps rules update

Use the `ably apps rules update` command to update an existing [channel rule](https://ably.com/docs/channels.md#rules) for an Ably application.

## Synopsis

<Code>

### Shell

```
ably apps rules update <rule-name-or-id> [options]
```
</Code>

## Arguments

### `rule-name-or-id`  **(Required)**

The name or ID of the channel rule to update.

## Options

<Aside data-type="note">
Boolean options support a `--no-` prefix to disable the option. For example, use `--no-persisted` to disable message persistence.
</Aside>

### `--app` 

The app ID that owns the rule to update. Uses the currently selected app if not specified.

### `--persisted` 

Enable message persistence for matching channels.

### `--push-enabled` 

Enable push notifications for matching channels.

### `--authenticated` 

Require authentication for operations on matching channels.

### `--tls-only` 

Restrict matching channels to TLS connections only.

### `--persist-last` 

Persist only the last message on matching channels.

### `--populate-channel-registry` 

Populate the channel registry for matching channels, enabling channel enumeration.

### `--mutable-messages` 

Enable message update and delete functionality on matching channels. Enabling this option automatically enables message persistence.

### `--batching-enabled` 

Enable message batching for matching channels.

### `--batching-interval` 

The batching interval in milliseconds for matching channels. Only applicable when `--batching-enabled` is set.

### `--conflation-enabled` 

Enable message conflation for matching channels.

### `--conflation-interval` 

The conflation interval in milliseconds for matching channels. Only applicable when `--conflation-enabled` is set.

### `--conflation-key` 

The conflation key for matching channels. Only applicable when `--conflation-enabled` is set.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Enable message persistence on a channel rule:

<Code>

### Shell

```
ably apps rules update "chat" --persisted
```
</Code>

Disable push notifications on a channel rule:

<Code>

### Shell

```
ably apps rules update "alerts" --no-push-enabled
```
</Code>

Update a channel rule and output the result as JSON:

<Code>

### Shell

```
ably apps rules update "chat" --persisted --json
```
</Code>

Enable mutable messages on a channel rule:

<Code>

### Shell

```
ably apps rules update "chat" --mutable-messages
```
</Code>

Update a channel rule with multiple options for a specific app:

<Code>

### Shell

```
ably apps rules update "notifications" --persisted --push-enabled --app "My App"
```
</Code>

## See also

* [Apps](https://ably.com/docs/cli/apps.md) — Explore all `ably apps` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/apps/rules/create.md): Create a channel rule for an Ably application using the CLI.
- [delete](https://ably.com/docs/cli/apps/rules/delete.md): Delete a channel rule from an Ably application using the CLI.
- [list](https://ably.com/docs/cli/apps/rules/list.md): List channel rules for an Ably application using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
