# Queues create

Use the `ably queues create` command to create a new queue for your Ably application.

## Synopsis

<Code>

### Shell

```
ably queues create <queue-name> [options]
```
</Code>

## Arguments

### `queue-name`  **(Required)**

The name of the queue to create.

## Options

### `--app` 

The app ID to create the queue for. If not specified, the currently selected app is used.

### `--max-length` 

The maximum number of messages the queue can hold. The default value is `10000`.

### `--region` 

The region to create the queue in. The default value is `us-east-1-a`. See the [queues documentation](https://ably.com/docs/platform/integrations/queues.md) for more details.

### `--ttl` 

The time-to-live for messages in the queue, in seconds. The default value is `60`. The maximum value is `3600`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Create a queue:

<Code>

### Shell

```
ably queues create "my-queue"
```
</Code>

Create a queue with custom settings:

<Code>

### Shell

```
ably queues create "my-queue" --ttl 300 --max-length 5000
```
</Code>

Create a queue in a specific region for a specific app:

<Code>

### Shell

```
ably queues create "my-queue" --region "eu-west-1-a" --app "My App"
```
</Code>

Create a queue and output the result in JSON format:

<Code>

### Shell

```
ably queues create "my-queue" --json
```
</Code>

## See also

* [Queues](https://ably.com/docs/cli/queues.md) — Explore all `ably queues` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [delete](https://ably.com/docs/cli/queues/delete.md): Delete a queue using the Ably CLI.
- [list](https://ably.com/docs/cli/queues/list.md): List all queues using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
