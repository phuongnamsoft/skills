# Spaces members enter

Use the `ably spaces members enter` command to enter a space and remain present until terminated.

## Synopsis

<Code>

### Shell

```
ably spaces members enter <space-name> [options]
```
</Code>

## Arguments

### `space-name`  **(Required)**

The name of the space to enter.

## Options

### `--profile` 

JSON profile data to associate with the member.

### `--duration | -D` 

The duration in seconds to remain present before automatically leaving.

### `--client-id` 

A client ID to use when entering the space.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Enter a space:

<Code>

### Shell

```
ably spaces members enter my-space
```
</Code>

Enter a space with profile data:

<Code>

### Shell

```
ably spaces members enter my-space --profile '{"name": "Alice", "avatar": "avatar-1"}'
```
</Code>

Enter a space for a specific duration:

<Code>

### Shell

```
ably spaces members enter my-space --duration 120
```
</Code>

Enter a space and output the result in JSON format:

<Code>

### Shell

```
ably spaces members enter my-space --json
```
</Code>

## See also

* [Spaces](https://ably.com/docs/cli/spaces.md) — Explore all `ably spaces` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [get](https://ably.com/docs/cli/spaces/members/get.md): Get all members in an Ably Space using the CLI.
- [subscribe](https://ably.com/docs/cli/spaces/members/subscribe.md): Subscribe to member presence events in an Ably Space using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
