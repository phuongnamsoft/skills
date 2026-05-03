# Spaces create

Use the `ably spaces create` command to initialize a space without entering it.

## Synopsis

<Code>

### Shell

```
ably spaces create <space-name> [options]
```
</Code>

## Arguments

### `space-name`  **(Required)**

The name of the space to create.

## Options

### `--client-id` 

A client ID to use when creating the space.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Create a space:

<Code>

### Shell

```
ably spaces create my-space
```
</Code>

Create a space with a specific client ID:

<Code>

### Shell

```
ably spaces create my-space --client-id "user-123"
```
</Code>

Create a space and output the result in JSON format:

<Code>

### Shell

```
ably spaces create my-space --json
```
</Code>

## See also

* [Spaces](https://ably.com/docs/cli/spaces.md) — Explore all `ably spaces` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [get](https://ably.com/docs/cli/spaces/get.md): Get the current state of an Ably Space using the CLI.
- [list](https://ably.com/docs/cli/spaces/list.md): List active Ably Spaces using the CLI.
- [subscribe](https://ably.com/docs/cli/spaces/subscribe.md): Subscribe to member and location update events in an Ably Space using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
