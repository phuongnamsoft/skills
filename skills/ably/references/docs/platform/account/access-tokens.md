# Access tokens

Access tokens authenticate requests to the [Control API](https://ably.com/docs/platform/account/control-api.md) and the [Ably CLI](https://ably.com/docs/platform/tools/cli.md). They are scoped to a specific account and grant a configurable set of capabilities. Manage your tokens from the [Access tokens](https://ably.com/users/access_tokens) page in the Ably dashboard.

## Create an access token 

You must be an account admin to create access tokens. If you don't see the "Create new token" button, contact your account administrator.

To create a new access token:

1. Go to the [Access tokens](https://ably.com/users/access_tokens) page in the Ably dashboard.
2. Click **Create new token**.
3. Enter a **Name** for the token. This is for your reference only and is not used in API requests.
4. Select the **Account** the token is scoped to. This is auto-selected if you only have one account.
5. Select an **Expiry** period for the token. Choose from 30 days, 60 days, 90 days, or no expiration. The default is 30 days.
6. Select the **Capabilities** the token requires. Capabilities are grouped into categories such as Apps, Keys, Rules, Queues, Namespaces, and Statistics. Each category has individual read and write checkboxes, and a "Select all" toggle.
7. Click **Create token**.

<Aside data-type='important'>
Copy your access token immediately after creation. The full token is only displayed once and cannot be retrieved later. Only the token ID is visible after you navigate away.
</Aside>

## Access token capabilities 

Capabilities control which operations the token can perform in the Control API and CLI. The dashboard displays human-readable labels such as "Read App". The raw format such as `read:app` appears in API responses and JWTs.

| Dashboard label | API capability | Control API | CLI commands |
| --- | --- | --- | --- |
| Read App | `read:app` | [List](https://ably.com/docs/api/control-api.md#tag/apps/paths/~1accounts~1{account_id}~1apps/get) apps | `ably apps list` |
| Write App | `write:app` | [Create](https://ably.com/docs/api/control-api.md#tag/apps/paths/~1accounts~1{account_id}~1apps/post), [update](https://ably.com/docs/api/control-api.md#tag/apps/paths/~1apps~1{id}/patch), and [delete](https://ably.com/docs/api/control-api.md#tag/apps/paths/~1apps~1{id}/delete) apps | `ably apps create`, `ably apps update`, `ably apps delete` |
| Read Key | `read:key` | [List](https://ably.com/docs/api/control-api.md#tag/keys/paths/~1apps~1{app_id}~1keys/get) API keys for an app | `ably auth keys list`, `ably auth keys get` |
| Write Key | `write:key` | [Create](https://ably.com/docs/api/control-api.md#tag/keys/paths/~1apps~1{app_id}~1keys/post), [update](https://ably.com/docs/api/control-api.md#tag/keys/paths/~1apps~1{app_id}~1keys~1{key_id}/patch), and [revoke](https://ably.com/docs/api/control-api.md#tag/keys/paths/~1apps~1{app_id}~1keys~1{key_id}~1revoke/post) API keys | `ably auth keys create`, `ably auth keys update`, `ably auth keys revoke` |
| Read Integration | `read:rule` | [List](https://ably.com/docs/api/control-api.md#tag/rules/paths/~1apps~1{app_id}~1rules/get) and [get](https://ably.com/docs/api/control-api.md#tag/rules/paths/~1apps~1{app_id}~1rules~1{rule_id}/get) integration rules | `ably integrations list`, `ably integrations get` |
| Write Integration | `write:rule` | [Create](https://ably.com/docs/api/control-api.md#tag/rules/paths/~1apps~1{app_id}~1rules/post), [update](https://ably.com/docs/api/control-api.md#tag/rules/paths/~1apps~1{app_id}~1rules~1{rule_id}/patch), and [delete](https://ably.com/docs/api/control-api.md#tag/rules/paths/~1apps~1{app_id}~1rules~1{rule_id}/delete) integration rules | `ably integrations create`, `ably integrations update`, `ably integrations delete` |
| Read Queue | `read:queue` | [List](https://ably.com/docs/api/control-api.md#tag/queues/paths/~1apps~1{app_id}~1queues/get) queues for an app | `ably queues list` |
| Write Queue | `write:queue` | [Create](https://ably.com/docs/api/control-api.md#tag/queues/paths/~1apps~1{app_id}~1queues/post) and [delete](https://ably.com/docs/api/control-api.md#tag/queues/paths/~1apps~1{app_id}~1queues~1{queue_id}/delete) queues | `ably queues create`, `ably queues delete` |
| Read Rule | `read:namespace` | [List](https://ably.com/docs/api/control-api.md#tag/namespaces/paths/~1apps~1{app_id}~1namespaces/get) rules for an app | `ably apps channel-rules list` |
| Write Rule | `write:namespace` | [Create](https://ably.com/docs/api/control-api.md#tag/namespaces/paths/~1apps~1{app_id}~1namespaces/post), [update](https://ably.com/docs/api/control-api.md#tag/namespaces/paths/~1apps~1{app_id}~1namespaces~1{namespace_id}/patch), and [delete](https://ably.com/docs/api/control-api.md#tag/namespaces/paths/~1apps~1{app_id}~1namespaces~1{namespace_id}/delete) rules | `ably apps channel-rules create`, `ably apps channel-rules update`, `ably apps channel-rules delete` |
| Read Stats | `read:stats` | [Account](https://ably.com/docs/api/control-api.md#tag/accounts/paths/~1accounts~1{id}~1stats/get) and [app](https://ably.com/docs/api/control-api.md#tag/apps/paths/~1apps~1{id}~1stats/get) statistics | `ably stats account`, `ably stats app` |

## Token expiration 

Access tokens can have an expiration date. When a token expires, any request that uses it receives a `401 Unauthorized` response from the Control API, and the token can no longer authenticate CLI commands.

The expiry period is set when you create a token. The available options are:

* 30 days
* 60 days
* 90 days
* No expiration

The default expiry is 30 days. Ably recommends setting an expiry period so that tokens are rotated periodically. Selecting "No expiration" means the token remains valid indefinitely unless revoked. The expiration date is visible in the token list on the [Access tokens](https://ably.com/users/access_tokens) page.
<Aside data-type='note'>
Ably sends reminder emails 7 days and 1 day before a token expires. Use these reminders to rotate or replace tokens before they expire.
</Aside>

## Rotate an access token 

Rotating an access token regenerates its value while preserving the token name, capabilities, and account association. Use rotation to replace a token that is approaching expiration or if the token value may have been exposed.

You must be an account admin to rotate access tokens.

To rotate a token:

1. Go to the [Access tokens](https://ably.com/users/access_tokens) page in the Ably dashboard.
2. Click the rotate icon next to the token you want to rotate.
3. Select a new **Expiry** period for the rotated token.
4. Click **Confirm** to complete the rotation.

The previous token value is invalidated immediately. Any systems using the old value must be updated with the new token.

<Aside data-type='important'>
Copy the new token value immediately after rotation. As with token creation, the full token is only displayed once and cannot be retrieved later.
</Aside>

## Revoke an access token 

Revoke an access token from the [Access tokens](https://ably.com/users/access_tokens) page by clicking the delete icon next to the token. Revocation is immediate and irreversible. Any requests using that token will fail.

## Rate limits 

The Control API limits the number of requests per account and per access token per hour. See [API limits](https://ably.com/docs/platform/pricing/limits.md#api) for details.

## Related Topics

- [Overview](https://ably.com/docs/platform/account.md): Manage all aspects of your account, from 2FA and billing to user management and personal preferences. 
- [User management](https://ably.com/docs/platform/account/users.md): Learn how to manage users, user roles, and the permissions associated with each role.
- [Organizations](https://ably.com/docs/platform/account/organizations.md): Manage Ably organizations, provision users, configure SSO with SCIM, and handle account roles.
- [Single sign-on (SSO)](https://ably.com/docs/platform/account/sso.md): Single sign-on enables users to authenticate with Ably using your own identity provider.
- [Two-factor authentication (2FA)](https://ably.com/docs/platform/account/2fa.md): Enable two-factor authentication for your Ably account.
- [Enterprise customization](https://ably.com/docs/platform/account/enterprise-customization.md): How Enterprise customers can create a custom endpoint and benefit from Active Traffic Management and other advanced Ably features.
- [Programmatic management using Control API](https://ably.com/docs/platform/account/control-api.md): The Control API is a REST API that enables you to manage your Ably account programmatically. This is the Control API user guide.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
