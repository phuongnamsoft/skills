# Skip integrations

Privileged users can skip integrations on a per-message basis, providing greater control and flexibility when publishing messages to a channel. Skipping integration helps avoid infinite loops, for example, when an integration republishes a message to the same channel, potentially triggering itself again.

A strong use case for skipping integrations is in chat applications. For example, a moderation service publishes a command telling clients to edit or delete a message. That command should not trigger further moderation events by itself.

<Aside data-type='note'>
Clients must have the [privileged-headers](https://ably.com/docs/auth/capabilities.md#capability-operations) capability enabled in their Ably [API key](https://ably.com/docs/auth.md) or [token](https://ably.com/docs/auth/token.md) to skip integrations.
</Aside>

## Skip all integrations

To skip all integration rules for a specific message, set the `skipRule` field to `'*'` in the `privileged` section of the message [`extras`](https://ably.com/docs/api/rest-sdk/messages.md#extras).

The following example shows how to skip all integration rules when publishing a message to a channel:

<Code>

### Javascript

```
const rest = new Ably.Rest('your-api-key');
const channel = rest.channels.get('your-channel-name');
await channel.publish({
  name: 'event_name',
  data: 'event_data',
  extras: {
    privileged: {
      skipRule: '*'
    }
  }
});
```

### Nodejs

```
const rest = new Ably.Rest('your-api-key');
const channel = rest.channels.get('your-channel-name');
await channel.publish({
  name: 'event_name',
  data: 'event_data',
  extras: {
    privileged: {
      skipRule: '*'
    }
  }
});
```

### Ruby

```
  rest = Ably::Rest.new('your-api-key')
  channel = rest.channels.get('your-channel-name')
  while true
    channel.publish 'event', 'data', extras: { { 'privileged' => { 'skipRule' => '*' } }
  end
```

### Python

```
  rest = AblyRest('your-api-key')
  channel = rest.channels.get('your-channel-name')
  extras = {
    "privileged": {
      "skipRule": "*"
    }
  }

  await channel.publish(Message(name='message', data="abc", extras=extras))
```

### Php

```
  $rest = new Ably\AblyRest('your-api-key');
  $channel = $rest->channels->get('your-channel-name');
  $channel->publish(
    'event_name',
    ['field' => 'value'],
    null,
    [
        'privileged' => [
            'skipRule' => '*',
        ],
    ]
  );
```

### Java

```
  AblyRest rest = new AblyRest("your-api-key");
  Channel channel = rest.channels.get("your-channel-name");

  // Using Google gson for JSON
  String extrasJson = "{ \"privileged\": { \"skipRule\": \"*\" } }";
  JsonObject extras = JsonParser.parseString(extrasJson).getAsJsonObject();
  channel.publish(
      new Message(
          "event_name",
          "event_data",
          new MessageExtras(extras)
      )
  );
```

### Csharp

```
  AblyRest rest = new AblyRest("your-api-key");
  var channel = rest.Channels.Get("your-channel-name");

  // Using Newtonsoft for JSON
  string extrasJson = @"{'privileged': { 'skipRule': '*' }}";
  MessageExtras extras = new MessageExtras(extrasJson);
  Message message = new Message("event", "data", null, extras);
  channel.Publish(message);
```

### Objc

```
  ARTRest *rest = [[ARTRest alloc] initWithKey:@"your-api-key"];
  ARTRestChannel *channel = [rest.channels get:@"your-channel-name"];
  ARTJsonObject *extras = @{
      @"privileged": @{@"skipRule": @"*"}
  };
  [channel publish:@"event" data:@"data" extras:extras];
```

### Swift

```
  let rest = ARTRest(key: "your-api-key")
  let channel = rest.channels.get("your-channel-name")
  let extras: NSDictionary = ["privileged": ["skipRule": "*"]]
  channel.publish("event", data: "data", extras: extras as ARTJsonCompatible)
```

### Go

```
  rest, err := ably.NewREST(ably.WithKey("your-api-key"))
  channel := rest.Channels.Get("your-channel-name")
  privileged := make(map[string]string)
  privileged["skipRule"] = "*"
  extras := make(map[string]interface{})
  extras["privileged"] = privileged
  err := channel.PublishMultiple(context.Background(), []*ably.Message{
		{Name: "event", Data: "data", Extras: extras},
	})

```
</Code>

## Skip specific integration rules

You can also skip specific integration rules by including their ruleId in an array passed to skipRule. Rule IDs can be found in the Integrations tab of your Ably [dashboard](https://ably.com/dashboard/any), via the Control API, or in the message envelope.

The following example shows how to skip specific integration rules when publishing a message to a channel:


<Code>

### Javascript

```
const rest = new Ably.Rest('your-api-key');
const channel = rest.channels.get('your-channel-name');
await channel.publish({
  name: 'event_name',
  data: 'event_data',
  extras: {
    privileged: { skipRule: ['rule_id_1'] }
  }
})
```

### Nodejs

```
const rest = new Ably.Rest('your-api-key');
const channel = rest.channels.get('your-channel-name');
await channel.publish({
  name: 'event_name',
  data: 'event_data',
  extras: {
    privileged: { skipRule: ['rule_id_1'] }
  }
})
```

### Ruby

```
  rest = Ably::Rest.new('your-api-key')
  channel = rest.channels.get('your-channel-name')
  while true
    channel.publish 'event', 'data', extras: { { 'privileged' => { 'skipRule' => ['rule_id_1'] } }
  end
```

### Python

```
  rest = AblyRest('your-api-key')
  channel = rest.channels.get('your-channel-name')
  extras = {
    "privileged": {
      "skipRule": ["rule_id_1"]
    }
  }

  await channel.publish(Message(name='message', data="abc", extras=extras))
```

### Php

```
  $rest = new Ably\AblyRest('your-api-key');
  $channel = $rest->channels->get('your-channel-name');
  $channel->publish(
    'event_name',
    ['field' => 'value'],
    null,
    [
        'privileged' => [
            'skipRule' => ['rule_id_1'],
        ],
    ]
  );
```

### Java

```
  AblyRest rest = new AblyRest("your-api-key");
  Channel channel = rest.channels.get("your-channel-name");

  // Using Google gson for JSON
  String extrasJson = "{ \"privileged\": { \"skipRule\": [\"rule_id_1\"] } }";
  JsonObject extras = JsonParser.parseString(extrasJson).getAsJsonObject();
  channel.publish(
      new Message(
          "event_name",
          "event_data",
          new MessageExtras(extras)
      )
  );
```

### Csharp

```
  AblyRest rest = new AblyRest("your-api-key");
  var channel = rest.Channels.Get("your-channel-name");

  // Using Newtonsoft for JSON
  string extrasJson = @"{'privileged': { 'skipRule': ['rule_id_1'] }}";
  MessageExtras extras = new MessageExtras(extrasJson);
  Message message = new Message("event", "data", null, extras);
  channel.Publish(message);
```

### Objc

```
  ARTRest *rest = [[ARTRest alloc] initWithKey:@"your-api-key"];
  ARTRestChannel *channel = [rest.channels get:@"your-channel-name"];
  ARTJsonObject *extras = @{
      @"privileged": @{@"skipRule": @[@"rule_id_1"]}
  };
  [channel publish:@"event" data:@"data" extras:extras];
```

### Swift

```
  let rest = ARTRest(key: "your-api-key")
  let channel = rest.channels.get("your-channel-name")
  let extras: NSDictionary = ["privileged": ["skipRule": ["rule_id_1"]]]
  channel.publish("event", data: "data", extras: extras as ARTJsonCompatible)
```

### Go

```
  rest, err := ably.NewREST(ably.WithKey("your-api-key"))
  channel := rest.Channels.Get("your-channel-name")
	privileged := make(map[string][]string)
	privileged["skipRule"] = []string{"rule_id_1"}
	extras := make(map[string]interface{})
  extras["privileged"] = privileged
	err := channel.PublishMultiple(context.Background(), []*ably.Message{
		{Name: "event", Data: "data", Extras: extras},
	})

```
</Code>

## Related Topics

- [Overview](https://ably.com/docs/platform/integrations.md): Integrations enable external services to send data to Ably channels, and for Ably events to send their data to external services.
- [Message Queues](https://ably.com/docs/platform/integrations/queues.md): Ably queues provide a queueing mechanism to integrate Ably with your external service.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
