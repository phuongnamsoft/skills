# Using the REST API

<Aside data-type='note'>
**Building with LiveObjects?** Help shape its future by [sharing your use case](https://44qpp.share.hsforms.com/2fZobHQA1ToyRfB9xqZYQmQ).
</Aside>

LiveObjects provides a comprehensive REST API that enables you to directly work with objects without using a client SDK.

## Authentication 

View the REST API [authentication](https://ably.com/docs/api/liveobjects-rest.md#authentication) documentation for details on how to authenticate your requests.

To read objects on a channel, an API key must have the `object-subscribe` [capability](https://ably.com/docs/auth/capabilities.md). With only this capability, clients have read-only access, preventing them from publishing operations.

To create or update objects, the API key must have the `object-publish` capability. Include both `object-subscribe` and `object-publish` for full read and write access.

## Fetching objects 

The REST API returns objects in two formats:

| Format | Query parameter | Description |
|--------|----------------|-------------|
| **Compact** (default) | None | Values-only representation without metadata. Ideal for reading data values. |
| **Full** | `compact=false` | Full structure including object IDs and type metadata. Useful for debugging. |

**Compact format** returns the logical structure of your data as a JSON object. [LiveMap](https://ably.com/docs/liveobjects/map.md) instances appear as JSON objects with their entries, and [LiveCounter](https://ably.com/docs/liveobjects/counter.md) instances appear as numbers.

**Full format** includes additional [metadata](https://ably.com/docs/liveobjects/concepts/objects.md#metadata) for each object:
- Object IDs for each instance
- Object type metadata (map semantics, counter values)
- Complete object hierarchy

### Fetch the channel object 

Fetch the entire channel object:

<Code>

#### Shell

```
  curl "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key
```
</Code>

Example compact response:

<Code>

#### Json

```
  {
    "votes": {
      "down": 10,
      "up": 5
    }
  }
  ```
</Code>

This example shows a `LiveMap` stored on the "votes" key of the channel object, which contains two `LiveCounter` instances on the "down" and "up" keys.

Add `compact=false` to include object metadata:

<Code>

#### Shell

```
  curl "https://main.realtime.ably.net/channels/my-channel/object?compact=false" \
  -u your-api-key
  ```
</Code>

<Code>

#### Json

```
  {
    "objectId": "root",
    "map": {
      "semantics": "LWW",
      "entries": {
        "votes": {
          "data": {
            "objectId": "map:qZXBk8xaGqf4kwLSlR7Tj0Eqhd48WDFfb3gTAbj194k@1760448597692",
            "map": {
              "semantics": "LWW",
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

Return a subset of the channel object by specifying the `path` query parameter. For example, to return only the `votes` `LiveMap` instance from the channel object:

<Code>

#### Shell

```
  curl "https://main.realtime.ably.net/channels/my-channel/object?path=votes" \
  -u your-api-key
  ```
</Code>

Example response:

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

Fetch a specific [object instance](https://ably.com/docs/liveobjects/concepts/instance.md) by specifying its object ID in the URL path:

<Code>

#### Shell

```
  curl "https://main.realtime.ably.net/channels/my-channel/object/map:qZXBk8xaGqf4kwLSlR7Tj0Eqhd48WDFfb3gTAbj194k@1760448597692" \
    -u your-api-key
```
</Code>

Example compact response:

<Code>

#### Json

```
{
  "down": 5,
  "up": 10
}
```
</Code>

Add `compact=false` to include object metadata:

<Code>

#### Shell

```
  curl "https://main.realtime.ably.net/channels/my-channel/object/map:qZXBk8xaGqf4kwLSlR7Tj0Eqhd48WDFfb3gTAbj194k@1760448597692?compact=false" \
  -u your-api-key
  ```
</Code>

<Code>

#### Json

```
  {
    "objectId": "map:qZXBk8xaGqf4kwLSlR7Tj0Eqhd48WDFfb3gTAbj194k@1760448597692",
    "map": {
      "semantics": "LWW",
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

This endpoint also supports the `path` query option. The path is evaluated relative to the specified object instance:

<Code>

#### Shell

```
  curl "https://main.realtime.ably.net/channels/my-channel/object/map:qZXBk8xaGqf4kwLSlR7Tj0Eqhd48WDFfb3gTAbj194k@1760448597692?path=down" \
  -u your-api-key
  ```
</Code>

<Code>

#### Json

```
5
```
</Code>

## Publishing operations 

Publish all operations to the same endpoint: `POST /channels/{channelId}/object`

<Aside data-type='further-reading'>
For complete OpenAPI specifications, see the [LiveObjects OpenAPI spec](https://ably.com/docs/api/liveobjects-rest.md).
</Aside>

Each operation includes:
1. A reference to an object using either `objectId` or `path`
2. An **operation-specific field** (`mapSet`, `counterInc`, etc.) containing the operation parameters

Operations can target objects using either `objectId` or `path`:
- `objectId` (string): The unique identifier of the object instance to update
- `path` (string): The path to the object instance within the channel object

Use dot-separated notation for paths (e.g. `votes.up`), relative to the channel object. An empty path `""` refers to the channel object itself. Paths can contain wildcards (`*`) to target multiple objects.

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

To create an object, see [Creating Objects](#creating-objects).

Each operation has specific required and optional fields:

#### mapSet 

<Code>

##### Json

```
{
  "path": "user",
  "mapSet": {
    "key": "username",
    "value": {"string": "alice"}
  }
}
```
</Code>

Map values can be any of the supported [data value types](#data-values), including references to other objects.

#### mapRemove 

<Code>

##### Json

```
{
  "path": "user",
  "mapRemove": {
    "key": "username"
  }
}
```
</Code>

#### counterInc 

<Code>

##### Json

```
{
  "path": "votes.up",
  "counterInc": {
    "number": 5
  }
}
```
</Code>

<Aside data-type='note'>
There is no explicit `counterDec` operation. To decrement a counter, use `counterInc` with a negative number.
</Aside>

#### mapCreate 

Optionally omit the `path` or `objectId` fields when creating an object with `mapCreate`.
For the object to be [reachable](https://ably.com/docs/liveobjects/concepts/objects.md#reachability) in the state tree, assign it to a key in a `LiveMap` that is reachable from the channel object.

<Code>

##### Json

```
{
  "path": "posts.post1",
  "mapCreate": {
    "semantics": 0,
    "entries": {
      "title": {"data": {"string": "LiveObjects is awesome"}},
      "createdAt": {"data": {"number": 1745835181122}},
      "isPublished": {"data": {"boolean": true}}
    }
  }
}
```
</Code>

#### counterCreate 

Optionally omit the `path` or `objectId` fields when creating an object with `counterCreate`.
For the object to be [reachable](https://ably.com/docs/liveobjects/concepts/objects.md#reachability) in the state tree, assign it to a key in a `LiveMap` that is reachable from the channel object.

<Code>

##### Json

```
{
  "path": "visits",
  "counterCreate": {
    "count": 0
  }
}
```
</Code>

### Update by object ID 

To perform operations on a specific object instance, provide its object ID in the request body:

<Code>

#### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '{
      "objectId": "counter:iVji62_MW_j4dShuJbr2fmsP2D8MyCs6tFqON9-xAkc@1745828645269",
      "counterInc": {
        "number": 1
      }
    }'
```
</Code>

The response includes the ID of the published operation message, the channel and a list of object IDs that were affected by the operation:

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

### Update by path 

Path operations target objects based on their location in the channel object.

Paths are expressed relative to the structure of the object as defined by the [compact](#fetch-channel-object) view of the channel object.

The following example increments the `LiveCounter` instance stored at the `up` key on the `votes` `LiveMap` object:

<Code>

#### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '{
      "path": "votes.up",
      "counterInc": {
        "number": 1
      }
    }'
```
</Code>

### Path operations 

Path operations provide flexibility when targeting objects.

#### Path wildcards 

Use wildcards in paths to target multiple objects at once. To increment all `LiveCounter` instances in the `votes` `LiveMap` instance:

<Code>

##### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '{
      "path": "votes.*",
      "counterInc": {
        "number": 1
      }
    }'
```
</Code>

The response includes the IDs of each of the affected object instances:

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
        "up": 5,
        "down": 10
      }
    },
    "post2": {
      "votes": {
        "up": 5,
        "down": 10
      }
    }
  }
}
```
</Code>

The following example increments the upvote `LiveCounter` instances for all posts in the `posts` `LiveMap` instance:

<Code>

##### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '{
      "path": "posts.*.votes.up",
      "counterInc": {
        "number": 1
      }
    }'
```
</Code>

#### Escaping special characters 

If your `LiveMap` keys contain periods, escape them with a backslash. The following example increments the upvote `LiveCounter` instance for a post with the key `post.123`:

<Code>

##### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '{
      "path": "posts.post\.123.votes.up",
      "counterInc": {
        "number": 1
      }
    }'
```
</Code>

### Removing objects 

Remove an object from the channel using `mapRemove` to delete the key referencing it:

<Code>

#### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '{
      "objectId": "root",
      "mapRemove": {
        "key": "posts"
      }
    }'
```
</Code>

Map keys can be removed by issuing a `mapRemove` operation targeting either an `objectId` or a `path`.

If no other references to the object exist, it becomes unreachable and is eligible for [garbage collection](#object-reachability).

<Aside data-type='note'>
Removing a key may also make nested child objects unreachable. These objects are also eligible for garbage collection.
</Aside>

## Creating objects 

Use `mapCreate` and `counterCreate` operations to create new LiveObjects [instances](https://ably.com/docs/liveobjects/concepts/instance.md).

### Creating objects with paths 

The simplest way to create an object is to specify a `path` where it should be created. The server automatically creates the object and assigns it to that path in a single atomic operation.

The following example creates a new `LiveMap` instance and assigns it to the `posts` `LiveMap` instance on the channel object under the key `post1`:

<Code>

#### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '{
      "path": "posts.post1",
      "mapCreate": {
        "semantics": 0,
        "entries": {
          "title": {"data": {"string": "LiveObjects is awesome"}},
          "createdAt": {"data": {"number": 1745835181122}},
          "isPublished": {"data": {"boolean": true}}
        }
      }
    }'
```
</Code>

When using `path` with a create operation, the server constructs two operations published as a [batch](#batch-operations):

1. A `mapCreate` or `counterCreate` operation to create the new object
2. A `mapSet` operation to assign the new object to the parent `LiveMap` at the specified path

This ensures the new object is immediately [reachable](#object-reachability) from the channel object.

The response will include the object IDs of all objects affected by the resulting set of operations.
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

### Creating standalone objects 

Create objects without immediately assigning them by omitting both `objectId` and `path` from the create operation.

<Code>

#### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '{
      "mapCreate": {
        "semantics": 0,
        "entries": {
          "name": {"data": {"string": "Alice"}}
        }
      }
    }'
```
</Code>

The response includes the generated object ID:

<Code>

#### Json

```
{
  "messageId": "TJPWHhMTrF:0",
  "channel": "my-channel",
  "objectIds": ["map:abc123def456...@1745835549101"]
}
```
</Code>

<Aside data-type='important'>
Standalone objects are not reachable until assigned to the object tree. Unreachable objects are eligible for garbage collection. See [Object reachability and garbage collection](#object-reachability) for details.
</Aside>

### Client-generated object IDs 

Generate [object IDs](https://ably.com/docs/liveobjects/concepts/objects.md#object-ids) when creating objects to enable atomic batch operations with cross-references between newly created objects. This is useful when creating multiple objects that reference each other in a single batch.

Object IDs are generated by hashing the operation type, the JSON-encoded initial value, and a random nonce. Format: `{type}:{hash}@{timestamp}`

The `hash` is a raw (unpadded) URL-safe base64-encoded SHA-256 hash of the concatenation of:
- The initial value bytes (as a JSON encoded string)
- The nonce bytes (as a UTF-8 encoded string)

In the format `sha256.Hash(initialValue + ":" + nonce)`. (i.e. colon separated).

The `timestamp` is the Unix timestamp in milliseconds at the time of creation.

The `type` is either `map` or `counter`.

There are additional operations for creating objects with client-generated IDs:
- `mapCreateWithObjectId`
- `counterCreateWithObjectId`

**mapCreateWithObjectId**

- `objectId` (string): The pre-computed object ID for the new map
- `initialValue` (string): JSON-encoded string of the map data, matching the format from
  `mapCreate`.
- `nonce` (string): Random string you generated

<Code>

#### Json

```
{
  "objectId": "map:Qj2kkvprTybCY5mkNMcm31hhNKZCDWqcz45LjYvCABs@1769079911168",
  "mapCreateWithObjectId": {
    "initialValue": "{\"semantics\":0,\"entries\":{\"name\":{\"data\":{\"string\":\"Alice\"}},\"age\":{\"data\":{\"number\":30}}}}",
    "nonce": "random-nonce-abc123"
  }
}
```
</Code>

**counterCreateWithObjectId**

- `objectId` (string): The pre-computed object ID for the new counter
- `initialValue` (string): JSON-encoded string of the counter data, matching the format from
  `counterCreate`.
- `nonce` (string): Random string you generated

<Code>

#### Json

```
{
  "objectId": "counter:xyz789@ts1",
  "counterCreateWithObjectId": {
    "initialValue": "{\"count\":0}",
    "nonce": "nonce-xyz789"
  }
}
```
</Code>

<Aside data-type='important'>
The server validates that your `objectId` matches the hash of `initialValue + nonce`.
</Aside>

#### Publishing with client-generated IDs 

Publish an operation using either `mapCreateWithObjectId` or `counterCreateWithObjectId` to create
an object with a client-generated ID.

For example:

<Code>

##### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '{
      "objectId": "map:Qj2kkvprTybCY5mkNMcm31hhNKZCDWqcz45LjYvCABs@1769079911168",
      "mapCreateWithObjectId": {
        "initialValue": "{\"semantics\":0,\"entries\":{\"name\":{\"data\":{\"string\":\"Alice\"}},\"age\":{\"data\":{\"number\":30}}}}",
        "nonce": "random-nonce-abc123"
      }
    }'
```
</Code>

#### Atomic batch with cross-references 

Create a map and immediately assign it to the channel object in a single atomic operation:

<Code>

##### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '[
      {
        "objectId": "map:Qj2kkvprTybCY5mkNMcm31hhNKZCDWqcz45LjYvCABs@1769079911168",
        "mapCreateWithObjectId": {
          "initialValue": "{\"semantics\":0,\"entries\":{\"name\":{\"data\":{\"string\":\"Alice\"}}}}",
          "nonce": "nonce-1"
        }
      },
      {
        "objectId": "root",
        "mapSet": {
          "key": "alice",
          "value": {"objectId": "map:Qj2kkvprTybCY5mkNMcm31hhNKZCDWqcz45LjYvCABs@1769079911168"}
        }
      }
    ]'
```
</Code>

Both operations execute atomically. The second operation references the object created in the first because you pre-computed the ID.

<Aside data-type='note'>
Only use client-generated IDs when you need atomic batch operations with cross-references. For most use cases, use simple operations or path-based operations instead.
</Aside>

## Cyclic references 

For both the full object and the compact response formats, cyclic references in the channel object are included as a
reference to the object ID rather than including the same object instance in the response more than once.

For example, if you create a cycle in the channel object by adding a reference to the channel object in the `votes` `LiveMap` instance with the following operation:

<Code>

### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '{
      "objectId": "map:qZXBk8xaGqf4kwLSlR7Tj0Eqhd48WDFfb3gTAbj194k@1760448597692",
      "mapSet": {
        "key": "myObject",
        "value": {"objectId": "root"}
      }
    }'
```
</Code>

The response will handle the cyclic reference by including the `myObject` key in the response as a reference to the object ID of the channel object:

<Code>

### Shell

```
  curl "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key
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

Objects that are not reachable from the channel object will be garbage collected. An object is reachable if it can be accessed by traversing keys starting from the channel object.

When you [remove an object](#removing-objects) using `mapRemove`, the object becomes unreachable if no other references to it exist. Unreachable objects are automatically deleted by garbage collection.

<Aside data-type='important'>
Garbage collection is permanent. Once collected, objects cannot be recovered.
</Aside>

<Aside data-type='further-reading'>
Learn more about [reachability and object lifecycle](https://ably.com/docs/liveobjects/concepts/objects.md#reachability).
</Aside>

## Batch operations 

Group multiple operations into a single request by sending an array of operations. All operations are published as a single message and processed as a single atomic unit. Learn more about [batch operations](https://ably.com/docs/liveobjects/batch.md).

The following example increments two distinct `LiveCounter` instances in a single batch operation:

<Code>

### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '[
      {
        "objectId": "counter:iVji62_MW_j4dShuJbr2fmsP2D8MyCs6tFqON9-xAkc@1745828645269",
        "counterInc": {
          "number": 1
        }
      },
      {
        "objectId": "counter:JbZYiHnw0ORAyzzLSQahVik31iBDL_ehJNpTEF3qwg8@1745828651669",
        "counterInc": {
          "number": 1
        }
      }
    ]'
```
</Code>

## Idempotent operations 

Publish operations idempotently by specifying an `id` for the operation message, using the same approach as [idempotent message publishing](https://ably.com/docs/api/liveobjects-rest.md#idempotent-publish):

<Code>

### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '{
      "id": "my-idempotency-key",
      "objectId": "counter:iVji62_MW_j4dShuJbr2fmsP2D8MyCs6tFqON9-xAkc@1745828645269",
      "counterInc": {
        "number": 1
      }
    }'
```
</Code>

For batch operations, use the format `<baseId>:<index>` where the index is the zero-based index of the operation in the array:

<Code>

### Shell

```
  curl -X POST "https://main.realtime.ably.net/channels/my-channel/object" \
    -u your-api-key \
    -H "Content-Type: application/json" \
    -d '[
      {
        "id": "my-idempotency-key:0",
        "objectId": "counter:iVji62_MW_j4dShuJbr2fmsP2D8MyCs6tFqON9-xAkc@1745828645269",
        "counterInc": {
          "number": 1
        }
      },
      {
        "id": "my-idempotency-key:1",
        "objectId": "counter:JbZYiHnw0ORAyzzLSQahVik31iBDL_ehJNpTEF3qwg8@1745828651669",
        "counterInc": {
          "number": 1
        }
      }
    ]'
```
</Code>

## Data values reference 

When working with objects via the REST API, [primitive types](https://ably.com/docs/liveobjects/concepts/objects.md#primitive-types) and [object references](https://ably.com/docs/liveobjects/concepts/objects.md#composability) are included in request and response bodies under `data` fields.

The key in the `data` object indicates the type of the value. Examples of data value formats:

<Code>

### Json

```
{ "data": { "number": 42 } }
{ "data": { "string": "LiveObjects is awesome" } }
{ "data": { "boolean": true } }
{ "data": { "bytes": "TGl2ZU9iamVjdHMgaXMgYXdlc29tZQo=" } }
{ "data": { "objectId": "counter:JbZYiHnw0ORAyzzLSQahVik31iBDL_ehJNpTEF3qwg8@1745828651669" } }
{ "data": { "json": "{\"someKey\": \"someValue\"}" } }
```
</Code>

<Aside data-type='note'>
`bytes` values use base64 string encoding in JSON request and response bodies.
</Aside>

## Related Topics

- [Batch operations](https://ably.com/docs/liveobjects/batch.md): Group multiple objects operations into a single channel message to apply grouped operations atomically and improve performance.
- [Lifecycle events](https://ably.com/docs/liveobjects/lifecycle.md): Understand lifecycle events for Objects, LiveMap and LiveCounter to track synchronization events and object deletions.
- [Typing](https://ably.com/docs/liveobjects/typing.md): Type objects on a channel for type safety and code autocompletion.
- [Inband objects](https://ably.com/docs/liveobjects/inband-objects.md): Subscribe to LiveObjects updates from Pub/Sub SDKs.
- [Object storage](https://ably.com/docs/liveobjects/storage.md): Learn about LiveObjects object storage.
- [Using the REST SDK](https://ably.com/docs/liveobjects/rest-sdk-usage.md): Learn how to work with Ably LiveObjects using the REST SDK

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
