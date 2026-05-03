# Push channels list-channels

Use the `ably push channels list-channels` command to list channels with push subscriptions.

## Synopsis

<Code>

### Shell

```
ably push channels list-channels [options]
```
</Code>

## Options

### `--limit` 

The maximum number of channels to retrieve. Defaults to `100`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

List channels with push subscriptions:

<Code>

### Shell

```
ably push channels list-channels
```
</Code>

List push channels with a limit:

<Code>

### Shell

```
ably push channels list-channels --limit 50
```
</Code>

List push channels in JSON format:

<Code>

### Shell

```
ably push channels list-channels --json
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [list](https://ably.com/docs/cli/push/channels/list.md): List push channel subscriptions using the Ably CLI.
- [save](https://ably.com/docs/cli/push/channels/save.md): Subscribe a device or client to push notifications on a channel using the Ably CLI.
- [remove](https://ably.com/docs/cli/push/channels/remove.md): Remove a push channel subscription using the Ably CLI.
- [remove-where](https://ably.com/docs/cli/push/channels/remove-where.md): Remove push channel subscriptions matching filter criteria using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
