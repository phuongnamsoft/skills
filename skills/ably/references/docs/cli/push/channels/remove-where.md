# Push channels remove-where

Use the `ably push channels remove-where` command to remove push channel subscriptions matching filter criteria.

## Synopsis

<Code>

### Shell

```
ably push channels remove-where <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The channel to remove subscriptions from.

## Options

### `--device-id` 

Filter subscriptions by device ID.

### `--client-id` 

Filter subscriptions by client ID.

### `--force | -f` 

Skip confirmation prompt. Required when using `--json`. The default is `false`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Remove all subscriptions on a channel:

<Code>

### Shell

```
ably push channels remove-where "my-channel"
```
</Code>

Remove all subscriptions for a device on a channel:

<Code>

### Shell

```
ably push channels remove-where "my-channel" --device-id device-123 --force
```
</Code>

Remove all subscriptions for a client on a channel:

<Code>

### Shell

```
ably push channels remove-where "my-channel" --client-id client-1 --force
```
</Code>

Remove push subscriptions and output in JSON format:

<Code>

### Shell

```
ably push channels remove-where "my-channel" --json
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [list](https://ably.com/docs/cli/push/channels/list.md): List push channel subscriptions using the Ably CLI.
- [list-channels](https://ably.com/docs/cli/push/channels/list-channels.md): List channels with push subscriptions using the Ably CLI.
- [save](https://ably.com/docs/cli/push/channels/save.md): Subscribe a device or client to push notifications on a channel using the Ably CLI.
- [remove](https://ably.com/docs/cli/push/channels/remove.md): Remove a push channel subscription using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
