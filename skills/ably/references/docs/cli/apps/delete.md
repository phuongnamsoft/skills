# Apps delete

Use the `ably apps delete` command to permanently delete an Ably application.

## Synopsis

<Code>

### Shell

```
ably apps delete [app-id] [options]
```
</Code>

<Aside data-type="important">
Deleting an application is irreversible. All data associated with the application, including API keys, channels, and message history, will be permanently removed.
</Aside>

## Arguments

### `app-id` 

The ID of the application to delete. If not specified, the currently selected app is used.

## Options

### `--app` 

The app ID to delete. This option overrides both the `app-id` argument and the currently selected app.

### `--force | -f` 

Skip the confirmation prompt and delete the application immediately. Required when using `--json`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Delete the currently selected app:

<Code>

### Shell

```
ably apps delete
```
</Code>

Delete a specific app by ID:

<Code>

### Shell

```
ably apps delete aBcDe1
```
</Code>

Delete an app without a confirmation prompt:

<Code>

### Shell

```
ably apps delete aBcDe1 --force
```
</Code>

Delete a specific app using the --app option:

<Code>

### Shell

```
ably apps delete --app app-id
```
</Code>

Delete an app using an access token environment variable:

<Code>

### Shell

```
ABLY_ACCESS_TOKEN="YOUR_ACCESS_TOKEN" ably apps delete app-id
```
</Code>

Delete an app and output the result in JSON format:

<Code>

### Shell

```
ably apps delete app-id --json
```
</Code>

Delete an app and output the result in formatted JSON:

<Code>

### Shell

```
ably apps delete app-id --pretty-json
```
</Code>

## See also

* [Apps](https://ably.com/docs/cli/apps.md) — Explore all `ably apps` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/apps/create.md): Create a new Ably application using the CLI.
- [current](https://ably.com/docs/cli/apps/current.md): Show the currently selected Ably application using the CLI.
- [list](https://ably.com/docs/cli/apps/list.md): List all Ably applications in the current account using the CLI.
- [switch](https://ably.com/docs/cli/apps/switch.md): Switch to a different Ably application using the CLI.
- [update](https://ably.com/docs/cli/apps/update.md): Update the name or TLS setting of an Ably application using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
