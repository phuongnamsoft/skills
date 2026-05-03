# Generic HTTP webhooks

Generic HTTP webhooks enable you to trigger HTTP endpoints and notify external services when events occur in Ably. Events include when messages are published, presence events occur, changes in channel occupancy, and when channels are created or discarded. Data can be delivered individually or in batches to any HTTP endpoint.

## Create a generic HTTP webhook integration 

<Tabs>
<Tab value="dashboard" label="Dashboard">

On the [Integrations](https://ably.com/accounts/any/apps/any/integrations) page of your app:

1. Click **New Integration Rule**.
2. Choose **Webhook**.
3. Choose **Webhook**.
4. Configure the webhook [settings](#settings).
5. Click **Create**.

</Tab>
<Tab value="control-api" label="Control API">

Create a generic HTTP webhook rule using the Control API by sending a `POST` request to [`/apps/{app_id}/rules`](https://ably.com/docs/api/control-api.md):

<Code>

### Shell

```
curl -X POST https://control.ably.net/v1/apps/{APP_ID}/rules \
  -H "Authorization: Bearer {ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "ruleType": "http",
    "requestMode": "single",
    "source": {
      "channelFilter": "",
      "type": "channel.message"
    },
    "target": {
      "url": "https://example.com/webhook",
      "headers": [
        { "name": "X-Custom-Header", "value": "my-value" }
      ],
      "format": "json",
      "enveloped": true
    }
  }'
```
</Code>

</Tab>
<Tab value="cli" label="Ably CLI">

Use the [Ably CLI](https://ably.com/docs/platform/tools/cli.md) to create a generic HTTP webhook rule:

<Code>

### Shell

```
ably integrations create \
  --rule-type http \
  --source-type channel.message \
  --target-url https://example.com/webhook
```
</Code>

Run `ably integrations create --help` for a full list of available options.

</Tab>
</Tabs>

## Settings

The following settings are available when creating a generic HTTP webhook integration:

| Setting | Description |
|---------|-------------|
| URL | The HTTP/HTTPS endpoint URL where webhook requests will be sent. Ably strongly recommends using HTTPS for security. |
| Headers | Optional HTTP headers to include with each request. Use the format `key:value`, for example, `X-Custom-Header:my-value`. Each header should be on a new line. |
| Request Mode | Choose between **Single request** (sends each event individually) or **Batch request** (groups multiple events into a single request). |
| Event types | Choose which event types trigger the webhook: `channel.message`, `channel.presence`, `channel.lifecycle`, or `channel.occupancy`. |
| [Channel filter](https://ably.com/docs/platform/integrations/webhooks.md#filter) | Filters the source channels based on a regular expression. |
| Encoding | Specifies the encoding format of messages. Either JSON or MsgPack. |
| Sign with key | Choose whether to sign webhook requests with your API key for security. |
| [Enveloped](https://ably.com/docs/platform/integrations/webhooks.md#enveloped) | When enabled (default), messages are wrapped in additional metadata. When disabled, only the raw message data is sent. |

## Related Topics

- [Overview](https://ably.com/docs/platform/integrations/webhooks.md): A guide on webhook payloads, including batched, enveloped, and non-enveloped event payloads, with decoding examples and sources.
- [Lambda Functions](https://ably.com/docs/platform/integrations/webhooks/lambda.md): Trigger AWS Lambda functions based on message, channel lifecycle, channel occupancy, and presence events.
- [Azure Functions](https://ably.com/docs/platform/integrations/webhooks/azure.md): Trigger Microsoft Azure functions based on message, channel lifecycle, channel occupancy, and presence events.
- [Google Functions](https://ably.com/docs/platform/integrations/webhooks/gcp-function.md): Trigger Google Functions based on message, channel lifecycle, channel occupancy, and presence events.
- [Zapier](https://ably.com/docs/platform/integrations/webhooks/zapier.md): Trigger Zapier based on message, channel lifecycle, channel occupancy, and presence events.
- [Cloudflare Workers](https://ably.com/docs/platform/integrations/webhooks/cloudflare.md): Trigger Cloudflare Workers based on message, channel lifecycle, channel occupancy, and presence events.
- [IFTTT](https://ably.com/docs/platform/integrations/webhooks/ifttt.md): Trigger IFTTT based on message, channel lifecycle, channel occupancy, and presence events.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
