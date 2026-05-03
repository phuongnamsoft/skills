# Accounts current

Use the `ably accounts current` command to show details of the currently active Ably account.

## Synopsis

<Code>

### Shell

```
ably accounts current [options]
```
</Code>

## Options

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Display the current account:

<Code>

### Shell

```
ably accounts current
```
</Code>

Display the current account in JSON format:

<Code>

### Shell

```
ably accounts current --json
```
</Code>

Display the current account in formatted JSON output:

<Code>

### Shell

```
ably accounts current --pretty-json
```
</Code>

## Output

The `ably accounts current` command displays:

| Property | Description |
| -------- | ----------- |
| Account | The account name and ID. |
| User | The email address of the logged-in user. |
| Apps configured | Number of apps configured for this account. |
| Current App | The currently selected app name and ID. |
| Current API Key | The API key being used. |
| Key Label | The label of the current API key. |

## See also

* [Accounts](https://ably.com/docs/cli/accounts.md) — Explore all `ably accounts` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [list](https://ably.com/docs/cli/accounts/list.md): List all locally configured Ably accounts using the CLI.
- [login](https://ably.com/docs/cli/accounts/login.md): Log in to your Ably account using the CLI.
- [logout](https://ably.com/docs/cli/accounts/logout.md): Log out from an Ably account using the CLI.
- [switch](https://ably.com/docs/cli/accounts/switch.md): Switch to a different Ably account using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
