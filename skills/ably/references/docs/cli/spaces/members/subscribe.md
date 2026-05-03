# Spaces members subscribe

Use the `ably spaces members subscribe` command to subscribe to member presence events in a space.

## Synopsis

<Code>

### Shell

```
ably spaces members subscribe <space-name> [options]
```
</Code>

## Arguments

### `space-name`  **(Required)**

The name of the space to subscribe to member events in.

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

Subscribe to member presence events in a space:

<Code>

### Shell

```
ably spaces members subscribe my-space
```
</Code>

Subscribe for a specific duration:

<Code>

### Shell

```
ably spaces members subscribe my-space --duration 60
```
</Code>

Subscribe to member events in JSON format:

<Code>

### Shell

```
ably spaces members subscribe my-space --json
```
</Code>

Subscribe to member events in formatted JSON:

<Code>

### Shell

```
ably spaces members subscribe my-space --pretty-json
```
</Code>

## See also

* [Spaces](https://ably.com/docs/cli/spaces.md) — Explore all `ably spaces` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [enter](https://ably.com/docs/cli/spaces/members/enter.md): Enter an Ably Space and remain present until terminated using the CLI.
- [get](https://ably.com/docs/cli/spaces/members/get.md): Get all members in an Ably Space using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
