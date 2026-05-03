# Push batch-publish

Use the `ably push batch-publish` command to publish push notifications to multiple recipients in a batch.

## Synopsis

<Code>

### Shell

```
ably push batch-publish [payload] [options]
```
</Code>

## Arguments

### `payload` 

A JSON array of push notification payloads. This can be provided as an inline JSON string, a file path (for example `./notifications.json` or `@notifications.json`), or `-` to read from stdin.

Each item must have either a `recipient` or `channels` key. Items with `channels` are routed via channel-based push. Channel items may include an optional `message` field with realtime message data (plain text or JSON object) to publish alongside the push notification. In a JSON object, the recognized message fields `name`, `data`, and `extras` are mapped directly; any other fields are merged into `data`.

## Options

### `--force | -f` 

Skip confirmation when publishing to channels. Required when using `--json`. The default is `false`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Publish to multiple recipients with an inline JSON payload:

<Code>

### Shell

```
ably push batch-publish '[{"recipient":{"deviceId":"device1"},"payload":{"notification":{"title":"Hello"}}},{"recipient":{"clientId":"user1"},"payload":{"notification":{"title":"Hi"}}}]'
```
</Code>

Publish from a file:

<Code>

### Shell

```
ably push batch-publish @notifications.json
```
</Code>

See notification file example [below](#notifications-json-file).

Publish from stdin:

<Code>

### Shell

```
cat notifications.json | ably push batch-publish -
```
</Code>

Publish to a specific client:

<Code>

### Shell

```
ably push batch-publish '[{"recipient":{"clientId":"user-456"},"payload":{"notification":{"title":"Hello","body":"World"}}}]'
```
</Code>

Publish a data-only notification to a device:

<Code>

### Shell

```
ably push batch-publish '[{"recipient":{"deviceId":"device-123"},"payload":{"data":{"orderId":"123","action":"update"}}}]'
```
</Code>

Publish to a channel with a message string and a force option:

<Code>

### Shell

```
ably push batch-publish '[{"channels":["my-channel"],"payload":{"notification":{"title":"Hello","body":"World"}},"message":"Hello from push"}]' --force
```
</Code>

Publish to multiple channels with a message JSON object:

<Code>

### Shell

```
ably push batch-publish '[{"channels":["channel-1","channel-2"],"payload":{"notification":{"title":"Alert","body":"Message"}},"message":{"name":"alert","data":"New alert"}}]' --force
```
</Code>

Publish to device and channel recipients in one batch:

<Code>

### Shell

```
ably push batch-publish '[{"recipient":{"deviceId":"device-123"},"payload":{"notification":{"title":"Hello","body":"World"}}},{"channels":["my-channel"],"payload":{"notification":{"title":"Hello","body":"World"}},"message":{"name":"greeting","data":"Hello from push"}}]' --force
```
</Code>

Publish from a file and output in JSON format:

<Code>

### Shell

```
ably push batch-publish ./notifications.json --json --force
```
</Code>

### Notifications.json file 

<Code>

#### Json

```
[
  {
    "recipient": {"deviceId": "device-123"},
    "payload": {
      "notification": {"title": "Hello", "body": "World"}
    }
  },
  {
    "channels": ["my-channel"],
    "payload": {
      "notification": {"title": "Hello", "body": "World"}
    },
    "message": {"name": "greeting", "data": "Hello from push"}
  }
]
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [publish](https://ably.com/docs/cli/push/publish.md): Publish a push notification to a device, client, or channel using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
