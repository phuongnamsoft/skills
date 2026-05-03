# Rooms presence enter

Use the `ably rooms presence enter` command to enter presence in a chat room and remain present until terminated.

## Synopsis

<Code>

### Shell

```
ably rooms presence enter <room-name> [options]
```
</Code>

## Arguments

### `room-name`  **(Required)**

The name of the chat room to enter presence in.

## Options

### `--data` 

A JSON string of data to associate with the presence member.

### `--show-others` 

Display presence events from other members while present. Defaults to `false`.

### `--duration | -D` 

The duration in seconds to remain present before automatically leaving.

### `--sequence-numbers` 

Display sequence numbers for presence events. Defaults to `false`.

### `--client-id` 

A client ID to use when entering presence.

### `--json` 

Output results as compact JSON. Mutually exclusive with `--pretty-json`.

### `--pretty-json` 

Output results in formatted JSON. Mutually exclusive with `--json`.

### `--verbose | -v` 

Enable verbose logging. Can be combined with `--json` or `--pretty-json`.

## Examples

Enter presence in a room:

<Code>

### Shell

```
ably rooms presence enter my-room
```
</Code>

Enter presence with data:

<Code>

### Shell

```
ably rooms presence enter my-room --data '{"status": "online", "name": "Alice"}'
```
</Code>

Enter presence and show other members' events:

<Code>

### Shell

```
ably rooms presence enter my-room --show-others
```
</Code>

Enter room presence for a specific duration:

<Code>

### Shell

```
ably rooms presence enter my-room --duration 30
```
</Code>

Enter room presence and output events in JSON format:

<Code>

### Shell

```
ably rooms presence enter my-room --json
```
</Code>

Enter room presence and output events in formatted JSON:

<Code>

### Shell

```
ably rooms presence enter my-room --pretty-json
```
</Code>

## See also

* [Rooms](https://ably.com/docs/cli/rooms.md) — Explore all `ably rooms` commands.
* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Related Topics

- [get](https://ably.com/docs/cli/rooms/presence/get.md): Get current presence members in an Ably Chat room using the CLI.
- [subscribe](https://ably.com/docs/cli/rooms/presence/subscribe.md): Subscribe to presence events in an Ably Chat room using the CLI.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
