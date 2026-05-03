# Config path

Use the `ably config path` command to print the path to the Ably CLI config file.

## Synopsis

<Code>

### Shell

```
ably config path
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

Print the config file path:

<Code>

### Shell

```
ably config path
```
</Code>

Open the config file in VS Code:

<Code>

### Shell

```
code $(ably config path)
```
</Code>

Open the config file in Vim:

<Code>

### Shell

```
vim $(ably config path)
```
</Code>

Print the config file path in JSON format:

<Code>

### Shell

```
ably config path --json
```
</Code>

## See also

* [Config](https://ably.com/docs/cli/config.md) — Explore all `ably config` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [show](https://ably.com/docs/cli/config/show.md): Display the contents of the Ably CLI config file.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
