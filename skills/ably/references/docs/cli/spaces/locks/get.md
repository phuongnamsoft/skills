# Spaces locks get

Use the `ably spaces locks get` command to get a lock or all locks in a space.

## Synopsis

<Code>

### Shell

```
ably spaces locks get <space-name> [lock-id]
```
</Code>

## Arguments

### `space-name`  **(Required)**

The name of the space to get locks for.

### `lock-id` 

The identifier of a specific lock to get. Omit to get all locks in the space.

## Options

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Get all locks in a space:

<Code>

### Shell

```
ably spaces locks get my-space
```
</Code>

Get a specific lock:

<Code>

### Shell

```
ably spaces locks get my-space my-lock
```
</Code>

Get all locks in JSON format:

<Code>

### Shell

```
ably spaces locks get my-space --json
```
</Code>

Get all locks in formatted JSON output:

<Code>

### Shell

```
ably spaces locks get my-space --pretty-json
```
</Code>

Get a specific lock in JSON format:

<Code>

### Shell

```
ably spaces locks get my-space lock-id --json
```
</Code>

Get a specific lock in formatted JSON output:

<Code>

### Shell

```
ably spaces locks get my-space lock-id --pretty-json
```
</Code>

## See also

* [Spaces](https://ably.com/docs/cli/spaces.md) — Explore all `ably spaces` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [acquire](https://ably.com/docs/cli/spaces/locks/acquire.md): Acquire a lock in an Ably Space using the CLI.
- [subscribe](https://ably.com/docs/cli/spaces/locks/subscribe.md): Subscribe to lock events in an Ably Space using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
