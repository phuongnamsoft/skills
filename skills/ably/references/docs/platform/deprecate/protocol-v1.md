# Deprecation of protocol version 1 - November 2025

SDKs using version 1 of Ably's realtime protocol will be sunset on 1st November 2025.

This version was superseded by version 2 in January 2023. It introduced new functionality, with a more efficient and scalable backend implementation. New features are not available using version 1 of the protocol, nor in any SDKs implementing it.

## Affected SDKs 

SDK versions earlier than those listed below are now considered deprecated. If you are using a version older than those listed, upgrade before the 1st November 2025.

| Product | Language | Versions |
| ------- | -------- | -------- |
| Pub/Sub | JavaScript | [`<= 1.2.36`](https://github.com/ably/ably-js/releases/tag/1.2.36) |
| Pub/Sub | Java | [`<= 1.2.35`](https://github.com/ably/ably-java/releases/tag/v1.2.35) |
| Pub/Sub | Swift / Objective-C | [`<= 1.2.24`](https://github.com/ably/ably-cocoa/releases/tag/1.2.24) |
| Pub/Sub | .NET | [`<= 1.2.12`](https://github.com/ably/ably-dotnet/releases/tag/1.2.12) |
| Pub/Sub | Go | [`<= 1.2.14`](https://github.com/ably/ably-go/releases/tag/v1.2.14) |
| Pub/Sub | Python | [`<= 2.0.0-beta.6`](https://github.com/ably/ably-python/releases/tag/v2.0.0-beta.6) |
| Pub/Sub | Ruby | [`<= 1.2.5`](https://github.com/ably/ably-ruby/releases/tag/v1.2.5) |
| Pub/Sub | PHP | [`<= 1.1.9`](https://github.com/ably/ably-php/releases/tag/1.1.9) |
| Pub/Sub | Flutter | [`<= 1.2.25`](https://github.com/ably/ably-flutter/releases/tag/v1.2.25) |
| Kafka Connect | - | [`<= 2.1.4`](https://github.com/ably/kafka-connect-ably/releases/tag/v2.1.4) |

Contact [support](https://ably.com/support) if you have any questions.

## Request failures 

On the 1st November 2025 attempts to connect to Ably using an SDK that uses version 1 of the protocol will start to fail. Failures will be phased, with only a fraction of traffic being rejected at first, until 100% of requests are rejected after several weeks.

Requests that are rejected will contain an error message and code referencing this deprecation notice and the associated [deprecation policy.](https://ably.com/docs/platform/deprecate.md)

## Related Topics

- [Policy](https://ably.com/docs/platform/deprecate.md): A policy detailing how Ably deprecates SDKs and APIs.
- [June 2025 - TLS v1.0 and v1.1](https://ably.com/docs/platform/deprecate/tls-v1-1.md): A policy detailing how Ably is deprecating support for TLS 1.0 and 1.1.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
