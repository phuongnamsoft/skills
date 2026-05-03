# Two-factor authentication (2FA)

Two-factor authentication (2FA) is an authentication process requiring users to utilize two different forms of verification. 2FA for your Ably account requires your password and a security token sent to your mobile phone.

## Enable 2FA 

To enable 2FA for your own user login:

1. Log in to your [account](https://ably.com/accounts/any).
2. Select **My Settings** from the account navigation dropdown.
3. Toggle **Enable Two-Factor Authentication** under the **Two-factor authentication** section.
    * Re-enter your password as prompted.
4. Select your **Country**.
5. Enter your **Phone number**
6. Click **Next** to receive an SMS with a security token.
7. Enter the security token and click **Verify security code**.
8. Scan the QR code into an authenticator app such as Authy, or Google Authenticator.
9. Store your recovery codes in a safe location.

### Disable 2FA 

To disable 2FA for your own user login:

1. Log in to your [account](https://ably.com/accounts/any).
2. Select **My Settings** from the account navigation dropdown.
3. Click the **Disable Two-Factor Authentication** button.
    * Re-enter your password as prompted.

### Change phone number 

Disable and re-enable 2FA in order to update your phone number.

### SMS and TOTP 2FA 

Disable and re-enable 2FA in order to switch between SMS 2FA and TOTP (time-based one-time password) 2FA.

## Enforce 2FA for all users 

[Account owners](https://ably.com/docs/platform/account/users.md) can require 2FA to be utilized by all users. Any user that hasn't already enabled 2FA will be prompted to do so the next time they attempt to access the account.

<Aside data-type='note'>
The account owner must already have 2FA enabled for their own login before they can enforce it account-wide.
</Aside>

To enforce 2FA for all users:

1. Log in to your [account](https://ably.com/accounts/any).
2. Select **Settings** from the account navigation dropdown.
3. Toggle **Require Two-Factor Authentication for all account users** under the **Authentication Settings** section.
4. **Save** the authentication settings.

### Remove 2FA requirement of all users 

To remove the requirement for all users to authenticate with 2FA:

1. Log in to your [account](https://ably.com/accounts/any).
2. Select **Settings** from the account navigation dropdown.
3. Toggle **Require Two-Factor Authentication for all account users** under the **Authentication Settings** section.
4. **Save** the authentication settings.

## Related Topics

- [Overview](https://ably.com/docs/platform/account.md): Manage all aspects of your account, from 2FA and billing to user management and personal preferences. 
- [User management](https://ably.com/docs/platform/account/users.md): Learn how to manage users, user roles, and the permissions associated with each role.
- [Organizations](https://ably.com/docs/platform/account/organizations.md): Manage Ably organizations, provision users, configure SSO with SCIM, and handle account roles.
- [Single sign-on (SSO)](https://ably.com/docs/platform/account/sso.md): Single sign-on enables users to authenticate with Ably using your own identity provider.
- [Enterprise customization](https://ably.com/docs/platform/account/enterprise-customization.md): How Enterprise customers can create a custom endpoint and benefit from Active Traffic Management and other advanced Ably features.
- [Access tokens](https://ably.com/docs/platform/account/access-tokens.md): Create and manage access tokens to authenticate with the Ably Control API and Ably CLI, including expiration and rotation.
- [Programmatic management using Control API](https://ably.com/docs/platform/account/control-api.md): The Control API is a REST API that enables you to manage your Ably account programmatically. This is the Control API user guide.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
