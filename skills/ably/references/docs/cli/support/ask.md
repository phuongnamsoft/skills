# Support ask

Use the `ably support ask` command to ask a question to the Ably AI agent for help.

## Synopsis

<Code>

### Shell

```
ably support ask <question> [options]
```
</Code>

## Arguments

### `question`  **(Required)**

The question to ask the Ably AI agent.

## Options

### `--continue` 

Continue a previous conversation with the AI agent. Defaults to `false`.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Ask a basic question:

<Code>

### Shell

```
ably support ask "How do I create an app?"
```
</Code>

Ask a technical question:

<Code>

### Shell

```
ably support ask "How do I authenticate with token auth?"
```
</Code>

Continue a previous conversation:

<Code>

### Shell

```
ably support ask "Can you give me more details?" --continue
```
</Code>

Ask a question and output the response in JSON format:

<Code>

### Shell

```
ably support ask "How do I get started with Ably?" --json
```
</Code>

## See also

* [Support](https://ably.com/docs/cli/support.md) — Explore all `ably support` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [contact](https://ably.com/docs/cli/support/contact.md): Contact Ably for assistance using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
