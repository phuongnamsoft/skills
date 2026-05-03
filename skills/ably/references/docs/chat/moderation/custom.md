# Custom Moderation

There may be situations where you have trained your own model, or you want to apply proprietary logic using your own infrastructure, whilst performing moderation.

Ably provides simple APIs to allow your moderation logic to prevent harmful content from being present in your chat room.

## Before publish 

Before publish moderation is where your moderation logic is invoked before the message is published to your chat room. This has the benefit of preventing harmful content from ever entering your chat room, at the cost of some latency in invoking your moderation logic as part of the publish path.

### Integration configuration 

To fine-tune how Ably handles messages according to your use-case, see the [common configuration fields](https://ably.com/docs/chat/moderation.md#common-config) shared across all before-publish moderation rules.

### The API 

Ably provides a simple API for integrations to moderate chat messages. There are some nuances for particular transports, which can be seen on the individual transports page.

#### Request format 

The request has the following JSON format.

<Code>

##### Json

```
{
  "source": "string",
  "appId": "string",
  "room": "string",
  "site": "string",
  "ruleId": "string",
  "message": {
    "clientId": "string",
    "text": "string",
    "metadata": {
      "key": "any"
    },
    "headers": {
      "key": "string"
    },
    "userClaim": "string (optional)"
  }
}
```
</Code>

#### Response format 

<Code>

##### Json

```
{
  "action": "accept|reject",
  "rejectionDetail": {
    "key": "string"
  }
}
```
</Code>

* `action`: Must be either `accept` or `reject`. `accept` means that the message will be published to the chat room, `reject` means it will be rejected.
* `rejectionDetail`: Optional. If provided with `action: "reject"`, a map of string key-value pairs containing structured information about why the message was rejected. Both keys and values must be strings. This information may be sent back to clients via the `ErrorInfo.detail` field. The total response payload must not exceed 32 KiB in size.

### Error handling 

If moderation was performed as expected, regardless of the outcome, your endpoint MUST return a status code of `200`. For other codes, Ably will take the following action:

| Code | Description |
| ---- | ----------- |
| 4xx (excluding 429) | Ably will not retry moderation. The message will be handled according to your rule configuration. |
| 429 | Ably will only retry if your rule configuration permits retries in the `429 Too Many Requests` case. |
| 5xx | Ably will retry moderation with backoff, until it either succeeds, or the retry window is exceeded. |

If, by the end of the retry window, Ably has not been able to get a definitive moderation answer from your endpoint, the action we take next will depend on your rule configuration. If you have elected to publish the message anyway, we will do so. You can always remove harmful content in hindsight using human moderators or community reporting schemes. Alternatively, you may have elected to reject the message. If this is the case, Ably will not publish the message.

## After publish 

After publish moderation is where your moderation logic is invoked after a message is published to the chat room. In this configuration, harmful content may briefly be visible in the room, although most moderation engines are able to process content and instruct its removal almost instantaneously. This configuration is helpful when you need to prioritize latency and performance.

There isn't currently a chat-specific custom API for after publish moderation.

However, you can still use standard Ably [integration rules](https://ably.com/docs/platform/integrations.md) to send chat messages to your infrastructure and then remove any offending content with the REST API.

## Related Topics

- [AWS Lambda](https://ably.com/docs/chat/moderation/custom/lambda.md): Detect and remove unwanted content in a Chat Room using AWS Lambda.
- [Webhook](https://ably.com/docs/chat/moderation/custom/webhook.md): Detect and remove unwanted content in a Chat Room using a custom webhook endpoint.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
