# Push config set-fcm

Use the `ably push config set-fcm` command to configure FCM push notifications for an app.

## Synopsis

<Code>

### Shell

```
ably push config set-fcm --service-account <path> [options]
```
</Code>

## Options

### `--service-account`  **(Required)**

The path to the FCM service account JSON file.

### `--app` 

The app ID to configure.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Configure FCM with a service account:

<Code>

### Shell

```
ably push config set-fcm --service-account /path/to/service-account.json
```
</Code>

Configure FCM for a specific app:

<Code>

### Shell

```
ably push config set-fcm --service-account /path/to/service-account.json --app my-app
```
</Code>

Configure FCM and output the result in JSON format:

<Code>

### Shell

```
ably push config set-fcm --service-account /path/to/service-account.json --json
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [show](https://ably.com/docs/cli/push/config/show.md): Show push notification configuration for an Ably app using the CLI.
- [set-apns](https://ably.com/docs/cli/push/config/set-apns.md): Configure APNs push notifications for an Ably app using the CLI.
- [clear-apns](https://ably.com/docs/cli/push/config/clear-apns.md): Clear APNs push notification configuration for an Ably app using the CLI.
- [clear-fcm](https://ably.com/docs/cli/push/config/clear-fcm.md): Clear FCM push notification configuration for an Ably app using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
