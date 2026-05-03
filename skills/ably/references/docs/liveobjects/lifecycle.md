# Lifecycle events

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

## Handle synchronization events 

The <If lang="javascript">[channel.object](https://ably.com/docs/liveobjects/concepts/objects.md#channel-object)</If><If lang="swift,java">[channel.objects](https://ably.com/docs/liveobjects/concepts/objects.md#root-object)</If> instance emits synchronization events that indicate when the local state on the client is being synchronized with the Ably service. These events can be useful for displaying loading indicators, preventing user interactions during synchronization, or triggering application logic when data is first loaded.

| Event | Description |
| ----- | ----------- |
| syncing | Emitted when the local copy of objects on a channel begins synchronizing with the Ably service. |
| synced | Emitted when the local copy of objects on a channel has been synchronized with the Ably service. |

<Code>

### Javascript

```
channel.object.on('syncing', () => {
  console.log('Objects are syncing...');
  // Show a loading indicator and disable edits in the application
});

channel.object.on('synced', () => {
  console.log('Objects have been synced.');
  // Hide loading indicator
});
```

### Swift

```
channel.objects.on(event: .syncing) { _ in
    print("objects are syncing...")
    // show a loading indicator and disable edits in the application
}

channel.objects.on(event: .synced) { _ in
    print("objects have been synced.")
    // hide loading indicator
}
```

### Java

```
channel.getObjects().on(ObjectsStateEvent.SYNCING, (stateEvent) -> {
    System.out.println("Objects are syncing...");
    // Show a loading indicator and disable edits in the application
});

channel.getObjects().on(ObjectsStateEvent.SYNCED, (stateEvent) -> {
    System.out.println("Objects have been synced.");
    // Hide loading indicator
});
```
</Code>

<Aside data-type='important'>
LiveObjects synchronization events do not replace [connection](https://ably.com/docs/connect/states.md) or [channel](https://ably.com/docs/channels/states.md) states. You should still monitor these states and handle [connection](https://ably.com/docs/connect/states.md#handling-failures) and [channel](https://ably.com/docs/channels/states.md#failure) failures to ensure your application behaves as expected. LiveObjects synchronization events specifically inform you about the progress of LiveObjects data synchronization and should be used alongside other state management mechanisms.
</Aside>

## Handle object lifecycle events 

<If lang="javascript">

### Detect object deletion 

Objects can become unreachable when they are removed from the object tree using [`remove()`](https://ably.com/docs/liveobjects/map.md#remove) and never reassigned. Unreachable objects are garbage collected by Ably, typically after 24 hours.

Since deleted objects are unreachable via any path, `object.delete` events can only be received through [Instance](https://ably.com/docs/liveobjects/concepts/instance.md) subscriptions, which track a specific object by its ID regardless of its location in the object tree:

<Code>

#### Javascript

```
const counterInstance = myObject.get('visits').instance();

if (counterInstance) {
  counterInstance.subscribe(({ object, message }) => {
    if (message?.operation.action === 'object.delete') {
      console.log('Counter instance was deleted');
      // The client automatically unsubscribes the subscription after this notification
      // Remove references to this object from your application
    } else {
      console.log('Counter updated:', object.value());
    }
  });
}
```
</Code>

In most cases, you don't need to explicitly handle object deletion. Your application should have already reacted to object removal when a corresponding [`LiveMap.remove()`](https://ably.com/docs/liveobjects/map.md#remove) operation was received. However, if your application separately stores references to object instances and does not properly clear them when objects are orphaned, any later interactions with those objects after they are deleted will result in an error. In such cases, handling deletion events via Instance subscriptions helps ensure that those references are cleaned up and runtime errors are avoided.

<Aside data-type='note'>
The [channel object](https://ably.com/docs/liveobjects/concepts/objects.md#channel-object) cannot be deleted, so deletion notifications will never occur for the channel object itself.
</Aside>
</If>

<If lang="swift,java">

Lifecycle events enable you to monitor changes in an object's lifecycle.

Currently, only the `deleted` event can be emitted. Understanding the conditions under which this event is emitted and handling it properly ensures that your application maintains expected behavior.

### deleted event 

Objects that were created on a channel can become orphaned when they were never assigned to the object tree, or because their reference was removed using [`LiveMap.remove()`](https://ably.com/docs/liveobjects/map.md#remove) and never reassigned. Ably garbage collects orphaned objects, typically after 24 hours. When this happens, a `deleted` event is broadcast for the affected object. Once deleted, an object can no longer be interacted with, and any operations performed on it result in an error.

While the LiveObjects feature internally manages object deletions and removes them from its internal state, your application may still hold references to these deleted objects in separate data structures. The `deleted` event provides a way to react accordingly by removing references to deleted objects and preventing potential errors.

In most cases, subscribing to `deleted` events is unnecessary. Your application should have already reacted to object removal when a corresponding [`LiveMap.remove()`](https://ably.com/docs/liveobjects/map.md#remove) operation was received. However, if your application separately stores references to object instances and does not properly clear them when objects are orphaned, any later interactions with those objects after they are deleted result in an error. In such cases, subscribing to `deleted` events helps ensure that those references are cleaned up and runtime errors are avoided.

<Aside data-type='note'>
The [root object](https://ably.com/docs/liveobjects/concepts/objects.md#root-object) cannot be deleted, so there is no need to subscribe to this event on the root object.
</Aside>

<Code>

#### Swift

```
counter.on(event: .deleted) { _ in
    print("LiveCounter has been deleted.")
    // Remove references to this object from your application
    // as it can no longer be interacted with
}
```

#### Java

```
ObjectsSubscription subscription = counter.on(ObjectLifecycleEvent.DELETED, (lifecycleEvent) -> {
    System.out.println("LiveCounter has been deleted.");
    // Remove references to this object from your application
    // as it can no longer be interacted with
});
```
</Code>

Read more about subscribing to object lifecycle events for [LiveCounter](https://ably.com/docs/liveobjects/counter.md#subscribe-lifecycle) and [LiveMap](https://ably.com/docs/liveobjects/map.md#subscribe-lifecycle).

</If>

## Related Topics

- [Batch operations](https://ably.com/docs/liveobjects/batch.md): Group multiple objects operations into a single channel message to apply grouped operations atomically and improve performance.
- [Typing](https://ably.com/docs/liveobjects/typing.md): Type objects on a channel for type safety and code autocompletion.
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
