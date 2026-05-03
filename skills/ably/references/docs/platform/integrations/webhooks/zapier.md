# Zapier integration

[Zapier](https://zapier.com/page/webhooks) integrations enable you to trigger Zapier Zaps when an event occurs in Ably. They are useful for integrating with thousands of other services using Zapier's webhooks feature.

## Create a Zapier integration 

<Tabs>
<Tab value="dashboard" label="Dashboard">

On the [Integrations](https://ably.com/accounts/any/apps/any/integrations) page of your app:

1. Click **New Integration Rule**.
2. Choose **Webhook**.
3. Choose **Zapier**.
4. Configure the Zapier [settings](#settings).
5. Click **Create**.

</Tab>
<Tab value="control-api" label="Control API">

Create a Zapier rule using the Control API by sending a `POST` request to [`/apps/{app_id}/rules`](https://ably.com/docs/api/control-api.md):

<Code>

### Shell

```
curl -X POST https://control.ably.net/v1/apps/{APP_ID}/rules \
  -H "Authorization: Bearer {ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "ruleType": "http/zapier",
    "requestMode": "single",
    "source": {
      "channelFilter": "",
      "type": "channel.message"
    },
    "target": {
      "url": "https://hooks.zapier.com/hooks/catch/123456/abcdef/"
    }
  }'
```
</Code>

</Tab>
</Tabs>

### Settings 

The following settings are available when creating a Zapier integration:

| Setting | Description |
| ------- | ----------- |
| URL | The Zapier webhook URL to POST a summary of events to. |
| Headers | Allows the inclusion of additional information in key-value format. |
| Request Mode | Choose between **Single Request** or **Batch Request**. |
| [Event types](https://ably.com/docs/platform/integrations/webhooks.md#sources) | Specifies the event types being sent to Zapier. |
| [Channel filter](https://ably.com/docs/platform/integrations/webhooks.md#filter) | Filters the source channels based on a regular expression. |
| Encoding | Specifies the encoding format of messages. Either JSON or MsgPack. |
| [Enveloped](https://ably.com/docs/platform/integrations/webhooks.md#enveloped) | Checkbox to set whether messages should be enveloped or not. Enveloped is the default. Only available when `Request Mode` is set to `Single`. |
| Sign with key | Payloads will be signed with an API key so they can be validated by your servers. Only available when `Request Mode` is set to `Batched`. |

## Related Topics

- [Overview](https://ably.com/docs/platform/integrations/webhooks.md): A guide on webhook payloads, including batched, enveloped, and non-enveloped event payloads, with decoding examples and sources.
- [Generic HTTP webhooks](https://ably.com/docs/platform/integrations/webhooks/generic.md): Configure generic HTTP webhooks to trigger HTTP endpoints and notify external services when events occur in Ably.
- [Lambda Functions](https://ably.com/docs/platform/integrations/webhooks/lambda.md): Trigger AWS Lambda functions based on message, channel lifecycle, channel occupancy, and presence events.
- [Azure Functions](https://ably.com/docs/platform/integrations/webhooks/azure.md): Trigger Microsoft Azure functions based on message, channel lifecycle, channel occupancy, and presence events.
- [Google Functions](https://ably.com/docs/platform/integrations/webhooks/gcp-function.md): Trigger Google Functions based on message, channel lifecycle, channel occupancy, and presence events.
- [Cloudflare Workers](https://ably.com/docs/platform/integrations/webhooks/cloudflare.md): Trigger Cloudflare Workers based on message, channel lifecycle, channel occupancy, and presence events.
- [IFTTT](https://ably.com/docs/platform/integrations/webhooks/ifttt.md): Trigger IFTTT based on message, channel lifecycle, channel occupancy, and presence events.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
