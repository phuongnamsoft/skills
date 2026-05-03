# Push config clear-fcm

Use the `ably push config clear-fcm` command to clear FCM push notification configuration for an app.

## Synopsis

<Code>

### Shell

```
ably push config clear-fcm [options]
```
</Code>

## Options

### `--app` 

The app ID to clear configuration for.

### `--force | -f` 

Skip confirmation prompt. Required when using `--json`. The default is `false`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Clear FCM configuration with confirmation:

<Code>

### Shell

```
ably push config clear-fcm
```
</Code>

Force clear FCM configuration:

<Code>

### Shell

```
ably push config clear-fcm --force
```
</Code>

Force clear FCM configuration and output in JSON format:

<Code>

### Shell

```
ably push config clear-fcm --force --json
```
</Code>

## See also

* [Push](https://ably.com/docs/cli/push.md) — Explore all `ably push` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [show](https://ably.com/docs/cli/push/config/show.md): Show push notification configuration for an Ably app using the CLI.
- [set-apns](https://ably.com/docs/cli/push/config/set-apns.md): Configure APNs push notifications for an Ably app using the CLI.
- [set-fcm](https://ably.com/docs/cli/push/config/set-fcm.md): Configure FCM push notifications for an Ably app using the CLI.
- [clear-apns](https://ably.com/docs/cli/push/config/clear-apns.md): Clear APNs push notification configuration for an Ably app using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
