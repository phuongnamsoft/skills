# Spaces occupancy subscribe

Use the `ably spaces occupancy subscribe` command to subscribe to occupancy events on a space.

## Synopsis

<Code>

### Shell

```
ably spaces occupancy subscribe <space-name> [options]
```
</Code>

## Arguments

### `space-name`  **(Required)**

The name of the space to subscribe to occupancy events on.

## Options

### `--duration | -D` 

The duration in seconds to subscribe for before automatically unsubscribing.

### `--client-id` 

A client ID to use when subscribing.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Subscribe to occupancy events on a space:

<Code>

### Shell

```
ably spaces occupancy subscribe my-space
```
</Code>

Subscribe for a specific duration:

<Code>

### Shell

```
ably spaces occupancy subscribe my-space --duration 60
```
</Code>

Subscribe to space occupancy in JSON format:

<Code>

### Shell

```
ably spaces occupancy subscribe my-space --json
```
</Code>

## See also

* [Spaces](https://ably.com/docs/cli/spaces.md) — Explore all `ably spaces` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [get](https://ably.com/docs/cli/spaces/occupancy/get.md): Get current occupancy metrics for an Ably Space using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
