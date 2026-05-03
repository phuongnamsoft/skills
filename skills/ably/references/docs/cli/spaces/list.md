# Spaces list

Use the `ably spaces list` command to list active spaces.

## Synopsis

<Code>

### Shell

```
ably spaces list [options]
```
</Code>

## Options

### `--limit` 

The maximum number of spaces to return. Defaults to `100`.

### `--prefix | -p` 

A prefix to filter spaces by name.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

List all active spaces:

<Code>

### Shell

```
ably spaces list
```
</Code>

List spaces with a prefix:

<Code>

### Shell

```
ably spaces list --prefix "project-"
```
</Code>

List spaces with a custom limit:

<Code>

### Shell

```
ably spaces list --limit 50
```
</Code>

List spaces in JSON format:

<Code>

### Shell

```
ably spaces list --json
```
</Code>

List spaces in formatted JSON output:

<Code>

### Shell

```
ably spaces list --pretty-json
```
</Code>

## See also

* [Spaces](https://ably.com/docs/cli/spaces.md) — Explore all `ably spaces` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [create](https://ably.com/docs/cli/spaces/create.md): Initialize an Ably Space without entering it using the CLI.
- [get](https://ably.com/docs/cli/spaces/get.md): Get the current state of an Ably Space using the CLI.
- [subscribe](https://ably.com/docs/cli/spaces/subscribe.md): Subscribe to member and location update events in an Ably Space using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
