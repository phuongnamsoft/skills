# Tisane

[Tisane](https://tisane.ai/) is a powerful Natural Language Understanding (NLU) platform that can be used to moderate content in chat rooms.

The Tisane integration can be applied to chat rooms so that you can use Tisane's text moderation capabilities to detect and handle inappropriate content before it's published to other users.

## Integration setup 

Configure the integration in your [Ably dashboard](https://ably.com/accounts/any/apps/any/integrations) or using the [Control API](https://ably.com/docs/platform/account/control-api.md).

The following are the fields specific to Tisane configuration:

| Field | Description |
| ----- | ----------- |
| Tisane API key | The API key for your Tisane account. |
| Thresholds | A map of [text moderation categories](https://docs.tisane.ai/apis/tisane-api-response-guide#supported-types) to severity levels (`low`, `medium`, `high`, `extreme`). When moderating text, any message deemed to be at or above a specified threshold will be rejected and not published to the chat room. |
| Default Language | The language to use for content analysis. |
| Model URL (optional) | A custom URL if using a custom moderation model. |

For additional configuration options shared across all before-publish moderation rules, see the [common configuration fields](https://ably.com/docs/chat/moderation.md#common-config).

## Handling rejections 

If a message fails moderation the message will not be published and the publish request will be rejected.

Moderation rejections will use error code `42213`.

## Related Topics

- [Hive (Model Only)](https://ably.com/docs/chat/moderation/direct/hive-model-only.md): Detect and remove unwanted content in a Chat Room using Hive AI.
- [Hive (Dashboard)](https://ably.com/docs/chat/moderation/direct/hive-dashboard.md): Detect and remove unwanted content in a Chat Room using Hive AI, providing human moderators a place to review and act on content.
- [Bodyguard](https://ably.com/docs/chat/moderation/direct/bodyguard.md): Detect and remove unwanted content in a Chat Room using Bodyguard AI.
- [Azure Content Safety](https://ably.com/docs/chat/moderation/direct/azure.md): Detect and remove unwanted content in a Chat Room using Azure Content Safety.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
