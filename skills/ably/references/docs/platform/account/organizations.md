# Organizations

Use organizations to manage multiple Ably accounts by centralizing user access and roles under a single organizational structure. Organizations streamline user provisioning through [Single Sign-On (SSO)](https://ably.com/docs/platform/account/sso.md) configuration and utilize SCIM System for Cross-domain Identity Management for group-based access control.

Organizations enable the [primary](#primary) account to assign and adjust the roles of users and groups across all accounts.

You can separate accounts within an organization to create isolated environments, such as production, staging, and development. Assign each environment a [package](https://ably.com/docs/platform/pricing.md#packages) that meets its specific needs. For example, production may need high capacity with an **Enterprise** package, staging might use a **Standard** package, and development a **Free** package.

<Aside data-type='note'>
An [Enterprise](https://ably.com/docs/platform/pricing/enterprise.md) account is required to use organizations. [Contact us](https://ably.com/support) to enable organizations for your account.
</Aside>

## Primary account 

The primary account is an organization's main account and holds the following privileges:

* The highest level of access to the organization.
* Ownership of all all accounts within the organization.
* The default account used for provisioning.

## Create accounts in an organization 

Create accounts in an organization:

* Open the **Account** navigation dropdown.
  * Click **Organization Accounts.**
  * Click **New account**.
  * Add an account name and **Create account**.

## Provision users via SCIM 

<Aside data-type='note'>
Google Workspace *alone* does not natively support SCIM.
</Aside>

Manage access to multiple Ably accounts through a single identity provider. To enable this, configure both [SSO](https://ably.com/docs/platform/account/sso.md) with your chosen identity provider and [SCIM](#SCIM). Once configured, Ably automatically provisions and deprovisions users with access to the Ably app in your identity provider, either individually or through assigned groups. New users are added to Ably's default provisioning account with the role of **Developer**.

Users can be provisioned into additional accounts through SCIM group membership. When a SCIM group is linked to an account, all members of that [group](#group) are automatically provisioned into that account.

Ably only recognizes one registered email domain per organization, unrecognized email domains will result in rejected provisioning attempts.

Users provisioned through SCIM cannot modify their name or email address within Ably. All personal information updates must be made through your identity provider, and changes will sync to Ably on the next SCIM update cycle.

The following steps outline the process for provisioning users through SCIM:

* Configure [SSO](https://ably.com/docs/platform/account/sso.md) by enabling and setting up SSO between Ably and your identity provider.

* Copy Ably SCIM configuration values:
  * Open the **Account** navigation dropdown in the Ably dashboard.
  * Select **Organization Settings** from the menu.
  * Navigate to the **Users & Groups Provisioning (SCIM)** section and copy:
  * **Service Provider Configuration Endpoint.**
  * **SCIM Username.**
  * **SCIM Password.**
* In your identity providers provisioning app, paste the following values from Ably:
  * **Service Provider Configuration Endpoint.**
  * **SCIM Username.**
  * **SCIM Password.**
* Ensure that any additional setup required by your identity provider is completed to finalize the SCIM configuration.


## Manage roles 

Manage user and group [roles](https://ably.com/docs/platform/account/users.md#roles) across accounts within your organization. User and group roles include those assigned directly to the user and through the groups the user belongs to. Use the **Organization Users** page as a central point of control, rather than managing access individually within each account.

### Group roles 

When organizations and your identity provider are configured, the groups you create in the identity provider are synchronized with Ably. This enables you to manage group-based access centrally. Assign roles to these groups across one or more accounts. When a group is linked to an account, all users in that group are automatically provisioned into that account and inherit the assigned roles. Users added to the group afterwards are also provisioned into the linked accounts automatically.

To manage group roles in Ably:
* Open the **Account** navigation dropdown.
  * Click **Organization Users**.
  * Under **Ably Realtime identity provider groups**, click **Manage account access**.
  * Select the group whose access you want to manage.
  * Specify the required **Roles** for the group -- and all users in this group inherit these roles automatically.

<Aside data-type='note'>
When modifying an individual user's roles, any rights assigned via groups will be greyed out and cannot be changed directly.
</Aside>

## Related Topics

- [Overview](https://ably.com/docs/platform/account.md): Manage all aspects of your account, from 2FA and billing to user management and personal preferences. 
- [User management](https://ably.com/docs/platform/account/users.md): Learn how to manage users, user roles, and the permissions associated with each role.
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
