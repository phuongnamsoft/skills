# AWS SQS integration

[SQS](https://aws.amazon.com/sqs) integrations enable you to automatically forward events that occur in Ably to AWS SQS queues.

## Create an SQS integration 

<Tabs>
<Tab value="dashboard" label="Dashboard">

On the [Integrations](https://ably.com/accounts/any/apps/any/integrations) page of your app:

1. Click **New Integration Rule**.
2. Choose **Firehose**.
3. Choose **AWS SQS**.
4. Configure the SQS [settings](#settings).
5. Click **Create**.

</Tab>
<Tab value="control-api" label="Control API">

Create an SQS rule using the Control API by sending a `POST` request to [`/apps/{app_id}/rules`](https://ably.com/docs/api/control-api.md):

<Code>

### Shell

```
curl -X POST https://control.ably.net/v1/apps/{APP_ID}/rules \
  -H "Authorization: Bearer {ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "ruleType": "aws/sqs",
    "requestMode": "single",
    "source": {
      "channelFilter": "",
      "type": "channel.message"
    },
    "target": {
      "region": "us-west-1",
      "awsAccountId": "123456789012",
      "queueName": "my-queue",
      "format": "json",
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

#### Settings 

The following settings are available when creating an SQS integration:

| Setting | Description |
| ------- | ----------- |
| URL | Specifies the URL for the SQS queue, including credentials, region, and stream name. Only HTTPS is supported. |
| AWS Region  | Specifies the AWS region of your SQS queue. |
| [AWS authentication scheme](#auth) | Choose the authentication method. Either **AWS credentials** or **ARN of an assumable role**. |
| AWS Credentials | If using AWS credentials, enter the values in `key:value` format. |
| ARN of an assumable role | If using ARN of an assumable role, enter the ARN of the role that Ably can assume to access your SQS queue. |
| [Source](https://ably.com/docs/platform/integrations/streaming.md#sources) | Specifies the event types being sent to SQS. |
| [Channel filter](https://ably.com/docs/platform/integrations/streaming.md#filter) | Filters the source channels based on a regular expression. |
| Encoding | Specifies the encoding format of messages. Either JSON or MsgPack. |
| [Enveloped](https://ably.com/docs/platform/integrations/streaming.md#enveloped) | Checkbox to set whether messages should be enveloped or not. Enveloped is the default. |

## AWS authentication 

Delegate access to your AWS resources by creating an [IAM role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) that the Ably AWS account can assume.

This approach follows AWS best practices, as it avoids sharing access keys directly. Specify the role's ARN to grant Ably the necessary permissions in a secure manner.

### Create an SQS policy 

The following steps show you how to create a policy for AWS SQS.

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
      "Sid": "AllowReadWriteSQS",
      "Effect": "Allow",
      "Action": [
        "sqs:DeleteMessage",
        "sqs:TagQueue",
        "sqs:GetQueueUrl",
        "sqs:ChangeMessageVisibility",
        "sqs:DeleteMessageBatch",
        "sqs:SendMessageBatch",
        "sqs:UntagQueue",
        "sqs:ReceiveMessage",
        "sqs:SendMessage",
        "sqs:ListQueueTags",
        "sqs:ChangeMessageVisibilityBatch"
      ],
      "Resource": [
        "arn:aws:sqs:<YOUR_AWS_REGION>:<YOUR_AWS_ACCOUNT>:<YOUR_QUEUE_NAME>"
      ]
    }
  ]
}
```
</Code>

<Aside data-type='note'>
You will need to replace `<YOUR_AWS_REGION>`, `<YOUR_AWS_ACCOUNT>`, and `<YOUR_QUEUE_NAME>` with the AWS region that hosts your SQS queue, your AWS account ID, and your SQS queue name respectively.
</Aside>

4. Click **Next: Tags**. You don't need to add any tags.
5. Click **Next: Review**.
6. Enter a suitable name for your policy.
7. Click **Create Policy**.

You have created a policy that grants the permissions required to use an SQS queue.

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

## Related Topics

- [Overview](https://ably.com/docs/platform/integrations/streaming.md): Outbound streaming integrations enable you to stream data from Ably to an external service for realtime processing.
- [Kafka](https://ably.com/docs/platform/integrations/streaming/kafka.md): Send data to Kafka based on message, channel lifecycle, channel occupancy, and presence events.
- [Kinesis](https://ably.com/docs/platform/integrations/streaming/kinesis.md): Send data to Kinesis based on message, channel lifecycle, channel occupancy, and presence events.
- [AMQP](https://ably.com/docs/platform/integrations/streaming/amqp.md): Send data to AMQP based on message, channel lifecycle, channel occupancy, and presence events.
- [Pulsar](https://ably.com/docs/platform/integrations/streaming/pulsar.md): Send data to Pulsar based on message, channel lifecycle, channel occupancy, and presence events.
- [DataDog](https://ably.com/docs/platform/integrations/streaming/datadog.md): Connect Ably and Datadog to monitor messages, channels, and connections in realtime, integrating your Ably statistics with your existing Datadog setup.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
