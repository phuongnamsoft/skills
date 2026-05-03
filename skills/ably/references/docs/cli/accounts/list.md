# Accounts list

Use the `ably accounts list` command to list all locally configured Ably accounts.

## Synopsis

<Code>

### Shell

```
ably accounts list [options]
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

List all configured accounts:

<Code>

### Shell

```
ably accounts list
```
</Code>

List all configured accounts in JSON format:

<Code>

### Shell

```
ably accounts list --json
```
</Code>

List all configured accounts in formatted JSON output:

<Code>

### Shell

```
ably accounts list --pretty-json
```
</Code>

## Output

The `ably accounts list` command displays a list of accounts in the following format:

| Property | Description |
| -------- | ----------- |
| Account | The account name and ID. |
| Name | The alias name of the account, if one is configured. |
| User | The email address of the logged-in user. |
| Apps | Number of apps configured for this account. |
| Current App | The currently selected app name and ID. |

## See also

* [Accounts](https://ably.com/docs/cli/accounts.md) — Explore all `ably accounts` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [current](https://ably.com/docs/cli/accounts/current.md): Show the current Ably account using the CLI.
- [login](https://ably.com/docs/cli/accounts/login.md): Log in to your Ably account using the CLI.
- [logout](https://ably.com/docs/cli/accounts/logout.md): Log out from an Ably account using the CLI.
- [switch](https://ably.com/docs/cli/accounts/switch.md): Switch to a different Ably account using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
