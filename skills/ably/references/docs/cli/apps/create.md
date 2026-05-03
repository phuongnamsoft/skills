# Apps create

Use the `ably apps create` command to create a new Ably application in your account.

## Synopsis

<Code>

### Shell

```
ably apps create <app-name> [options]
```
</Code>

## Arguments

### `app-name`  **(Required)**

The name of the application to create.

## Options

### `--tls-only` 

Restrict the application to TLS connections only. When enabled, all connections to this app must use TLS encryption.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Create a new application:

<Code>

### Shell

```
ably apps create "My New App"
```
</Code>

Create an application restricted to TLS connections only:

<Code>

### Shell

```
ably apps create "My New App" --tls-only
```
</Code>

Create an application and output the result in JSON format:

<Code>

### Shell

```
ably apps create "My New App" --json
```
</Code>

Create an application using an access token environment variable:

<Code>

### Shell

```
ABLY_ACCESS_TOKEN="YOUR_ACCESS_TOKEN" ably apps create "My New App"
```
</Code>

## See also

* [Apps](https://ably.com/docs/cli/apps.md) — Explore all `ably apps` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [current](https://ably.com/docs/cli/apps/current.md): Show the currently selected Ably application using the CLI.
- [delete](https://ably.com/docs/cli/apps/delete.md): Permanently delete an Ably application using the CLI.
- [list](https://ably.com/docs/cli/apps/list.md): List all Ably applications in the current account using the CLI.
- [switch](https://ably.com/docs/cli/apps/switch.md): Switch to a different Ably application using the CLI.
- [update](https://ably.com/docs/cli/apps/update.md): Update the name or TLS setting of an Ably application using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
