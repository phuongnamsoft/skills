# Environment variables

The Ably CLI supports environment variables for `authentication` and `configuration` of default settings. These variables are useful in scripts, CI/CD pipelines, and automated workflows where interactive login is not possible. When `authentication variables` are set, the CLI bypasses the `ably login` workflow entirely.

## Synopsis

<Code>

### Shell

```
ably env [env-var-name] [options]
```
</Code>

## Arguments

### `env-var-name` 

Name of an environment variable. Supported variables:

* `ABLY_API_KEY` — API key for data plane commands.
* `ABLY_TOKEN` — Token/JWT for data plane commands.
* `ABLY_ACCESS_TOKEN` — Access token for Control API commands.
* `ABLY_ENDPOINT` — Override Realtime/REST API endpoint.
* `ABLY_APP_ID` — Default app for the `--app` flag.
* `ABLY_CLI_CONFIG_DIR` — Custom config directory.
* `ABLY_HISTORY_FILE` — Custom history file location.
* `ABLY_CLI_DEFAULT_DURATION` — Auto-exit long-running commands after N seconds.
* `ABLY_CLI_NON_INTERACTIVE` — Auto-confirm "Did you mean?" prompts.

## Options

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted, colorized JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Show usage doc for `ABLY_API_KEY`:

<Code>

### Shell

```
ably env ABLY_API_KEY
```
</Code>

Show usage doc for `ABLY_TOKEN`:

<Code>

### Shell

```
ably env ABLY_TOKEN
```
</Code>

Show usage doc for `ABLY_ACCESS_TOKEN`:

<Code>

### Shell

```
ably env ABLY_ACCESS_TOKEN
```
</Code>

Show usage doc for `ABLY_ENDPOINT`:

<Code>

### Shell

```
ably env ABLY_ENDPOINT
```
</Code>

Show usage doc for `ABLY_API_KEY` as compact JSON (machine-readable, useful in scripts):

<Code>

### Shell

```
ably env ABLY_API_KEY --json
```
</Code>

## Usage

<Aside data-type="note">
The CLI does not automatically load `.env` files. Set environment variables in your shell, CI/CD configuration, or inline with your commands.
</Aside>

To publish using `ABLY_API_KEY`:

<Code>

### Shell

```
ABLY_API_KEY="your-app-id.key-id:key-secret" ably channels publish my-channel "Hello"
```
</Code>

To subscribe using `ABLY_TOKEN`:
<Code>

### Shell

```
export ABLY_TOKEN="$(ABLY_API_KEY='appId.keyId:keySecret' ably auth issue-jwt-token --token-only)"
ably channels subscribe my-channel
```
</Code>

To list all apps using `ABLY_ACCESS_TOKEN`:
<Code>

### Shell

```
ABLY_ACCESS_TOKEN="your-access-token" ably apps list --json
```
</Code>

To publish to a custom Ably endpoint using `ABLY_ENDPOINT`:
<Code>

### Shell

```
export ABLY_ENDPOINT="custom-endpoint.example.com"
ably channels publish my-channel "Hello"
```
</Code>

## See also

* [Login](https://ably.com/docs/cli/login.md) — Log in to your Ably account via OAuth instead of using environment variables.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [Overview](https://ably.com/docs/cli.md): Command-line interface for the Ably realtime messaging platform.
- [Login](https://ably.com/docs/cli/login.md): Log in to your Ably account using the CLI.
- [Autocomplete](https://ably.com/docs/cli/autocomplete.md): Display autocomplete installation instructions for the Ably CLI.
- [Status](https://ably.com/docs/cli/status.md): Check the status of Ably services using the CLI.
- [Version](https://ably.com/docs/cli/version.md): Display the version of the Ably CLI.
- [Help](https://ably.com/docs/cli/help.md): Display help information for Ably CLI commands.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
