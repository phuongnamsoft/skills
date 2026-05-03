# Accounts logout

Use the `ably accounts logout` command to log out from an Ably account. By default, this logs out from the current account and prompts for confirmation. For OAuth accounts, the CLI also revokes the stored access and refresh tokens with the Ably authorization server.

## Synopsis

<Code>

### Shell

```
ably accounts logout [account-alias-or-id] [options]
```
</Code>

## Arguments

### `account-alias-or-id` 

An optional account alias or ID to log out from. If not provided, the CLI logs out from the current account.

## Options

### `--force | -f` 

Skip the confirmation prompt and log out immediately. Required when using `--json`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Log out from the current account:

<Code>

### Shell

```
ably accounts logout
```
</Code>

Log out from a specific account by alias:

<Code>

### Shell

```
ably accounts logout work
```
</Code>

Log out from a specific account by ID:

<Code>

### Shell

```
ably accounts logout VgQpOZ
```
</Code>

Log out without confirmation:

<Code>

### Shell

```
ably accounts logout --force
```
</Code>

Log out and output the result in JSON format:

<Code>

### Shell

```
ably accounts logout --json
```
</Code>

Log out and output the result in formatted JSON:

<Code>

### Shell

```
ably accounts logout --pretty-json
```
</Code>

## See also

* [Accounts](https://ably.com/docs/cli/accounts.md) — Explore all `ably accounts` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [current](https://ably.com/docs/cli/accounts/current.md): Show the current Ably account using the CLI.
- [list](https://ably.com/docs/cli/accounts/list.md): List all locally configured Ably accounts using the CLI.
- [login](https://ably.com/docs/cli/accounts/login.md): Log in to your Ably account using the CLI.
- [switch](https://ably.com/docs/cli/accounts/switch.md): Switch to a different Ably account using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
