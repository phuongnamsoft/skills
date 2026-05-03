# Push publish

Use the `ably push publish` command to publish a push notification to a device, client, or channel.

## Synopsis

<Code>

### Shell

```
ably push publish [options]
```
</Code>

## Options

### `--device-id` 

The ID of the device to publish to. Exclusive with `--client-id` and `--recipient`.

### `--client-id` 

The client ID to publish to. Exclusive with `--device-id` and `--recipient`.

### `--recipient` 

A raw JSON recipient object. Exclusive with `--device-id` and `--client-id`.

### `--channel` 

The target channel name. Publishes a push notification via the channel using `extras.push`. Ignored if `--device-id`, `--client-id`, or `--recipient` is also provided. Use together with `--message` to publish a realtime message on the channel alongside the push notification.

### `--message` 

Realtime message to include alongside the push notification. Accepts plain text, or a JSON object. In a JSON object, the recognized message fields `name`, `data`, and `extras` are mapped directly; any other fields are merged into `data`. Only applies when publishing via `--channel`.

### `--title` 

The title of the push notification.

### `--body` 

The body text of the push notification.

### `--sound` 

The sound to play when the notification is received.

### `--icon` 

The icon for the push notification.

### `--badge` 

The badge number to display on the app icon.

### `--data` 

A JSON payload to include with the push notification.

### `--collapse-key` 

A collapse key for grouping notifications.

### `--ttl` 

The time-to-live for the notification in seconds.

### `--payload` 

A full JSON payload for the push notification, provided as a JSON string or a file path. Overrides convenience options such as `--title` and `--body`.

### `--apns` 

APNs-specific JSON configuration.

### `--fcm` 

FCM-specific JSON configuration.

### `--web` 

Web push-specific JSON configuration.

### `--force | -f` 

Skip confirmation prompt. Required when using `--json`. The default is `false`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Publish to a device:

<Code>

### Shell

```
ably push publish --device-id "device123" --title "Hello" --body "World"
```
</Code>

Publish to a client:

<Code>

### Shell

```
ably push publish --client-id "user456" --title "Update" --body "New content available"
```
</Code>

Publish to a channel:

<Code>

### Shell

```
ably push publish --channel "announcements" --title "News" --body "Breaking update" --message "Breaking update" --force
```
</Code>

Publish to a device with a custom payload:

<Code>

### Shell

```
ably push publish --device-id "device123" --payload '{"notification":{"title":"Custom","body":"Payload"},"data":{"key":"value"}}'
```
</Code>

Publish to a device with additional data:

<Code>

### Shell

```
ably push publish --device-id device-123 --title Hello --body World --data '{"key":"value"}'
```
</Code>

Publish to a device using a JSON payload string:

<Code>

### Shell

```
ably push publish --device-id device-123 --payload '{"notification":{"title":"Hello","body":"World"}}'
```
</Code>

Publish to a device using a payload from a file:

<Code>

### Shell

```
ably push publish --device-id device-123 --payload ./notification.json
```
</Code>

See notification file example [below](#notification-json-file).

Publish to a client using a JSON payload string:

<Code>

### Shell

```
ably push publish --client-id client-1 --payload '{"notification":{"title":"Hello","body":"World"}}'
```
</Code>

Publish to a channel with a message string and additional data:

<Code>

### Shell

```
ably push publish --channel my-channel --title Hello --body World --data '{"key":"value"}' --message 'Hello from push'
```
</Code>

Publish to a channel using a JSON payload string:

<Code>

### Shell

```
ably push publish --channel my-channel --payload '{"notification":{"title":"Hello","body":"World"},"data":{"key":"value"}}' --message 'Hello from push'
```
</Code>

Publish to a channel with a message JSON object (a full message object with `name` and `data` fields):

<Code>

### Shell

```
ably push publish --channel my-channel --title Hello --body World --message '{"name":"greeting","data":"Welcome back"}'
```
</Code>

Publish to a channel with a message `data` JSON payload (a JSON object containing arbitrary message `data` fields):

<Code>

### Shell

```
ably push publish --channel my-channel --title Hello --body World --message '{"event":"push","text":"Hello"}'
```
</Code>

Publish to a channel using a payload from a file and a string message:

<Code>

### Shell

```
ably push publish --channel my-channel --payload ./notification.json --message 'Hello from push'
```
</Code>

See notification file example [below](#notification-json-file).

Publish using raw recipient attributes:

<Code>

### Shell

```
ably push publish --recipient '{"transportType":"apns","deviceToken":"token123"}' --title Hello --body World
```
</Code>

Publish and output in JSON format:

<Code>

### Shell

```
ably push publish --device-id device-123 --title Hello --body World --json
```
</Code>

### Notification.json file 

<Code>

#### Json

```
{
  "notification": {
    "title": "Hello",
    "body": "World"
  },
  "data": {
    "key": "value"
  }
}
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [batch-publish](https://ably.com/docs/cli/push/batch-publish.md): Publish push notifications to multiple recipients in a batch using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
