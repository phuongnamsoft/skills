# Spaces locks acquire

Use the `ably spaces locks acquire` command to acquire a lock in a space.

## Synopsis

<Code>

### Shell

```
ably spaces locks acquire <space-name> <lock-id> [options]
```
</Code>

## Arguments

### `space-name`  **(Required)**

The name of the space to acquire the lock in.

### `lock-id`  **(Required)**

The identifier of the lock to acquire.

## Options

### `--data` 

JSON data to associate with the lock.

### `--duration | -D` 

The duration in seconds to hold the lock before automatically releasing it.

### `--client-id` 

A client ID to use when acquiring the lock.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Acquire a lock in a space:

<Code>

### Shell

```
ably spaces locks acquire my-space my-lock
```
</Code>

Acquire a lock with associated data:

<Code>

### Shell

```
ably spaces locks acquire my-space my-lock --data '{"component": "editor"}'
```
</Code>

Acquire a lock for a specific duration:

<Code>

### Shell

```
ably spaces locks acquire my-space my-lock --duration 300
```
</Code>

Acquire a lock and output the result in JSON format:

<Code>

### Shell

```
ably spaces locks acquire my-space my-lock-id --json
```
</Code>

## See also

* [Spaces](https://ably.com/docs/cli/spaces.md) — Explore all `ably spaces` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [get](https://ably.com/docs/cli/spaces/locks/get.md): Get a lock or all locks in an Ably Space using the CLI.
- [subscribe](https://ably.com/docs/cli/spaces/locks/subscribe.md): Subscribe to lock events in an Ably Space using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
