# Ably CLI

The [Ably CLI](https://github.com/ably/ably-cli) brings the full power of Ably to your terminal. You can use it to manage your Ably account and its resources, and to explore Ably's APIs and features.

It's a quick and easy way to simulate additional clients when testing how Ably works.

The Ably CLI interacts with:

* The [Control API](https://ably.com/docs/platform/account/control-api.md) to manage your Ably account and applications.
* [Pub/Sub](https://ably.com/docs/basics.md) to publish and subscribe to messages in realtime.
* [Chat](https://ably.com/docs/chat.md) to send messages, display typing indicators and react to what's happening in a chat room.
* [Spaces](https://ably.com/docs/spaces.md) to enter spaces and register member locations.

## Installation

The Ably CLI is available as an NPM package. Install it using:

<Code>

### Shell

```
npm install -g @ably/cli
```
</Code>

## Usage

Run the following to log in to your Ably account:

<Code>

### Shell

```
ably login
```
</Code>
<Aside data-type='note'>
Alternatively, you can skip interactive `ably login` and use [environment variables](https://ably.com/docs/cli/env.md) to authenticate directly in scripts and CI/CD pipelines.
</Aside>

This initiates an [OAuth Device Authorization](https://datatracker.ietf.org/doc/html/rfc8628) flow: the CLI displays an authorization code and opens your browser to approve it. Once approved, the CLI receives an [access token](https://ably.com/docs/platform/account/access-tokens.md) that is stored locally and refreshed automatically — no manual token management required.

After you have successfully authenticated and chosen your app and API key, you're ready to interact with Ably resources directly from your terminal. 

For example, open two terminal instances and subscribe to one, and publish messages in the other:

To subscribe:

<Code>

### Shell

```
# Attach to channel `channel-1` and start receiving new messages
ably channels subscribe channel-1
```
</Code>

To publish:

<Code>

### Shell

```
# To publish 1 message:
ably channels publish channel-1 Hi!
```
</Code>

<Code>

### Shell

```
# To publish 5 messages:
ably channels publish --count 5 channel-1 "Message number {{.Count}}"
```
</Code>

For a list of all available commands, run:

<Code>

### Shell

```
ably help
```
</Code>

## Global options 

The following options can be used with any command for programmatic usage and debugging:

* [`--json`](https://ably.com/docs/cli.md#json) or [`--pretty-json`](https://ably.com/docs/cli.md#pretty-json) — JSON output. Mutually exclusive options.
* [`--verbose`](https://ably.com/docs/cli.md#verbose) — Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Feature set

You can use the Ably CLI for undertaking operations such as:

| Operation | Description |
| --------- | ----------- |
| **Ably Accounts** ||
| [List accounts](https://ably.com/docs/cli/accounts/list.md) | List the accounts you have access to. |
| [Switch accounts](https://ably.com/docs/cli/accounts/switch.md) | Switch between multiple Ably accounts. |
| [Account statistics](https://ably.com/docs/cli/stats/account.md) | Query your account statistics. |
| **Ably Apps** ||
| [List apps](https://ably.com/docs/cli/apps/list.md) | List all apps in your account. |
| [Switch apps](https://ably.com/docs/cli/apps/switch.md) | Switch between multiple apps. |
| [Manage apps](https://ably.com/docs/cli/apps.md) | Create and delete apps. |
| [Manage API keys](https://ably.com/docs/cli/auth.md) | Create, update and revoke API keys in an app. |
| [App statistics](https://ably.com/docs/cli/stats/app.md) | Query app statistics. |
| [Manage rules](https://ably.com/docs/cli/apps.md) | Create, update and delete rules in an app. |
| [Logs](https://ably.com/docs/cli/logs.md) | Query and subscribe to logs. |
| **Integrations and Queues** ||
| [Manage integrations](https://ably.com/docs/cli/integrations.md) | List, create and delete integrations. |
| [Manage queues](https://ably.com/docs/cli/queues.md) | List, create and delete queues. |
| **Pub/Sub** ||
| [List channels](https://ably.com/docs/cli/channels/list.md) | List active channels in an app. |
| [Publish](https://ably.com/docs/cli/channels/publish.md) | Publish and batch publish messages. |
| [Subscribe](https://ably.com/docs/cli/channels/subscribe.md) | Subscribe to messages on channels. |
| [Presence](https://ably.com/docs/cli/channels.md) | Enter and subscribe to the presence set of channels. |
| [History](https://ably.com/docs/cli/channels/history.md) | Query message history. |
| [Occupancy](https://ably.com/docs/cli/channels.md) | Fetch and subscribe to channel occupancy. |
| **Chat** ||
| [List rooms](https://ably.com/docs/cli/rooms/list.md) | List chat rooms in an app. |
| [Messages](https://ably.com/docs/cli/rooms.md) | Send and subscribe to messages. |
| [Presence](https://ably.com/docs/cli/rooms.md) | Enter and subscribe to the presence set of chat rooms. |
| [History](https://ably.com/docs/cli/rooms/messages/history.md) | Query chat message history. |
| [Occupancy](https://ably.com/docs/cli/rooms.md) | Fetch and subscribe to chat room occupancy. |
| [Reactions](https://ably.com/docs/cli/rooms.md) | Send and subscribe to message-level and room-level reactions. |
| [Typing indicators](https://ably.com/docs/cli/rooms.md) | Send and subscribe to typing indicators. |
| **Spaces** ||
| [List spaces](https://ably.com/docs/cli/spaces/list.md) | List spaces in an app. |
| [Members](https://ably.com/docs/cli/spaces.md) | Enter and subscribe the list of members. |
| [Locations](https://ably.com/docs/cli/spaces.md) | Set and subscribe to member locations. |
| [Cursors](https://ably.com/docs/cli/spaces.md) | Set and subscribe to member cursors. |
| [Locks](https://ably.com/docs/cli/spaces.md) | Acquire and subscribe to locks. |

## Auto-completion 

The Ably CLI supports shell auto-completion for bash, zsh, and PowerShell. This helps you discover and use commands more efficiently.

To set up auto-completion, run:

<Code>

### Shell

```
ably autocomplete
```
</Code>

This displays installation instructions specific to your shell. Follow them to enable tab completion for commands, subcommands, and options.

For more details, see the auto-completion [CLI reference](https://ably.com/docs/cli/autocomplete.md) and [auto completion usage documentation](https://github.com/ably/ably-cli/blob/main/docs/Auto-completion.md).

## Interactive mode 

The Ably CLI includes an interactive shell mode that provides a more convenient way to work with multiple commands:

<Code>

### Shell

```
ably-interactive
```
</Code>

Interactive mode provides the following features:

* **Command history**: Previous commands are saved and can be accessed with up/down arrows.
* **Tab completion**: Full support for command and option completion.
* **Ctrl+C handling**: A single Ctrl+C interrupts the current command and returns to the prompt. A double Ctrl+C (within 500ms) force quits the shell.
* **No "ably" prefix needed**: Commands can be typed directly, for example `channels list` instead of `ably channels list`.

## CLI reference

See the [CLI reference](https://ably.com/docs/cli.md), for detailed documentation on every CLI command, including options, arguments, and usage examples.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
