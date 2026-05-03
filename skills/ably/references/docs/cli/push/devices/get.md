# Push devices get

Use the `ably push devices get` command to get details of a push device registration.

## Synopsis

<Code>

### Shell

```
ably push devices get <device-id>
```
</Code>

## Arguments

### `device-id`  **(Required)**

The ID of the device to retrieve details for.

## Options

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Get details of a device registration:

<Code>

### Shell

```
ably push devices get "device123"
```
</Code>

Get device registration details in JSON format:

<Code>

### Shell

```
ably push devices get device-123 --json
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [list](https://ably.com/docs/cli/push/devices/list.md): List push device registrations using the Ably CLI.
- [save](https://ably.com/docs/cli/push/devices/save.md): Register or update a push device using the Ably CLI.
- [remove](https://ably.com/docs/cli/push/devices/remove.md): Remove a push device registration using the Ably CLI.
- [remove-where](https://ably.com/docs/cli/push/devices/remove-where.md): Remove push device registrations matching filter criteria using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
