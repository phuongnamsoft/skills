# Webhook

The webhook integration enables you to implement custom moderation by configuring an HTTP endpoint that Ably will invoke before messages are published to a chat room.

This integration is useful when you want to:

* Integrate with a custom moderation service hosted on your own infrastructure.
* Implement your own moderation logic using any web server or serverless platform.
* Use a moderation provider that isn't directly supported by Ably.

## Integration setup 

Configure the integration in your [Ably dashboard](https://ably.com/accounts/any/apps/any/integrations) or using the [Control API](https://ably.com/docs/platform/account/control-api.md).

The following fields are specific to the webhook transport. You can also configure the [general fields](https://ably.com/docs/chat/moderation/custom.md#configuration).

| Field | Description |
| ----- | ----------- |
| URL | The endpoint URL that Ably will send moderation requests to. |
| Headers | Optional HTTP headers to include with requests. Use this to provide authorization credentials or other required headers. |

## Request and response 

The webhook transport uses the standard [request](https://ably.com/docs/chat/moderation/custom.md#request) and [response](https://ably.com/docs/chat/moderation/custom.md#response) formats for custom moderation.

The HTTP status code is returned directly from your endpoint's response.

## Best practice 

When implementing your webhook endpoint, consider the following:

* Keep your endpoint response time as low as possible to minimize latency.
* Implement proper error handling and logging.
* Consider implementing rate limiting if you're using a third-party moderation service.
* Use HTTPS to encrypt data in transit.
* Authenticate requests using the headers field to prevent unauthorized access to your endpoint.
* Consider implementing caching for reoccurring content.
* Monitor the API request and integration error logs in the Ably dashboard to view errors from your integration.

## Related Topics

- [API overview](https://ably.com/docs/chat/moderation/custom.md): Detect and remove unwanted content in a Chat Room using a custom provider
- [AWS Lambda](https://ably.com/docs/chat/moderation/custom/lambda.md): Detect and remove unwanted content in a Chat Room using AWS Lambda.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
