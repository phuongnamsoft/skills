# Push channels remove

Use the `ably push channels remove` command to remove a push channel subscription.

## Synopsis

<Code>

### Shell

```
ably push channels remove <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The channel to remove the subscription from.

## Options

### `--device-id` 

The device ID to unsubscribe. Exclusive with `--client-id`.

### `--client-id` 

The client ID to unsubscribe. Exclusive with `--device-id`.

### `--force | -f` 

Skip confirmation prompt. Required when using `--json`. The default is `false`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Remove a device subscription from a channel:

<Code>

### Shell

```
ably push channels remove "my-channel" --device-id device-123
```
</Code>

Remove a client subscription from a channel:

<Code>

### Shell

```
ably push channels remove "my-channel" --client-id client-1 --force
```
</Code>

Remove a push channel subscription and output in JSON format:

<Code>

### Shell

```
ably push channels remove "my-channel" --device-id device-123 --json
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [list](https://ably.com/docs/cli/push/channels/list.md): List push channel subscriptions using the Ably CLI.
- [list-channels](https://ably.com/docs/cli/push/channels/list-channels.md): List channels with push subscriptions using the Ably CLI.
- [save](https://ably.com/docs/cli/push/channels/save.md): Subscribe a device or client to push notifications on a channel using the Ably CLI.
- [remove-where](https://ably.com/docs/cli/push/channels/remove-where.md): Remove push channel subscriptions matching filter criteria using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
