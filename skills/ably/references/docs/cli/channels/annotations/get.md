# Channels annotations get

Use the `ably channels annotations get` command to get annotations for a channel message.

## Synopsis

<Code>

### Shell

```
ably channels annotations get <channel-name> <message-serial> [options]
```
</Code>

## Arguments

### `channel-name`  **(Required)**

The name of the channel containing the message.

### `message-serial`  **(Required)**

The serial of the message to get annotations for.

## Options

### `--limit` 

The maximum number of annotations to return. Defaults to `100`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Get annotations for a message:

<Code>

### Shell

```
ably channels annotations get my-channel "msg-serial"
```
</Code>

Get annotations with a limit:

<Code>

### Shell

```
ably channels annotations get my-channel "msg-serial" --limit 10
```
</Code>

Get annotations and output in JSON format:

<Code>

### Shell

```
ably channels annotations get my-channel "msg-serial" --json
```
</Code>

Get annotations and output in formatted JSON:

<Code>

### Shell

```
ably channels annotations get my-channel "msg-serial" --pretty-json
```
</Code>

## See also

* [Channels](https://ably.com/docs/cli/channels.md) — Explore all `ably channels` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [publish](https://ably.com/docs/cli/channels/annotations/publish.md): Publish an annotation on an Ably Pub/Sub channel message using the CLI.
- [subscribe](https://ably.com/docs/cli/channels/annotations/subscribe.md): Subscribe to annotations on an Ably Pub/Sub channel using the CLI.
- [delete](https://ably.com/docs/cli/channels/annotations/delete.md): Delete an annotation from an Ably Pub/Sub channel message using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
