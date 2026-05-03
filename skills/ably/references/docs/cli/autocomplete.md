# Autocomplete

Use the `ably autocomplete` command to display installation instructions for shell autocompletion. Once configured, autocomplete enables tab completion for commands and options in your terminal.

## Synopsis

<Code>

### Shell

```
ably autocomplete [shell]
```
</Code>

## Arguments

### `shell` 

The shell type to set up autocomplete for. Supported values: `zsh`, `bash`, `powershell`.

If no shell is specified, the default shell is used.

## Options

### `--refresh-cache | -r` 

Refresh the autocomplete cache instead of displaying instructions.

## Examples

Display autocomplete setup instructions for the default shell:

<Code>

### Shell

```
ably autocomplete
```
</Code>

Set up autocomplete for bash:

<Code>

### Shell

```
ably autocomplete bash
```
</Code>

Set up autocomplete for zsh:

<Code>

### Shell

```
ably autocomplete zsh
```
</Code>

Set up autocomplete for powershell:

<Code>

### Shell

```
ably autocomplete powershell
```
</Code>

Refresh the autocomplete cache:

<Code>

### Shell

```
ably autocomplete --refresh-cache
```
</Code>

## See also

* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [Overview](https://ably.com/docs/cli.md): Command-line interface for the Ably realtime messaging platform.
- [Login](https://ably.com/docs/cli/login.md): Log in to your Ably account using the CLI.
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
