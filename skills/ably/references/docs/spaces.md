# About Spaces

Spaces enables you to build collaborative environments in your application.

Building realtime collaborative applications requires managing two different states; participant state and application state. Both states involve different types of data, and that data is handled differently.

Participant state is the data related to the members collaborating synchronously in an application, such as their online status, their locations and the positions of their cursors. Application state is the data related to the application itself, such as the data in a cell or field, or the description and status of a task.

The requirements in how realtime updates are managed vary between the two different states. Participant state is largely ephemeral and usually doesn't need to be stored or retained. Application state must be sent to your backend servers, validated and then stored in your database.

Ably's Spaces provides high-level APIs for managing the participant state of your application. Each API is optimized based on the payload structure and frequency of updates that are anticipated for that feature. Ably's [Pub/Sub](https://ably.com/docs/basics.md) product provides flexible APIs to manage application state in realtime by enabling communication between your frontend and backend systems, as well as third-party services.

<Aside data-type='usp'>
Scalable collaboration

Collaborative features generate frequent updates from many participants simultaneously. Ably's platform [delivers over 500 billion messages monthly](https://ably.com/docs/platform/architecture/scalability.md), ensuring your collaborative experiences remain responsive as your user base grows.
</Aside>

## Spaces SDK 

Spaces is powered by a [separate SDK](https://ably.com/docs/spaces.md) that is built on top of Ably's JavaScript SDK. Use cases include adding live cursors to an interactive whiteboard, building an avatar stack for an application to show who is online, and displaying which UI components users have selected and which ones are locked for editing to avoid conflicts.

Whether you're adding realtime collaborative capabilities to an existing application, or building a new application from scratch, the Spaces SDK enables you to quickly and easily implement the following features:

| Feature  | Description |
| -------- | ----------- |
| [Space](https://ably.com/docs/spaces/space.md) | virtual area of your application in which realtime collaboration between users can take place. |
| [Avatar stack](https://ably.com/docs/spaces/avatar.md) | the most common way of showing the online status of users in an application. |
| [Member locations](https://ably.com/docs/spaces/locations.md) | a way to track where users are to see which part of your application they're interacting with, such as a cell or form field. |
| [Live cursors](https://ably.com/docs/spaces/cursors.md) | a way to efficiently track the cursor positions of users in realtime. |
| [Component locking](https://ably.com/docs/spaces/locking.md) | a way to optimistically lock stateful UI components before letting users edit them. |

There are several benefits provided by the fact that the Spaces SDK is built on top of the Ably JavaScript SDK:

* [Authentication](https://ably.com/docs/auth.md) and [connection management](https://ably.com/docs/connect.md) are handled by the underlying SDK.
* You can use the Ably JavaScript SDK to extend your application's functionality further with [Pub/Sub](https://ably.com/docs/basics.md).

The following are a selection of additional features that can be built using Ably Pub/Sub to further enhance your collaborative applications:

* Chat
* Comments and annotations
* Typing indicators
* Reactions
* Notifications
* 'Follow me' and 'bring to me' functionality

Use the [multiplayer reference guide](https://ably.com/reference-guide-multiplayer#multiplayer-features) for guidance on how to build each of these features with Ably.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
