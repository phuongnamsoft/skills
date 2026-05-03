# Hive (Model Only)

[Hive Moderation](https://hivemoderation.com) is a powerful suite of moderation tools that can be used to moderate content in chat rooms.

The Hive (model only) rule is a rule applied to chat rooms in Ably Chat which enables you to use [Hive's text moderation models](https://hivemoderation.com/text-moderation) to detect and handle inappropriate content before it is published to other users.

## Integration setup 

Configure the integration rule in your [Ably dashboard](https://ably.com/accounts/any/apps/any/integrations) or using the [Control API](https://ably.com/docs/platform/account/control-api.md).

The following are the fields specific to Hive (model only) configuration:

| Field | Description |
| ----- | ----------- |
| Hive API key | The API key for your Hive account. |
| Thresholds | A map of text [text moderation classes](https://docs.thehive.ai/reference/text-moderation) to [severity](https://docs.thehive.ai/docs/detailed-class-descriptions-text-moderation). When moderating text, any message deemed to be at or above a specified threshold will be rejected and not published to the chat room. |
| Model URL (optional) | A custom URL if using a custom moderation model. |

For additional configuration options shared across all before-publish moderation rules, see the [common configuration fields](https://ably.com/docs/chat/moderation.md#common-config).

## Text length 

Hive's models accept content with a maximum length of 1024 characters. If sending a message larger than this, Ably will automatically break the text into smaller requests, with crossover between segments to ensure context is preserved.

Ably will aggregate the model responses, rejecting the message as a whole if one or more of the text segments fail to pass the threshold requirements.

## Handling rejections 

If a message fails moderation and the rule policy is to reject, then it will be rejected by the server.

Moderation rejections will use error code `42213`.

## Related Topics

- [Hive (Dashboard)](https://ably.com/docs/chat/moderation/direct/hive-dashboard.md): Detect and remove unwanted content in a Chat Room using Hive AI, providing human moderators a place to review and act on content.
- [Tisane](https://ably.com/docs/chat/moderation/direct/tisane.md): Detect and remove unwanted content in a Chat Room using Tisane AI.
- [Bodyguard](https://ably.com/docs/chat/moderation/direct/bodyguard.md): Detect and remove unwanted content in a Chat Room using Bodyguard AI.
- [Azure Content Safety](https://ably.com/docs/chat/moderation/direct/azure.md): Detect and remove unwanted content in a Chat Room using Azure Content Safety.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
