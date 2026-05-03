# Integrations update

Use the `ably integrations update` command to update an existing integration rule.

## Synopsis

<Code>

### Shell

```
ably integrations update <integration-id> [options]
```
</Code>

## Arguments

### `integration-id`  **(Required)**

The ID of the integration rule to update.

## Options

### `--app` 

The app ID that the integration rule belongs to. If not specified, the currently selected app is used.

### `--channel-filter` 

Update the channel name filter for the integration rule.

### `--request-mode` 

Update the request mode for the integration rule. Valid options are `single` or `batch`.

### `--source` 

Update the [source type](https://ably.com/docs/platform/integrations.md) for the integration rule. Valid options are `channel.message`, `channel.presence`, `channel.lifecycle`, or `presence.message`.

### `--status` 

Update the status of the integration rule. Valid options are `enabled` or `disabled`.

### `--target` 

Update the target configuration for the integration rule.

### `--target-url` 

Update the target URL for the integration rule.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Disable an integration rule:

<Code>

### Shell

```
ably integrations update aBcDe1 --status disabled
```
</Code>

Update the channel filter for an integration rule:

<Code>

### Shell

```
ably integrations update aBcDe1 --channel-filter "^notifications"
```
</Code>

Update the target URL for an integration rule:

<Code>

### Shell

```
ably integrations update aBcDe1 --target-url https://example.com/new-webhook
```
</Code>

Update an integration rule and output the result in JSON format:

<Code>

### Shell

```
ably integrations update rule123 --status disabled --json
```
</Code>

## See also

* [Integrations](https://ably.com/docs/cli/integrations.md) — Explore all `ably integrations` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/integrations/create.md): Create an integration rule using the Ably CLI.
- [delete](https://ably.com/docs/cli/integrations/delete.md): Delete an integration rule using the Ably CLI.
- [get](https://ably.com/docs/cli/integrations/get.md): Get an integration rule by ID using the Ably CLI.
- [list](https://ably.com/docs/cli/integrations/list.md): List all integration rules using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
