# Deprecation policy

Ably's SDKs are regularly updated to add support for new features, bugfixes, and to accommodate version or API changes in dependencies. Whilst Ably ensures changes are backwards-compatible wherever possible, there are some instances where the previous API structure is no longer suitable.

In all cases, updates to SDKs conform to [semantic versioning](https://semver.org/) guidelines. It is recommended that you always update to the latest version of an SDK when it is available.

## Applicability 

This policy applies to the following:

Ably SDKs and associated APIs, including;

* HTTP APIs
* Ably's realtime protocol

## Deprecation timelines 

Ably will support all releases for at least 12 months from the date of release of a version that supersedes it. For example, if version `1.1.0` is released on 1st January 2025, version `1.0.X` will be supported until at least 1st January 2026.

Releases will be always be deprecated within 24 months of being superseded.

### Sunset date 

The sunset date is the date on which a version of an SDK or API will no longer function, at the end of the deprecation period. Ably will usually sunset features by a process of rejecting just a (gradually increasing) proportion of requests to avoid large-scale disruption where possible. However, this won't always be the case, so you should assume that features or versions will stop working on the sunset date.

## Supportability 

Ably will no longer provide the following when a version is deprecated:

* Technical support for that version.
* Bugfixes for that version.

Ably also reserves the right to withhold Service Level Agreement (SLA) remedies in the case of service failure, if the use of the deprecated version is believed to be a contributing factor in that failure.

## Related Topics

- [Nov 2025 - Protocol v1](https://ably.com/docs/platform/deprecate/protocol-v1.md): A policy detailing how Ably deprecates SDKs and APIs.
- [June 2025 - TLS v1.0 and v1.1](https://ably.com/docs/platform/deprecate/tls-v1-1.md): A policy detailing how Ably is deprecating support for TLS 1.0 and 1.1.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
