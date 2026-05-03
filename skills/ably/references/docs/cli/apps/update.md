# Apps update

Use the `ably apps update` command to update the name or TLS setting of an Ably application.

## Synopsis

<Code>

### Shell

```
ably apps update <app-name-or-id> [options]
```
</Code>

## Arguments

### `app-name-or-id`  **(Required)**

The app name or ID to update.

## Options

<Aside data-type="note">
Boolean options support a `--no-` prefix to disable the option. For example, use `--no-tls-only` to allow non-TLS connections.
</Aside>

### `--name` 

The new name for the application.

### `--tls-only` 

Restrict the application to TLS connections only. When enabled, all connections to this app must use TLS encryption.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Update an application's name:

<Code>

### Shell

```
ably apps update "My App" --name "New App Name"
```
</Code>

Restrict an application to TLS connections only:

<Code>

### Shell

```
ably apps update my-app-id --tls-only
```
</Code>

Allow non-TLS connections for an application:

<Code>

### Shell

```
ably apps update my-app-id --no-tls-only
```
</Code>

Update an app and output the result in JSON format:

<Code>

### Shell

```
ably apps update "My App" --name "New App Name" --tls-only --json
```
</Code>

## See also

* [Apps](https://ably.com/docs/cli/apps.md) — Explore all `ably apps` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/apps/create.md): Create a new Ably application using the CLI.
- [current](https://ably.com/docs/cli/apps/current.md): Show the currently selected Ably application using the CLI.
- [delete](https://ably.com/docs/cli/apps/delete.md): Permanently delete an Ably application using the CLI.
- [list](https://ably.com/docs/cli/apps/list.md): List all Ably applications in the current account using the CLI.
- [switch](https://ably.com/docs/cli/apps/switch.md): Switch to a different Ably application using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
