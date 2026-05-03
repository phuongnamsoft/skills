# Push channels save

Use the `ably push channels save` command to subscribe a device or client to push notifications on a channel.

## Synopsis

<Code>

### Shell

```
ably push channels save <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The channel to subscribe to.

## Options

### `--device-id` 

The device ID to subscribe. Exclusive with `--client-id`.

### `--client-id` 

The client ID to subscribe. Exclusive with `--device-id`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Subscribe a device to push notifications on a channel:

<Code>

### Shell

```
ably push channels save "my-channel" --device-id device-123
```
</Code>

Subscribe a client to push notifications on a channel:

<Code>

### Shell

```
ably push channels save "my-channel" --client-id client-1
```
</Code>

Save a push channel subscription and output in JSON format:

<Code>

### Shell

```
ably push channels save "my-channel" --device-id device-123 --json
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [list](https://ably.com/docs/cli/push/channels/list.md): List push channel subscriptions using the Ably CLI.
- [list-channels](https://ably.com/docs/cli/push/channels/list-channels.md): List channels with push subscriptions using the Ably CLI.
- [remove](https://ably.com/docs/cli/push/channels/remove.md): Remove a push channel subscription using the Ably CLI.
- [remove-where](https://ably.com/docs/cli/push/channels/remove-where.md): Remove push channel subscriptions matching filter criteria using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
