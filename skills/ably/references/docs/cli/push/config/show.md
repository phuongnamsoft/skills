# Push config show

Use the `ably push config show` command to show push notification configuration for an app.

## Synopsis

<Code>

### Shell

```
ably push config show [options]
```
</Code>

## Options

### `--app` 

The app ID to show configuration for.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Show push configuration for the current app:

<Code>

### Shell

```
ably push config show
```
</Code>

Show push configuration for a specific app:

<Code>

### Shell

```
ably push config show --app "app-id"
```
</Code>

Show push configuration in JSON format:

<Code>

### Shell

```
ably push config show --json
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [set-apns](https://ably.com/docs/cli/push/config/set-apns.md): Configure APNs push notifications for an Ably app using the CLI.
- [set-fcm](https://ably.com/docs/cli/push/config/set-fcm.md): Configure FCM push notifications for an Ably app using the CLI.
- [clear-apns](https://ably.com/docs/cli/push/config/clear-apns.md): Clear APNs push notification configuration for an Ably app using the CLI.
- [clear-fcm](https://ably.com/docs/cli/push/config/clear-fcm.md): Clear FCM push notification configuration for an Ably app using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
