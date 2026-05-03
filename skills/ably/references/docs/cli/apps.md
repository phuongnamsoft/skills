# Apps

Use the `ably apps` command group to manage your Ably applications. These commands enable you to create, update, delete, list, and switch between apps, as well as manage channel rules for your apps.

## App management commands 

Use the following commands to create, list, update, delete, and switch between [Ably apps](https://ably.com/docs/platform/account/app.md). Each app is a sandboxed environment isolated from other apps in your account:

| Command | Description |
| ------- | ----------- |
| [`ably apps create`](https://ably.com/docs/cli/apps/create.md) | Create a new Ably application. |
| [`ably apps current`](https://ably.com/docs/cli/apps/current.md) | Show the currently selected app. |
| [`ably apps delete`](https://ably.com/docs/cli/apps/delete.md) | Permanently delete an Ably application. |
| [`ably apps list`](https://ably.com/docs/cli/apps/list.md) | List all apps in the current account. |
| [`ably apps switch`](https://ably.com/docs/cli/apps/switch.md) | Switch to a different Ably app. |
| [`ably apps update`](https://ably.com/docs/cli/apps/update.md) | Update an app's configuration. |

## Rule management commands 

Use the following commands to manage channel rules (namespaces) for your Ably applications. Channel rules enable you to configure behavior such as message persistence, TLS-only access, and push notification settings for channels matching a specific namespace:

| Command | Description |
| ------- | ----------- |
| [`ably apps rules create`](https://ably.com/docs/cli/apps/rules/create.md) | Create a channel rule for an app. |
| [`ably apps rules delete`](https://ably.com/docs/cli/apps/rules/delete.md) | Delete a channel rule from an app. |
| [`ably apps rules list`](https://ably.com/docs/cli/apps/rules/list.md) | List channel rules for an app. |
| [`ably apps rules update`](https://ably.com/docs/cli/apps/rules/update.md) | Update a channel rule for an app. |

## See also

* [CLI reference](https://ably.com/docs/cli.md) — Full list of available commands.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
