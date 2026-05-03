# Channels annotations publish

Use the `ably channels annotations publish` command to publish an annotation on a channel message.

## Synopsis

<Code>

### Shell

```
ably channels annotations publish <channel-name> <message-serial> <annotation-type> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel containing the message.

### `message-serial`  **(Required)**

The serial of the message to annotate.

### `annotation-type`  **(Required)**

The annotation type, specified in the format `namespace:summarization.version`. The `namespace` is a custom string that groups related annotations, such as `reactions`, `categories`, `metrics`, `rating` etc. For example, `reactions:unique.v1` or `metrics:total.v1`.

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

The annotation name. For example, an emoji name such as `thumbsup`.

### `--count` 

The count value for the annotation. Used with `multiple.v1` type annotations.

### `--data` 

A JSON payload to include with the annotation.

### `--encoding | -e` 

The encoding of the annotation data, such as `json/utf-8`.

### `--client-id` 

A client ID to use when publishing the annotation.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Publish a simple annotation:

<Code>

### Shell

```
ably channels annotations publish my-channel "msg-serial" "reactions:unique.v1"
```
</Code>

Publish a reaction with a name:

<Code>

### Shell

```
ably channels annotations publish my-channel "msg-serial" "reactions:unique.v1" --name thumbsup
```
</Code>

Publish an annotation with a count:

<Code>

### Shell

```
ably channels annotations publish my-channel "msg-serial" "metrics:multiple.v1" --name views --count 5
```
</Code>

Publish a total-type metric annotation:

<Code>

### Shell

```
ably channels annotations publish my-channel "msg-serial" "metrics:total.v1"
```
</Code>

Publish a flag annotation such as a read receipt:

<Code>

### Shell

```
ably channels annotations publish my-channel "msg-serial" "receipts:flag.v1"
```
</Code>

Publish an annotation and output the result in JSON format:

<Code>

### Shell

```
ably channels annotations publish my-channel "msg-serial" "metrics:total.v1" --json
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [subscribe](https://ably.com/docs/cli/channels/annotations/subscribe.md): Subscribe to annotations on an Ably Pub/Sub channel using the CLI.
- [get](https://ably.com/docs/cli/channels/annotations/get.md): Get annotations for an Ably Pub/Sub channel message using the CLI.
- [delete](https://ably.com/docs/cli/channels/annotations/delete.md): Delete an annotation from an Ably Pub/Sub channel message using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
