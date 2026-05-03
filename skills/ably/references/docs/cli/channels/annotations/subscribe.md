# Channels annotations subscribe

Use the `ably channels annotations subscribe` command to subscribe to annotations on an Ably Pub/Sub channel.

## Synopsis

<Code>

### Shell

```
ably channels annotations subscribe <channel-name> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel to subscribe to annotations on.

## Options

### `--type` 

Filter annotations by type. The type is specified in the format `namespace:summarization.version`. The `namespace` is a custom string that groups related annotations, such as `reactions`, `categories`, `metrics`, `rating` etc. For example, `reactions:unique.v1` or `metrics:total.v1`.

The following summarization methods are available:

| Method | Description |
| --- | --- |
| `total.v1` | Counts all annotations without client attribution. Unidentified clients can publish this type. |
| `flag.v1` | Counts distinct clients contributing once per type. Requires an identified client. |
| `distinct.v1` | Counts unique clients per annotation name. Each client contributes once per name. Requires an identified client. |
| `unique.v1` | Guarantees each client contributes to only one name at a time. Publishing a new name auto-removes the previous one. Requires an identified client. |
| `multiple.v1` | Tracks per-client and total counts. A client can contribute to the same annotation name multiple times. Requires an identified client. |

See the [annotations documentation](https://ably.com/docs/messages/annotations.md) for more details.

### `--duration | -D` 

The duration in seconds to subscribe for before automatically unsubscribing.

### `--rewind` 

The number of annotations to rewind when subscribing. Defaults to `0`.

### `--client-id` 

A client ID to use when subscribing.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Subscribe to all annotations on a channel:

<Code>

### Shell

```
ably channels annotations subscribe my-channel
```
</Code>

Subscribe to annotations filtered by type:

<Code>

### Shell

```
ably channels annotations subscribe my-channel --type "reactions:unique.v1"
```
</Code>

Subscribe for a specific duration:

<Code>

### Shell

```
ably channels annotations subscribe my-channel --duration 60
```
</Code>

Subscribe to metric-type annotations on a channel:

<Code>

### Shell

```
ably channels annotations subscribe my-channel --type "metrics:total.v1"
```
</Code>

Subscribe to annotations and output events in JSON format:

<Code>

### Shell

```
ably channels annotations subscribe my-channel --json
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [publish](https://ably.com/docs/cli/channels/annotations/publish.md): Publish an annotation on an Ably Pub/Sub channel message using the CLI.
- [get](https://ably.com/docs/cli/channels/annotations/get.md): Get annotations for an Ably Pub/Sub channel message using the CLI.
- [delete](https://ably.com/docs/cli/channels/annotations/delete.md): Delete an annotation from an Ably Pub/Sub channel message using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
