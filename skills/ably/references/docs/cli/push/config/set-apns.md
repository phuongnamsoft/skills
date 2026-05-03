# Push config set-apns

Use the `ably push config set-apns` command to configure APNs push notifications for an app.

## Synopsis

<Code>

### Shell

```
ably push config set-apns [options]
```
</Code>

## Options

### `--app` 

The app ID to configure.

### `--certificate` 

The path to a P12 certificate file. Exclusive with `--key-file`.

### `--key-file` 

The path to a P8 key file. Exclusive with `--certificate`.

### `--key-id` 

The key ID for the P8 key. Required when using `--key-file`.

### `--password` 

The password for the P12 certificate.

### `--sandbox` 

Use the APNs sandbox environment. Defaults to `false`.

### `--team-id` 

The Apple Developer team ID. Required when using `--key-file`.

### `--topic` 

The bundle ID for the app. Required when using `--key-file`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Configure APNs with a P12 certificate:

<Code>

### Shell

```
ably push config set-apns --certificate /path/to/cert.p12 --password "cert-password"
```
</Code>

Configure APNs with a P8 key:

<Code>

### Shell

```
ably push config set-apns --key-file /path/to/key.p8 --key-id "ABC123" --team-id "TEAM456" --topic "com.example.app"
```
</Code>

Configure APNs with a P12 certificate and sandbox environment:

<Code>

### Shell

```
ably push config set-apns --certificate /path/to/cert.p12 --password secret --sandbox
```
</Code>

Configure APNs and output the result in JSON format:

<Code>

### Shell

```
ably push config set-apns --certificate /path/to/cert.p12 --json
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [show](https://ably.com/docs/cli/push/config/show.md): Show push notification configuration for an Ably app using the CLI.
- [set-fcm](https://ably.com/docs/cli/push/config/set-fcm.md): Configure FCM push notifications for an Ably app using the CLI.
- [clear-apns](https://ably.com/docs/cli/push/config/clear-apns.md): Clear APNs push notification configuration for an Ably app using the CLI.
- [clear-fcm](https://ably.com/docs/cli/push/config/clear-fcm.md): Clear FCM push notification configuration for an Ably app using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
