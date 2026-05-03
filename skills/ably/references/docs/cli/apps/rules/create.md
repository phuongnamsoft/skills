# Apps rules create

Use the `ably apps rules create` command to create a new [channel rule](https://ably.com/docs/channels.md#rules) for an Ably application. Channel rules define behavior for channels matching a specific namespace.

## Synopsis

<Code>

### Shell

```
ably apps rules create <rule-name> [options]
```
</Code>

## Arguments

### `rule-name`  **(Required)**

The name of the channel rule to create. The name defines the namespace that matching channels belong to.

## Options

### `--app` 

The app ID to create the rule for. Uses the currently selected app if not specified.

### `--persisted` 

Enable message persistence for matching channels. Defaults to `false`.

### `--push-enabled` 

Enable push notifications for matching channels. Defaults to `false`.

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

Create a channel rule with message persistence enabled:

<Code>

### Shell

```
ably apps rules create "chat" --persisted
```
</Code>

Create a channel rule with mutable messages enabled:

<Code>

### Shell

```
ably apps rules create "chat" --mutable-messages
```
</Code>

Create a channel rule with push notifications enabled:

<Code>

### Shell

```
ably apps rules create "events" --push-enabled
```
</Code>

Create a channel rule with persistence and push notifications for a specific app:

<Code>

### Shell

```
ably apps rules create "notifications" --persisted --push-enabled --app "My App"
```
</Code>

Create a channel rule and output the result in JSON format:

<Code>

### Shell

```
ably apps rules create "chat" --persisted --json
```
</Code>

## See also

* [Apps](https://ably.com/docs/cli/apps.md) — Explore all `ably apps` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [delete](https://ably.com/docs/cli/apps/rules/delete.md): Delete a channel rule from an Ably application using the CLI.
- [list](https://ably.com/docs/cli/apps/rules/list.md): List channel rules for an Ably application using the CLI.
- [update](https://ably.com/docs/cli/apps/rules/update.md): Update a channel rule for an Ably application using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
