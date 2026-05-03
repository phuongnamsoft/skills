# Login

Use the `ably login` command to log in to your Ably account via OAuth. The CLI opens a browser, you authorize the request, and tokens are stored locally and auto-refreshed.

If your account has multiple accounts, apps, or API keys, the CLI prompts you to pick one.

## Synopsis

<Code>

### Shell

```
ably login [options]
```
</Code>

<Aside data-type="note">
This command is an alias for [`ably accounts login`](https://ably.com/docs/cli/accounts/login.md).
</Aside>

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
ably login
```
</Code>

Log in and set an alias for the account:

<Code>

### Shell

```
ably login --alias work
```
</Code>

Log in without opening a browser (for use over SSH or in headless environments):

<Code>

### Shell

```
ably login --no-browser
```
</Code>

Log in and output the result in JSON format:

<Code>

### Shell

```
ably login --json
```
</Code>

Log in and output the result in formatted JSON:

<Code>

### Shell

```
ably login --pretty-json
```
</Code>

## See also

* [Accounts logout](https://ably.com/docs/cli/accounts/logout.md) — Sign out and revoke stored OAuth tokens.
* [Accounts switch](https://ably.com/docs/cli/accounts/switch.md) — Switch between aliased accounts.
* [Environment variables](https://ably.com/docs/cli/env.md) — Authenticate via environment variables instead of using OAuth login.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [Overview](https://ably.com/docs/cli.md): Command-line interface for the Ably realtime messaging platform.
- [Autocomplete](https://ably.com/docs/cli/autocomplete.md): Display autocomplete installation instructions for the Ably CLI.
- [Env](https://ably.com/docs/cli/env.md): Show the reference for environment variables supported by the Ably CLI.
- [Status](https://ably.com/docs/cli/status.md): Check the status of Ably services using the CLI.
- [Version](https://ably.com/docs/cli/version.md): Display the version of the Ably CLI.
- [Help](https://ably.com/docs/cli/help.md): Display help information for Ably CLI commands.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
