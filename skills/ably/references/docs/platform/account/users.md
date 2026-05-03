# User management

The user that creates an Ably account is assigned the account owner role. An account owner has permission to undertake any action within an account, such as inviting new users. There are two other account roles that inherit a subset of an account owner's permissions. An account can only have a single account owner.

## User roles 

Users can be assigned to the following roles. Each user may be assigned multiple roles:

* Developer
* Billing
* Admin
* Owner

User roles have the following permissions:

| Permission | Developer | Billing | Admin | Owner |
|------------|-----------|---------|-------|-------|
| View all apps | ✓ | ✓ | ✓ | ✓ |
| View app configuration | ✓ | - | ✓ | ✓ |
| View app settings | ✓ | - | ✓ | ✓ |
| View [app statistics](https://ably.com/docs/metadata-stats/stats.md#app) | ✓ | ✓ | ✓ | ✓ |
| View [account statistics](https://ably.com/docs/metadata-stats/stats.md#account) | ✓ | ✓ | ✓ | ✓ |
| Configure own [2FA](https://ably.com/docs/platform/account/2fa.md) | ✓ | - | ✓ | ✓ |
| [Invite new users](#invite) | - | - | ✓ | ✓ |
| [Remove existing users](#remove) | - | - | ✓ | ✓ |
| Manage [API keys](https://ably.com/docs/auth.md) | - | - | ✓ | ✓ |
| Manage app configuration | - | - | ✓ | ✓ |
| Manage app settings | - | - | ✓ | ✓ |
| Create apps | - | - | ✓ | ✓ |
| Receive [limit notifications](https://ably.com/docs/platform/pricing/limits.md) | - | - | ✓ | ✓ |
| Configure [single sign-on](https://ably.com/docs/platform/account/sso.md) | - | - | - | ✓ |
| Enforce [2FA](https://ably.com/docs/platform/account/2fa.md#enforce) | - | - | - | ✓ |
| View invoices | - | ✓ | - | ✓ |
| Update billing information | - | ✓ | - | ✓ |
| Manage [account package](https://ably.com/pricing) | - | - | - | ✓ |

### Change user roles 

The following steps add or remove roles from a user within an Ably account. You must be an account owner or admin to change user roles:

1. Log in to your [account](https://ably.com/accounts/any).
2. Select Users from the account navigation dropdown.
3. Click the checkboxes corresponding to the roles you want to add or remove.

<Aside data-type='note'>
Follow [this process](https://faqs.ably.com/can-i-change-my-ably-account-owner) to transfer account ownership.
</Aside>

## Invite a new user 

The following steps invite a new user to your account. You must be an account owner or admin to invite new users:

1. Log in to your [account](https://ably.com/accounts/any).
2. Select Users from the account navigation dropdown.
3. Click Invite new user.
4. Enter the user's first name and email address, then click Invite.
5. The user can then follow the instructions emailed to them to join your account.

<Aside data-type='note'>
You can view the status of pending invitations from the Users page. You can also re-send or revoke an invitation.
</Aside>

## Remove users from an account 

The following steps remove a user from your account. You must be an account owner or admin to remove users:

1. Log in to your [account](https://ably.com/accounts/any).
2. Select Users from the account navigation dropdown.
3. Click the Remove button next to the user to remove from the account.
4. Confirm the action when prompted.

## Delete your profile or leave an account 

The following steps delete your profile or remove yourself from an Ably account:

1. Log in to your [account](https://ably.com/accounts/any).
2. Go to [My Settings](https://ably.com/users/edit).
3. [Disconnect SSO provider](#sso) if you use SSO to log in.
4. Scroll to Want to delete your profile?
5. Click Start to remove yourself from this account.

<Aside data-type='important'>
**Account owners:** Deleting your profile will delete the entire account and all data. You must first [transfer ownership](https://faqs.ably.com/can-i-change-my-ably-account-owner) to another user before deleting your profile.
</Aside>

## Close your account 

To close your Ably account, you must be the account owner and have downgraded to the Free package. The following steps outline the process to close your account:

1. Log in to your [Ably account](https://ably.com/accounts/any).
2. Confirm that you are the [account owner](https://ably.com/docs/platform/account/users.md#roles).
3. Ensure you are the account [owner](https://ably.com/docs/platform/account/users.md#roles).
4. [Downgrade your current package](https://ably.com/docs/platform/pricing/free.md#downgrade) to Free.

<Aside data-type='note'>
You will not be able to delete your account until the 1st of the month following your downgrade, after your final invoice has been paid.
</Aside>

5. [Disconnect SSO provider](#sso) if you use SSO to log in.
6. Go to your [My Settings](https://ably.com/users/edit) page.
7. Scroll to Want to delete your profile?

<Aside data-type='note'>
If you are using an SSO login you'll see a Contact us link instead of a Start button. You'll need to [disconnect your SSO provider](#sso) first.
</Aside>

8. Click Start to proceed with permanently closing your account.
9. On the proceeding Close Your Ably Account page, review the accounts for closure.
10. Click Close Account to permanently deactivate your account.

### Disconnect SSO provider 

If you use SSO (Single Sign-On) to log in to your Ably account, you must first set a password and disconnect your SSO provider before closing your account. The self-service account closure process requires a password to authenticate the closure request. The following steps set a password and disconnect your SSO provider:

1. Log in to your [account](https://ably.com/accounts/any) using your current SSO method (Google or GitHub).
2. Navigate to Account then [My Settings.](https://ably.com/users/edit)
3. In the Password section, click Change your password.
4. Click Update my personal settings to save the changes.
5. Scroll to the Login provider section.
6. Click remove connection next to the SSO provider/s you want to disconnect.
7. After completing these steps, return to the instructions above to [close your account](#close).

## Related Topics

- [Overview](https://ably.com/docs/platform/account.md): Manage all aspects of your account, from 2FA and billing to user management and personal preferences. 
- [Organizations](https://ably.com/docs/platform/account/organizations.md): Manage Ably organizations, provision users, configure SSO with SCIM, and handle account roles.
- [Single sign-on (SSO)](https://ably.com/docs/platform/account/sso.md): Single sign-on enables users to authenticate with Ably using your own identity provider.
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
