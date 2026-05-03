# Channels annotations delete

Use the `ably channels annotations delete` command to delete an annotation from a channel message.

## Synopsis

<Code>

### Shell

```
ably channels annotations delete <channel-name> <message-serial> <annotation-type> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel containing the message.

### `message-serial`  **(Required)**

The serial of the message to delete the annotation from.

### `annotation-type`  **(Required)**

The annotation type to delete, specified in the format `namespace:summarization.version`. The `namespace` is a custom string that groups related annotations, such as `reactions`, `categories`, `metrics`, `rating` etc. For example, `reactions:unique.v1` or `receipts:flag.v1`.

The following summarization methods are available:

| Method | Description |
| --- | --- |
| `total.v1` | Counts all annotations without client attribution. Unidentified clients can publish this type. |
| `flag.v1` | Counts distinct clients contributing once per type. Requires an identified client. |
| `distinct.v1` | Counts unique clients per annotation name. Each client contributes once per name. Requires an identified client. |
| `unique.v1` | Guarantees each client contributes to only one name at a time. Publishing a new name auto-removes the previous one. Requires an identified client. |
| `multiple.v1` | Tracks per-client and total counts. A client can contribute to the same annotation name multiple times. Requires an identified client. |

See the [annotations documentation](https://ably.com/docs/messages/annotations.md) for more details.

## Options

### `--name | -n` 

The annotation name to delete. Use this to target a specific annotation when multiple annotations of the same type exist.

### `--client-id` 

A client ID to use when deleting the annotation.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Delete a receipt annotation:

<Code>

### Shell

```
ably channels annotations delete my-channel "msg-serial" "receipts:unique.v1"
```
</Code>

Delete a reaction by name:

<Code>

### Shell

```
ably channels annotations delete my-channel "msg-serial" "reactions:unique.v1" --name thumbsup
```
</Code>

Delete a flag-type annotation such as a read receipt:

<Code>

### Shell

```
ably channels annotations delete my-channel "msg-serial" "receipts:flag.v1"
```
</Code>

Delete a distinct category annotation by name:

<Code>

### Shell

```
ably channels annotations delete my-channel "msg-serial" "categories:distinct.v1" --name important
```
</Code>

Delete an annotation and output the result in JSON format:

<Code>

### Shell

```
ably channels annotations delete my-channel "msg-serial" "receipts:flag.v1" --json
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [publish](https://ably.com/docs/cli/channels/annotations/publish.md): Publish an annotation on an Ably Pub/Sub channel message using the CLI.
- [subscribe](https://ably.com/docs/cli/channels/annotations/subscribe.md): Subscribe to annotations on an Ably Pub/Sub channel using the CLI.
- [get](https://ably.com/docs/cli/channels/annotations/get.md): Get annotations for an Ably Pub/Sub channel message using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
