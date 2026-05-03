# Bodyguard

[Bodyguard](https://bodyguard.ai/) is a powerful contextual analysis platform that can be used to moderate content in chat rooms.

The Bodyguard integration can be applied to chat rooms so that you can use Bodyguard's content moderation capabilities to detect and handle inappropriate content before it's published to other users.

## Integration setup 

Configure the integration in your [Ably dashboard](https://ably.com/accounts/any/apps/any/integrations) or using the [Control API](https://ably.com/docs/platform/account/control-api.md).

The following fields are specific to Bodyguard configuration:

| Field | Description |
| ----- | ----------- |
| Bodyguard API key | The API key for your Bodyguard account. |
| Channel ID | The ID of your Bodyguard channel where moderation rules are configured. |
| Default Language (optional) | The default language to use for content analysis. This will be used as a fallback in case automatic language detection fails. |
| Model URL (optional) | A custom URL if using a custom moderation model. |

For additional configuration options shared across all before-publish moderation rules, see the [common configuration fields](https://ably.com/docs/chat/moderation.md#common-config).

Messages will be rejected if Bodyguard's analysis returns a `REMOVE` recommended action based on the moderation rules configured in your Bodyguard channel.

## Handling rejections 

Messages are rejected when they fail Bodyguard's analysis. Bodyguard returns a REMOVE action in these instances and the messages will not be published to your channel. The publish request will be rejected. Moderation rejections will use the error code `42213`.

## Related Topics

- [Hive (Model Only)](https://ably.com/docs/chat/moderation/direct/hive-model-only.md): Detect and remove unwanted content in a Chat Room using Hive AI.
- [Hive (Dashboard)](https://ably.com/docs/chat/moderation/direct/hive-dashboard.md): Detect and remove unwanted content in a Chat Room using Hive AI, providing human moderators a place to review and act on content.
- [Tisane](https://ably.com/docs/chat/moderation/direct/tisane.md): Detect and remove unwanted content in a Chat Room using Tisane AI.
- [Azure Content Safety](https://ably.com/docs/chat/moderation/direct/azure.md): Detect and remove unwanted content in a Chat Room using Azure Content Safety.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
