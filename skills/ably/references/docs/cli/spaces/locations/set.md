# Spaces locations set

Use the `ably spaces locations set` command to set location in a space.

## Synopsis

<Code>

### Shell

```
ably spaces locations set <space-name> <location> [options]
```
</Code>

## Arguments

### `space-name`  **(Required)**

The name of the space to set the location in.

### `location`  **(Required)**

JSON location data to set.

## Options

### `--duration | -D` 

The duration in seconds to maintain the location before automatically removing it.

### `--client-id` 

A client ID to use when setting the location.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Set a location in a space:

<Code>

### Shell

```
ably spaces locations set "my-space" '{"x":10,"y":20}'
```
</Code>

Set a location with section data:

<Code>

### Shell

```
ably spaces locations set "my-space" '{"sectionId":"section1"}'
```
</Code>

Set a location and output in JSON format:

<Code>

### Shell

```
ably spaces locations set "my-space" '{"x":10,"y":20}' --json
```
</Code>

## See also

* [Spaces](https://ably.com/docs/cli/spaces.md) — Explore all `ably spaces` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [get](https://ably.com/docs/cli/spaces/locations/get.md): Get all current locations in an Ably Space using the CLI.
- [subscribe](https://ably.com/docs/cli/spaces/locations/subscribe.md): Subscribe to location updates for members in an Ably Space using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
