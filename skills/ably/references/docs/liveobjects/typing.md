# Typing

<If lang="javascript">
  <Aside data-type='note'>
  **Building with LiveObjects?** Help shape its future by [sharing your use case](https://44qpp.share.hsforms.com/2fZobHQA1ToyRfB9xqZYQmQ).
  </Aside>
</If>
<If lang="swift">
  <Aside data-type='experimental'>
  LiveObjects Swift is currently Experimental. Its features are still in development and subject to rapid change.

  **Building with LiveObjects?** Help shape its future by [sharing your use case](https://44qpp.share.hsforms.com/2fZobHQA1ToyRfB9xqZYQmQ).
  </Aside>
</If>
<If lang="java">
  <Aside data-type='experimental'>
  LiveObjects Java is currently Experimental. Its features are still in development and subject to rapid change.

  **Building with LiveObjects?** Help shape its future by [sharing your use case](https://44qpp.share.hsforms.com/2fZobHQA1ToyRfB9xqZYQmQ).
  </Aside>
</If>

If you are using TypeScript in your project, you can leverage built-in TypeScript support to ensure type safety and enable autocompletion when working with the channel object.

## Provide a type for the channel object 

You can provide a type parameter to the `channel.object.get<T>()` method to specify the expected structure of the channel object:

<Code>

### Javascript

```
import { LiveCounter, LiveMap } from 'ably/liveobjects';

// Define the expected structure of your channel object
type MyObject = {
  visits: LiveCounter;
  reactions: LiveMap<{
    likes: LiveCounter;
    hearts: LiveCounter;
  }>;
  settings: LiveMap<{
    theme: string;
    notifications: boolean;
  }>;
};

// Get a typed PathObject for the channel
const myObject = await channel.object.get<MyObject>();
```
</Code>

This enables TypeScript to infer the correct types when accessing and mutating objects. TypeScript surfaces the correct set of methods that are expected for the current `Instance` or `PathObject` and infers the correct arguments and return values for all methods:

<Code>

### Javascript

```
// TypeScript knows 'visits' is a LiveCounter
const visits = myObject.get('visits');
await visits.increment(5);  // Type-safe

// TypeScript knows the structure of 'reactions'
const reactions = myObject.get('reactions');
const likes = reactions.get('likes');
await likes.increment(1);  // Type-safe

// TypeScript knows 'theme' is a string
const theme = myObject.get('settings').get('theme');
const themeValue: string | undefined = theme.value();

// Type errors are caught at compile time
await reactions.set('likes', 'invalid');
// Error: Argument of type 'string' is not assignable to parameter of type 'LiveCounter'
```
</Code>

When obtaining [Instance](https://ably.com/docs/liveobjects/concepts/instance.md) objects, TypeScript automatically infers the correct instance type:

<Code>

### Javascript

```
type MyObject = {
  visits: LiveCounter;
  settings: LiveMap<{
    theme: string;
  }>;
};

const myObject = await channel.object.get<MyObject>();

const visits = myObject.get('visits').instance();
await visits?.increment(1); // TypeScript knows visits is an Instance of a LiveCounter
const value: number | undefined = visits?.value(); // TypeScript knows the LiveCounter has a number value

const settings = myObject.get('settings').instance();
await settings?.set('theme', 'dark'); // TypeScript knows settings is an Instance of a LiveMap
const theme: string | undefined = settings?.get('theme');
```
</Code>

TypeScript also infers the correct instance type when using [batch operations](https://ably.com/docs/liveobjects/batch.md):

<Code>

### Javascript

```
type MyObject = {
  visits: LiveCounter;
  settings: LiveMap<{
    theme: string;
  }>;
};

const myObject = await channel.object.get<MyObject>();

await myObject.batch((ctx) => {
  const visits = ctx.get('visits');
  visits?.increment(1); // TypeScript knows visits is a LiveCounter
  const value: number | undefined = visits?.value(); // TypeScript knows the LiveCounter has a number value

  const settings = ctx.get('settings');
  settings?.set('theme', 'dark'); // TypeScript knows settings is a LiveMap
  const theme: string | undefined = settings?.get('theme');
});
```
</Code>

## Define reusable types 

You can define and export types for reuse across your application:

<Code>

### Javascript

```
// types/liveobjects.ts
import { LiveCounter, LiveMap } from 'ably/liveobjects';

export type ReactionsType = {
  likes: LiveCounter;
  hearts: LiveCounter;
  fire: LiveCounter;
};

export type UserProfileType = {
  name: string;
  score: LiveCounter;
  settings: LiveMap<{
    theme: string;
    notifications: boolean;
  }>;
};

export type ChannelObjectType = {
  reactions: LiveMap<ReactionsType>;
  users: LiveMap<{
    [userId: string]: LiveMap<UserProfileType>;
  }>;
};
```
</Code>

Then import and use these types where needed:

<Code>

### Javascript

```
import type { ChannelObjectType } from './types/liveobjects';

const myObject = await channel.object.get<ChannelObjectType>();

// Fully typed access
const userScore = myObject
  .get('users')
  .get('user123')
  .get('score');

await userScore.increment(10);  // Type-safe
```
</Code>

## Use per-channel types 

When your application uses multiple channels with different object structures, you can specify different types for each:

<Code>

### Javascript

```
// Define types for different channels
type ReactionsChannelObject = {
  likes: LiveCounter;
  hearts: LiveCounter;
};

type LeaderboardChannelObject = {
  players: LiveMap<{
    [playerId: string]: LiveMap<{
      name: string;
      score: LiveCounter;
    }>;
  }>;
};

// Get typed objects for different channels
const reactionsChannel = client.channels.get('reactions');
const reactions = await reactionsChannel.object.get<ReactionsChannelObject>();

const leaderboardChannel = client.channels.get('leaderboard');
const leaderboard = await leaderboardChannel.object.get<LeaderboardChannelObject>();

// Each channel has its own type safety
await reactions.get('likes').increment(1);  // Type-safe for reactions
const players = leaderboard.get('players');  // Type-safe for leaderboard
```
</Code>

## Related Topics

- [Batch operations](https://ably.com/docs/liveobjects/batch.md): Group multiple objects operations into a single channel message to apply grouped operations atomically and improve performance.
- [Lifecycle events](https://ably.com/docs/liveobjects/lifecycle.md): Understand lifecycle events for Objects, LiveMap and LiveCounter to track synchronization events and object deletions.
- [Inband objects](https://ably.com/docs/liveobjects/inband-objects.md): Subscribe to LiveObjects updates from Pub/Sub SDKs.
- [Object storage](https://ably.com/docs/liveobjects/storage.md): Learn about LiveObjects object storage.
- [Using the REST SDK](https://ably.com/docs/liveobjects/rest-sdk-usage.md): Learn how to work with Ably LiveObjects using the REST SDK
- [Using the REST API](https://ably.com/docs/liveobjects/rest-api-usage.md): Learn how to work with Ably LiveObjects using the REST API

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
