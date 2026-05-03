# Accounts switch

Use the `ably accounts switch` command to switch to a different locally configured Ably account. If no alias or ID is provided, the CLI presents an interactive list of available accounts.

## Synopsis

<Code>

### Shell

```
ably accounts switch [account-alias-or-id] [options]
```
</Code>

## Arguments

### `account-alias-or-id` 

An optional account alias or ID to switch to. If not provided, the CLI displays an interactive prompt to select from available accounts.

## Options

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Switch accounts interactively:

<Code>

### Shell

```
ably accounts switch
```
</Code>

Switch to a specific account by alias:

<Code>

### Shell

```
ably accounts switch work
```
</Code>

Switch to a specific account by ID:

<Code>

### Shell

```
ably accounts switch VgQpOZ
```
</Code>

Switch accounts and output the result in JSON format:

<Code>

### Shell

```
ably accounts switch --json
```
</Code>

Switch accounts and output the result in formatted JSON:

<Code>

### Shell

```
ably accounts switch --pretty-json
```
</Code>

## See also

* [Accounts](https://ably.com/docs/cli/accounts.md) — Explore all `ably accounts` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [current](https://ably.com/docs/cli/accounts/current.md): Show the current Ably account using the CLI.
- [list](https://ably.com/docs/cli/accounts/list.md): List all locally configured Ably accounts using the CLI.
- [login](https://ably.com/docs/cli/accounts/login.md): Log in to your Ably account using the CLI.
- [logout](https://ably.com/docs/cli/accounts/logout.md): Log out from an Ably account using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
