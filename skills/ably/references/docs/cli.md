# Ably CLI

## Overview

For an overview of the Ably CLI, including [installation instructions](https://ably.com/docs/platform/tools/cli.md#installation) and [feature highlights](https://ably.com/docs/platform/tools/cli.md#feature-set), see the [Ably CLI](https://ably.com/docs/platform/tools/cli.md) page.

## Global options 

### `--json` 

Output results as compact, single-line [NDJSON](https://github.com/ndjson/ndjson-spec) (Newline Delimited JSON). Each line is a self-contained JSON object, making it suitable for programmatic usage and piping into tools such as `jq`. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in colorized, pretty-printed JSON format for human-readable inspection. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Commands 

The following top-level commands are available in the Ably CLI:

| Command | Description |
| ------- | ----------- |
| [`ably login`](https://ably.com/docs/cli/login.md) | Log in to your Ably account (alias for "ably accounts login") |
| [`ably accounts`](https://ably.com/docs/cli/accounts.md) | Manage Ably accounts and your configured access tokens |
| [`ably apps`](https://ably.com/docs/cli/apps.md) | Manage Ably apps |
| [`ably auth`](https://ably.com/docs/cli/auth.md) | Manage authentication, keys and tokens |
| [`ably channels`](https://ably.com/docs/cli/channels.md) | Interact with Ably Pub/Sub channels |
| [`ably rooms`](https://ably.com/docs/cli/rooms.md) | Interact with Ably Chat rooms |
| [`ably spaces`](https://ably.com/docs/cli/spaces.md) | Interact with Ably Spaces |
| [`ably queues`](https://ably.com/docs/cli/queues.md) | Manage Ably Queues |
| [`ably integrations`](https://ably.com/docs/cli/integrations.md) | Manage Ably integrations |
| [`ably push`](https://ably.com/docs/cli/push.md) | Manage push notifications |
| [`ably logs`](https://ably.com/docs/cli/logs.md) | Streaming and retrieving logs from Ably |
| [`ably stats`](https://ably.com/docs/cli/stats.md) | View statistics for your Ably account or apps |
| [`ably config`](https://ably.com/docs/cli/config.md) | Manage Ably CLI configuration |
| [`ably bench`](https://ably.com/docs/cli/bench.md) | Commands for running benchmark tests |
| [`ably connections`](https://ably.com/docs/cli/connections.md) | Interact with Ably Pub/Sub connections |
| [`ably support`](https://ably.com/docs/cli/support.md) | Get support and help from Ably |
| [`ably autocomplete`](https://ably.com/docs/cli/autocomplete.md) | Display autocomplete installation instructions |
| [`ably env`](https://ably.com/docs/cli/env.md) | Show the reference for environment variables supported by the Ably CLI |
| [`ably status`](https://ably.com/docs/cli/status.md) | Check the status of the Ably service |
| [`ably version`](https://ably.com/docs/cli/version.md) | Display the current version of the Ably CLI |
| [`ably help`](https://ably.com/docs/cli/help.md) | Display help for ably |

## Related Topics

- [Login](https://ably.com/docs/cli/login.md): Log in to your Ably account using the CLI.
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
