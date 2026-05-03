# Queues delete

Use the `ably queues delete` command to delete a queue.

## Synopsis

<Code>

### Shell

```
ably queues delete <queue-name-or-id> [options]
```
</Code>

## Arguments

### `queue-name-or-id`  **(Required)**

The name or ID of the queue to delete.

## Options

### `--app` 

The app ID that the queue belongs to. If not specified, the currently selected app is used.

### `--force | -f` 

Skip the confirmation prompt and delete the queue immediately. Required when using `--json`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Delete a queue by name:

<Code>

### Shell

```
ably queues delete "my-queue"
```
</Code>

Delete a queue for a specific app:

<Code>

### Shell

```
ably queues delete "my-queue" --app "My App"
```
</Code>

Delete a queue without a confirmation prompt:

<Code>

### Shell

```
ably queues delete "my-queue" --force
```
</Code>

Delete a queue and output the result in JSON format:

<Code>

### Shell

```
ably queues delete "my-queue" --json
```
</Code>

## See also

* [Queues](https://ably.com/docs/cli/queues.md) — Explore all `ably queues` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/queues/create.md): Create a queue using the Ably CLI.
- [list](https://ably.com/docs/cli/queues/list.md): List all queues using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
