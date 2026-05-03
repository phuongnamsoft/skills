# Apache Kafka integration

[Kafka](https://kafka.apache.org/) integrations enable you to automatically forward events that occur in Ably to Kafka topics.

<Aside data-type='note'>
If you want to send data from Kafka to Ably, you can use the [Ably Kafka Connector.](https://ably.com/docs/platform/integrations/inbound/kafka-connector.md)
</Aside>

## Create a Kafka integration 

<Tabs>
<Tab value="dashboard" label="Dashboard">

On the [Integrations](https://ably.com/accounts/any/apps/any/integrations) page of your app:

1. Click **New Integration Rule**.
2. Choose **Firehose**.
3. Choose **Kafka**.
4. Configure the Kafka [settings](#settings).
5. Click **Create**.

</Tab>
<Tab value="control-api" label="Control API">

Create a Kafka rule using the Control API by sending a `POST` request to [`/apps/{app_id}/rules`](https://ably.com/docs/api/control-api.md):

<Code>

### Shell

```
curl -X POST https://control.ably.net/v1/apps/{APP_ID}/rules \
  -H "Authorization: Bearer {ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "ruleType": "kafka",
    "requestMode": "single",
    "source": {
      "channelFilter": "",
      "type": "channel.message"
    },
    "target": {
      "routingKey": "my-topic:#{message.name}",
      "brokers": ["kafka.example.com:9092"],
      "auth": {
        "sasl": {
          "mechanism": "scram-sha-256",
          "username": "my-username",
          "password": "my-password"
        }
      },
      "format": "json",
      "enveloped": true
    }
  }'
```
</Code>

</Tab>
</Tabs>
### Settings 

The following settings are available when creating a Kafka integration:

| Setting | Description |
| ------- | ----------- |
| [Source](https://ably.com/docs/platform/integrations/streaming.md#sources) | Specifies the event types being sent to Kafka. |
| [Channel filter](https://ably.com/docs/platform/integrations/streaming.md#filter) | Filters the source channels based on a regular expression. |
| Encoding | Specifies the encoding format of messages. Either JSON or MsgPack. |
| [Enveloped](https://ably.com/docs/platform/integrations/streaming.md#enveloped) | Checkbox to set whether messages should be enveloped or not. Enveloped is the default. |
| Routing key | Specifies the [routing key](https://ably.com/docs/messages.md#routing) used to route messages to Kafka topics. |
| Mechanism | The [SASL/SCRAM mechanism](#mechanism) used for Kafka connection. |
| Username | The username to connect to Kafka with. |
| Password | The password to connect to Kafka with. |
| Brokers | List of Kafka broker endpoints in the format `<host>:<port>`. |

### Authentication mechanism 

The available authentication mechanisms for Kafka are:

* [SASL/PLAIN](https://docs.confluent.io/platform/current/kafka/authentication_sasl/authentication_sasl_plain.html#kafka-sasl-auth-plain)
* [SASL/SCRAM-SHA-256](https://docs.confluent.io/platform/current/kafka/authentication_sasl/authentication_sasl_scram.html#kafka-sasl-auth-scram)
* [SASL/SCRAM-SHA-512](https://docs.confluent.io/platform/current/kafka/authentication_sasl/authentication_sasl_scram.html)

## Related Topics

- [Overview](https://ably.com/docs/platform/integrations/streaming.md): Outbound streaming integrations enable you to stream data from Ably to an external service for realtime processing.
- [Kinesis](https://ably.com/docs/platform/integrations/streaming/kinesis.md): Send data to Kinesis based on message, channel lifecycle, channel occupancy, and presence events.
- [AMQP](https://ably.com/docs/platform/integrations/streaming/amqp.md): Send data to AMQP based on message, channel lifecycle, channel occupancy, and presence events.
- [SQS](https://ably.com/docs/platform/integrations/streaming/sqs.md): Send data to SQS based on message, channel lifecycle, channel occupancy, and presence events.
- [Pulsar](https://ably.com/docs/platform/integrations/streaming/pulsar.md): Send data to Pulsar based on message, channel lifecycle, channel occupancy, and presence events.
- [DataDog](https://ably.com/docs/platform/integrations/streaming/datadog.md): Connect Ably and Datadog to monitor messages, channels, and connections in realtime, integrating your Ably statistics with your existing Datadog setup.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
