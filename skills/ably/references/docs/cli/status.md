# Status

Use the `ably status` command to check the current status of Ably services.

## Synopsis

<Code>

### Shell

```
ably status [options]
```
</Code>

## Options

### `--open | -o` 

Open the Ably status page in a browser.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Check the status of Ably services:

<Code>

### Shell

```
ably status
```
</Code>

Check status with JSON output:

<Code>

### Shell

```
ably status --json
```
</Code>

## See also

* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [Overview](https://ably.com/docs/cli.md): Command-line interface for the Ably realtime messaging platform.
- [Login](https://ably.com/docs/cli/login.md): Log in to your Ably account using the CLI.
- [Autocomplete](https://ably.com/docs/cli/autocomplete.md): Display autocomplete installation instructions for the Ably CLI.
- [Env](https://ably.com/docs/cli/env.md): Show the reference for environment variables supported by the Ably CLI.
- [Version](https://ably.com/docs/cli/version.md): Display the version of the Ably CLI.
- [Help](https://ably.com/docs/cli/help.md): Display help information for Ably CLI commands.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
