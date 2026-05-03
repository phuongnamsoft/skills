# Push devices list

Use the `ably push devices list` command to list push device registrations.

## Synopsis

<Code>

### Shell

```
ably push devices list [options]
```
</Code>

## Options

### `--device-id` 

Filter registrations by device ID.

### `--client-id` 

Filter registrations by client ID.

### `--state` 

Filter registrations by state. Options are `ACTIVE`, `FAILING`, and `FAILED`.

### `--limit` 

The maximum number of registrations to retrieve. Defaults to `100`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

List all device registrations:

<Code>

### Shell

```
ably push devices list
```
</Code>

Filter by state:

<Code>

### Shell

```
ably push devices list --state ACTIVE
```
</Code>

List device registrations filtered by client ID:

<Code>

### Shell

```
ably push devices list --client-id client-1
```
</Code>

List device registrations with a limit in JSON format:

<Code>

### Shell

```
ably push devices list --limit 50 --json
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [get](https://ably.com/docs/cli/push/devices/get.md): Get details of a push device registration using the Ably CLI.
- [save](https://ably.com/docs/cli/push/devices/save.md): Register or update a push device using the Ably CLI.
- [remove](https://ably.com/docs/cli/push/devices/remove.md): Remove a push device registration using the Ably CLI.
- [remove-where](https://ably.com/docs/cli/push/devices/remove-where.md): Remove push device registrations matching filter criteria using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
