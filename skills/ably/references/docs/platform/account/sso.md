# Single sign-on (SSO)

Single sign-on (SSO) enables your users to authenticate via any SAML-compatible identity provider.

## Configure 

Single sign-on is restricted to Enterprise customers only and must be enabled on a per-account basis by [contacting Ably](https://ably.com/support). Only [account owners](https://ably.com/docs/platform/account/users.md) can configure SSO for an account.

Any SAML-compatible identity provider can be used to enable SSO.

The following instructions are examples of configuring SSO with [Okta](#okta) and [Google Workspace](#google).

### Okta 

To enable SSO using [Okta](https://www.okta.com/) as the identity provider, configure the following properties in your Ably account dashboard and your Okta account:

In your Ably account dashboard:

1. Log in to your [account](https://ably.com/accounts/any).
2. Select **Settings** from the account navigation dropdown.
3. Toggle **Enable Single Sign-On** under the **Authentication Settings** section.
4. Note down the **Single sign-on URL** and **Audience URI** values.

In your Okta account:

Use the [Okta guide](https://developer.okta.com/docs/guides/saml-application-setup/overview/) for enabling SSO.

1. Upload the Ably logo.
2. Select **EmailAddress** for the **Name ID format** field.
3. Select **Email** for the **Application username** field.
4. Ably requires users' full names, so ensure **first_name** and **last_name** are populated.
5. Assign users to the newly created Okta application.
6. Note down the **Identity Provider metadata** from Okta.

In your Ably account dashboard:

1. Log in to your [account](https://ably.com/accounts/any).
2. Select **Settings** from the account navigation dropdown.
3. Complete the SSO fields with the values obtained from Okta:
    * Identity Provider Single Sign-On URL
    * Identity Provider Issuer
    * X.509 Certificate
4. Save the authentication settings.

### Google Workspace 

To enable SSO using [Google Workspace](https://workspace.google.com/) as the identity provider, configure the following properties in your Ably account dashboard and your Google Workspace:

In your Ably account dashboard:

1. Log in to your [account](https://ably.com/accounts/any).
2. Select **Settings** from the account navigation dropdown.
3. Toggle **Enable Single Sign-On** under the **Authentication Settings** section.
4. Note down the **Single sign-on URL** and **Audience URI** values.

In your Google Workspace account:

Use the [Google Workspace guide](https://support.google.com/a/answer/6087519?hl=en) for enabling SSO.

1. Upload the Ably logo.
2. Copy and paste the metadata configuration into your Ably account:
    * Identity Provider Single Sign-On URL
    * Use Entity ID from Google Workspace as the Identity Provider Issuer in your Ably account.
    * X.509 Certificate
3. Save the authentication setting changes in your Ably account.
4. Copy and paste the SAML settings from your Ably account into Google Workspace:
    * Use Single sign on URL from your Ably account as the ACS URL in Google Workspace.
    * Use SP Entity Id from your Ably account as the Entity ID in Google Workspace.
    * Use Entity ID from Google Workspace as the Identity Provider Issuer in your Ably account.
    * Select EMAIL for the Name ID format field.
    * Select Basic Information > Primary Email for the Name ID field.
5. Ably requires users' full names, so ensure first_name and last_name are populated.
6. Assign users to the newly created Google Workspace application.
7. Test the SSO connection from Google Workspace.

<Aside data-type='note'>
Google Workspace **alone** does not natively support SCIM.
</Aside>

## Strict mode 

Strict mode can be enabled to restrict access to your Ably account to only those users that authenticate with your identity provider. Users that attempt to log in using another method, such as their email address and password or a GitHub log in will be prompted to re-authenticate with your identity provider.

Strict mode ensures that Ably account access is handled by your identity provider. If a user is removed from your identity provider they will no longer be able to access the Ably account once their current session expires.

<Aside data-type='important'>
Account owners can access account resources regardless of their current authentication method.
</Aside>

To enable strict mode:

1. Log in to your [account](https://ably.com/accounts/any).
2. Select **Settings** from the account navigation dropdown.
3. Toggle **Enable Strict Mode** under the **Authentication Settings** section. This setting is only visible if SSO has been enabled.

## Related Topics

- [Overview](https://ably.com/docs/platform/account.md): Manage all aspects of your account, from 2FA and billing to user management and personal preferences. 
- [User management](https://ably.com/docs/platform/account/users.md): Learn how to manage users, user roles, and the permissions associated with each role.
- [Organizations](https://ably.com/docs/platform/account/organizations.md): Manage Ably organizations, provision users, configure SSO with SCIM, and handle account roles.
- [Two-factor authentication (2FA)](https://ably.com/docs/platform/account/2fa.md): Enable two-factor authentication for your Ably account.
- [Enterprise customization](https://ably.com/docs/platform/account/enterprise-customization.md): How Enterprise customers can create a custom endpoint and benefit from Active Traffic Management and other advanced Ably features.
- [Access tokens](https://ably.com/docs/platform/account/access-tokens.md): Create and manage access tokens to authenticate with the Ably Control API and Ably CLI, including expiration and rotation.
- [Programmatic management using Control API](https://ably.com/docs/platform/account/control-api.md): The Control API is a REST API that enables you to manage your Ably account programmatically. This is the Control API user guide.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
