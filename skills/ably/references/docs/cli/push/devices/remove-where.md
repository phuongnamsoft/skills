# Push devices remove-where

Use the `ably push devices remove-where` command to remove push device registrations matching filter criteria.

## Synopsis

<Code>

### Shell

```
ably push devices remove-where [options]
```
</Code>

## Options

### `--device-id` 

Filter registrations by device ID.

### `--client-id` 

Filter registrations by client ID.

### `--force | -f` 

Skip confirmation prompt. Required when using `--json`. The default is `false`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Remove registrations by device ID:

<Code>

### Shell

```
ably push devices remove-where --device-id "device123"
```
</Code>

Remove registrations by client ID:

<Code>

### Shell

```
ably push devices remove-where --client-id "user456"
```
</Code>

Remove device registrations and output in JSON format:

<Code>

### Shell

```
ably push devices remove-where --device-id device-123 --json
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [list](https://ably.com/docs/cli/push/devices/list.md): List push device registrations using the Ably CLI.
- [get](https://ably.com/docs/cli/push/devices/get.md): Get details of a push device registration using the Ably CLI.
- [save](https://ably.com/docs/cli/push/devices/save.md): Register or update a push device using the Ably CLI.
- [remove](https://ably.com/docs/cli/push/devices/remove.md): Remove a push device registration using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
