# Programmatic management with Control API

Ably Control API is a REST API that enables you to manage your Ably account programmatically. The Control API also enables you to build web apps and command-line tools, to create and manage your Ably realtime infrastructure. Details of the API can be found in the [Control API Reference](https://ably.com/docs/api/control-api.md).

Using the Control API you can automate the provisioning, management, and testing of  your Ably realtime infrastructure. You can dynamically create Ably apps, configure them, and delete them if necessary. You can implement multi-tenancy solutions for your customers, and create configuration-driven environments that can easily be replicated under programmatic control. Once these environments are created you can also test them using Control API.

With the Control API you can create and manage:

* Your Ably apps
* API keys for an Ably app
* [Account and app statistics](https://ably.com/docs/metadata-stats/stats.md)
* [Namespaces](https://ably.com/docs/channels.md#namespaces) (for rules)
* [Queues](https://ably.com/docs/platform/integrations/queues.md)
* [Integrations](https://ably.com/docs/platform/integrations.md)

Repetitive operations such as creating, updating or deleting Ably apps, enumerating queues, creation of rules, and other tasks that would be time-consuming to carry out manually, can be automated using the Control API.

The following diagram illustrates an example use case:

![Provision and Test](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/control-api/provision-and-test.png)

In this use case, Control API is used to provision a sample app for review and testing purposes. Once provisioned, the [realtime](https://ably.com/docs/api/realtime-sdk.md) or [REST API](https://ably.com/docs/api/rest-api.md) can be used to test the app as needed. Once fully tested, the Control API can be used to replicate the app for users as required, using the known-good configuration.

In order to use the Control API you must first [create an access token](https://ably.com/docs/platform/account/access-tokens.md). You can then use the Control API to manage many account functions without having to interact with the dashboard.

The Control API limits the number of requests per account and per access token per hour. See [API limits](https://ably.com/docs/platform/pricing/limits.md#api) for details.

## OpenAPI document 

The OpenAPI document for this API can be found in the Ably OpenAPI Documents [GitHub repository](https://github.com/ably/open-specs). It is not required in order to use Control API, but is provided to you so you may optionally generate your own documentation in the tool of your choice, or use mocking tools such as [Prism](https://stoplight.io/open-source/prism/) to assist in developing your clients.

In the [testing with Postman](#postman) section you learn how to import this OpenAPI document into Postman, to enable you to quickly try out Control API.

Using the code-generation capabilities of tools such as [Postman](https://www.postman.com/) or [Paw](https://paw.cloud/) you can build clients to manage your realtime apps with a minimum of development effort.

## Authentication 

To use the Control API you must first [create an access token](https://ably.com/docs/platform/account/access-tokens.md). You use the access token to authenticate requests by supplying it as a Bearer token in the Authorization header of the HTTP request. For example, in the following curl request replace `<YOUR_ACCESS_TOKEN>` with your token:

<Code>

### Shell

```
curl -H 'Authorization: Bearer <YOUR_ACCESS_TOKEN>' ...
```
</Code>

### Obtain token details using the Control API 

You can use the Control API to obtain information about your access token, such as its capabilities, expiration date, when it was last used, and the user and account it is assigned to. This is shown in the following request:

<Code>

#### Shell

```
curl --location --request GET 'https://control.ably.net/v1/me' \
--header 'Authorization: Bearer <YOUR_ACCESS_TOKEN>'
```
</Code>

Sample response:

<Code>

#### Json

```
{
    "token": {
        "id": "a975eecd-b189-4f5b-9f07-1197f3407193",
        "name": "Control API - new token",
        "capabilities": [
            "write:namespace",
            "read:namespace",
            "write:queue",
            "read:queue",
            "write:rule",
            "read:rule",
            "write:key",
            "read:key",
            "write:app",
            "read:app"
        ],
        "expires_at": "2026-04-25T00:00:00Z",
        "last_used_at": "2026-04-17T12:34:56Z"
    },
    "user": {
        "id": 12140,
        "email": "example@email.com"
    },
    "account": {
        "id": "VgQpOZ",
        "name": "Free account"
    }
}
```
</Code>

## Account ID and app ID 

Operations that affect your entire account, such as [listing the apps](https://ably.com/docs/api/control-api.md#operation/listApps) associated with that account, require an account ID. Those that affect individual apps, such as [creating an API key](https://ably.com/docs/api/control-api.md#tag/keys/paths/~1apps~1{app_id}~1keys/post), require an app ID.

### How to find your account ID 

In the [Ably dashboard](https://ably.com/accounts/any), on the top menu bar, select your account from the dropdown list and then select **Account settings**:

![Account Settings](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/control-api/account-settings-menu-item.png)

Your account settings are displayed. From here you can obtain your Ably account ID, as shown in the following screenshot:

![Account ID](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/control-api/account-id.png)

You'll need your account ID for account-level Control API requests, such as listing all the apps in your Ably account.

### How to find your app ID 

In the [Ably dashboard](https://ably.com/accounts/any) select the app you want to find the app ID for. Click on the **Settings** tab:

![Application Settings](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/control-api/application-settings.png)

The **App ID** is displayed under **Application settings**. It is also the first part of your API key for that app. For example, if your API key is `28AB6c.DEFi0Q`, then the App ID is `28AB6c`. You can find out more in the Ably Help Center article [what is an app API key?](https://ably.com/docs/auth.md#api-key).

## Examples 

These examples demonstrate the use of the Control API with [Curl](https://curl.se/).

In the code examples, you will need to set the following variables by any convenient method (such as setting the variables in a script, or copying and pasting suitable values directly into the code):

| Variable | Description |
| -------- | ----------- |
| ACCOUNT_ID | Your Ably account ID (see [here](#account-id)) |
| ACCESS_TOKEN | Your Ably access token for the Control API (see [here](#authentication)) |
| APP_ID | The ID of the app you want to modify (see [here](#app-id)) |

### Account 

The only operation available at the account-level is to retrieve account-wide statistics.

To retrieve account-level statistics:

<Code>

#### Shell

```
curl --request GET \
  --url 'https://control.ably.net/v1/accounts/${ACCOUNT_ID}/stats?unit=minute&limit=2' \
  --header 'Authorization: Bearer ${ACCESS_TOKEN}' \
  --header 'Content-Type: application/json'
```
</Code>

See the [API reference](https://ably.com/docs/api/control-api.md#tag/accounts/paths/~1accounts~1{account_id}~1stats/get) for information on the request body.

Sample response, with `entries` trimmed for readability:

<Code>

#### Json

```
[
  {
    "intervalId": "2024-10-17:08:45",
    "unit": "minute",
    "accountId": "VgQpOZ",
    "schema": "https://schemas.ably.com/json/account-stats-0.0.3.json",
    "entries": {
      "messages.all.all.count": 125,
      "messages.all.all.data": 349,
      "connections.all.peak": 502,
      "channels.peak": 37
    }
  },
  {
    "intervalId": "2024-10-17:08:44",
    "unit": "minute",
    "accountId": "VgQpOZ",
    "schema": "https://schemas.ably.com/json/account-stats-0.0.3.json",
    "entries": {
      "messages.all.all.count": 92,
      "messages.all.all.data": 279,
      "connections.all.peak": 472,
      "channels.peak": 36
    }
  }
]
```
</Code>

### Apps 

You can use the Control API to perform tasks such as listing and creating Ably apps. Operations available include:

* Get a list of apps
* Create an app
* Update an app
* Delete an app
* Update an app's [APNs](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html) info
* Retrieve app statistics

#### Create an app 

To create an app:

<Code>

##### Shell

```
curl --location --request POST 'https://control.ably.net/v1/accounts/${ACCOUNT_ID}/apps' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer ${ACCESS_TOKEN}' \
--data-raw '{
    "name": "Created App 123",
    "status": "enabled",
    "tlsOnly": true,
    "fcmKey": null,
    "fcmServiceAccount": null,
    "fcmProjectId": null,
    "apnsCertificate": null,
    "apnsPrivateKey": null,
    "apnsUseSandboxEndpoint": false
}'
```
</Code>

<Aside data-type='note'>
The `apnsUseSandboxEndpoint` field controls which [APNs endpoint](https://developer.apple.com/documentation/usernotifications/sending-notification-requests-to-apns) Ably uses to deliver push notifications. Set to `true` for the sandbox endpoint `api.sandbox.push.apple.com` or `false` for the production endpoint `api.push.apple.com`.

You must specify this field for both token-based (.p8) and certificate-based (.p12) authentication. Use sandbox when testing with development builds and production for App Store or TestFlight distribution.

For certificate-based authentication, ensure the endpoint matches your certificate type. Use a development certificate for sandbox, and a distribution certificate for production.
</Aside>

See the [API reference](https://ably.com/docs/api/control-api.md#tag/apps/paths/~1accounts~1{account_id}~1apps/post) for information on the request body.

Sample response:

<Code>

##### Json

```
{
    "accountId": "VgQpOZ",
    "id": "bh4QSw",
    "name": "Created App 123",
    "status": "enabled",
    "tlsOnly": true,
    "apnsUseSandboxEndpoint": false,
    "created": 1625813276973,
    "modified": 1625813276973
}
```
</Code>

#### List apps 

To list all the Ably apps associated with your account:

<Code>

##### Shell

```
curl "https://control.ably.net/v1/accounts/${ACCOUNT_ID}/apps" \
     --header "Authorization: Bearer ${ACCESS_TOKEN}" \
     --header "Accept: application/json"
```
</Code>

Sample response:

<Code>

##### Json

```
[
  {
      "accountId": "VgQpOZ",
      "id": "bh4QSw",
      "name": "Created App 123",
      "status": "enabled",
      "tlsOnly": true,
      "apnsUseSandboxEndpoint": false,
      "created": 1625813276973,
      "modified": 1625813276973
  },
  ...
]
```
</Code>

#### Retrieve app statistics 

To retrieve app-level statistics:

<Code>

##### Shell

```
curl --location --request POST 'https://control.ably.net/v1/apps/${APP_ID}/stats' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer ${ACCESS_TOKEN}' \
--data-raw '{
    "unit": "hour",
    "limit": 1
}'
```
</Code>

See the [API reference](https://ably.com/docs/api/control-api.md#tag/apps/paths/~1apps~1{app_id}~1stats/get) for information on the request body.

Sample response, with `entries` trimmed for readability:

<Code>

##### Json

```
[
  {
    "intervalId": "2024-10-17:15",
    "unit": "hour",
    "appId": "pR4La5",
    "schema": "https://schemas.ably.com/json/app-stats-0.0.5.json",
    "entries": {
      "messages.all.all.count": 10293,
      "messages.all.all.data": 30879,
      "connections.all.peak": 510,
      "channels.peak": 68
    }
  }
]
```
</Code>

### Queues 

You can use the Control API to manage [Ably queues](https://ably.com/docs/platform/integrations/queues.md). The main operations are:

* List all Ably queues
* Create a queue
* Delete a queue

#### List queues 

To list all queues associated with an app ID:

<Code>

##### Shell

```
curl --location --request GET 'https://control.ably.net/v1/apps/${APP_ID}/queues' \
--header 'Authorization: Bearer ${ACCESS_TOKEN}'
```
</Code>

Sample response:

<Code>

##### Json

```
[
    {
        "id": "28GY6a:us-east-1-a:Test",
        "appId": "28GY6a",
        "name": "Test",
        "region": "us-east-1-a",
        "amqp": {
            "uri": "amqps://us-east-1-a-queue.ably.io:5671/shared",
            "queueName": "28GY6a:Test"
        },
        "stomp": {
            "uri": "stomp://us-east-1-a-queue.ably.io:61614",
            "host": "shared",
            "destination": "/amqp/queue/28GY6a:Test"
        },
        "state": "Running",
        "messages": {
            "ready": 0,
            "unacknowledged": 0,
            "total": 0
        },
        "stats": {
            "publishRate": null,
            "deliveryRate": null,
            "acknowledgementRate": null
        },
        "ttl": 60,
        "maxLength": 10000,
        "deadletter": false,
        "deadletterId": "28GY6a:us-east-1-a:deadletter"
    },
    ...
]
```
</Code>

#### Create a queue 

To create a queue for an app:

<Code>

##### Shell

```
curl --location --request POST 'https://control.ably.net/v1/apps/${APP_ID}/queues' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer ${ACCESS_TOKEN}' \
--data-raw '{
    "name": "Queue 123",
    "ttl": 60,
    "maxLength": 10000,
    "region": "eu-west-1-a"
}'
```
</Code>

See the [API reference](https://ably.com/docs/api/control-api.md#tag/queues/paths/~1apps~1{app_id}~1queues/post) for information on the request body.

Sample response:

<Code>

##### Json

```
{
    "id": "28GY6a:eu-west-1-a:Queue 123",
    "appId": "28GY6a",
    "name": "Queue 123",
    "region": "eu-west-1-a",
    "amqp": {
        "uri": "amqps://eu-west-1-a-queue.ably.io:5671/shared",
        "queueName": "28GY6a:Queue 123"
    },
    "stomp": {
        "uri": "stomp://eu-west-1-a-queue.ably.io:61614",
        "host": "shared",
        "destination": "/amqp/queue/28GY6a:Queue 123"
    },
    "state": "Unknown",
    "messages": {
        "ready": 0,
        "unacknowledged": 0,
        "total": 0
    },
    "stats": {
        "publishRate": null,
        "deliveryRate": null,
        "acknowledgementRate": null
    },
    "ttl": 60,
    "maxLength": 10000,
    "deadletter": false,
    "deadletterId": "28GY6a:eu-west-1-a:deadletter"
}
```
</Code>

### Keys 

You can use the Control API to manage Ably API keys. The main operations are:

* List all Ably API keys for an app
* Create a key
* Update a key
* Revoke a key

Control API enables you to create a key that has different [capabilities](https://ably.com/docs/auth/capabilities.md) for different channels.

#### List API keys 

To list all keys associated with an app ID:

<Code>

##### Shell

```
curl --location --request GET 'https://control.ably.net/v1/apps/${APP_ID}/keys' \
--header 'Authorization: Bearer ${ACCESS_TOKEN}'
```
</Code>

Sample response:

<Code>

##### Json

```
[
    {
        "appId": "28GY6a",
        "id": "-frw5Q",
        "name": "Control API Key",
        "key": "28GY6a.-frw5Q:ZHTaEUGGJWJtHSkZ",
        "capability": {
            "channel-1": [
                "publish"
            ]
        },
        "created": 1630074457007,
        "modified": 1630074457007
    },
    ...
]
```
</Code>

#### Create a key 

The following example demonstrates how to create an Ably API key:

<Code>

##### Shell

```
curl --location --request POST 'https://control.ably.net/v1/apps/${APP_ID}/keys' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer ${ACCESS_TOKEN}' \
--data-raw '{
    "name": "My key name",
    "capability": {
        "channel1": [
            "publish",
            "subscribe"
        ],
        "channel2": [
            "history"
        ]
    }
}'
```
</Code>

This request creates an API key with the key name `My key name`. Note that this key specifies different capabilities for each channel, for example, on `channel1` this key has publish and subscribe capabilities. On `channel2` the key only has the history capability.

Sample response:

<Code>

##### Json

```
{
    "appId": "28GY6a",
    "id": "Eg063g",
    "name": "My key name",
    "key": "28GY6a.Eg063g:Dp9ZNfK6Qr8aWy-q",
    "capability": {
        "channel1": [
            "publish",
            "subscribe"
        ],
        "channel2": [
            "history"
        ]
    },
    "created": 1630506079278,
    "modified": 1630506079278
}
```
</Code>

#### Update a key 

The following request updates the key name, and also adds the history capability to `channel1`:

<Code>

##### Shell

```
curl --location --request PATCH 'https://control.ably.net/v1/apps/${APP_ID}/keys/${KEY_ID}' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer ${ACCESS_TOKEN}' \
--data-raw '{
    "name": "My key name UPDATED",
    "capability": {
        "channel1": [
            "publish",
            "subscribe",
            "history"
        ],
        "channel2": [
            "history"
        ]
    }
}'
```
</Code>

Sample response:

<Code>

##### Json

```
{
    "appId": "28GY6a",
    "id": "RCSMrg",
    "name": "My key name UPDATED",
    "key": "28GY6a.RCSMrg:z8HkAtY7rMtnpcGq",
    "capability": {
        "channel1": [
            "history",
            "publish",
            "subscribe"
        ],
        "channel2": [
            "history"
        ]
    },
    "created": 1630507628335,
    "modified": 1630507811349
}
```
</Code>
#### Revoke a key 

To revoke a specific key for a specific app:

<Code>

##### Shell

```
curl --location --request POST 'https://control.ably.net/v1/apps/${APP_ID/keys/${KEY_ID}/revoke' \
--header 'Authorization: Bearer ${ACCESS_TOKEN}'
```
</Code>

In this case there is only a status code returned (200), or an error code.

### Rules 

You can use the Control API to manage Ably [integration rules](https://ably.com/docs/platform/integrations.md). The main operations are:

* List all rules for an app
* List details of a specific rule using rule ID
* Create a rule
* Update a rule
* Delete a rule

#### List rules 

To list the rules for an app:

<Code>

##### Shell

```
curl --location --request GET 'https://control.ably.net/v1/apps/${APP_ID}/rules' \
--header 'Authorization: Bearer ${ACCESS_TOKEN}'
```
</Code>

Sample response:

<Code>

##### Json

```
[
    {
        "id": "oO-Tug",
        "appId": "28GY6a",
        "ruleType": "http",
        "requestMode": "single",
        "status": "disabled",
        "source": {
            "channelFilter": "",
            "type": "channel.message"
        },
        "target": {
            "url": "https://example.com/webhooks",
            "signingKeyId": null,
            "enveloped": true,
            "format": "json",
            "headers": [
                {
                    "name": "User-Agent",
                    "value": " user-agent-name"
                }
            ]
        },
        "version": "1.0",
        "created": 1626893758695,
        "modified": 1626894987810,
        "_links": {
            "self": "https://control.ably.net/v1/apps/28GY6a/rules/oO-Tug"
        }
    },
    ...
]
```
</Code>

#### List a rule by rule ID 

<Code>

##### Shell

```
curl --location --request GET 'https://control.ably.net/v1/apps/${APP_ID}/rules/${RULE_ID}' \
--header 'Authorization: Bearer ${ACCESS_TOKEN}'
```
</Code>
The rule details are returned for the specified rule.

#### Create a rule 

The following example creates a rule with the following configuration:

| Parameter | Value | Description |
| --------- | ----- | ----------- |
| `ruleType` | http | The type of rule, in this case a webhook rule |
| `requestMode` | single | Request mode can be single or batched |
| `channelFilter` | `^my-channel.*` | An optional regular expression that allows the rule to be applied to the specified channel set |
| `type` | channel.message | Source type. This means that the source event that will trigger this rule is any message on the channel |
| `url` | `https://example.com/webhooks` | The webhook endpoint. This is the URL triggered for the event |
| `format` | json | Format of encoding for the rule, in this case JSON |
| `name` | User-Agent | Optional header or headers, including custom headers that might be required. In this case a user agent header is specified (this needs to be set for some providers) |
| `value` | user-agent-name | The value of the header |
| `enveloped` | true | Wrap packet in [metadata](https://ably.com/docs/platform/integrations/webhooks.md#envelope) |

The corresponding request is:

<Code>

##### Shell

```
curl --location --request POST 'https://control.ably.net/v1/apps/${APP_ID}/rules' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer ${ACCESS_TOKEN}' \
--data-raw '{
    "ruleType": "http",
    "requestMode": "single",
    "source": {
        "channelFilter": "^my-channel.*",
        "type": "channel.message"
    },
    "target": {
        "url": "https://example.com/webhooks",
        "format": "json",
        "headers": [
            {
                "name": "User-Agent",
                "value": "user-agent-string"
            },
            {
                "name": "headerName",
                "value": "headerValue"
            }
        ],
        "enveloped": true
    }
}'
```
</Code>

Sample response:

<Code>

##### Json

```
{
    "id": "3DySkw",
    "appId": "28GY6a",
    "ruleType": "http",
    "requestMode": "single",
    "status": "enabled",
    "source": {
        "channelFilter": "^my-channel.*",
        "type": "channel.message"
    },
    "target": {
        "url": "https://example.com/webhooks",
        "signingKeyId": null,
        "enveloped": true,
        "format": "json",
        "headers": [
            {
                "name": "User-Agent",
                "value": "user-agent-string"
            },
            {
                "name": "headerName",
                "value": "headerValue"
            }
        ]
    },
    "version": "1.0",
    "created": 1630588265781,
    "modified": 1630588265781,
    "_links": {
        "self": "https://control.ably.net/v1/apps/28GY6a/rules/3DySkw"
    }
}
```
</Code>

This shows the created webhook rule.

#### Update a rule 

If you need to change a rule you can update it. For example, if you wanted to change the webhook endpoint URL you could carry out the following request:

<Code>

##### Shell

```
curl --location --request PATCH 'https://control.ably.net/v1/apps/${APP_ID}/rules/${RULE_ID}' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer ${ACCESS_TOKEN}' \
--data-raw '{
    "ruleType": "http",
    "target": {
        "url": "https://example.com/webhooks/webhook1"
    }
}'
```
</Code>

The response is the same as for rule creation, but reflects the updated information.

#### Delete a rule 

If you need to delete a rule you can:

<Code>

##### Shell

```
curl --location --request DELETE 'https://control.ably.net/v1/apps/${APP_ID}/rules/${RULE_ID}' \
--header 'Authorization: Bearer ${ACCESS_TOKEN}'
```
</Code>

In this case there is only a status code returned (204), or an error code.

## Testing with Postman 

The Control API is designed for programmatic access to your account. However, you can try out individual requests using either a command line tool such as [Curl](https://curl.se/) or [HTTPie](https://httpie.io/), or a graphical tool such as [Postman](https://www.postman.com/) or [Paw](https://paw.cloud/). The following section shows you how to make requests using Postman.

### Importing the OpenAPI document into Postman 

A convenient way to try out the Control API is by importing the OpenAPI document into [Postman](https://www.postman.com/), and then sending requests and checking the responses. To do this, perform the following steps:

1. Make sure you have [Postman](https://www.postman.com/downloads/) installed.

2. Start Postman and select **File > Import** from the main menu. The import dialog is displayed:

![Postman import dialog](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/control-api/postman-import-dialog.png)

3. Click the **Link** tab, and paste in the following URL: `https://raw.githubusercontent.com/ably/open-specs/main/definitions/control-v1.yaml`, then click **Continue**:

![Link to OpenAPI document](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/control-api/postman-link.png)

4. In the Import dialog, use the default settings and click **Import**:

![Postman import default](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/control-api/postman-import-default.png)

5. The imported document now appears in your Postman collections:

![Postman imported collection](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/control-api/imported-collection.png)

You have now imported the OpenAPI document into Postman.

### Sending a request 

First, you need to [obtain a Control API token](https://ably.com/docs/platform/account/access-tokens.md#create) to authenticate any requests you send to the Control API.

For many Control API requests you also need to specify your account ID or app ID. You can see the [account ID and app ID](#ids) section for details on how to obtain these.

Now that you have obtained the token and IDs, you can learn how to send a request in Postman.

1. Expand the collection to the `Lists account apps` request. The following screenshot shows the parameters for the request:

![App list request](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/control-api/app-list-request.png)

2. The `Lists account apps` request is an account-level operation and therefore requires your account ID in the `account_id` path variable. This path variable is highlighted with the green box in the previous screenshot. Paste your Ably account ID into the **VALUE** field.

3. You also need to enter your Control API token as a `Bearer Token` in the **Authorization** tab. Paste your Ably Control API token into the token field marked with the placeholder text `<Bearer Token>`, as shown in the following screenshot:

![Bearer token](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/control-api/bearer-token.png)

**Note:** If you don't supply this token, your request will fail to authenticate.

4. Now that this request is configured, you can send the request by clicking the **Send** button:

![Send request](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/control-api/send-request.png)

5. The server returns a response, listing your Ably apps:

![Response](https://raw.githubusercontent.com/ably/docs/main/src/images/content/screenshots/control-api/list-apps-response.png)

You can now try out other requests. You need to set the necessary parameters and authentication token as required by that specific request. Consult the [API Reference](https://ably.com/docs/api/control-api.md) for further information.

## Related Topics

- [Overview](https://ably.com/docs/platform/account.md): Manage all aspects of your account, from 2FA and billing to user management and personal preferences. 
- [User management](https://ably.com/docs/platform/account/users.md): Learn how to manage users, user roles, and the permissions associated with each role.
- [Organizations](https://ably.com/docs/platform/account/organizations.md): Manage Ably organizations, provision users, configure SSO with SCIM, and handle account roles.
- [Single sign-on (SSO)](https://ably.com/docs/platform/account/sso.md): Single sign-on enables users to authenticate with Ably using your own identity provider.
- [Two-factor authentication (2FA)](https://ably.com/docs/platform/account/2fa.md): Enable two-factor authentication for your Ably account.
- [Enterprise customization](https://ably.com/docs/platform/account/enterprise-customization.md): How Enterprise customers can create a custom endpoint and benefit from Active Traffic Management and other advanced Ably features.
- [Access tokens](https://ably.com/docs/platform/account/access-tokens.md): Create and manage access tokens to authenticate with the Ably Control API and Ably CLI, including expiration and rotation.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
