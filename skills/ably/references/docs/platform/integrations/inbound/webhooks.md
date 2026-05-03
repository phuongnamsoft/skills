# Inbound webhooks

External services can publish messages to Ably channels using the [REST API](https://ably.com/docs/api/rest-api.md), however, a simpler alternative is to use [incoming webhooks](#configure).

Many web services generate webhooks to communicate with applications. These webhooks are triggered based on interactions with their APIs or infrastructure. When a webhook request is received by Ably, its payload is published to a channel as an [unenveloped](https://ably.com/docs/api/rest-api.md#unenveloped) message.

Ably also supports [outbound webhooks](https://ably.com/docs/platform/integrations/webhooks.md), which send data from Ably to other external services such as AWS, Google Cloud Platform or Zapier.

<Aside data-type='note'>
Webhook messages are subject to rate [limits](https://ably.com/docs/platform/pricing/limits.md#integrations), similar to REST publishes.
</Aside>

## Configure an incoming webhook 

Set up incoming webhooks in the Integrations tab of the [Ably dashboard](https://ably.com/accounts/any/app/any/integrations):

1. Click **Register a new webhook endpoint**.
2. **Name** your webhook.
3. **Select an Ably channel** to receive webhook messages.
4. Click **Generate a URL**.
5. Copy the generated URL and configure your external service with it.

### Test incoming webhook 

Run the following Curl command to simulate an incoming webhook request:

<Code>

#### Shell

```
curl -X POST 'https://main.realtime.ably.net/channels/webhook-test/messages?key={{API_KEY_NAME}}:{{API_KEY_SECRET}}&enveloped=false' \
     -H 'content-type: application/json' --data '{"some":"json"}'
```
</Code>

Incoming webhooks function as REST publishes, meaning they follow the same behavior and functionality as the [REST publish API](https://ably.com/docs/api/rest-api.md#publish).

Ably responds with the `channel` and `messageId`:

<Code>

#### Json

```
{
	"channel": "webhook-test",
	"messageId": "20xxxxxxx"
}
```
</Code>

A successful request returns a `201` status. Failures return with an [`ErrorInfo`](https://ably.com/docs/api/rest-sdk/types.md#error-info) response.

## Receive webhook messages 

Incoming webhooks publish messages to an Ably channel. You can [subscribe](https://ably.com/docs/pub-sub.md#subscribe) to these messages using an Ably SDK:

<Code>

### Javascript

```
const Ably = require("ably");

const ably = new Ably.Realtime('your-api-key');
const channel = ably.channels.get('webhook-test');

channel.subscribe((message) => {
    console.log(`webhook received: ${JSON.stringify(message.data)}`);
});
```
</Code>

## Optional headers 

The request body of incoming webhooks is treated as a message to be published. If the external service allows, you can customize webhook requests by including optional headers and parameters.

The following example demonstrates how to set a message `name` using the `X-Ably-Name` header:

<Code>

### Shell

```
curl -X POST 'https://main.realtime.ably.net/channels/webhook-test/messages?key=key:secret&enveloped=false' \
     -H 'content-type: application/json' --data '{"some":"json"}' \
     -H 'X-Ably-Name: webhook-message'
```
</Code>

Then, filter messages by name:

<Code>

### Javascript

```
channel.subscribe('webhook-message', (message) => {
    console.log("webhook: " + JSON.stringify(message.data));
});
```
</Code>

To ensure that publishes are [idempotent](https://ably.com/docs/pub-sub/advanced.md#idempotency), add a unique `X-Ably-MessageId` header.

## Related Topics

- [Kafka Connector](https://ably.com/docs/platform/integrations/inbound/kafka-connector.md): The Ably Kafka Connector sends data from Kafka to an Ably channel in realtime.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
