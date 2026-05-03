# Deprecation of TLS 1.0 and 1.1 - June 2025

Support for TLS (Transport Layer Security) versions 1.0 and 1.1 will be sunset on 1st June 2025.

As part of Ably's ongoing commitment to ensure the highest standards of security and performance, support for older TLS versions across the service will be deprecated. After this date, all connections to Ably must use TLS 1.2 or higher.

## Impact 

After 1st June 2025, requests using TLS 1.0 or 1.1 may be refused. This affects all connections to Ably's services, including:

* Realtime and WebSocket connections
* REST API calls
* Any other service that communicates with Ably

## Error messages 

When attempting to connect using TLS 1.0 or 1.1, you may receive a TLS protocol version error. The error message will reference `protocol_version` to indicate that the TLS version is not supported.

## Recommended actions 

* **Verify compatibility:** Ensure that your systems, applications, and integrations are configured to support TLS 1.2 or higher.
* **Update legacy systems:** If you are using older platforms, consult with your IT team or integration partners to update any components that still rely on TLS 1.0 or 1.1.

For customers who have a custom environment or active traffic management enabled, Ably can update your settings at any time.

## Request failures 

From 1st June 2025, attempts to connect to Ably using TLS 1.0 or 1.1 may start to fail. Failures will be phased, with only a fraction of traffic being rejected at first, until 100% of requests are rejected after several weeks.

Requests that are rejected will contain an error message and code referencing this deprecation notice and the associated [deprecation policy.](https://ably.com/docs/platform/deprecate.md)

Contact [support](https://ably.com/support) if you have any questions.

## Related Topics

- [Policy](https://ably.com/docs/platform/deprecate.md): A policy detailing how Ably deprecates SDKs and APIs.
- [Nov 2025 - Protocol v1](https://ably.com/docs/platform/deprecate/protocol-v1.md): A policy detailing how Ably deprecates SDKs and APIs.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
