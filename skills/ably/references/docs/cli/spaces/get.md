# Spaces get

Use the `ably spaces get` command to get the current state of a space.

## Synopsis

<Code>

### Shell

```
ably spaces get <space-name>
```
</Code>

## Arguments

### `space-name`  **(Required)**

The name of the space to get.

## Options

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Get the current state of a space:

<Code>

### Shell

```
ably spaces get my-space
```
</Code>

Get the state of a space in JSON format:

<Code>

### Shell

```
ably spaces get my-space --json
```
</Code>

Get the state of a space in formatted JSON output:

<Code>

### Shell

```
ably spaces get my-space --pretty-json
```
</Code>

## See also

* [Spaces](https://ably.com/docs/cli/spaces.md) — Explore all `ably spaces` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/spaces/create.md): Initialize an Ably Space without entering it using the CLI.
- [list](https://ably.com/docs/cli/spaces/list.md): List active Ably Spaces using the CLI.
- [subscribe](https://ably.com/docs/cli/spaces/subscribe.md): Subscribe to member and location update events in an Ably Space using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
