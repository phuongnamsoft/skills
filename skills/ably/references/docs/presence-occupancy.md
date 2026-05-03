# Presence and occupancy overview

[Presence](https://ably.com/docs/presence-occupancy/presence.md) and [occupancy](https://ably.com/docs/presence-occupancy/occupancy.md) are features that provide information about the clients and [connections](https://ably.com/docs/connect.md) attached to a channel. Occupancy returns high level metrics about the clients attached to a channel, whereas presence provides details about individual members that have joined a channel's presence set.

## Occupancy versus presence 

Presence and occupancy can both be used to satisfy some use cases. It is important to understand the differences in order to choose the right feature for each use case.

Presence is a feature that tracks the membership of a presence set for a channel. Members are specific connections that are identifiable. Each member may also have data associated with them. Any change in the presence set of a channel, or the data associated with a member, publishes a presence event.

Occupancy provides metrics for a channel. It is a feature that counts how many of a thing are attached to a channel, such as the number of connections. It does not provide any information that can identify individual connections or clients attached to the channel.

Take a chat application containing multiple chat rooms as an example. Occupancy would be a more lightweight method for displaying the popularity of rooms, by displaying the number of connections to each channel. Presence could be utilized in each channel to indicate which users are online, and to notify other members when someone leaves the room.

## Related Topics

- [Presence](https://ably.com/docs/presence-occupancy/presence.md): Presence enables clients to be aware of the other clients present on a channel.
- [Occupancy](https://ably.com/docs/presence-occupancy/occupancy.md): Occupancy provides high level metrics about the clients attached to a channel.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
