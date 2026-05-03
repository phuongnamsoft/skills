# AWS Lambda integration

[AWS Lambda](https://aws.amazon.com/lambda/) integrations enable you to trigger event-driven serverless compute functions when an event occurs in Ably. They are useful for integrating into various AWS services.

## Create an AWS Lambda integration 

<Tabs>
<Tab value="dashboard" label="Dashboard">

On the [Integrations](https://ably.com/accounts/any/apps/any/integrations) page of your app:

1. Click **New Integration Rule**.
2. Choose **Webhook**.
3. Choose **AWS Lambda**.
4. Configure the AWS Lambda [settings](#settings).
5. Click **Create**.

</Tab>
<Tab value="control-api" label="Control API">

Create an AWS Lambda rule using the Control API by sending a `POST` request to [`/apps/{app_id}/rules`](https://ably.com/docs/api/control-api.md):

<Code>

### Shell

```
curl -X POST https://control.ably.net/v1/apps/{APP_ID}/rules \
  -H "Authorization: Bearer {ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "ruleType": "aws/lambda",
    "requestMode": "single",
    "source": {
      "channelFilter": "",
      "type": "channel.message"
    },
    "target": {
      "region": "us-west-1",
      "functionName": "my-function",
      "authentication": {
        "authenticationMode": "assumeRole",
        "assumeRoleArn": "arn:aws:iam::123456789012:role/my-ably-role"
      },
      "enveloped": true
    }
  }'
```
</Code>

</Tab>
</Tabs>

### Settings 

The following settings are available when creating an AWS Lambda integration:

| Setting | Description |
| ------- | ----------- |
| AWS Region | Specifies the region of your AWS Lambda. |
| Function Name | The name of your AWS Lambda function. |
| [AWS authentication scheme](#auth) | Choose the authentication method. Either **AWS credentials** or **ARN of an assumable role**. |
| AWS Credentials | If using AWS credentials, enter the values in `key:value` format. |
| ARN of an assumable role | If using ARN of an assumable role, enter the ARN of the role that Ably can assume to access your AWS Lambada function. |
| Qualifier | The qualifier of your Lambda function, if set. |
| [Event types](https://ably.com/docs/platform/integrations/webhooks.md#sources) | Specifies the event types being sent to your AWS Lambda function. |
| [Channel filter](https://ably.com/docs/platform/integrations/webhooks.md#filter) | Filters the source channels based on a regular expression. |
| Encoding | Specifies the encoding format of messages. Either JSON or MsgPack. |
| [Enveloped](https://ably.com/docs/platform/integrations/webhooks.md#enveloped) | Checkbox to set whether messages should be enveloped or not. Enveloped is the default. |

## AWS authentication 

Delegate access to your AWS resources by creating an [IAM role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) that the Ably AWS account can assume.

This approach follows AWS best practices, as it avoids sharing access keys directly. Specify the role's ARN to grant Ably the necessary permissions in a secure manner.

### Create a Lambda policy 

The following steps show you how to create a policy for an AWS Lambda.

1. In the IAM console sidebar select **Policies**.
2. Click **Create Policy**.
3. Click the JSON tab and enter the following JSON to configure the policy:

<Code>

#### Json

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowInvokeLambdaFunction",
      "Effect": "Allow",
      "Action": [
        "lambda:InvokeAsync",
        "lambda:InvokeFunction"
      ],
      "Resource": [
        "arn:aws:lambda:<YOUR_AWS_REGION>:<YOUR_AWS_ACCOUNT>:function:<YOUR_FUNCTION_NAME>"
      ]
    }
  ]
}
```
</Code>

<Aside data-type='note'>
You will need to replace `<YOUR_AWS_REGION>`, `<YOUR_AWS_ACCOUNT>` and `<YOUR_STREAM_NAME>` with the AWS region that hosts your Lambda function, your AWS account ID, and your Lambda function name respectively.
</Aside>

4. Click **Next: Tags**. You don't need to add any tags.
5. Click **Next: Review**.
6. Enter a suitable name for your policy.
7. Click **Create Policy**.

You have created a policy that grants the permissions required to use a Kinesis stream. You must now attach it to the role that you'll specify in your Ably integration rule.

### Create a role 

Create an IAM role as follows:

1. In the AWS IAM console, click **Roles** in the sidebar and then click **Create Role**.
2. For type of trusted entity select **Another AWS account**.
3. For Account ID specify 203461409171. This is the Ably AWS account.
4. Click the **Require external ID checkbox** and then enter an external ID of [`<Your_Ably_Account_ID>.<Your_Ably_app_ID>`](https://ably.com/docs/platform/account/control-api.md#ids).
5. Click **Next: Permissions**.
6. Now select the policy you created earlier to attach to this role. You can type the name of your policy into the **Filter policies** search box.

Then ensure the checkbox for the policy is selected.

7. Click **Next: Tags**.
8. You don't need to add tags so click **Next: Review**.
9. Enter a suitable name for your role.
10. Click **Create Role**.

## Lambda retry behavior 

Ably invokes Lambda functions asynchronously using the `event` invocation type. When a function returns an error, AWS Lambda automatically retries the execution up to two more times with delays between attempts (1 minute, then 2 minutes).

Lambda functions might run multiple times for the same Ably event. Design functions to handle this by making them idempotent or checking for duplicate processing.

You can configure retry behavior in your AWS Lambda console under the function's asynchronous invocation settings. See the [AWS Lambda documentation](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#invocation-async-errors) for details on adjusting retry settings.

## Routing messages with integration Rules 

When an Integration Rule triggers your Lambda function, it can process the incoming message and publish a response back to Ably. This enables message routing and transformation patterns across your channels.

### Lambda Function setup 

Your Lambda Function must be packaged with the Ably SDK and uploaded to AWS Lambda as a zip file.

Uses `Ably.Rest` instead of `Ably.Realtime` because REST API is more efficient for one-off publishing operations and avoids WebSocket connection overhead in Lambda's stateless environment.

<If lang="javascript,nodejs">
The following example shows an AWS Lambda function that receives Ably events and publishes responses back to an Ably channel:

<If lang="javascript">
<Code>

#### Javascript

```
'use strict';

const Ably = require('ably');
const inspect = require('util').inspect;

exports.handler = (event, context, callback) => {
  console.log("Received the following event from Ably: ", inspect(event));

  // Parse the incoming event
  // With enveloping enabled: event contains 'source', 'appId', 'channel',
  // 'site', 'ruleId', and 'messages' or 'presence' arrays
  // With enveloping disabled: event is the message data directly
  const details = JSON.parse(event.messages[0].data);

  // Use Ably.Rest for efficient REST-based publishing
  // This avoids the overhead of establishing a WebSocket connection
  const ably = new Ably.Rest({ key: '<YOUR_API_KEY>' });

  // Get the target channel and publish the response
  // Important: Do not publish to a channel that triggers this same rule
  // to avoid infinite loops
  const channel = ably.channels.get('<TARGET_CHANNEL_NAME>');

  channel.publish('lambdaresponse', 'success', (err) => {
    if(err) {
      console.log("Error publishing back to ably:", inspect(err));
      callback(err);
    } else {
      // Only call callback() after publish completes
      // to ensure the HTTP request finishes before function execution ends
      callback(null, 'success');
    }
  });
};
```
</Code>
</If>

<If lang="nodejs">
<Code>

#### Nodejs

```
'use strict';

const Ably = require('ably');
const inspect = require('util').inspect;

exports.handler = (event, context, callback) => {
  console.log("Received the following event from Ably: ", inspect(event));

  // Parse the incoming event
  // With enveloping enabled: event contains 'source', 'appId', 'channel',
  // 'site', 'ruleId', and 'messages' or 'presence' arrays
  // With enveloping disabled: event is the message data directly
  const details = JSON.parse(event.messages[0].data);

  // Use Ably.Rest for efficient REST-based publishing
  // This avoids the overhead of establishing a WebSocket connection
  const ably = new Ably.Rest({ key: '<YOUR_API_KEY>' });

  // Get the target channel and publish the response
  // Important: Do not publish to a channel that triggers this same rule
  // to avoid infinite loops
  const channel = ably.channels.get('<TARGET_CHANNEL_NAME>');

  channel.publish('lambdaresponse', 'success', (err) => {
    if(err) {
      console.log("Error publishing back to ably:", inspect(err));
      callback(err);
    } else {
      // Only call callback() after publish completes
      // to ensure the HTTP request finishes before function execution ends
      callback(null, 'success');
    }
  });
};
```
</Code>
</If>
</If>

## Handling high message volumes 

Rate limiting is necessary when the message rate on source channels exceeds what your Lambda function can process. Without rate limiting, unprocessed messages accumulate in a backlog with no visibility or management options.

### Using Kinesis for High-Volume Processing 

For high-volume message processing, use an intermediary queue such as [AWS Kinesis](https://aws.amazon.com/kinesis/). Configure [Integration Rules](https://ably.com/docs/platform/integrations/webhooks.md) to send events to Kinesis, then stream from Kinesis into your Lambda function.

See [AWS documentation on streaming from Kinesis to Lambda](https://docs.aws.amazon.com/lambda/latest/dg/with-kinesis.html) for configuration details.

## Related Topics

- [Overview](https://ably.com/docs/platform/integrations/webhooks.md): A guide on webhook payloads, including batched, enveloped, and non-enveloped event payloads, with decoding examples and sources.
- [Generic HTTP webhooks](https://ably.com/docs/platform/integrations/webhooks/generic.md): Configure generic HTTP webhooks to trigger HTTP endpoints and notify external services when events occur in Ably.
- [Azure Functions](https://ably.com/docs/platform/integrations/webhooks/azure.md): Trigger Microsoft Azure functions based on message, channel lifecycle, channel occupancy, and presence events.
- [Google Functions](https://ably.com/docs/platform/integrations/webhooks/gcp-function.md): Trigger Google Functions based on message, channel lifecycle, channel occupancy, and presence events.
- [Zapier](https://ably.com/docs/platform/integrations/webhooks/zapier.md): Trigger Zapier based on message, channel lifecycle, channel occupancy, and presence events.
- [Cloudflare Workers](https://ably.com/docs/platform/integrations/webhooks/cloudflare.md): Trigger Cloudflare Workers based on message, channel lifecycle, channel occupancy, and presence events.
- [IFTTT](https://ably.com/docs/platform/integrations/webhooks/ifttt.md): Trigger IFTTT based on message, channel lifecycle, channel occupancy, and presence events.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
