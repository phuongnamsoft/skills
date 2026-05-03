# IFTTT integration

[IFTTT](https://ifttt.com/maker_webhooks) (If This Then That) integrations enable you to trigger conditional chains, and help to combine various services together when an event occurs in Ably.

## Create a IFTTT integration 

<Tabs>
<Tab value="dashboard" label="Dashboard">

On the [Integrations](https://ably.com/accounts/any/apps/any/integrations) page of your app:

1. Click **New Integration Rule**.
2. Choose **Webhook**.
3. Choose **IFTTT**.
4. Configure the IFTTT [settings](#settings).
5. Click **Create**.

</Tab>
<Tab value="control-api" label="Control API">

Create an IFTTT rule using the Control API by sending a `POST` request to [`/apps/{app_id}/rules`](https://ably.com/docs/api/control-api.md):

<Code>

### Shell

```
curl -X POST https://control.ably.net/v1/apps/{APP_ID}/rules \
  -H "Authorization: Bearer {ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "ruleType": "http/ifttt",
    "requestMode": "single",
    "source": {
      "channelFilter": "",
      "type": "channel.message"
    },
    "target": {
      "webhookKey": "your-ifttt-webhook-key",
      "eventName": "your-event-name"
    }
  }'
```
</Code>

</Tab>
</Tabs>

### Settings 

The following settings are available when creating an IFTTT integration:

| Setting | Description |
| ------- | ----------- |
| IFTTT Webhook key | The webhook key for your IFTTT account. |
| Event name | The name used to identify the IFTTT applet. |
| [Event types](https://ably.com/docs/platform/integrations/webhooks.md#sources) | Specifies the event types being sent to IFTTT. |
| [Channel filter](https://ably.com/docs/platform/integrations/webhooks.md#filter) | Filters the source channels based on a regular expression. |
| Encoding | Specifies the encoding format of messages. Either JSON or MsgPack. |

## Restrictions 

IFTTT has limitations on the data it can process. All payloads must be `JSON` and use only the keys `value1`, `value2`, or `value3`. Any other format or additional keys will not be processed.

As a result, [enveloping](https://ably.com/docs/platform/integrations/webhooks.md#enveloped) and [batching](https://ably.com/docs/platform/integrations/webhooks.md#batching) are not supported. Additionally, protocols that require decoding such as [MQTT](https://ably.com/docs/protocols/mqtt.md), are not supported with IFTTT.

To ensure data is processed by IFTTT, it must match the required IFTTT structure. The following example shows the headers and payload sent to IFTTT when a message is sent to a channel:

<Code>

### Json

```
{
  "value1" :"data I want to send 1",
  "value2" :"data I want to send 2",
  "value3" :"data I want to send 3"
}
```
</Code>

For a [message data](https://ably.com/docs/api/realtime-sdk/messages.md#data) or [presence message data](https://ably.com/docs/api/realtime-sdk/presence.md#presence-message) of `{ "value1": "My first message", "value2": "My second message" }`, the following would be sent to your IFTTT endpoint:

Headers:

<Code>

### Text

```
host: https://maker.ifttt.com/trigger/{YOUR_EVENT}/with/key/{YOUR_IFTTT_KEY}
content-type: application/json
x-ably-envelope-appid: {YOUR_APP_ID}
x-ably-envelope-channel: {YOUR_CHANNEL}
x-ably-envelope-rule-id: {YOUR_RULE_ID}
x-ably-envelope-site: {ably-server-location}
x-ably-envelope-source: channel.message
x-ably-message-encoding: json
x-ably-message-id: {UNIQUE_ABLY_MESSAGE_ID}
x-ably-message-timestamp: {TIMESTAMP_ORIGINAL_MESSAGE_WAS_SENT}
x-ably-version: 1.2
content-length: 18
connection: keep-alive
```
</Code>

Payload:

<Code>

### Json

```
{
  "value1": "My first message",
  "value2": "My second message"
}
```
</Code>

## Related Topics

- [Overview](https://ably.com/docs/platform/integrations/webhooks.md): A guide on webhook payloads, including batched, enveloped, and non-enveloped event payloads, with decoding examples and sources.
- [Generic HTTP webhooks](https://ably.com/docs/platform/integrations/webhooks/generic.md): Configure generic HTTP webhooks to trigger HTTP endpoints and notify external services when events occur in Ably.
- [Lambda Functions](https://ably.com/docs/platform/integrations/webhooks/lambda.md): Trigger AWS Lambda functions based on message, channel lifecycle, channel occupancy, and presence events.
- [Azure Functions](https://ably.com/docs/platform/integrations/webhooks/azure.md): Trigger Microsoft Azure functions based on message, channel lifecycle, channel occupancy, and presence events.
- [Google Functions](https://ably.com/docs/platform/integrations/webhooks/gcp-function.md): Trigger Google Functions based on message, channel lifecycle, channel occupancy, and presence events.
- [Zapier](https://ably.com/docs/platform/integrations/webhooks/zapier.md): Trigger Zapier based on message, channel lifecycle, channel occupancy, and presence events.
- [Cloudflare Workers](https://ably.com/docs/platform/integrations/webhooks/cloudflare.md): Trigger Cloudflare Workers based on message, channel lifecycle, channel occupancy, and presence events.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
