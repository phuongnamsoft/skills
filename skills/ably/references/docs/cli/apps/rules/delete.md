# Apps rules delete

Use the `ably apps rules delete` command to delete a [channel rule](https://ably.com/docs/channels.md#rules) from an Ably application.

## Synopsis

<Code>

### Shell

```
ably apps rules delete <rule-name-or-id> [options]
```
</Code>

## Arguments

### `rule-name-or-id`  **(Required)**

The name or ID of the channel rule to delete.

## Options

### `--app` 

The app ID to delete the rule from. Uses the currently selected app if not specified.

### `--force | -f` 

Skip the confirmation prompt and delete the rule immediately. Required when using `--json`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Delete a channel rule by name:

<Code>

### Shell

```
ably apps rules delete chat
```
</Code>

Delete a channel rule for a specific app:

<Code>

### Shell

```
ably apps rules delete "events-rule" --app "My App"
```
</Code>

Delete a channel rule without a confirmation prompt:

<Code>

### Shell

```
ably apps rules delete "notifications-rule" --force
```
</Code>

Delete a channel rule and output the result in JSON format:

<Code>

### Shell

```
ably apps rules delete "chat-rule" --json
```
</Code>

Delete a channel rule and output the result in formatted JSON:

<Code>

### Shell

```
ably apps rules delete "chat-rule" --pretty-json
```
</Code>

## See also

* [Apps](https://ably.com/docs/cli/apps.md) — Explore all `ably apps` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/apps/rules/create.md): Create a channel rule for an Ably application using the CLI.
- [list](https://ably.com/docs/cli/apps/rules/list.md): List channel rules for an Ably application using the CLI.
- [update](https://ably.com/docs/cli/apps/rules/update.md): Update a channel rule for an Ably application using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
