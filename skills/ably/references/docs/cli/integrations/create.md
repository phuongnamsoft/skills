# Integrations create

Use the `ably integrations create` command to create an integration rule for your Ably application.

## Synopsis

<Code>

### Shell

```
ably integrations create --rule-type <type> --source-type <source> [options]
```
</Code>

## Options

### `--rule-type`  **(Required)**

The type of integration rule to create. Valid options are `http`, `amqp`, `kinesis`, `firehose`, `pulsar`, `kafka`, `azure`, `azure-functions`, `mqtt`, or `cloudmqtt`.

### `--source-type`  **(Required)**

The source type for the integration rule. Valid options are `channel.message`, `channel.presence`, `channel.lifecycle`, or `presence.message`.

### `--app` 

The app ID to create the integration rule for. If not specified, the currently selected app is used.

### `--channel-filter` 

A channel name filter to apply to the integration rule.

### `--target-url` 

The target URL for the integration rule. This option is required for `http` rule types.

### `--request-mode` 

The request mode for the integration rule. Valid options are `single` or `batch`. The default value is `single`.

### `--status` 

The initial status of the integration rule. Valid options are `enabled` or `disabled`. The default value is `enabled`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Create an HTTP webhook integration:

<Code>

### Shell

```
ably integrations create --rule-type http --source-type channel.message --target-url https://example.com/webhook
```
</Code>

Create an AMQP integration with a channel filter:

<Code>

### Shell

```
ably integrations create --rule-type amqp --source-type channel.message --channel-filter "^notifications"
```
</Code>

Create a disabled integration rule:

<Code>

### Shell

```
ably integrations create --rule-type http --source-type channel.message --target-url https://example.com/webhook --status disabled
```
</Code>

Create an integration rule and output the result in JSON format:

<Code>

### Shell

```
ably integrations create --rule-type "http" --source-type "channel.message" --target-url "https://example.com/webhook" --json
```
</Code>

## See also

* [Integrations](https://ably.com/docs/cli/integrations.md) — Explore all `ably integrations` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [delete](https://ably.com/docs/cli/integrations/delete.md): Delete an integration rule using the Ably CLI.
- [get](https://ably.com/docs/cli/integrations/get.md): Get an integration rule by ID using the Ably CLI.
- [list](https://ably.com/docs/cli/integrations/list.md): List all integration rules using the Ably CLI.
- [update](https://ably.com/docs/cli/integrations/update.md): Update an integration rule using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
