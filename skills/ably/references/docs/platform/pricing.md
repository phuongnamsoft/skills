# Pricing overview

Ably offers two usage-based pricing models:

* [Per minute pricing](#per-minute), where you pay for the channels, connections and messages that you use.
* [MAU (Monthly Active User) pricing](#mau), where you pay a fixed amount based on the number of unique active users each month.

For full details of the models, refer to the [pricing](https://ably.com/pricing) page.

## Packages 

Ably offers four different package types so that you can choose the one that best suits your needs:

* [Free:](https://ably.com/docs/platform/pricing/free.md) for experimenting with Ably, or building a proof of concept. No credit card required.
* [Standard:](https://ably.com/docs/platform/pricing/standard.md) for when you're ready to roll out into production.
* [Pro:](https://ably.com/docs/platform/pricing/pro.md) higher limits than the standard package to accommodate a growing business.
* [Enterprise:](https://ably.com/docs/platform/pricing/enterprise.md) create a custom package to meet all of your business needs.

Packages have a monthly base package price which is the same regardless of which pricing model you choose:

| Free | Standard | Pro | Enterprise |
| ---- | -------- | --- | ---------- |
| N/A | $29 | $399 | Custom |

## Per minute pricing 

Ably primarily charges based on three units of consumption under the per minute pricing model:

| Unit | Description |
| ---- | ----------- |
| Messages *(per million)* | The unit of data transfer throughout Ably. For example, if a user sends (publishes) a message and 10 users receive it (subscribed) that counts as 11 messages. Other operations also count towards the total message count, such as retrieving messages from history, or sending them through an integration. |
| Active channels`[*]` *(per million minutes)* | [Channels](https://ably.com/docs/channels.md) are used to logically separate message traffic into different topics, such as `account-debits` and `account-credits`. For example, if you have three chat rooms open with users communicating in all of them for 2 hours then that would be 6 hours of channel time. The number of users attached to each channel does not influence the channel minutes. |
| Connections *(per million minutes)* | A [connection](https://ably.com/docs/connect.md) is established between your clients and Ably for realtime communication. For example, if you have 5 users that are all connected to Ably for exactly 10 minutes each, this counts as 50 minutes worth of connection time. If you have 50,000 users that are connected to Ably for 3 hours each, then this counts as 9,000,000 minutes. |

`[*]` Channels are created on demand when clients attach to them. They remain active until there are no more realtime clients attached, approximately one minute has passed since the last client detached, and approximately one minute has passed since the last message was published to the channel.

### Message cost 

Messages are charged at $2.50 per million messages consumed.

Depending on volume, rates can go as low as $0.50 per million messages.

### Channel minutes cost 

Channels are charged at $1.00 for every million minutes of activity.

Depending on volume, rates can go as low as $0.20 per million minutes.

### Connection minutes cost 

Connections are charged at $1.00 for every million minutes of activity.

Depending on volume, rates can go as low as $0.20 per million minutes.

### Bandwidth 

There is also a charge on additional bandwidth consumed.

This is worked out based on the average message size of 5KiB multiplied by the number of messages consumed in the month. If your total bandwidth for the month is less than this value then there is no charge for bandwidth. Anything over this value is charged at $0.25 per GiB.

## MAU (Monthly Active User) pricing 

Ably charges based on the number of unique active users (MAUs) each month under the MAU pricing model.

Each MAU is charged at $0.05 per user.

Depending on volume, rates can go as low as $0.01 per user.

### MAU limits 

There are limits in the MAU model to ensure fair usage:

| Limit | Description |
| ----- | ----------- |
| Messages per user, each month | 20,000 |
| Connection minutes per user, each month | 2,000 |

Usage above these limits will be charged at the standard per minute pricing rates:

* $2.50 per million messages
* $1.00 per million connection minutes

## Limits 

There are limits on certain operations within Ably. This is to protect against deliberate or accidental abuse of your application, and to provide a level of protection on your consumption costs if abuse does occur.

Whilst hitting a limit should be an infrequent occurrence if you're on the correct package, it's important to be aware of the different types of limits that exist.

The following table explains the limits related to the three primary units:

| Limit | Free | Standard | Pro | Enterprise |
| ----- | ---- | -------- | --- | ---------- |
| Message rate (per second)<p>*the maximum rate at which messages can be published and received across your account each second*</p> | 500 | 2,500 | 10,000 | Unlimited |
| Messages (per month)<p>*the maximum number of messages that can be sent and received across your account each month*</p> | 6,000,000 | Unlimited | Unlimited | Unlimited |
| Concurrent channels<p>*the maximum number of channels that are active simultaneously at any point*</p> | 200 | 10,000 | 50,000 | Unlimited |
| Concurrent connections<p>*the maximum number of realtime clients connected to Ably simultaneously at any point*</p> | 200 | 10,000 | 50,000 | Unlimited |

Find out more about [limits](https://ably.com/docs/platform/pricing/limits.md).

## Billing 

It's important to understand how, and when, you're billed.

Invoices are issued in arrears on the first of each month. They include:

* Your base package price.
* Either;
  * Your consumption of messages, and channel and connection minutes used in the previous month, if you're on the per minute pricing model.
  * The number of unique active users you had in the previous month, if you're on the MAU pricing model.

Find out more about [billing](https://ably.com/docs/platform/pricing/billing.md).

## Related Topics

- [Billing](https://ably.com/docs/platform/pricing/billing.md): Understand how invoicing and billing works for Ably packages.
- [Limits](https://ably.com/docs/platform/pricing/limits.md): The limits associated with each Ably package.
- [Pricing FAQs](https://ably.com/docs/platform/pricing/faqs.md): A list of the most commonly asked questions related to Ably pricing.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
