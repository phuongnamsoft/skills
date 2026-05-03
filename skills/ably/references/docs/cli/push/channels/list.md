# Push channels list

Use the `ably push channels list` command to list push channel subscriptions.

## Synopsis

<Code>

### Shell

```
ably push channels list <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The channel to list subscriptions for.

## Options

### `--device-id` 

Filter subscriptions by device ID.

### `--client-id` 

Filter subscriptions by client ID.

### `--limit` 

The maximum number of subscriptions to retrieve. Defaults to `100`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

List all subscriptions for a channel:

<Code>

### Shell

```
ably push channels list "my-channel"
```
</Code>

Filter subscriptions by device:

<Code>

### Shell

```
ably push channels list "my-channel" --device-id device-123
```
</Code>

List push channel subscriptions in JSON format:

<Code>

### Shell

```
ably push channels list "my-channel" --json
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [list-channels](https://ably.com/docs/cli/push/channels/list-channels.md): List channels with push subscriptions using the Ably CLI.
- [save](https://ably.com/docs/cli/push/channels/save.md): Subscribe a device or client to push notifications on a channel using the Ably CLI.
- [remove](https://ably.com/docs/cli/push/channels/remove.md): Remove a push channel subscription using the Ably CLI.
- [remove-where](https://ably.com/docs/cli/push/channels/remove-where.md): Remove push channel subscriptions matching filter criteria using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
