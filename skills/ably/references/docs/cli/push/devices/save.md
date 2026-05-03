# Push devices save

Use the `ably push devices save` command to register or update a push device.

## Synopsis

<Code>

### Shell

```
ably push devices save [options]
```
</Code>

## Options

### `--id` 

The device ID. Required unless `--data` is provided.

### `--platform` 

The device platform. Options are `ios`, `android`, and `browser`.

### `--form-factor` 

The device form factor. Options are `phone`, `tablet`, `desktop`, `tv`, `watch`, `car`, `embedded`, and `other`.

### `--transport-type` 

The push transport type. Options are `apns`, `fcm`, and `web`.

### `--device-token` 

The device token for APNs or FCM. Required when transport type is `apns` or `fcm`.

### `--target-url` 

The target URL for web push. Required when transport type is `web`.

### `--p256dh-key` 

The P-256 Diffie-Hellman key for web push. Required when transport type is `web`.

### `--auth-secret` 

The authentication secret for web push. Required when transport type is `web`.

### `--client-id` 

The client ID to associate with the device.

### `--metadata` 

Device metadata as a JSON string.

### `--data` 

Full device registration JSON, or a file path prefixed with `@`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Register an iOS device:

<Code>

### Shell

```
ably push devices save --id "device-001" --platform ios --form-factor phone --transport-type apns --device-token "token123" --client-id "user456"
```
</Code>

Register a web push device:

<Code>

### Shell

```
ably push devices save --platform browser --form-factor desktop --transport-type web --target-url "https://example.com/push" --p256dh-key "key123" --auth-secret "secret456"
```
</Code>

Register a device from a JSON file:

<Code>

### Shell

```
ably push devices save --data @device.json
```
</Code>

Register a device using inline JSON data:

<Code>

### Shell

```
ably push devices save --data '{"id":"device-123","platform":"ios","formFactor":"phone","push":{"recipient":{"transportType":"apns","deviceToken":"token123"}}}'
```
</Code>

Register a device and output the result in JSON format:

<Code>

### Shell

```
ably push devices save --id device-123 --platform ios --form-factor phone --transport-type apns --device-token token123 --json
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [list](https://ably.com/docs/cli/push/devices/list.md): List push device registrations using the Ably CLI.
- [get](https://ably.com/docs/cli/push/devices/get.md): Get details of a push device registration using the Ably CLI.
- [remove](https://ably.com/docs/cli/push/devices/remove.md): Remove a push device registration using the Ably CLI.
- [remove-where](https://ably.com/docs/cli/push/devices/remove-where.md): Remove push device registrations matching filter criteria using the Ably CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
