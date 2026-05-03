# Using the REST SDK

<Aside data-type='note'>
**Building with LiveObjects?** Help shape its future by [sharing your use case](https://44qpp.share.hsforms.com/2fZobHQA1ToyRfB9xqZYQmQ).
</Aside>

LiveObjects provides a JavaScript REST SDK that enables you to directly work with objects without using a realtime connection.

## Setup 

Create an [`Ably.Rest`](https://ably.com/docs/api/rest-sdk.md) client instance with the `LiveObjects` plugin:

<Code>

### Javascript

```
import { LiveObjects } from 'ably/liveobjects';

const rest = new Ably.Rest({ plugins: { LiveObjects }, /* other ClientOptions */ });
```
</Code>

The LiveObjects REST SDK is then available on a channel via `channel.object`:

<Code>

### Javascript

```
const channel = rest.channels.get('my-channel');
channel.object // LiveObjects REST SDK
```
</Code>

## Authentication 

Authentication is configured when instantiating the REST client. Pass an API key or use [token authentication](https://ably.com/docs/auth/token.md) via the [`ClientOptions`](https://ably.com/docs/api/rest-sdk.md#client-options). See the [REST SDK authentication](https://ably.com/docs/api/rest-sdk/authentication.md) documentation for details.

To read objects on a channel, an API key must have the `object-subscribe` [capability](https://ably.com/docs/auth/capabilities.md). With only this capability, clients have read-only access, preventing them from publishing operations.

To create or update objects, the API key must have the `object-publish` capability. Include both `object-subscribe` and `object-publish` for full read and write access.

## Fetch objects 

### Use `channel.object.get` 

`get(RestObjectGetParams params?): Promise<Object>`

Reads object data from the channel. If no `objectId` is provided then the entire channel object is returned. Makes a request to the [`GET /channels/{channelId}/object`](https://ably.com/docs/liveobjects/rest-api-usage.md#fetch-channel-object) REST API endpoint. The return type depends on the `compact` parameter: when `compact` is `true` (default), returns a [`RestObjectGetCompactResult`](#rest-object-get-compact-result); when `compact` is `false`, returns a [`RestObjectGetFullResult`](#rest-object-get-full-result).

| Parameter | Description | Type |
|-----------|-------------|------|
| params | An optional object containing the query parameters | [`RestObjectGetParams`](#rest-object-get-params) |

Objects can be fetched in two formats:

| Format | Parameter | Description |
|--------|----------------|-------------|
| **Compact** (default) | `compact: true` | Values-only representation without metadata. Ideal for reading data values. |
| **Full** | `compact: false` | Full structure including object IDs and type metadata. Useful for debugging. |

**Compact format** returns the logical structure of your data as a JSON-like value. [LiveMap](https://ably.com/docs/liveobjects/map.md) instances appear as JSON objects with their entries, and [LiveCounter](https://ably.com/docs/liveobjects/counter.md) instances appear as numbers. `bytes`-typed values are returned as <If lang="javascript">`ArrayBuffer`</If><If lang="nodejs">`Buffer`</If> when using the binary protocol, or as base64-encoded strings when using the JSON protocol. `json`-typed values remain as JSON-encoded strings.

**Full format** includes additional [metadata](https://ably.com/docs/liveobjects/concepts/objects.md#metadata) for each object:
- Object IDs for each instance
- Object type metadata (map semantics, counter values)
- Complete object hierarchy

Since each value in the full format carries explicit type information, the SDK always decodes `bytes` values to <If lang="javascript">`ArrayBuffer`</If><If lang="nodejs">`Buffer`</If> and `json` values to native objects or arrays.

See [Data values reference](#data-values) for more details on value types and encoding.

### Fetch the channel object 

Fetch the entire channel object:

<Code>

#### Javascript

```
const data = await channel.object.get();
```
</Code>

Example compact result:

<Code>

#### Json

```
{
  "votes": {
    "down": 5,
    "up": 10
  }
}
```
</Code>

This example shows a `LiveMap` stored on the "votes" key of the channel object, which contains two `LiveCounter` instances on the "down" and "up" keys.

Set `compact: false` to include object metadata:

<Code>

#### Javascript

```
const data = await channel.object.get({ compact: false });
```
</Code>

<Code>

#### Json

```
{
  "objectId": "root",
  "map": {
    "semantics": "lww",
    "entries": {
      "votes": {
        "data": {
          "objectId": "map:qZXBk8xaGqf4kwLSlR7Tj0Eqhd48WDFfb3gTAbj194k@1760448597692",
          "map": {
            "semantics": "lww",
            "entries": {
              "down": {
                "data": {
                  "objectId": "counter:Yj1F_aEX3T2rRkTkra7Aifmlr8PxUWSR3kO3MzxtQto@1760448653393",
                  "counter": {
                    "data": {
                      "number": 5
                    }
                  }
                }
              },
              "up": {
                "data": {
                  "objectId": "counter:ibxddWpDjH8R3cvXWWacfe4IVd3DxT_oqkAafhaS68s@1760448646413",
                  "counter": {
                    "data": {
                      "number": 10
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
```
</Code>

### Fetch by path 

Return a subset of the channel object by specifying the `path` parameter. For example, to return only the `votes` `LiveMap` instance from the channel object:

<Code>

#### Javascript

```
const data = await channel.object.get({ path: 'votes' });
```
</Code>

Example result:

<Code>

#### Json

```
{
  "down": 5,
  "up": 10
}
```
</Code>

### Fetch by object ID 

Fetch a specific [object instance](https://ably.com/docs/liveobjects/concepts/instance.md) by specifying its `objectId`:

<Code>

#### Javascript

```
const data = await channel.object.get({
  objectId: 'map:qZXBk8xaGqf4kwLSlR7Tj0Eqhd48WDFfb3gTAbj194k@1760448597692'
});
```
</Code>

Example compact result:

<Code>

#### Json

```
{
  "down": 5,
  "up": 10
}
```
</Code>

Set `compact: false` to include object metadata:

<Code>

#### Javascript

```
const data = await channel.object.get({
  objectId: 'map:qZXBk8xaGqf4kwLSlR7Tj0Eqhd48WDFfb3gTAbj194k@1760448597692',
  compact: false
});
```
</Code>

<Code>

#### Json

```
{
  "objectId": "map:qZXBk8xaGqf4kwLSlR7Tj0Eqhd48WDFfb3gTAbj194k@1760448597692",
  "map": {
    "semantics": "lww",
    "entries": {
      "down": {
        "data": {
          "objectId": "counter:Yj1F_aEX3T2rRkTkra7Aifmlr8PxUWSR3kO3MzxtQto@1760448653393",
          "counter": {
            "data": {
              "number": 5
            }
          }
        }
      },
      "up": {
        "data": {
          "objectId": "counter:ibxddWpDjH8R3cvXWWacfe4IVd3DxT_oqkAafhaS68s@1760448646413",
          "counter": {
            "data": {
              "number": 10
            }
          }
        }
      }
    }
  }
}
```
</Code>

You can also specify a `path` parameter alongside `objectId`. The path is evaluated relative to the specified object instance:

<Code>

#### Javascript

```
const data = await channel.object.get({
  objectId: 'map:qZXBk8xaGqf4kwLSlR7Tj0Eqhd48WDFfb3gTAbj194k@1760448597692',
  path: 'down'
});
```
</Code>

<Code>

#### Json

```
5
```
</Code>

## Publish operations 

### Use `channel.object.publish` 

`publish(RestObjectOperation operation): Promise<RestObjectPublishResult>`

`publish(RestObjectOperation[] operations): Promise<RestObjectPublishResult>`

Publishes one or more operations to modify objects on the channel. Makes a request to the [`POST /channels/{channelId}/object`](https://ably.com/docs/liveobjects/rest-api-usage.md#publishing-operations) REST API endpoint. When an array is provided, all operations are published as an atomic [batch](#batch-operations).

| Parameter | Description | Type |
|-----------|-------------|------|
| operation | The operation or array of operations to publish | [`RestObjectOperation`](#rest-object-operation) or [`RestObjectOperation[]`](#rest-object-operation) |

Returns a [`RestObjectPublishResult`](#rest-object-publish-result) containing the message ID and affected object IDs.

Each operation includes:
1. A reference to an object using either `objectId` or `path`.
2. An **operation-specific field** (`mapSet`, `counterInc`, etc.) containing the operation parameters

Operations can target objects using `objectId` or `path`:
- `objectId` (string): The unique identifier of the object instance to create or update
- `path` (string): The path to the object instance within the channel object

Use dot-separated notation for paths (for example `votes.up`), relative to the channel object. An empty path `""` refers to the channel object itself. Paths can contain wildcards (`*`) to target multiple objects.

<Aside data-type='important'>
When using path operations, the server resolves object IDs at the time it receives the request. Ably applies the operation to these specific object instances. If the object instances at the specified path change due to concurrent updates before Ably processes the operation, Ably does not apply the operation to the new object instances.
</Aside>

<Aside data-type='further-reading'>
See [PathObject](https://ably.com/docs/liveobjects/concepts/path-object.md) for details on path-based access in realtime client SDKs.
</Aside>

### Available operations 

LiveObjects supports the following operations:

| Operation | Description |
| --------- | ----------- |
| `mapSet` | Sets a key/value pair in a `LiveMap`. |
| `mapRemove` | Removes a key from a `LiveMap`. |
| `counterInc` | Increments or decrements a `LiveCounter`. |
| `mapCreate` | Creates a new `LiveMap` instance. |
| `counterCreate` | Creates a new `LiveCounter` instance. |
| `mapCreateWithObjectId` | Creates a new `LiveMap` with a [client-generated ID](#client-generated-ids). |
| `counterCreateWithObjectId` | Creates a new `LiveCounter` with a [client-generated ID](#client-generated-ids). |

To create an object, see [Create objects](#create-objects).

Each operation has specific required and optional fields:

#### mapSet 

<Code>

##### Javascript

```
await channel.object.publish({
  path: 'user',
  mapSet: {
    key: 'username',
    value: { string: 'alice' }
  }
});
```
</Code>

Map values can be any of the supported [data value types](#data-values), including references to other objects.

#### mapRemove 

<Code>

##### Javascript

```
await channel.object.publish({
  path: 'user',
  mapRemove: {
    key: 'username'
  }
});
```
</Code>

#### counterInc 

<Code>

##### Javascript

```
await channel.object.publish({
  path: 'votes.up',
  counterInc: {
    number: 5
  }
});
```
</Code>

<Aside data-type='note'>
There is no explicit `counterDec` operation. To decrement a counter, use `counterInc` with a negative number.
</Aside>

#### mapCreate 

Optionally omit the `path` or `objectId` fields when creating an object with `mapCreate`.
For the object to be [reachable](https://ably.com/docs/liveobjects/concepts/objects.md#reachability) in the state tree, assign it to a key in a `LiveMap` that is reachable from the channel object.

<Code>

##### Javascript

```
await channel.object.publish({
  path: 'posts.post1',
  mapCreate: {
    semantics: 'lww',
    entries: {
      title: { data: { string: 'LiveObjects is awesome' } },
      createdAt: { data: { number: 1745835181122 } },
      isPublished: { data: { boolean: true } }
    }
  }
});
```
</Code>

#### counterCreate 

Optionally omit the `path` or `objectId` fields when creating an object with `counterCreate`.
For the object to be [reachable](https://ably.com/docs/liveobjects/concepts/objects.md#reachability) in the state tree, assign it to a key in a `LiveMap` that is reachable from the channel object.

<Code>

##### Javascript

```
await channel.object.publish({
  path: 'visits',
  counterCreate: {
    count: 0
  }
});
```
</Code>

### Update by object ID 

To perform operations on a specific object instance, provide its `objectId` in the operation:

<Code>

#### Javascript

```
const result = await channel.object.publish({
  objectId: 'counter:iVji62_MW_j4dShuJbr2fmsP2D8MyCs6tFqON9-xAkc@1745828645269',
  counterInc: {
    number: 1
  }
});
```
</Code>

### Update by path 

Path operations target objects based on their location in the channel object.

Paths are expressed relative to the structure of the object as defined by the [compact](#fetch-channel-object) view of the channel object.

The following example increments the `LiveCounter` instance stored at the `up` key on the `votes` `LiveMap` object:

<Code>

#### Javascript

```
const result = await channel.object.publish({
  path: 'votes.up',
  counterInc: {
    number: 1
  }
});
```
</Code>

### Publish result 

The result includes the ID of the published operation message, the channel and a list of object IDs that were affected by the operation:

<Code>

#### Json

```
{
  "messageId": "TJPWHhMTrF:0",
  "channel": "my-channel",
  "objectIds": ["counter:iVji62_MW_j4dShuJbr2fmsP2D8MyCs6tFqON9-xAkc@1745828645269"]
}
```
</Code>

### Path operations 

Path operations provide flexibility when targeting objects.

#### Path wildcards 

Use wildcards in paths to target multiple objects at once. To increment all `LiveCounter` instances in the `votes` `LiveMap` instance:

<Code>

##### Javascript

```
const result = await channel.object.publish({
  path: 'votes.*',
  counterInc: {
    number: 1
  }
});
```
</Code>

The result includes the IDs of each of the affected object instances:

<Code>

##### Json

```
{
  "messageId": "0Q1w-LpA11:0",
  "channel": "my-channel",
  "objectIds": [
    "counter:iVji62_MW_j4dShuJbr2fmsP2D8MyCs6tFqON9-xAkc@1745828645269",
    "counter:JbZYiHnw0ORAyzzLSQahVik31iBDL_ehJNpTEF3qwg8@1745828651669"
  ]
}
```
</Code>

Wildcards match exactly one level in the channel object and can appear at the end or middle of paths. For example, given the following compact view of the channel object:

<Code>

##### Json

```
{
  "posts": {
    "post1": {
      "votes": {
        "down": 5,
        "up": 10
      }
    },
    "post2": {
      "votes": {
        "down": 5,
        "up": 10
      }
    }
  }
}
```
</Code>

The following example increments the upvote `LiveCounter` instances for all posts in the `posts` `LiveMap` instance:

<Code>

##### Javascript

```
const result = await channel.object.publish({
  path: 'posts.*.votes.up',
  counterInc: {
    number: 1
  }
});
```
</Code>

#### Escape special characters 

If your `LiveMap` keys contain periods, escape them with a backslash. The following example increments the upvote `LiveCounter` instance for a post with the key `post.123`:

<Code>

##### Javascript

```
const result = await channel.object.publish({
  path: 'posts.post\\.123.votes.up',
  counterInc: {
    number: 1
  }
});
```
</Code>

### Remove objects 

Remove an object from the channel using `mapRemove` to delete the key referencing it:

<Code>

#### Javascript

```
await channel.object.publish({
  objectId: 'root',
  mapRemove: {
    key: 'posts'
  }
});
```
</Code>

Map keys can be removed by issuing a `mapRemove` operation targeting either an `objectId` or a `path`.

If no other references to the object exist, it becomes unreachable and is eligible for [garbage collection](#object-reachability).

<Aside data-type='note'>
Removing a key may also make nested child objects unreachable. These objects are also eligible for garbage collection.
</Aside>

## Create objects 

Use `mapCreate` and `counterCreate` operations to create new LiveObjects [instances](https://ably.com/docs/liveobjects/concepts/instance.md).

### Create objects with paths 

The simplest way to create an object is to specify a `path` where it should be created. The server automatically creates the object and assigns it to that path in a single atomic operation.

The following example creates a new `LiveMap` instance and assigns it to the `posts` `LiveMap` instance on the channel object under the key `post1`:

<Code>

#### Javascript

```
const result = await channel.object.publish({
  path: 'posts.post1',
  mapCreate: {
    semantics: 'lww',
    entries: {
      title: { data: { string: 'LiveObjects is awesome' } },
      createdAt: { data: { number: 1745835181122 } },
      isPublished: { data: { boolean: true } }
    }
  }
});
```
</Code>

When using `path` with a create operation, the server constructs two operations published as a [batch](#batch-operations):

1. A `mapCreate` or `counterCreate` operation to create the new object
2. A `mapSet` operation to assign the new object to the parent `LiveMap` at the specified path

This ensures the new object is immediately [reachable](#object-reachability) from the channel object.

The result will include the object IDs of all objects affected by the resulting set of operations.
The newly created object's ID will be the first item in the list:

<Code>

#### Json

```
{
  "messageId": "mkfjWU2jju:0",
  "channel": "my-channel",
  "objectIds": [
    "map:cRCKx-eev7Tl66jGfl1SkZh_uEMo6F5jyV0B7mUn4Zs@1745835549101",
    "map:a_oQqPYUGxi95_Cn0pWcsoeBlHZZtVW5xKIw0hnJCZs@1745835547258"
  ]
}
```
</Code>

### Client-generated object IDs 

Client-generated object IDs enable atomic batch operations with cross-references between newly created objects. Use `channel.object.generateObjectId` to generate an object ID, then use `mapCreateWithObjectId` or `counterCreateWithObjectId` to create the object with that ID. See the [REST API documentation](https://ably.com/docs/liveobjects/rest-api-usage.md#client-generated-ids) for details on the ID generation algorithm.

#### Use `channel.object.generateObjectId` 

`generateObjectId(RestObjectOperationMapCreateBody | RestObjectOperationCounterCreateBody createBody): Promise<RestObjectGenerateIdResult>`

Generates an object ID for a create operation. Pass a [`RestObjectOperationMapCreateBody`](#rest-object-operation-map-create-body) or [`RestObjectOperationCounterCreateBody`](#rest-object-operation-counter-create-body) to specify the object type and initial value. Returns a [`RestObjectGenerateIdResult`](#rest-object-generate-id-result) containing the generated `objectId`, `nonce`, and `initialValue` needed to construct a `mapCreateWithObjectId` or `counterCreateWithObjectId` operation.

The following example generates an object ID for a new map, then creates and assigns it to the channel object in a single atomic batch:

<Code>

##### Javascript

```
// Generate an object ID for a new map
const { objectId, nonce, initialValue } = await channel.object.generateObjectId({
  mapCreate: {
    semantics: 'lww',
    entries: {
      name: { data: { string: 'Alice' } }
    }
  }
});

// Create the map and assign it to the channel object atomically
const result = await channel.object.publish([
  {
    objectId,
    mapCreateWithObjectId: { initialValue, nonce }
  },
  {
    objectId: 'root',
    mapSet: {
      key: 'alice',
      value: { objectId }
    }
  }
]);
```
</Code>

Both operations execute atomically. The second operation references the object created in the first because the ID was pre-computed with `generateObjectId`.

<Aside data-type='important'>
Objects created with client-generated IDs should be assigned to the object tree as part of the same batch operation. Objects that are not assigned are immediately unreachable and subject to [garbage collection](https://ably.com/docs/liveobjects/rest-api-usage.md#object-reachability).
</Aside>

<Aside data-type='note'>
Only use client-generated IDs when you need atomic batch operations with cross-references. For most use cases, use path-based operations to create objects instead.
</Aside>

## Cyclic references 

For both the full object and the compact formats, cyclic references in the channel object are included as a reference to the object ID rather than including the same object instance in the result more than once.

For example, if you create a cycle in the channel object by adding a reference to the channel object in the `votes` `LiveMap` instance with the following operation:

<Code>

### Javascript

```
await channel.object.publish({
  objectId: 'map:qZXBk8xaGqf4kwLSlR7Tj0Eqhd48WDFfb3gTAbj194k@1760448597692',
  mapSet: {
    key: 'myObject',
    value: { objectId: 'root' }
  }
});
```
</Code>

The result will handle the cyclic reference by including the `myObject` key as a reference to the object ID of the channel object:

<Code>

### Javascript

```
const data = await channel.object.get();
```
</Code>

<Code>

### Json

```
{
  "votes": {
    "down": 5,
    "up": 10,
    "myObject": {
      "objectId": "root"
    }
  }
}
```
</Code>

## Object reachability and garbage collection 

Objects that are not reachable from the channel object will be automatically garbage collected. See the [REST API documentation](https://ably.com/docs/liveobjects/rest-api-usage.md#object-reachability) and [reachability and object lifecycle](https://ably.com/docs/liveobjects/concepts/objects.md#reachability) for details.

## Batch operations 

Group multiple operations into a single call by passing an array of operations to `publish()`. All operations are published as a single message and processed as a single atomic unit. Learn more about [batch operations](https://ably.com/docs/liveobjects/batch.md).

The following example increments two distinct `LiveCounter` instances in a single batch operation:

<Code>

### Javascript

```
await channel.object.publish([
  {
    objectId: 'counter:iVji62_MW_j4dShuJbr2fmsP2D8MyCs6tFqON9-xAkc@1745828645269',
    counterInc: {
      number: 1
    }
  },
  {
    objectId: 'counter:JbZYiHnw0ORAyzzLSQahVik31iBDL_ehJNpTEF3qwg8@1745828651669',
    counterInc: {
      number: 1
    }
  }
]);
```
</Code>

## Idempotent operations 

Publish operations idempotently by specifying an `id` for the operation, using the same approach as [idempotent message publishing](https://ably.com/docs/api/liveobjects-rest.md#idempotent-publish):

<Code>

### Javascript

```
await channel.object.publish({
  id: 'my-idempotency-key',
  objectId: 'counter:iVji62_MW_j4dShuJbr2fmsP2D8MyCs6tFqON9-xAkc@1745828645269',
  counterInc: {
    number: 1
  }
});
```
</Code>

For batch operations, use the format `<baseId>:<index>` where the index is the zero-based index of the operation in the array:

<Code>

### Javascript

```
await channel.object.publish([
  {
    id: 'my-idempotency-key:0',
    objectId: 'counter:iVji62_MW_j4dShuJbr2fmsP2D8MyCs6tFqON9-xAkc@1745828645269',
    counterInc: {
      number: 1
    }
  },
  {
    id: 'my-idempotency-key:1',
    objectId: 'counter:JbZYiHnw0ORAyzzLSQahVik31iBDL_ehJNpTEF3qwg8@1745828651669',
    counterInc: {
      number: 1
    }
  }
]);
```
</Code>

## Data values reference 

When working with objects via the REST SDK, [primitive types](https://ably.com/docs/liveobjects/concepts/objects.md#primitive-types) and [object references](https://ably.com/docs/liveobjects/concepts/objects.md#composability) are represented as typed value objects.

The key in the value object indicates the type of the value. Examples of data value formats:

<Code>

### Javascript

```
{ number: 42 }
{ string: 'LiveObjects is awesome' }
{ boolean: true }
{ bytes: new Uint8Array([76, 105, 118, 101]) }
{ objectId: 'counter:JbZYiHnw0ORAyzzLSQahVik31iBDL_ehJNpTEF3qwg8@1745828651669' }
{ json: { someKey: 'someValue' } }
```
</Code>

<Aside data-type='note'>
Over the wire, `bytes` values are base64-encoded and `json` values are JSON-stringified strings, matching the [REST API format](https://ably.com/docs/liveobjects/rest-api-usage.md#data-values). When publishing operations, the SDK automatically encodes these values, so you can work with native types directly: <If lang="javascript">`ArrayBuffer`</If><If lang="nodejs">`Buffer`</If> for `bytes`, and plain objects or arrays for `json`.

When fetching with `compact: false`, the SDK decodes `bytes` to <If lang="javascript">`ArrayBuffer`</If><If lang="nodejs">`Buffer`</If> and `json` to native objects or arrays.

When fetching with `compact: true` (default), the SDK returns `bytes`-typed values as <If lang="javascript">`ArrayBuffer`</If><If lang="nodejs">`Buffer`</If> when using the binary protocol, or as base64-encoded strings when using the JSON protocol. `json`-typed values remain as JSON-encoded strings.
</Aside>

## Related types 

### RestObjectGetParams 

Parameters for the [`get()`](#get) method:

| Property | Description | Type |
|----------|-------------|------|
| objectId | The unique identifier of the [object instance](https://ably.com/docs/liveobjects/concepts/instance.md) to fetch. If omitted, fetches from the channel object | `String` (optional) |
| path | A dot-separated path to return a subset of the object. Evaluated relative to the channel object or the specified `objectId` | `String` (optional) |
| compact | When `true` (default), returns a values-only representation. When `false`, includes object IDs and type metadata | `Boolean` (optional) |

### RestObjectOperation 

An operation passed to the [`publish()`](#publish) method. Each operation contains an optional `id` for [idempotent publishing](#idempotent-operations), an optional target (`objectId` or `path`), and exactly one operation-specific field containing the operation parameters:

| Property | Description | Type |
|----------|-------------|------|
| id | Identifier for [idempotent publishing](#idempotent-operations) | `String` (optional) |
| objectId | The unique identifier of the [object instance](https://ably.com/docs/liveobjects/concepts/instance.md) to target | `String` (optional) |
| path | The dot-separated path to the object instance within the channel object. Evaluated relative to the channel object | `String` (optional) |
| mapSet | Parameters for setting a key to a value in a `LiveMap` | [`RestObjectOperationMapSet`](#rest-object-operation-map-set) (optional) |
| mapRemove | Parameters for removing a key from a `LiveMap` | [`RestObjectOperationMapRemove`](#rest-object-operation-map-remove) (optional) |
| counterInc | Parameters for incrementing a `LiveCounter` | [`RestObjectOperationCounterInc`](#rest-object-operation-counter-inc) (optional) |
| mapCreate | Parameters for creating a new `LiveMap` | [`RestObjectOperationMapCreate`](#rest-object-operation-map-create) (optional) |
| counterCreate | Parameters for creating a new `LiveCounter` | [`RestObjectOperationCounterCreate`](#rest-object-operation-counter-create) (optional) |
| mapCreateWithObjectId | Parameters for creating a new `LiveMap` with a [client-generated ID](#client-generated-ids) | [`RestObjectOperationMapCreateWithObjectId`](#rest-object-operation-map-create-with-object-id) (optional) |
| counterCreateWithObjectId | Parameters for creating a new `LiveCounter` with a [client-generated ID](#client-generated-ids) | [`RestObjectOperationCounterCreateWithObjectId`](#rest-object-operation-counter-create-with-object-id) (optional) |

### RestObjectOperationMapSet 

| Property | Description | Type |
|----------|-------------|------|
| key | The key to set | `String` |
| value | The value to assign to the key | [`PublishObjectData`](#publish-object-data) |

### RestObjectOperationMapRemove 

| Property | Description | Type |
|----------|-------------|------|
| key | The key to remove | `String` |

### RestObjectOperationCounterInc 

| Property | Description | Type |
|----------|-------------|------|
| number | The amount to increment by. Use a negative value to decrement | `Number` |

### RestObjectOperationMapCreate 

| Property | Description | Type |
|----------|-------------|------|
| semantics | The conflict-resolution semantics for the map. One of: `'lww'` | `String` |
| entries | Initial key-value pairs, keyed by string | `Record<String, { data: `[`PublishObjectData`](#publish-object-data)` }>` |

### RestObjectOperationCounterCreate 

| Property | Description | Type |
|----------|-------------|------|
| count | The initial value of the counter | `Number` |

### RestObjectOperationMapCreateWithObjectId 

Use [`generateObjectId()`](#generate-object-id) to get the `initialValue` and `nonce` values for this operation.

| Property | Description | Type |
|----------|-------------|------|
| initialValue | JSON-encoded string of the [`mapCreate`](#rest-object-operation-map-create) object. Binary values in entries must be base64-encoded | `String` |
| nonce | Random string used to generate the object ID | `String` |

### RestObjectOperationCounterCreateWithObjectId 

Use [`generateObjectId()`](#generate-object-id) to get the `initialValue` and `nonce` values for this operation.

| Property | Description | Type |
|----------|-------------|------|
| initialValue | JSON-encoded string of the [`counterCreate`](#rest-object-operation-counter-create) object | `String` |
| nonce | Random string used to generate the object ID | `String` |

### RestObjectGetCompactResult 

Returned by [`get()`](#get) when `compact` is `true` (default). The result is a recursive type: `null`, `boolean`, `number`, `string`, binary data (<If lang="javascript">`ArrayBuffer`</If><If lang="nodejs">`Buffer`</If> when using the binary protocol, or a base64-encoded string when using the JSON protocol), or a JSON object whose values are themselves `RestObjectGetCompactResult`. [LiveMap](https://ably.com/docs/liveobjects/map.md) instances appear as JSON objects with their entries, and [LiveCounter](https://ably.com/docs/liveobjects/counter.md) instances appear as numbers.

### RestObjectGetFullResult 

Returned by [`get()`](#get) when `compact` is `false`. Can be a [`RestLiveObject`](#rest-live-object) (full object with metadata) or a [`RestObjectData`](#rest-object-data) (leaf value when the path resolves to a primitive entry in a map).

### RestLiveObject 

A full object structure including object IDs and type metadata. Can be a [`RestLiveMap`](#rest-live-map), [`RestLiveCounter`](#rest-live-counter), or a generic object with an `objectId` property.

### RestLiveMap 

| Property | Description | Type |
|----------|-------------|------|
| objectId | The ID of the map object | `String` |
| map | The map data | [`RestLiveMapValue`](#rest-live-map-value) |

### RestLiveMapValue 

| Property | Description | Type |
|----------|-------------|------|
| semantics | The conflict-resolution semantics. One of: `'lww'` | `String` |
| entries | The map entries, indexed by key. Each entry is either a [`RestObjectDataMapEntry`](#rest-object-data-map-entry) (leaf value) or a [`RestLiveObjectMapEntry`](#rest-live-object-map-entry) (nested object) | `Record<String, RestObjectDataMapEntry \| RestLiveObjectMapEntry>` |

### RestObjectDataMapEntry 

| Property | Description | Type |
|----------|-------------|------|
| data | The value for this entry | [`RestObjectData`](#rest-object-data) |

### RestLiveObjectMapEntry 

| Property | Description | Type |
|----------|-------------|------|
| data | A nested object | [`RestLiveObject`](#rest-live-object) |

### RestLiveCounter 

| Property | Description | Type |
|----------|-------------|------|
| objectId | The ID of the counter object | `String` |
| counter | The counter data | [`RestLiveCounterValue`](#rest-live-counter-value) |

### RestLiveCounterValue 

| Property | Description | Type |
|----------|-------------|------|
| data | Holds the counter value | `{ number: Number }` |

### RestObjectData 

Represents a leaf data value for an object. Either a primitive value or a reference to another object. Exactly one property is set, indicating the type:

| Property | Description | Type |
|----------|-------------|------|
| string | A string value | `String` |
| number | A numeric value | `Number` |
| boolean | A boolean value | `Boolean` |
| bytes | A binary value | <If lang="javascript">`ArrayBuffer`</If><If lang="nodejs">`Buffer`</If> |
| json | A JSON value (array or object) | `Array` / `Object` |
| objectId | A reference to another object by its ID | `String` |

### PublishObjectData 

Same properties as [`RestObjectData`](#rest-object-data). Used when publishing operations via [`publish()`](#publish). Exactly one property must be set.

### RestObjectPublishResult 

Result returned by the [`publish()`](#publish) method:

| Property | Description | Type |
|----------|-------------|------|
| messageId | The ID of the message containing the published operations | `String` |
| channel | The name of the channel the operations were published to | `String` |
| objectIds | Array of object IDs affected by the operations. May include multiple IDs for wildcard paths and batch operations | `String[]` |

### RestObjectOperationMapCreateBody 

| Property | Description | Type |
|----------|-------------|------|
| mapCreate | Parameters for creating a new `LiveMap` | [`RestObjectOperationMapCreate`](#rest-object-operation-map-create) |

### RestObjectOperationCounterCreateBody 

| Property | Description | Type |
|----------|-------------|------|
| counterCreate | Parameters for creating a new `LiveCounter` | [`RestObjectOperationCounterCreate`](#rest-object-operation-counter-create) |

### RestObjectGenerateIdResult 

Result returned by [`generateObjectId()`](#generate-object-id):

| Property | Description | Type |
|----------|-------------|------|
| objectId | The generated object ID | `String` |
| nonce | The nonce used in ID generation | `String` |
| initialValue | The JSON-encoded initial value used in ID generation | `String` |

## Related Topics

- [Batch operations](https://ably.com/docs/liveobjects/batch.md): Group multiple objects operations into a single channel message to apply grouped operations atomically and improve performance.
- [Lifecycle events](https://ably.com/docs/liveobjects/lifecycle.md): Understand lifecycle events for Objects, LiveMap and LiveCounter to track synchronization events and object deletions.
- [Typing](https://ably.com/docs/liveobjects/typing.md): Type objects on a channel for type safety and code autocompletion.
- [Inband objects](https://ably.com/docs/liveobjects/inband-objects.md): Subscribe to LiveObjects updates from Pub/Sub SDKs.
- [Object storage](https://ably.com/docs/liveobjects/storage.md): Learn about LiveObjects object storage.
- [Using the REST API](https://ably.com/docs/liveobjects/rest-api-usage.md): Learn how to work with Ably LiveObjects using the REST API

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
