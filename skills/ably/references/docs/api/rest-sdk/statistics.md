# Statistics

### <If lang="javascript,nodejs,ruby,python,php,java">stats</If><If lang="csharp,go">Stats</If> 

<If lang="javascript,nodejs">

`stats(Object params?): Promise<PaginatedResult<Stats>>`

</If>
<If lang="ruby">

`PaginatedResult<Stats> stats(Hash options)`

</If>
<If lang="python">

`PaginatedResult<Stats> stats(kwargs_options)`

</If>
<If lang="php">

`PaginatedResult<Stats> stats(Array options)`

</If>
<If lang="java">

`PaginatedResult<Stats> stats(Param[] options)`

</If>
<If lang="csharp">

`Task<PaginatedResult<Stats>> StatsAsync(StatsRequestParams query)`

</If>
<If lang="swift,objc">

`stats(query: ARTStatsQuery?, callback: (ARTPaginatedResult<ARTStats>?, ARTErrorInfo?) -> Void) throws`

</If>
<If lang="go">

`(c *RestClient) Stats(params *PaginateParams) (*PaginatedResult, error)`

</If>

This call queries the [REST `/stats` API](https://ably.com/docs/api/rest-api.md#stats) and retrieves your application's usage statistics. A [PaginatedResult](https://ably.com/docs/api/rest-sdk/types.md#paginated-result) is returned, containing an array of [Stats](#stats-type) for the first page of results. [PaginatedResult](https://ably.com/docs/api/rest-sdk/types.md#paginated-result) objects are iterable providing a means to page through historical statistics. [See an example set of raw stats returned via the REST API](https://ably.com/docs/metadata-stats/stats.md#metrics).

#### Parameters

<If lang="javascript,nodejs,java,csharp,python,php,go">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="csharp">query</If><If lang="javascript,nodejs">params</If><If lang="java,python,php,go">options</If> | An optional object containing the query parameters<If lang="javascript,nodejs"> used to specify which statistics are retrieved. If not specified the default parameters will be used</If> | <If lang="csharp">[`StatsRequestParams`](#stats-request-params)</If><If lang="java">[`Param[]`](#param)</If><If lang="javascript,nodejs">Object</If><If lang="python">kwargs</If><If lang="php">Array</If><If lang="go">`*PaginateParams`</If> |

</If>

<If lang="ruby">

| Parameter | Description | Type |
|-----------|-------------|------|
| options | An optional object containing the query parameters | Hash |
| &block | yields a `PaginatedResult<Stats>` object | Block |

</If>

<If lang="swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| query | An optional object containing the query parameters | `ARTStatsQuery` |
| callback | called with a ARTPaginatedResult&lt;[ARTStats](https://ably.com/docs/api/rest-sdk/types.md#stats)&gt; object or an error | Callback |

</If>

#### <If lang="objc,swift">`ARTStatsQuery` properties</If><If lang="csharp">`StatsRequestParams` properties</If><If lang="javascript,nodejs">`params` properties</If><If lang="ruby,java,python,php,go">`options` parameters</If>

The following options, as defined in the [REST `/stats` API](https://ably.com/docs/api/rest-api.md#stats) endpoint, are permitted:

| Property | Description | Type |
|----------|-------------|------|
| <If lang="csharp">Start</If><If lang="ruby">:start</If><If lang="javascript,nodejs,java,python,php,swift,objc,go">start</If> | Earliest <If lang="csharp">`DateTimeOffset` or </If><If lang="ruby">`Time` or </If>time in milliseconds since the epoch for any stats retrieved. <br />_Default: beginning of time_ | <If lang="javascript,nodejs">`Number`</If><If lang="ruby">`Int` or `Time`</If><If lang="java,python,php,swift,objc,go">`Long`</If><If lang="csharp">`DateTimeOffset`</If> |
| <If lang="csharp">End</If><If lang="ruby">:end</If><If lang="javascript,nodejs,java,python,php,swift,objc,go">end</If> | Latest <If lang="csharp">`DateTimeOffset` or </If><If lang="ruby">`Time` or </If>time in milliseconds since the epoch for any stats retrieved. <br />_Default: current time_ | <If lang="javascript,nodejs">`Number`</If><If lang="ruby">`Int` or `Time`</If><If lang="java,python,php,swift,objc,go">`Long`</If><If lang="csharp">`DateTimeOffset`</If> |
| <If lang="csharp">Direction</If><If lang="ruby">:direction</If><If lang="javascript,nodejs,java,python,php,swift,objc,go">direction</If> | <If lang="ruby">`:forwards` or `:backwards`</If><If lang="javascript,nodejs,java,python,php,swift,objc,go">`forwards` or `backwards`</If><If lang="csharp">`forwards` or `backwards`</If>. <br />_Default: `backwards`_ | <If lang="javascript,nodejs,java,python,php,swift,objc,go">`String`</If><If lang="ruby">`Symbol`</If><If lang="csharp">`Direction` enum</If> |
| <If lang="csharp">Limit</If><If lang="ruby">:limit</If><If lang="javascript,nodejs,java,python,php,swift,objc,go">limit</If> | Maximum number of stats to retrieve up to 1,000. <br />_Default: `100`_ | <If lang="javascript,nodejs">`Number`</If><If lang="ruby,java,python,php,swift,objc,go,csharp">`Integer`</If> |
| <If lang="csharp">Unit</If><If lang="ruby">:unit</If><If lang="javascript,nodejs,java,python,php,swift,objc,go">unit</If> | <If lang="ruby">`:minute`, `:hour`, `:day` or `:month`</If><If lang="csharp">`Minute`, `Hour`, `Day` or `Month`</If><If lang="javascript,nodejs,java,python,php,swift,objc,go">`minute`, `hour`, `day` or `month`</If>. Based on the unit selected, the given start or end times are rounded down to the start of the relevant interval depending on the unit granularity of the query. <br />_Default: <If lang="csharp">`Minute`</If><If lang="ruby">`:minute`</If><If lang="javascript,nodejs,java,python,php,swift,objc,go">`minute`</If>_ | <If lang="javascript,nodejs">[`StatsIntervalGranularity`](https://ably.com/docs/api/rest-sdk/types.md#stats-granularity)</If><If lang="ruby">`Symbol`</If><If lang="java,python,php,go">`String`</If><If lang="swift,objc">[`ARTStatsGranularity`](#stats-granularity)</If><If lang="csharp">[`StatsIntervalGranularity`](https://ably.com/docs/api/rest-sdk/types.md#stats-granularity) enum</If> |

<If lang="javascript,nodejs">

#### Returns

Returns a promise. On success, the promise is fulfilled with a [PaginatedResult](https://ably.com/docs/api/rest-sdk/types.md#paginated-result) object containing an array of [Stats](https://ably.com/docs/api/rest-sdk/types.md#stats) objects. On failure, the promise is rejected with an [ErrorInfo](https://ably.com/docs/api/rest-sdk/types.md#error-info) object.

</If>

<If lang="objc,swift">

#### Callback result

On success, `result` contains a [PaginatedResult](#paginated-result) encapsulating an array of [Stats](https://ably.com/docs/api/rest-sdk/types.md#stats) objects corresponding to the current page of results. [PaginatedResult](#paginated-result) supports pagination using [next](#paginated-result) and [first](#paginated-result) methods.

On failure to retrieve stats, `err` contains an [ErrorInfo](#error-info) object with an error response as defined in the [Ably REST API](https://ably.com/docs/api/rest-api.md#common) documentation.

</If>

<If lang="java,ruby,php">

#### Returns

On success, the returned [PaginatedResult](#paginated-result) encapsulates an array of [Stats](https://ably.com/docs/api/rest-sdk/types.md#stats) objects corresponding to the current page of results. [PaginatedResult](#paginated-result) supports pagination using [next](#paginated-result) and [first](#paginated-result) methods.

Failure to retrieve the stats will raise an [AblyException](https://ably.com/docs/api/rest-sdk/types.md#ably-exception)

</If>

<If lang="csharp">

#### Returns

The method is asynchronous and return Task which needs to be awaited.

On success, the returned [PaginatedResult](#paginated-result) encapsulates a list of [Stats](https://ably.com/docs/api/rest-sdk/types.md#stats) objects corresponding to the current page of results. [PaginatedResult](#paginated-result) supports pagination using [NextAsync](#paginated-result) and [FirstAsync](#paginated-result) methods.

Failure to retrieve the stats will raise an [AblyException](https://ably.com/docs/api/rest-sdk/types.md#ably-exception)

</If>

## Related types 

### <If lang="objc,swift">ARTStats</If><If lang="java">io.ably.lib.types.Stats</If><If lang="ruby">Ably::Models::Stats</If><If lang="php">Ably\Models\Stats</If><If lang="csharp">IO.Ably.Stats</If><If lang="javascript,nodejs,python,go">Stats object</If> 

A `Stats` object represents an application's statistics for the specified interval and time period. Ably aggregates statistics globally for all accounts and applications, and makes these available both through our [statistics API](https://ably.com/docs/metadata-stats/stats.md) as well as your [application dashboard](https://ably.com/dashboard).

<If lang="ruby,python,java,php,csharp,swift,objc,go">

Please note that most attributes of the `Stats` type below contain references to further stats types. This documentation is not exhaustive for all stats types, and as such, links to the stats types below will take you to the [Ruby library stats documentation](https://www.rubydoc.info/gems/ably/Ably/Models/Stats) which contains exhaustive stats documentation. Ruby and Python however uses `under_score` case instead of the default `camelCase` in most languages, so please bear that in mind.

</If>

#### <If lang="java">Members</If><If lang="ruby">Attributes</If><If lang="python">Keyword arguments</If><If lang="javascript,nodejs,csharp,php,swift,objc,go">Properties</If>

<If lang="ruby,python,java,php,csharp,swift,objc,go">

| Property | Description | Type |
|----------|-------------|------|
| <If lang="csharp,go">Unit</If><If lang="ruby,python,java,php,swift,objc">unit</If> | the length of the interval that this statistic covers, such as <If lang="ruby">`:minute`, `:hour`, `:day`, `:month`</If><If lang="csharp">`Minute`, `Hour`, `Day`, `Month`</If><If lang="go">`StatGranularityDay`, `StatGranularityMonth`</If><If lang="java,php,swift,objc,python">`'minute'`, `'hour'`, `'day'`, `'month'`</If>. | <If lang="ruby">[`Stats::GRANULARITY`](https://www.rubydoc.info/gems/ably/Ably/Models/Stats#GRANULARITY-constant)</If><If lang="csharp">[`StatsIntervalGranularity`](https://ably.com/docs/api/realtime-sdk/types.md#stats-granularity) enum</If><If lang="swift,objc">`ARTStatsGranularity`</If><If lang="java,php,go,python">`String`</If> |
| <If lang="ruby,python">interval_granularity</If><If lang="swift,objc,csharp">intervalGranularity</If> | <If lang="ruby,python,objc,swift,csharp">Deprecated alias for `unit`; scheduled to be removed in version 2.x client library versions.</If> | <If lang="ruby">[`Stats::GRANULARITY`](https://www.rubydoc.info/gems/ably/Ably/Models/Stats#GRANULARITY-constant)</If><If lang="csharp">[`StatsIntervalGranularity`](https://ably.com/docs/api/realtime-sdk/types.md#stats-granularity) enum</If><If lang="swift,objc">`ARTStatsGranularity`</If><If lang="python">`String`</If> |
| <If lang="ruby,python">interval_id</If><If lang="csharp,go">IntervalId</If><If lang="java,php,swift,objc">intervalId</If> | the UTC time at which the time period covered by this `Stats` object starts. For example, an interval ID value of "2018-03-01:10" in a `Stats` object whose `unit` is `day` would indicate that the period covered is "2018-03-01:10 .. 2018-03-01:11". All `Stats` objects, except those whose `unit` is `minute`, have an interval ID with resolution of one hour and the time period covered will always begin and end at a UTC hour boundary. For this reason it is not possible to infer the `unit` by looking at the resolution of the <If lang="ruby,python">`interval_id`</If><If lang="csharp,go">`IntervalId`</If><If lang="java,php,swift,objc">`intervalId`</If>. `Stats` objects covering an individual minute will have an interval ID indicating that time; for example "2018-03-01:10:02". | `String` |
| <If lang="ruby,python">interval_time</If><If lang="csharp,go">IntervalTime</If> | <If lang="ruby,python,csharp,go">A <If lang="ruby">`Time`</If><If lang="python">`DateTime`</If><If lang="csharp,go">`DateTimeOffset`</If> object representing the parsed <If lang="ruby,python">`interval_id`</If><If lang="csharp,go">`IntervalId`</If> (the UTC time at which the time period covered by this `Stats` object starts)</If> | <If lang="ruby">`Time`</If><If lang="python">`DateTime`</If><If lang="csharp,go">`DateTimeOffset`</If> |
| <If lang="csharp,go">All</If><If lang="ruby,python,java,php,swift,objc">all</If> | aggregate count of both `inbound` and `outbound` message stats | [`MessageTypes`](https://www.rubydoc.info/gems/ably/Ably/Models/Stats/MessageTypes) |
| <If lang="ruby,python">api_requests</If><If lang="csharp,go">ApiRequests</If><If lang="java,php,swift,objc">apiRequests</If> | breakdown of API requests received via the Ably REST API | [`RequestCount`](https://www.rubydoc.info/gems/ably/Ably/Models/Stats/RequestCount) |
| <If lang="csharp,go">Channels</If><If lang="ruby,python,java,php,swift,objc">channels</If> | breakdown of channel related stats such as min, mean and peak channels | [`ResourceCount`](https://www.rubydoc.info/gems/ably/Ably/Models/Stats/ResourceCount) |
| <If lang="csharp,go">Connections</If><If lang="ruby,python,java,php,swift,objc">connections</If> | breakdown of connection related stats such as min, mean and peak connections for TLS and non-TLS connections | [`ConnectionTypes`](https://www.rubydoc.info/gems/ably/Ably/Models/Stats/ConnectionTypes) |
| <If lang="csharp,go">Inbound</If><If lang="ruby,python,java,php,swift,objc">inbound</If> | statistics such as count and data for all inbound messages received over REST and Realtime connections, organized into normal channel messages or presence messages | [`MessageTraffic`](https://www.rubydoc.info/gems/ably/Ably/Models/Stats/MessageTraffic) |
| <If lang="csharp,go">Outbound</If><If lang="ruby,python,java,php,swift,objc">outbound</If> | statistics such as count and data for all outbound messages retrieved via REST history requests, received over Realtime connections, or pushed with Webhooks, organized into normal channel messages or presence messages | [`MessageTraffic`](https://www.rubydoc.info/gems/ably/Ably/Models/Stats/MessageTraffic) |
| <If lang="csharp,go">Persisted</If><If lang="ruby,python,java,php,swift,objc">persisted</If> | messages persisted and later retrieved via the [history API](https://ably.com/docs/storage-history/history.md) | [`MessageTypes`](https://www.rubydoc.info/gems/ably/Ably/Models/Stats/MessageTypes) |
| <If lang="ruby,python">token_requests</If><If lang="csharp,go">TokenRequests</If><If lang="java,php,swift,objc">tokenRequests</If> | breakdown of Ably Token requests received via the Ably REST API. | [`RequestCount`](https://www.rubydoc.info/gems/ably/Ably/Models/Stats/RequestCount) |
| <If lang="csharp,go">Push</If><If lang="ruby,python,java,php,swift,objc">push</If> | Detailed stats on push notifications, see [our Push documentation](https://ably.com/push) for more details | `PushStats` |

</If>

<If lang="javascript,nodejs">

| Property | Description | Type |
|----------|-------------|------|
| appId | the ID of the Ably application the statistics relate to. | `String` |
| entries | The statistics for the requested time interval and time period. The `schema` property provides further information | `Partial<Record<String, Number>>` |
| inProgress | Optional. For entires that are still in progress, such as the current month, the last sub-interval included in the stats entry. In the format `yyyy-mm-dd:hh:mm:ss` | `String` |
| intervalId | The UTC time period that the stats coverage begins at. If `unit` was requested as `minute` this will be in the format `YYYY-mm-dd:HH:MM`, if `hour` it will be `YYYY-mm-dd:HH`, if `day` it will be `YYYY-mm-dd:00` and if `month` it will be `YYYY-mm-01:00` | `String` |
| schema | The URL of a JSON schema describing the structure of the `Stats` object | `String` |

</If>

<If lang="csharp">

### IO.Ably.StatsRequestParams 

`StatsRequestParams` is a type that encapsulates the parameters for a stats query. For example usage see [`Realtime#Stats`](https://ably.com/docs/metadata-stats/stats.md).

#### Members

| Member | Description | Type |
|--------|-------------|------|
| Start | The start of the queried interval <br />_Default: null_ | `DateTimeOffset` |
| End | The end of the queried interval <br />_Default: null_ | `DateTimeOffset` |
| Limit | By default it is null. Limits the number of items returned by history or stats <br />_Default: null_ | `Integer` |
| Direction | Enum which is either `Forwards` or `Backwards` <br />_Default: Backwards_ | `Direction` enum |
| Unit | `Minute`, `Hour`, `Day` `Month`. Based on the unit selected, the given start or end times are rounded down to the start of the relevant interval depending on the unit granularity of the query <br />_Default: Minute_ | [`StatsIntervalGranularity`](https://ably.com/docs/api/realtime-sdk/types.md#stats-granularity) enum |
| ExtraParameters | Optionally any extra query parameters that may be passed to the query. This is mainly used internally by the library to manage paging. | `Dictionary<string, string>` |

</If>

<If lang="objc,swift,javascript,nodejs,csharp">

### <If lang="objc,swift">ARTStatsGranularity</If><If lang="javascript,nodejs,csharp">StatsIntervalGranularity</If> 

<If lang="javascript,nodejs">

`StatsIntervalGranularity` is an enum specifying the granularity of a [`Stats` interval](https://ably.com/docs/api/rest-sdk/statistics.md#stats-type).

<If lang="javascript">

<Code>

#### Javascript

```
  const StatsIntervalGranularity = [
      'minute',
      'hour',
      'day',
      'month'
  ]
```
</Code>

</If>
<If lang="nodejs">

<Code>

#### Nodejs

```
  const StatsIntervalGranularity = [
      'minute',
      'hour',
      'day',
      'month'
  ]
```
</Code>

</If>

</If>

<If lang="objc,swift">

`ARTStatsGranularity` is an enum specifying the granularity of a [`ARTStats` interval](https://ably.com/docs/api/rest-sdk/statistics.md#stats-type).

<If lang="objc">

<Code>

#### Objc

```
  typedef NS_ENUM(NSUInteger, ARTStatsGranularity) {
      ARTStatsGranularityMinute,
      ARTStatsGranularityHour,
      ARTStatsGranularityDay,
      ARTStatsGranularityMonth
  };
```
</Code>

</If>
<If lang="swift">

<Code>

#### Swift

```
  enum ARTStatsGranularity : UInt {
      case Minute
      case Hour
      case Day
      case Month
  }
```
</Code>

</If>
</If>

<If lang="csharp">

`StatsIntervalGranularity` is an enum specifying the granularity of a [`Stats` interval](https://ably.com/docs/api/rest-sdk/statistics.md#stats-type).

<Code>

#### Csharp

```
  public enum StatsIntervalGranularity
  {
      Minute,
      Hour,
      Day,
      Month
  }
```
</Code>

</If>
</If>

<If lang="java">

### io.ably.lib.types.Param 

`Param` is a type encapsulating a key/value pair. This type is used frequently in method parameters allowing key/value pairs to be used more flexible, see [`Channel#history`](https://ably.com/docs/api/realtime-sdk/history.md#channel-history) for an example.

Please note that `key` and `value` attributes are always strings. If an `Integer` or other value type is expected, then you must coerce that type into a `String`.

#### Members

| Member | Description | Type |
|--------|-------------|------|
| key | The key value | `String` |
| value | The value associated with the `key` | `String` |

</If>

## Related Topics

- [Constructor](https://ably.com/docs/api/rest-sdk.md): Client Library SDK REST API Reference constructor documentation.
- [Channels](https://ably.com/docs/api/rest-sdk/channels.md): Client Library SDK REST API Reference Channels documentation.
- [Channel Status](https://ably.com/docs/api/rest-sdk/channel-status.md): Client Library SDK REST API Reference Channel Status documentation.
- [Messages](https://ably.com/docs/api/rest-sdk/messages.md): Client Library SDK REST API Reference Message documentation.
- [Presence](https://ably.com/docs/api/rest-sdk/presence.md): Presence events provide clients with information about the status of other clients 'present' on a channel
- [Authentication](https://ably.com/docs/api/rest-sdk/authentication.md): Client Library SDK REST API Reference Authentication documentation.
- [History](https://ably.com/docs/api/rest-sdk/history.md): Client Library SDK REST API Reference History documentation.
- [Push Notifications - Admin](https://ably.com/docs/api/rest-sdk/push-admin.md): Client Library SDK REST API Reference Push documentation.
- [Encryption](https://ably.com/docs/api/rest-sdk/encryption.md): Client Library SDK REST API Reference Crypto documentation.
- [Types](https://ably.com/docs/api/rest-sdk/types.md): Client Library SDK REST API Reference Types documentation.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
