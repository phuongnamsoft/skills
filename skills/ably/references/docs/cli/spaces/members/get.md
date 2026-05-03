# Spaces members get

Use the `ably spaces members get` command to get all members in a space.

## Synopsis

<Code>

### Shell

```
ably spaces members get <space-name>
```
</Code>

## Arguments

### `space-name`  **(Required)**

The name of the space to get members for.

## Options

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Get all members in a space:

<Code>

### Shell

```
ably spaces members get my-space
```
</Code>

Get members in JSON format:

<Code>

### Shell

```
ably spaces members get my-space --json
```
</Code>

Get members in formatted JSON output:

<Code>

### Shell

```
ably spaces members get my-space --pretty-json
```
</Code>

## See also

* [Spaces](https://ably.com/docs/cli/spaces.md) — Explore all `ably spaces` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [enter](https://ably.com/docs/cli/spaces/members/enter.md): Enter an Ably Space and remain present until terminated using the CLI.
- [subscribe](https://ably.com/docs/cli/spaces/members/subscribe.md): Subscribe to member presence events in an Ably Space using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
