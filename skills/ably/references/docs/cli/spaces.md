# Spaces

Use the `ably spaces` command group to interact with Ably Spaces. These commands enable you to create and manage spaces, track cursors, locations, locks, members, and occupancy.

## Spaces management 

Use the following commands to create, retrieve, list, and subscribe to [Spaces](https://ably.com/docs/spaces.md). Spaces enable collaborative features such as member tracking, cursor positions, and component locking:

| Command | Description |
| ------- | ----------- |
| [`ably spaces create`](https://ably.com/docs/cli/spaces/create.md) | Initialize a space without entering it. |
| [`ably spaces get`](https://ably.com/docs/cli/spaces/get.md) | Get the current state of a space. |
| [`ably spaces list`](https://ably.com/docs/cli/spaces/list.md) | List active spaces. |
| [`ably spaces subscribe`](https://ably.com/docs/cli/spaces/subscribe.md) | Subscribe to member and location update events in a space. |

## Members 

Use the following commands to manage [members](https://ably.com/docs/spaces/avatar.md) in [Spaces](https://ably.com/docs/spaces.md). Members represent users who have entered a space and are tracked in real time as they join, leave, or update their status:

| Command | Description |
| ------- | ----------- |
| [`ably spaces members enter`](https://ably.com/docs/cli/spaces/members/enter.md) | Enter a space and remain present until terminated. |
| [`ably spaces members get`](https://ably.com/docs/cli/spaces/members/get.md) | Get all members in a space. |
| [`ably spaces members subscribe`](https://ably.com/docs/cli/spaces/members/subscribe.md) | Subscribe to member presence events in a space. |

## Locations 

Use the following commands to manage [locations](https://ably.com/docs/spaces/locations.md) in Spaces. Locations track where members are within a collaborative space, enabling you to display which component each member currently has selected:

| Command | Description |
| ------- | ----------- |
| [`ably spaces locations get`](https://ably.com/docs/cli/spaces/locations/get.md) | Get all current locations in a space. |
| [`ably spaces locations set`](https://ably.com/docs/cli/spaces/locations/set.md) | Set location in a space. |
| [`ably spaces locations subscribe`](https://ably.com/docs/cli/spaces/locations/subscribe.md) | Subscribe to location updates for members in a space. |

## Cursors 

Use the following commands to manage [cursors](https://ably.com/docs/spaces/cursors.md) in Spaces. Cursors track the pointer positions of members in real time, with automatic batching for efficiency:

| Command | Description |
| ------- | ----------- |
| [`ably spaces cursors get`](https://ably.com/docs/cli/spaces/cursors/get.md) | Get all current cursors in a space. |
| [`ably spaces cursors set`](https://ably.com/docs/cli/spaces/cursors/set.md) | Set a cursor with position data in a space. |
| [`ably spaces cursors subscribe`](https://ably.com/docs/cli/spaces/cursors/subscribe.md) | Subscribe to cursor movements in a space. |

## Locks 

Use the following commands to manage [component locking](https://ably.com/docs/spaces/locking.md) in Spaces. Locks enable members to optimistically lock UI components before editing them, reducing the risk of conflicting changes:

| Command | Description |
| ------- | ----------- |
| [`ably spaces locks acquire`](https://ably.com/docs/cli/spaces/locks/acquire.md) | Acquire a lock in a space. |
| [`ably spaces locks get`](https://ably.com/docs/cli/spaces/locks/get.md) | Get a lock or all locks in a space. |
| [`ably spaces locks subscribe`](https://ably.com/docs/cli/spaces/locks/subscribe.md) | Subscribe to lock events in a space. |

## Occupancy 

Use the following commands to monitor occupancy in [Spaces](https://ably.com/docs/spaces.md). Occupancy provides real-time metrics on how many members are currently connected to a space:

| Command | Description |
| ------- | ----------- |
| [`ably spaces occupancy get`](https://ably.com/docs/cli/spaces/occupancy/get.md) | Get current occupancy metrics for a space. |
| [`ably spaces occupancy subscribe`](https://ably.com/docs/cli/spaces/occupancy/subscribe.md) | Subscribe to occupancy events on a space. |

## See also

* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
