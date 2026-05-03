# Accounts login

Use the `ably accounts login` command to log in to your Ably account via OAuth. The CLI opens a browser, you authorize the request, and tokens are stored locally and auto-refreshed.

If your account has multiple accounts, apps, or API keys, the CLI prompts you to pick one.

## Synopsis

<Code>

### Shell

```
ably accounts login [options]
```
</Code>

## Options

### `--alias | -a` 

Set an alias name for this account so you can switch between multiple accounts using `ably accounts switch`. If omitted, the CLI generates one from the account name.

### `--no-browser` 

Prevent the CLI from automatically opening a browser. The CLI displays the verification URL and user code to open manually.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Log in to your Ably account using the browser:

<Code>

### Shell

```
ably accounts login
```
</Code>

Log in and set an alias for the account:

<Code>

### Shell

```
ably accounts login --alias work
```
</Code>

Log in without opening a browser (for use over SSH or in headless environments):

<Code>

### Shell

```
ably accounts login --no-browser
```
</Code>

Log in and output the result in JSON format:

<Code>

### Shell

```
ably accounts login --json
```
</Code>

Log in and output the result in formatted JSON:

<Code>

### Shell

```
ably accounts login --pretty-json
```
</Code>

## See also

* [Accounts](https://ably.com/docs/cli/accounts.md) — Explore all `ably accounts` commands.
* [Environment variables](https://ably.com/docs/cli/env.md) — Authenticate via environment variables instead of using OAuth login.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [current](https://ably.com/docs/cli/accounts/current.md): Show the current Ably account using the CLI.
- [list](https://ably.com/docs/cli/accounts/list.md): List all locally configured Ably accounts using the CLI.
- [logout](https://ably.com/docs/cli/accounts/logout.md): Log out from an Ably account using the CLI.
- [switch](https://ably.com/docs/cli/accounts/switch.md): Switch to a different Ably account using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
