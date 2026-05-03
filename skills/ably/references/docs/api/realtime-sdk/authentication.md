# Authentication

This is the Authentication API Reference.

## Tokens 

In the documentation, references to Ably-compatible tokens typically refer either to an Ably Token, or an [Ably JWT](#ably-jwt). For Ably Tokens, this can either be referring to the `TokenDetails` object that contain the `token` string or the token string itself. `TokenDetails` objects are obtained when [requesting an Ably Token](#request-token) from the Ably service and contain not only the `token` string in the `token` attribute, but also contain attributes describing the properties of the Ably Token. For [Ably JWT](#ably-jwt), this will be simply referring to a JWT which has been signed by an Ably private API key.

## Auth object 

The principal use-case for the `Auth` object is to create Ably [`TokenRequest`](#token-request) objects with [createTokenRequest](#create-token-request) or obtain [Ably Tokens](#token-details) from Ably with [requestToken](#request-token), and then issue them to other "less trusted" clients. Typically, your servers should be the only devices to have a [private API key](https://ably.com/docs/auth.md#api-key), and this private API key is used to securely sign Ably [`TokenRequest`](#token-request) objects or request [Ably Tokens](#token-details) from Ably. Clients are then issued with these short-lived [Ably Tokens](#token-details) or Ably [`TokenRequest`](#token-request) objects, and the libraries can then use these to authenticate with Ably. If you adopt this model, your private API key is never shared with clients directly.

A subsidiary use-case for the `Auth` object is to preemptively trigger renewal of a token or to acquire a new token with a revised set of capabilities by explicitly calling <If lang="javascript,nodejs,java,objc,ruby,swift">[`authorize`](#authorize)</If><If lang="csharp">[`Authorize`](#authorize)</If>.

The Auth object is available as the <If lang="java">[`auth` field](https://ably.com/docs/api/realtime-sdk.md#auth)</If><If lang="csharp">[`Auth` property](https://ably.com/docs/api/realtime-sdk.md#auth)</If><If lang="javascript,nodejs,objc,swift">[`auth` property](https://ably.com/docs/api/realtime-sdk.md#auth)</If><If lang="ruby">[`auth` attribute](https://ably.com/docs/api/realtime-sdk.md#auth)</If> of an [Ably Realtime client instance](https://ably.com/docs/api/realtime-sdk.md#constructor).

## <If lang="javascript,nodejs">Auth Properties</If><If lang="java">io.ably.lib.rest.Auth Members</If><If lang="csharp">IO.Ably.AblyAuth Properties</If><If lang="ruby">Ably::Auth Attributes</If><If lang="objc,swift">ARTAuth Properties</If> 

The <If lang="objc,swift">`ART`</If>`Auth` object exposes the following public <If lang="javascript,nodejs,csharp,objc,swift">properties</If><If lang="ruby">attributes</If><If lang="java">members</If>:

### <If lang="javascript,nodejs,java,objc,swift">clientId</If><If lang="ruby">client_id</If><If lang="csharp">ClientId</If> 

The client ID string, if any, configured for this client connection. See [identified clients](https://ably.com/docs/auth/identified-clients.md) for more information on trusted client identifiers.

## <If lang="javascript,nodejs">Auth Methods</If><If lang="java">io.ably.lib.rest.Auth Methods</If><If lang="csharp">IO.Ably.AblyAuth Methods</If><If lang="ruby">Ably::Auth Methods</If><If lang="objc,swift">ARTAuth Methods</If> 

### <If lang="javascript,nodejs,java,ruby,objc,swift">authorize</If><If lang="csharp">Authorize</If> 

<If lang="javascript,nodejs">

`authorize(TokenParams tokenParams?, AuthOptions authOptions?): Promise<TokenDetails>`

</If>

<If lang="ruby">

`Deferrable authorize(TokenParams token_params, AuthOptions auth_options) -> yields TokenDetails`

</If>

<If lang="java">

`TokenDetails authorize(TokenParams tokenParams, AuthOptions authOptions)`

</If>

<If lang="csharp">

`Task<TokenDetails> AuthorizeAsync(TokenParams?, AuthOptions?)`

</If>

<If lang="swift,objc">

`authorize(tokenParams: ARTTokenParams?, authOptions: ARTAuthOptions?, callback: (ARTTokenDetails?, NSError?) -> Void)`

</If>

Instructs the library to get a new token immediately. Once fetched, it will upgrade the current realtime connection to use the new token, or if not connected, will initiate a connection to Ably once the new token has been obtained. Also stores any <If lang="ruby">`token_params` and `auth_options`</If><If lang="javascript,nodejs,java,csharp,objc,swift">`tokenParams` and `authOptions`</If> passed in as the new defaults, to be used for all subsequent implicit or explicit token requests.

Any <If lang="ruby">`token_params` and `auth_options`</If><If lang="javascript,nodejs,java,csharp,objc,swift">`tokenParams` and `authOptions`</If> objects passed in will entirely replace (as opposed to being merged with) the currently client library saved <If lang="ruby">`token_params` and `auth_options`</If><If lang="javascript,nodejs,java,csharp,objc,swift">`tokenParams` and `authOptions`</If>.

#### Parameters

<If lang="javascript,nodejs,java,csharp">

| Parameter | Description | Type |
|-----------|-------------|------|
| tokenParams | <If lang="javascript,nodejs,csharp">an optional object containing the [token parameters](#token-params)</If><If lang="java">an optional [`TokenParams`](#token-params) object containing the [Ably Token](#token-details) parameters</If> for the authorization request | [`TokenParams`](#token-params) |
| authOptions | <If lang="javascript,nodejs,csharp">an optional object containing the [authentication options](#auth-options)</If><If lang="java">an optional [`TokenParams`](#auth-options) object containing the authentication options</If> for the authorization request | [`AuthOptions`](#auth-options) |

</If>

<If lang="ruby,swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="ruby">token_params</If><If lang="objc,swift">tokenParams</If> | <If lang="objc,swift">an optional object containing the [token parameters](#token-params)</If><If lang="ruby">an optional set of key value pairs containing the [token parameters](#token-params)</If> for the authorization request | [`TokenParams`](#token-params) |
| <If lang="ruby">auth_options</If><If lang="objc,swift">authOptions</If> | <If lang="objc,swift">an optional object containing the [authentication options](#auth-options)</If><If lang="ruby">an optional set of key value pairs containing the [authentication options](#auth-options)</If> for the authorization request | [`AuthOptions`](#auth-options) |
| <If lang="ruby">&block</If><If lang="swift,objc">callback</If> | <If lang="ruby">yields a [`TokenDetails`](#token-details) object</If><If lang="swift,objc">called with a [`ARTTokenDetails`](#token-details) object or an error</If> | |

</If>

<If lang="objc,swift">

#### Callback result

On success, the callback will be called with the new [`TokenDetails`](#token-details) object only once the realtime connection has been successfully upgraded to use the new token.

On failure to obtain an token or upgrade the token, the connection will move to the `SUSPENDED` or `FAILED` state, and the callback will be called with  `err` containing an `NSError` object with the error response as defined in the [Ably REST API](https://ably.com/docs/api/rest-api.md#common) documentation.

The `authorize` callback can therefore be used to only trigger an event once the new token has taken effect. This can be useful if, for example, you want to do attach to a new channel following a new channel capability being applied to the connection.

</If>
<If lang="javascript,nodejs">

#### Returns

Returns a promise.

On success, the promise is fulfilled with the new [`TokenDetails`](#token-details) once the realtime connection has been successfully upgraded to use the new token.

On failure to obtain a token or upgrade the token, the connection will move to the `SUSPENDED` or `FAILED` state, and the promise will be rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the error response as defined in the [Ably REST API](https://ably.com/docs/api/rest-api.md#common) documentation.

</If>
<If lang="java">

#### Returns

On success, a new [`TokenDetails`](#token-details) is returned only once the realtime connection has been successfully upgraded to use the new [Ably Token](#token-details).

On failure to obtain a token or upgrade the token, the connection will move to the `SUSPENDED` or `FAILED` state and an [`AblyException`](#ably-exception) will be raised with the error response as defined in the [Ably REST API](https://ably.com/docs/api/rest-api.md#common) documentation.

The synchronous `authorize` method can therefore be used to run subsequent code only once the new token has taken effect. This can be useful if, for example, you want to do attach to a new channel following a new channel capability being applied to the connection.

</If>
<If lang="csharp">

#### Returns

Returns a `Task<TokenDetails>` which needs to be awaited.

On success, a new [`TokenDetails`](#token-details) is returned only once the realtime connection has been successfully upgraded to use the new token.

On failure to obtain a token or upgrade the token, the connection will move to the `SUSPENDED` or `FAILED` state and an [`AblyException`](#ably-exception) will be raised with the error response as defined in the [Ably REST API](https://ably.com/docs/api/rest-api.md#common) documentation.

By waiting for the `authorize` method return value, it can be used to run subsequent code only once the new token has taken effect. This can be useful if, for example, you want to do attach to a new channel following a new channel capability being applied to the connection.

</If>
<If lang="ruby">

#### Returns

A [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) object is returned from this method.

On success, the registered success callbacks for the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and any block provided to this method yields a [`TokenDetails`](#token-details) only once the realtime connection has been successfully upgraded to use the new token.

On failure to obtain a token or upgrade the token, the connection will move to the `SUSPENDED` or `FAILED` state, triggering the `errback` callbacks of the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) with an [`ErrorInfo`](#error-info) object with the error response as defined in the [Ably REST API](https://ably.com/docs/api/rest-api.md#common) documentation.

The `authorize` callbacks can therefore be used to trigger an event once the new [Ably Token](#token-details) has taken effect. This can be useful if, for example, you want to do attach to a new channel following a new channel capability being applied to the connection.

</If>

#### Example

<If lang="javascript">

<Code>

##### Javascript

```
try {
  const tokenDetails = await client.auth.authorize({ clientId: 'bob' });
  console.log('Success; token: ' + tokenDetails.token);
} catch (error) {
  console.log('An error occurred; err = ' + error.message);
}
```
</Code>

</If>
<If lang="nodejs">

<Code>

##### Nodejs

```
try {
  const tokenDetails = await client.auth.authorize({ clientId: 'bob' });
  console.log('Success; token: ' + tokenDetails.token);
} catch (error) {
  console.log('An error occurred; err = ' + error.message);
}
```
</Code>

</If>
<If lang="java">

<Code>

##### Java

```
try {
  TokenParams tokenParams = new TokenParams();
  tokenParams.clientId = "bob";
  TokenDetails tokenDetails = client.auth.authorize(tokenParams, null);
  System.out.println("Success; token = " + tokenDetails.token);
} catch(AblyException e) {
  System.out.println("An error occurred; err = " + e.getMessage());
}
```
</Code>

</If>
<If lang="csharp">

<Code>

##### Csharp

```
try {
  TokenParams tokenParams = new TokenParams {ClientId = "bob"};
  TokenDetails tokenDetails = await client.Auth.AuthorizeAsync(tokenParams);
  Console.WriteLine("Success; Token = " + tokenDetails.Token);
} catch (AblyException e) {
  Console.WriteLine("An error occurred; Error = " + e.Message);
}
```
</Code>

</If>
<If lang="ruby">

<Code>

##### Ruby

```
client.auth.authorize(client_id: 'bob') do |token_details|
  puts "Success; token = #{token_details.token}"
end
```
</Code>

</If>
<If lang="objc">

<Code>

##### Objc

```
ARTTokenParams *tokenParams = [[ARTTokenParams alloc] initWithClientId:@"Bob"];
[client.auth authorize:tokenParams options:nil callback:^(ARTTokenDetails *tokenDetails, NSError *error) {
    if (error) {
        NSLog(@"An error occurred; err = %@", error);
    } else {
        NSLog(@"Success; token = %@", tokenDetails.token);
    }
}];
```
</Code>

</If>
<If lang="swift">

<Code>

##### Swift

```
let tokenParams = ARTTokenParams(clientId: "Bob")
client.auth.authorize(tokenParams, options: nil) { tokenDetails, error in
    guard let tokenDetails = tokenDetails else {
        print("An error occurred; err = \(error!)")
        return
    }
    print("Success; token = \(tokenDetails.token)")
}
```
</Code>

</If>

### <If lang="javascript,nodejs,java,objc,swift">createTokenRequest</If><If lang="ruby">create_token_request</If><If lang="csharp">CreateTokenRequestAsync</If> 

<If lang="javascript,nodejs">

`createTokenRequest(TokenParams tokenParams?, AuthOptions authOptions?): Promise<TokenRequest>`

</If>

<If lang="ruby">

`Deferrable create_token_request(TokenParams token_params, AuthOptions auth_options) -> yields TokenRequest`

</If>

<If lang="java">

`TokenRequest createTokenRequest(TokenParams tokenParams, AuthOptions authOptions)`

</If>

<If lang="csharp">

`Task<TokenRequest> CreateTokenRequestAsync(TokenParams tokenParams, AuthOptions authOptions)`

</If>

<If lang="objc,swift">

`createTokenRequest(tokenParams: ARTTokenParams?, options: ARTAuthOptions?, callback: (ARTTokenRequest?, NSError?) -> Void)`

</If>

Creates and signs an Ably [`TokenRequest`](#request-token) based on the specified (or if none specified, the client library stored) <If lang="ruby">`token_params` and `auth_options`</If><If lang="javascript,nodejs,java,csharp,objc,swift">`tokenParams` and `authOptions`</If>. Note this can only be used when the [API `key`](https://ably.com/docs/auth.md#api-key) value is available locally. Otherwise, the Ably [`TokenRequest`](#request-token) must be obtained from the key owner. Use this to generate Ably [`TokenRequests`](#request-token) in order to implement an [Ably Token](#token-details) request callback for use by other clients.

Both <If lang="ruby">`auth_options` and `token_params`</If><If lang="javascript,nodejs,java,csharp,objc,swift">`authOptions` and `tokenParams`</If> are optional. When omitted or `null`, the default token parameters and authentication options for the client library are used, as specified in the `ClientOptions` when the client library was instantiated, or later updated with an explicit <If lang="javascript,nodejs,java,objc,swift,ruby">[`authorize`](#authorize)</If><If lang="csharp">[`Authorize`](#authorize)</If> request.  Values passed in will be used instead of (rather than being merged with) the default values.

To understand why an Ably [`TokenRequest`](#request-token) may be issued to clients in favor of a token, see [Token Authentication explained](https://ably.com/docs/auth/token.md).

#### Parameters

<If lang="javascript,nodejs,java,csharp">

| Parameter | Description | Type |
|-----------|-------------|------|
| tokenParams | <If lang="javascript,nodejs,csharp">an optional object containing the [token parameters](#token-params)</If><If lang="java">an optional [`TokenParams`](#token-params) object containing the token parameters</If> for the [Ably Token](#token-details) request | [`TokenParams`](#token-params) |
| authOptions | <If lang="javascript,nodejs,csharp">an optional object containing the [authentication options](#auth-options)</If><If lang="java">an optional [`TokenParams`](#token-params) object containing the authentication options</If> | [`AuthOptions`](#auth-options) |

</If>

<If lang="ruby,swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="ruby">token_params</If><If lang="objc,swift">tokenParams</If> | <If lang="objc,swift">an optional object containing the [token parameters](#token-params)</If><If lang="ruby">an optional set of key value pairs containing the [token parameters](#token-params)</If> for the [Ably Token](#token-details) request | [`TokenParams`](#token-params) |
| <If lang="ruby">auth_options</If><If lang="objc,swift">authOptions</If> | <If lang="ruby">an optional set of key value pairs containing the [authentication options](#auth-options)</If><If lang="objc,swift">an optional [`ARTTokenParams`](#token-params) containing the [authentication options](#auth-options)</If> | [`AuthOptions`](#auth-options) |
| <If lang="ruby">&block</If><If lang="swift,objc">callback</If> | <If lang="ruby">yields a [`TokenRequest`](#token-request) object</If><If lang="swift,objc">called with a [`ARTTokenRequest`](#token-request) object or an error</If> | |

</If>

<If lang="javascript,nodejs">

#### Returns

Returns a promise.

On success, the promise is fulfilled with the new [`TokenRequest`](#token-request) JSON object

On failure to issue a [`TokenRequest`](#token-request), the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the error response as defined in the [Ably REST API](https://ably.com/docs/api/rest-api.md#common) documentation.

</If>
<If lang="java">

#### Returns

On success, a [`TokenRequest`](#token-request) object is returned.

Failure to issue a [`TokenRequest`](#token-request) will raise an [`AblyException`](#ably-exception).

</If>
<If lang="csharp">

#### Returns

Returns a `Task<string>` which needs to be awaited.

On success, a [`TokenRequest`](#token-request) object is returned.

Failure to issue a [`TokenRequest`](#token-request) will raise an [`AblyException`](#ably-exception).

</If>
<If lang="ruby">

#### Returns

A [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) object is returned from this method.

On success, the registered success callbacks for the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and any block provided to this method yields a [`TokenRequest`](#token-request) object.

Failure to issue a [`TokenRequest`](#token-request) will trigger the errback callbacks of the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) with an [`ErrorInfo`](#error-info) object containing an error response as defined in the [Ably REST API](https://ably.com/docs/api/rest-api.md#common) documentation.

</If>

#### Example

<If lang="javascript">

<Code>

##### Javascript

```
try {
  const tokenRequest = await client.auth.createTokenRequest({ clientId: 'bob' });
  console.log('Success; token request = ' + tokenRequest);
} catch (error) {
  console.log('An error occurred; err = ' + error.message);
}
```
</Code>

</If>

<If lang="nodejs">

<Code>

##### Nodejs

```
try {
  const tokenRequest = await client.auth.createTokenRequest({ clientId: 'bob' });
  console.log('Success; token request = ' + tokenRequest);
} catch (error) {
  console.log('An error occurred; err = ' + error.message);
}
```
</Code>

</If>

<If lang="java">

<Code>

##### Java

```
try {
  TokenParams tokenParams = new TokenParams();
  tokenParams.clientId = "bob";
  TokenRequest tokenRequest = client.auth.createTokenRequest(tokenParams, null);
  System.out.println("Success; token request issued");
} catch(AblyException e) {
  System.out.println("An error occurred; err = " + e.getMessage());
}
```
</Code>

</If>

<If lang="csharp">

<Code>

##### Csharp

```
try {
    TokenParams tokenParams = new TokenParams {ClientId = "bob"};
    TokenRequest tokenRequest = await client.Auth.CreateTokenRequestAsync(tokenParams);
    Console.WriteLine("Success; token request issued");
} catch (AblyException e) {
    Console.WriteLine("An error occurred; err = " + e.Message);
}
```
</Code>

</If>

<If lang="ruby">

<Code>

##### Ruby

```
client.auth.create_token_request(client_id: 'bob') do |token_request|
  puts "Success; token request = #{token_request}"
end
```
</Code>

</If>

<If lang="objc">

<Code>

##### Objc

```
ARTTokenParams *tokenParams = [[ARTTokenParams alloc] initWithClientId:@"Bob"];
[client.auth createTokenRequest:tokenParams options:nil callback:^(ARTTokenRequest *tokenRequest, NSError *error) {
    if (error) {
        NSLog(@"An error occurred; err = %@", error);
    } else {
        NSLog(@"Success; token request = %@", tokenRequest);
    }
}];
```
</Code>

</If>

<If lang="swift">

<Code>

##### Swift

```
let tokenParams = ARTTokenParams(clientId: "Bob")
client.auth.createTokenRequest(tokenParams, options: nil) { tokenRequest, error in
    guard let tokenRequest = tokenRequest else {
        print("An error occurred; err = \(error!)")
        return
    }
    print("Success; token request = \(tokenRequest)")
}
```
</Code>

</If>

### <If lang="javascript,nodejs,java,objc,swift">requestToken</If><If lang="ruby">request_token</If><If lang="csharp">RequestTokenAsync</If> 

<If lang="javascript,nodejs">

`requestToken(TokenParams tokenParams?, AuthOptions authOptions?): Promise<TokenDetails>`

</If>

<If lang="ruby">

`Deferrable request_token(TokenParams token_params, AuthOptions auth_options) -> yields TokenDetails`

</If>

<If lang="java">

`TokenDetails requestToken(TokenParams tokenParams, AuthOptions authOptions)`

</If>

<If lang="csharp">

`async Task<TokenDetails> RequestTokenAsync(TokenParams? tokenParams, AuthOptions? options)`

</If>

<If lang="objc,swift">

`requestToken(tokenParams: ARTTokenParams?, withOptions: ARTAuthOptions?, callback: (ARTTokenDetails?, NSError?) -> Void)`

</If>

Calls the [`requestToken` REST API endpoint](https://ably.com/docs/api/rest-api.md#request-token) to obtain an [Ably Token](#token-details) according to the specified <If lang="ruby">`token_params` and `auth_options`</If><If lang="javascript,nodejs,java,csharp,objc,swift">`tokenParams` and `authOptions`</If>.

Both <If lang="ruby">`auth_options` and `token_params`</If><If lang="javascript,nodejs,java,csharp,objc,swift">`authOptions` and `tokenParams`</If> are optional. When omitted or `null`, the default token parameters and authentication options for the client library are used, as specified in the `ClientOptions` when the client library was instantiated, or later updated with an explicit <If lang="javascript,nodejs,java,objc,swift,ruby">[`authorize`](#authorize)</If><If lang="csharp">[`Authorize`](#authorize)</If> request.  Values passed in will be used instead of (rather than being merged with) the default values.

To understand why an Ably [`TokenRequest`](#request-token) may be issued to clients in favor of a token, see [Token Authentication explained](https://ably.com/docs/auth/token.md).

#### Parameters

<If lang="javascript,nodejs,java,csharp">

| Parameter | Description | Type |
|-----------|-------------|------|
| tokenParams | <If lang="javascript,nodejs,csharp">an optional object containing the [token parameters](#token-params)</If><If lang="java">an optional [`TokenParams`](#token-params) object containing the token parameters</If> for the requested token | [`TokenParams`](#token-params) |
| authOptions | <If lang="javascript,nodejs,csharp">an optional object containing the [authentication options](#auth-options)</If><If lang="java">an optional [`TokenParams`](#auth-options) object containing the authentication options</If> for the requested [Ably Token](#token-details) | [`AuthOptions`](#auth-options) |

</If>

<If lang="ruby,swift,objc">

| Parameter | Description | Type |
|-----------|-------------|------|
| <If lang="ruby">token_params</If><If lang="objc,swift">tokenParams</If> | <If lang="objc,swift">an optional object containing the [token parameters](#token-params)</If><If lang="ruby">an optional set of key value pairs containing the [token parameters](#token-params)</If> for the requested token | [`TokenParams`](#token-params) |
| <If lang="ruby">auth_options</If><If lang="objc,swift">authOptions</If> | <If lang="objc,swift">an optional object containing the [authentication options](#auth-options)</If><If lang="ruby">an optional set of key value pairs containing the [authentication options](#auth-options)</If> for the requested [Ably Token](#token-details) | [`AuthOptions`](#auth-options) |
| <If lang="ruby">&block</If><If lang="swift,objc">callback</If> | <If lang="ruby">yields a [`TokenDetails`](#token-details) object</If><If lang="swift,objc">called with a [`ARTTokenDetails`](#token-details) object or an error</If> | |

</If>

<If lang="javascript,nodejs">

#### Returns

Returns a promise.

On success, the promise is fulfilled with a [`TokenDetails`](#token-details) object containing the details of the new [Ably Token](#token-details) along with the `token` string.

On failure to obtain an [Ably Token](#token-details), the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the error response as defined in the [Ably REST API](https://ably.com/docs/api/rest-api.md#common) documentation.

</If>
<If lang="objc,swift">

#### Callback result

On success, `tokenDetails` contains a [`TokenDetails`](#token-details) object containing the details of the new [Ably Token](#token-details) along with the `token` string.

On failure to obtain an [Ably Token](#token-details), `err` contains an <If lang="javascript,nodejs,java,csharp,ruby">[`ErrorInfo`](#error-info)</If><If lang="objc,swift">`NSError`</If> object with an error response as defined in the [Ably REST API](https://ably.com/docs/api/rest-api.md#common) documentation.

</If>
<If lang="java">

#### Returns

On success, a [`TokenDetails`](#token-details) object containing the details of the new [Ably Token](#token-details) along with the `token` string is returned.

Failure to obtain an [Ably Token](#token-details) will raise an [`AblyException`](#ably-exception).

</If>
<If lang="csharp">

#### Returns

Returns a `Task<TokenDetails>` which needs to be awaited.

On success, a [`TokenDetails`](#token-details) object containing the details of the new [Ably Token](#token-details) along with the `token` string is returned.

Failure to obtain an [Ably Token](#token-details) will raise an [`AblyException`](#ably-exception).

</If>
<If lang="ruby">

#### Returns

A [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) object is returned from this method.

On success, the registered success callbacks for the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) and any block provided to this method yields a [`TokenDetails`](#token-details) object containing the details of the new [Ably Token](#token-details) along with the `token` string.

Failure to obtain an [Ably Token](#token-details) will trigger the errback callbacks of the [`Deferrable`](https://ably.com/docs/api/realtime-sdk/types.md#deferrable) with an [`ErrorInfo`](#error-info) object containing an error response as defined in the [Ably REST API](https://ably.com/docs/api/rest-api.md#common) documentation.

</If>

#### Example

<If lang="javascript">

<Code>

##### Javascript

```
try {
  const tokenDetails = await client.auth.requestToken({ clientId: 'bob'});
  console.log('Success; token = ' + tokenDetails.token);
} catch (error) {
  console.log('An error occurred; err = ' + error.message);
}
```
</Code>

</If>

<If lang="nodejs">

<Code>

##### Nodejs

```
try {
  const tokenDetails = await client.auth.requestToken({ clientId: 'bob'});
  console.log('Success; token = ' + tokenDetails.token);
} catch (error) {
  console.log('An error occurred; err = ' + error.message);
}
```
</Code>

</If>

<If lang="ruby">

<Code>

##### Ruby

```
client.auth.request_token(client_id: 'bob') do |token_details|
  puts "Success; token = #{token_details.token}"
end
```
</Code>

</If>

<If lang="java">

<Code>

##### Java

```
try {
  TokenParams tokenParams = new TokenParams();
  tokenParams.clientId = "bob";
  TokenDetails tokenDetails = client.auth.requestToken(tokenParams, null);
  System.out.println("Success; token = " + tokenDetails.token);
} catch(AblyException e) {
  System.out.println("An error occurred; err = " + e.getMessage());
}
```
</Code>

</If>

<If lang="csharp">

<Code>

##### Csharp

```
try {
  TokenParams tokenParams = new TokenParams {ClientId = "bob"};
  TokenDetails tokenDetails = await client.Auth.RequestTokenAsync(tokenParams);
  Console.WriteLine("Success; token = " + tokenDetails.Token);
} catch (AblyException e) {
  Console.WriteLine("An error occurred; err = " + e.Message);
}
```
</Code>

</If>

<If lang="objc">

<Code>

##### Objc

```
ARTTokenParams *tokenParams = [[ARTTokenParams alloc] initWithClientId:@"Bob"];
[client.auth requestToken:tokenParams withOptions:nil callback:^(ARTTokenDetails *tokenDetails, NSError *error) {
  if (error) {
    NSLog(@"An error occurred; err = %@", error);
  } else {
    NSLog(@"Success; token = %@", tokenDetails.token);
  }
}];
```
</Code>

</If>

<If lang="swift">

<Code>

##### Swift

```
let tokenParams = ARTTokenParams(clientId: "Bob")
client.auth.requestToken(tokenParams, withOptions: : nil) { tokenDetails, error in
  guard let tokenDetails = tokenDetails else {
    print("An error occurred; err = \(error!)")
    return
}
  print("Success; token = \(tokenDetails.token)")
}
```
</Code>

</If>

<If lang="javascript,nodejs">

### revokeTokens 

`revokeTokens(TokenRevocationTargetSpecifier[] specifiers, TokenRevocationOptions options?): Promise<BatchResult<TokenRevocationSuccessResult | TokenRevocationFailureResult>>`

Calls the [`revokeTokens` REST API endpoint](https://ably.com/docs/api/rest-api.md#revoke-tokens) to revoke tokens specified by the provided array of [TokenRevocationTargetSpecifier](#token-revocation-target-specifier).

Only tokens issued by an API key that had revocable tokens enabled before the token was issued can be revoked. See the [token revocation docs](https://ably.com/docs/auth/revocation.md) for more information.

#### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| specifiers | an array of [TokenRevocationTargetSpecifier](#token-revocation-target-specifier) objects | [`TokenRevocationTargetSpecifier[]`](#token-revocation-target-specifier) |
| options | an optional set of options which are used to modify the revocation request | [`TokenRevocationOptions`](#token-revocation-options) |

#### Returns

Returns a promise.

On success, the promise is fulfilled with a [BatchResult](#batch-result) containing information about the result of the token revocation request for each provided [TokenRevocationTargetSpecifier](#token-revocation-target-specifier).

On failure, the promise is rejected with an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object with the error response as defined in the [Ably REST API](https://ably.com/docs/api/rest-api.md#common) documentation.

#### Example

<If lang="javascript">

<Code>

##### Javascript

```
try {
  const response = await client.auth.revokeTokens([{ type: 'clientId', value: 'bob' }]);
  console.log('Revocation successful; revoked tokens: ' + response.results.length);
} catch (error) {
  console.log('An error occurred; err = ' + error.message);
}
```
</Code>

</If>

<If lang="nodejs">

<Code>

##### Nodejs

```
try {
  const response = await client.auth.revokeTokens([{ type: 'clientId', value: 'bob' }]);
  console.log('Revocation successful; revoked tokens: ' + response.results.length);
} catch (error) {
  console.log('An error occurred; err = ' + error.message);
}
```
</Code>

</If>

</If>

## Related types 

### <If lang="javascript,nodejs,csharp">AuthOptions Object</If><If lang="objc,swift">ARTAuthOptions</If><If lang="ruby">AuthOptions Hash</If><If lang="java">io.ably.lib.rest.Auth.AuthOptions</If> 

<If lang="javascript,nodejs">

`AuthOptions` is a plain JavaScript object and is used when making [authentication](https://ably.com/docs/auth.md) requests. If passed in, an `authOptions` object will be used instead of (as opposed to supplementing or being merged with) the default values given when the library was instantiated. The following attributes are supported:

</If>

<If lang="ruby">

`AuthOptions` is a Hash object and is used when making [authentication](https://ably.com/docs/auth.md) requests. These options will supplement or override the corresponding options given when the library was instantiated. The following key symbol values can be added to the Hash:

</If>

<If lang="swift,objc">

`ARTAuthOptions` is used when making [authentication](https://ably.com/docs/auth.md) requests. These options will supplement or override the corresponding options given when the library was instantiated.

</If>

<If lang="java">

`AuthOptions` is used when making [authentication](https://ably.com/docs/auth.md) requests. These options will supplement or override the corresponding options given when the library was instantiated.

</If>

#### <If lang="javascript,nodejs,csharp,objc,swift">Properties</If><If lang="java">Members</If><If lang="ruby">Attributes</If>

| Property | Description | Type |
|----------|-------------|------|
| <If lang="javascript,nodejs,java,objc,swift">authCallback</If><If lang="csharp,go">AuthCallback</If><If lang="ruby">:auth_callback</If> | A <If lang="objc,swift">function</If><If lang="javascript,nodejs">function with the form `function(tokenParams, callback(err, tokenOrTokenRequest))`</If><If lang="java">`TokenCallback` instance</If><If lang="ruby">proc / lambda (called synchronously in REST and Realtime but does not block EventMachine in the latter)</If> which is called when a new token is required. The role of the callback is to obtain a fresh token, one of: an Ably Token string (in plain text format); a signed [`TokenRequest`](https://ably.com/docs/api/realtime-sdk/types.md#token-request) ; a [`TokenDetails`](https://ably.com/docs/api/realtime-sdk/types.md#token-details) (in JSON format); an [Ably JWT](https://ably.com/docs/api/realtime-sdk/authentication.md#ably-jwt). See [our authentication documentation](https://ably.com/docs/auth.md) for details of the Ably TokenRequest format and associated API calls. | <If lang="javascript,nodejs,objc,swift">`Callable`</If><If lang="java">`TokenCallback`</If><If lang="ruby">`Proc`</If><If lang="csharp">`Func<TokenParams, Task<object>>`</If> |
| <If lang="javascript,nodejs,java,objc,swift">authUrl</If><If lang="csharp,go">AuthUrl</If><If lang="ruby">:auth_url</If> | A URL that the library may use to obtain a fresh token, one of: an Ably Token string (in plain text format); a signed [`TokenRequest`](https://ably.com/docs/api/realtime-sdk/types.md#token-request) ; a [`TokenDetails`](https://ably.com/docs/api/realtime-sdk/types.md#token-details) (in JSON format); an [Ably JWT](https://ably.com/docs/api/realtime-sdk/authentication.md#ably-jwt). For example, this can be used by a client to obtain signed Ably TokenRequests from an application server. | <If lang="javascript,nodejs,java">`String`</If><If lang="csharp">`Uri`</If><If lang="swift,objc">`NSURL`</If> |
| <If lang="javascript,nodejs,java,objc,swift">authMethod</If><If lang="csharp">AuthMethod</If><If lang="ruby">:auth_method</If> | _<If lang="javascript,nodejs,java,objc,swift">`GET`</If><If lang="ruby">`:get`</If>_ The HTTP verb to use for the request, either <If lang="javascript,nodejs,java,objc,swift">`GET`</If><If lang="ruby">`:get`</If> or <If lang="javascript,nodejs,java,objc,swift">`POST`</If><If lang="ruby">`:post`</If> | <If lang="javascript,nodejs,java,objc,swift">`String`</If><If lang="ruby">`Symbol`</If><If lang="csharp">`HttpMethod`</If> |
| <If lang="javascript,nodejs,objc,java,swift">authHeaders</If><If lang="csharp,go">AuthHeaders</If><If lang="ruby">:auth_headers</If> | A set of key value pair headers to be added to any request made to the <If lang="nodejs,objc,swift,javascript">`authUrl`</If><If lang="csharp">`AuthUrl`</If>. Useful when an application requires these to be added to validate the request or implement the response. <If lang="javascript,nodejs">If the `authHeaders` object contains an `authorization` key, then `withCredentials` will be set on the xhr request.</If> | <If lang="javascript,nodejs,objc,swift">`Object`</If><If lang="ruby">`Hash`</If><If lang="java">`Param []`</If><If lang="csharp">`Dictionary<string, string>`</If> |
| <If lang="javascript,nodejs,java,objc,swift">authParams</If><If lang="csharp">AuthParams</If><If lang="ruby">:auth_params</If> | A set of key value pair params to be added to any request made to the <If lang="javascript,nodejs">`authUrl`</If><If lang="csharp">`AuthUrl`</If>. When the <If lang="javascript,nodejs">`authMethod`</If><If lang="csharp">`AuthMethod`</If> is `GET`, query params are added to the URL, whereas when <If lang="javascript,nodejs">`authMethod`</If><If lang="csharpo">`AuthMethod`</If> is `POST`, the params are sent as URL encoded form data. Useful when an application require these to be added to validate the request or implement the response. | <If lang="javascript,nodejs">`Object`</If><If lang="ruby">`Hash`</If><If lang="java">`Param[]`</If><If lang="csharp">`Dictionary<string, string>`</If><If lang="objc">`NSArray<NSURLQueryItem *>`</If><If lang="swift">`[NSURLQueryItem]/Array<NSURLQueryItem>`</If> |
| <If lang="javascript,nodejs,java,objc,swift">tokenDetails</If><If lang="csharp,go">TokenDetails</If><If lang="ruby">:token_details</If> | An authenticated [`TokenDetails`](https://ably.com/docs/api/realtime-sdk/types.md#token-details) object (most commonly obtained from an Ably Token Request response). This option is mostly useful for testing: since tokens are short-lived, in production you almost always want to use an authentication method that allows the client library to renew the token automatically when the previous one expires, such as <If lang="javascript,nodejs,java,objc,swift">`authUrl`</If><If lang="csharp">`AuthUrl`</If><If lang="ruby">`:auth_url`</If> or <If lang="javascript,nodejs,java,objc,swift">`authCallback`</If><If lang="csharp">AuthCallback</If><If lang="python">`auth_callback`</If><If lang="ruby">`:auth_callback`</If>. Use this option if you wish to use Token authentication. Read more about [Token authentication](https://ably.com/docs/auth/token.md) | `TokenDetails` |
| <If lang="javascript,nodejs,java,objc,swift">key</If><If lang="csharp">Key</If><If lang="ruby">:key</If> | Optionally the [API key](https://ably.com/docs/auth.md#api-key) to use can be specified as a full key string; if not, the API key passed into [`ClientOptions`](#client-options) when instancing the Realtime or REST library is used | `String` |
| <If lang="javascript,nodejs,java,objc,swift">queryTime</If><If lang="csharp,go">QueryTime</If><If lang="ruby">:query_time</If> | _false_ If true, the library will query the Ably servers for the current time when [issuing TokenRequests](https://ably.com/docs/auth/token.md) instead of relying on a locally-available time of day. Knowing the time accurately is needed to create valid signed Ably [TokenRequests](https://ably.com/docs/auth/token.md), so this option is useful for library instances on auth servers where for some reason the server clock cannot be kept synchronized through normal means, such as an [NTP daemon](https://en.wikipedia.org/wiki/Ntpd) . The server is queried for the current time once per client library instance (which stores the offset from the local clock), so if using this option you should avoid instancing a new version of the library for each request. | `Boolean` |
| <If lang="javascript,nodejs,java,objc,swift">token</If><If lang="csharp,go">Token</If><If lang="ruby">:token</If> | An authentication token. This can either be a [`TokenDetails`](https://ably.com/docs/api/realtime-sdk/types.md#token-details) object, a [`TokenRequest`](https://ably.com/docs/api/realtime-sdk/types.md#token-request) object, or token string (obtained from the <If lang="javascript,nodejs,java,objc,swift">`token`</If><If lang="csharp,go">`Token`</If> property of a [`TokenDetails`](https://ably.com/docs/api/realtime-sdk/types.md#token-details) component of an Ably TokenRequest response, or a [JSON Web Token](https://tools.ietf.org/html/rfc7519) satisfying [the Ably requirements for JWTs](https://ably.com/docs/auth/token/jwt.md)). This option is mostly useful for testing: since tokens are short-lived, in production you almost always want to use an authentication method that allows the client library to renew the token automatically when the previous one expires, such as <If lang="javascript,nodejs,java,objc,swift">`authUrl`</If><If lang="csharp">AuthUrl</If><If lang="ruby">:auth_url</If><If lang="python">auth_url</If> or <If lang="javascript,nodejs,java,objc,swift">authCallback</If><If lang="csharp">AuthCallback</If><If lang="python">auth_callback</If><If lang="ruby">:auth_callback</If>. Read more about [Token authentication](https://ably.com/docs/auth/token.md) | `String`, `TokenDetails` or `TokenRequest` |

### <If lang="javascript,nodejs">TokenDetails Object</If><If lang="objc,swift">ARTTokenDetails</If><If lang="java">io.ably.lib.types.TokenDetails</If><If lang="ruby">Ably::Models::TokenDetails</If><If lang="csharp">IO.Ably.TokenDetails</If> 

`TokenDetails` is a type providing details of Ably Token string and its associated metadata.

#### <If lang="javascript,nodejs,csharp,objc,swift">Properties</If><If lang="java">Members</If><If lang="ruby">Attributes</If>

| Property | Description | Type |
|----------|-------------|------|
| <If lang="javascript,nodejs,java,objc,swift,ruby">token</If><If lang="csharp">Token</If> | The [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details) itself. A typical [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details) string may appear like `{{TOKEN}}` | `String` |
| <If lang="javascript,nodejs,java,objc,swift,ruby">expires</If><If lang="csharp">Expires</If> | <If lang="javascript,nodejs,java">The time (in milliseconds since the epoch)</If><If lang="ruby,objc,swift">The time</If> at which this token expires | <If lang="javascript,nodejs">`Integer`</If><If lang="java">`Long Integer`</If><If lang="csharp">`DateTimeOffset`</If><If lang="ruby">`Time`</If><If lang="objc,swift">`NSDate`</If> |
| <If lang="javascript,nodejs,java,objc,swift,ruby">issued</If><If lang="csharp">Issued</If> | <If lang="javascript,nodejs,java">The time (in milliseconds since the epoch)</If><If lang="ruby,objc,swift">The time</If> at which this token was issued | <If lang="javascript,nodejs">`Integer`</If><If lang="java">`Long Integer`</If><If lang="csharp">`DateTimeOffset`</If><If lang="ruby">`Time`</If><If lang="objc,swift">`NSDate`</If> |
| <If lang="javascript,nodejs,java,objc,swift,ruby">capability</If><If lang="csharp">Capability</If> | The capability associated with this [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details). The capability is a a JSON stringified canonicalized representation of the resource paths and associated operations. [Read more about authentication and capabilities](https://ably.com/docs/auth/capabilities.md) | <If lang="javascript,nodejs,java,objc,swift,ruby">`String`</If><If lang="csharp">`Capability`</If> |
| <If lang="javascript,nodejs,java,objc,swift,flutter,php">clientId</If><If lang="ruby,python">client_id</If><If lang="csharp,go">ClientId</If> | The client ID, if any, bound to this [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details). If a client ID is included, then the [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details) authenticates its bearer as that client ID, and the [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details) may only be used to perform operations on behalf of that client ID. The client is then considered to be an [identified client](https://ably.com/docs/auth/identified-clients.md) | `String` |

<If lang="ruby">

### Methods

| Method | Description | Type |
|--------|-------------|------|
| expired? | True when the token has expired | `Boolean` |

</If>
<If lang="csharp">

### Methods

| Method | Description | Type |
|--------|-------------|------|
| IsValidToken() | True if the token has not expired | `Boolean` |

</If>

### TokenDetails constructors

#### <If lang="javascript,nodejs,java,csharp,objc,swift">TokenDetails.fromJson</If><If lang="ruby">TokenDetails.from_json</If> 

<If lang="javascript,nodejs,java,csharp,objc,swift">

`TokenDetails.fromJson(String json) -> TokenDetails`

</If>

<If lang="ruby">

`TokenDetails.from_json(String json) -> TokenDetails`

</If>

A <If lang="javascript,nodejs,java,csharp,objc,ruby">static factory method</If> to create a [`TokenDetails`](https://ably.com/docs/api/realtime-sdk/types.md#token-details) from a deserialized `TokenDetails`-like <If lang="javascript,nodejs,java,csharp,objc,ruby">object or a JSON stringified `TokenDetails`</If>. This method is provided to minimize bugs as a result of differing types by platform for fields such as `timestamp` or `ttl`. For example, in Ruby `ttl` in the `TokenDetails` object is exposed in seconds as that is idiomatic for the language, yet when serialized to JSON using `to_json` it is automatically converted to the Ably standard which is milliseconds. By using the <If lang="javascript,nodejs,java,csharp,objc,swift,ruby">`fromJson`</If> method when constructing a `TokenDetails`, Ably ensures that all fields are consistently serialized and deserialized across platforms.

#### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| json | a `TokenDetails`-like deserialized object or JSON stringified `TokenDetails`. | `Object`, `String` |

#### Returns

A [`TokenDetails`](https://ably.com/docs/api/realtime-sdk/types.md#token-details) object

### <If lang="javascript,nodejs">TokenParams Object</If><If lang="objc,swift">ARTTokenParams</If><If lang="ruby">TokenParams Hash</If><If lang="java">io.ably.lib.rest.Auth.TokenParams</If><If lang="csharp">IO.Ably.TokenParams</If> 

<If lang="javascript,nodejs">

`TokenParams` is a plain JavaScript object and is used in the parameters of [token authentication](https://ably.com/docs/auth/token.md) requests, corresponding to the desired attributes of the [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details). The following attributes can be defined on the object:

</If>

<If lang="ruby">

`TokenParams` is a Hash object and is used in the parameters of [token authentication](https://ably.com/docs/auth/token.md) requests, corresponding to the desired attributes of the [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details). The following key symbol values can be added to the Hash:

</If>

<If lang="java,csharp">

`TokenParams` is used in the parameters of [token authentication](https://ably.com/docs/auth/token.md) requests, corresponding to the desired attributes of the [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details).

</If>

<If lang="objc,swift">

`ARTTokenParams` is used in the parameters of [token authentication](https://ably.com/docs/auth/token.md) requests, corresponding to the desired attributes of the [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details).

</If>

#### <If lang="javascript,nodejs,csharp,objc,swift">Properties</If><If lang="java">Members</If><If lang="ruby">Attributes</If>

| Property | Description | Type |
|----------|-------------|------|
| <If lang="javascript,nodejs,java,objc,swift">capability</If><If lang="csharp,go">Capability</If><If lang="ruby">:capability</If> | JSON stringified capability of the [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details). If the [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details) request is successful, the capability of the returned [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details) will be the intersection of this capability with the capability of the issuing key. [Find our more about how to use capabilities to manage access privileges for clients](https://ably.com/docs/auth/capabilities.md). | <If lang="javascript,nodejs,java,objc,swift">`String`</If><If lang="csharp">`Capability`</If> |
| <If lang="javascript,nodejs,java,objc,swift">clientId</If><If lang="csharp,go">ClientId</If><If lang="python">client_id</If><If lang="ruby">:client_id</If> | A client ID, used for identifying this client when publishing messages or for presence purposes. The <If lang="javascript,nodejs,java,objc,swift">`clientId`</If><If lang="ruby,python">`client_id`</If><If lang="csharp,go">`ClientId`</If> can be any non-empty string. This option is primarily intended to be used in situations where the library is instantiated with a key; note that a <If lang="javascript,nodejs,java,objc,swift">`clientId`</If><If lang="ruby,python">`client_id`</If><If lang="csharp,go">`ClientId`</If> may also be implicit in a token used to instantiate the library; an error will be raised if a <If lang="javascript,nodejs,java,objc,swift">`clientId`</If><If lang="ruby,python">`client_id`</If><If lang="csharp,go">`ClientId`</If> specified here conflicts with the <If lang="javascript,nodejs,java,objc,swift">`clientId`</If><If lang="ruby,python">`client_id`</If><If lang="csharp,go">`ClientId`</If> implicit in the token. [Find out more about client identities](https://ably.com/docs/auth/identified-clients.md) | `String` |
| <If lang="javascript,nodejs,java,objc,swift">nonce</If><If lang="csharp,go">Nonce</If><If lang="ruby">:nonce</If> | An optional opaque nonce string of at least 16 characters to ensure uniqueness of this request. Any subsequent request using the same nonce will be rejected. | `String` |
| <If lang="javascript,nodejs,java,objc,swift">timestamp</If><If lang="csharp">Timestamp</If><If lang="ruby">:timestamp</If> | <If lang="javascript,nodejs,java">The timestamp (in milliseconds since the epoch)</If><If lang="ruby,objc,swift,csharp">The timestamp</If> of this request. `timestamp`, in conjunction with the `nonce`, is used to prevent requests for [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details) from being replayed. | <If lang="javascript,nodejs">`Integer`</If><If lang="java">`Long Integer`</If><If lang="ruby">`Time`</If><If lang="objc,swift">`NSDate`</If><If lang="csharp">`DateTimeOffset`</If><If lang="flutter">`DateTime`</If> |
| <If lang="javascript,nodejs,java,objc,swift">ttl</If><If lang="csharp">Ttl</If><If lang="ruby">:ttl</If> | Requested time to live for the [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details) being created <If lang="javascript,nodejs,java">in milliseconds</If><If lang="ruby">in seconds</If><If lang="objc,swift">as a `NSTimeInterval`</If><If lang="csharp">as a `TimeSpan`.</If> When omitted, the Ably REST API default of 60 minutes is applied by Ably. <br />_Default: 1 hour_ | <If lang="javascript,nodejs">`Integer` (milliseconds)</If><If lang="ruby">`Integer` (seconds)</If><If lang="objc,swift">`NSTimeInterval`</If><If lang="java">`Long Integer`</If><If lang="csharp">`TimeSpan`</If> |

### <If lang="javascript,nodejs">TokenRequest Object</If><If lang="objc,swift">ARTTokenRequest</If><If lang="ruby">Ably::Models::TokenRequest</If><If lang="java">io.ably.lib.rest.Auth.TokenRequest</If><If lang="csharp">IO.Ably.TokenRequest</If> 

`TokenRequest` is a type containing parameters for an Ably `TokenRequest`. [Ably Tokens](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details) are requested using <If lang="javascript,nodejs,java,csharp,objc,swift">[Auth#requestToken](https://ably.com/docs/api/rest-sdk/authentication.md#request-token)</If><If lang="ruby">[Auth#request_token](https://ably.com/docs/api/rest-sdk/authentication.md#request-token)</If>

#### <If lang="javascript,nodejs,csharp,objc,swift">Properties</If><If lang="java">Members</If><If lang="ruby">Attributes</If>

| Property | Description | Type |
|----------|-------------|------|
| <If lang="javascript,nodejs,java,objc,swift">keyName</If><If lang="ruby">key_name</If><If lang="csharp">KeyName</If> | The key name of the key against which this request is made. The key name is public, whereas the key secret is private | `String` |
| <If lang="javascript,nodejs,java,objc,swift,ruby">ttl</If><If lang="csharp">Ttl</If> | Requested time to live for the [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details) <If lang="javascript,nodejs,java,objc,swift">in milliseconds</If><If lang="ruby">in seconds</If><If lang="csharp,go">as a `TimeSpan`</If>. If the Ably `TokenRequest` is successful, the TTL of the returned [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details) will be less than or equal to this value depending on application settings and the attributes of the issuing key. | <If lang="javascript,nodejs,java">`Integer`</If><If lang="csharp">`TimeSpan`</If><If lang="swift,objc">`NSTimeInterval`</If> |
| <If lang="javascript,nodejs,java,ruby,objc,swift">timestamp</If><If lang="csharp">Timestamp</If> | The timestamp of this request<If lang="javascript,nodejs,java"> in milliseconds</If><If lang="ruby,csharp"></If> | <If lang="javascript,nodejs">`Integer`</If><If lang="java">`Long Integer`</If><If lang="ruby">`Time`</If><If lang="csharp">`DateTimeOffset`</If><If lang="swift,obj">`NSDate`</If> |
| <If lang="javascript,nodejs,java,objc,swift,ruby">capability</If><If lang="csharp,go">Capability</If> | Capability of the requested [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details). If the Ably `TokenRequest` is successful, the capability of the returned [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details) will be the intersection of this capability with the capability of the issuing key. The capability is a JSON stringified canonicalized representation of the resource paths and associated operations. [Read more about authentication and capabilities](https://ably.com/docs/auth.md) | `String` |
| <If lang="javascript,nodejs,java,objc,swift">clientId</If><If lang="ruby">client_id</If><If lang="csharp">ClientId</If> | The client ID to associate with the requested [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details). When provided, the [Ably Token](https://ably.com/docs/api/realtime-sdk/authentication.md#token-details) may only be used to perform operations on behalf of that client ID | `String` |
| <If lang="javascript,nodejs,java,objc,swift,ruby">nonce</If><If lang="csharp">Nonce</If> | An opaque nonce string of at least 16 characters | `String` |
| <If lang="javascript,nodejs,java,objc,swift,ruby">mac</If><If lang="csharp">Mac</If> | The Message Authentication Code for this request | `String` |

### TokenRequest constructors

#### <If lang="javascript,nodejs,java,csharp,objc,swift">TokenRequest.fromJson</If><If lang="ruby">TokenRequest.from_json</If><If lang="flutter">TokenRequest.fromMap</If> 

<If lang="javascript,nodejs,java,csharp,objc,swift">

`TokenRequest.fromJson(String json) -> TokenRequest`

</If>

<If lang="ruby">

`TokenRequest.from_json(String json) -> TokenRequest`

</If>

A <If lang="javascript,nodejs,java,csharp,objc,swift,ruby">static factory method</If> to create a [`TokenRequest`](https://ably.com/docs/api/realtime-sdk/types.md#token-request) from a deserialized `TokenRequest`-like <If lang="javascript,nodejs,java,csharp,objc,swift,ruby">object or a JSON stringified `TokenRequest`</If>. This method is provided to minimize bugs as a result of differing types by platform for fields such as `timestamp` or `ttl`. For example, in Ruby `ttl` in the `TokenRequest` object is exposed in seconds as that is idiomatic for the language, yet when serialized to JSON using `to_json` it is automatically converted to the Ably standard which is milliseconds. By using the <If lang="javascript,nodejs,java,csharp,objc,swift,ruby">`fromJson`</If> method when constructing a `TokenRequest`, Ably ensures that all fields are consistently serialized and deserialized across platforms.

#### Parameters

| Parameter | Description | Type |
|-----------|-------------|------|
| json | a `TokenRequest`-like deserialized object or JSON stringified `TokenRequest`. | `Object`, `String` |

#### Returns

A [`TokenRequest`](https://ably.com/docs/api/realtime-sdk/types.md#token-request) object

### Ably JWT 

An Ably JWT is not strictly an Ably construct, rather it is a [JWT](https://jwt.io/) which has been constructed to be compatible with Ably. The JWT must adhere to the following to ensure compatibility:

| Section | Field | Required | Description |
|---------|-------|----------|-------------|
| JOSE header | `kid` | Yes | Key name, such that an API key of `your-api-key` will have key name `{{API_KEY_NAME}}` |
| JWT claim set | `iat` | Yes | Time of issue in seconds |
| JWT claim set | `exp` | Yes | Expiry time in seconds |
| JWT claim set | `x-ably-capability` | No | JSON text encoding of the [capability](#tokens) |
| JWT claim set | `x-ably-clientId` | No | Client ID |

Arbitrary additional claims and headers are supported (apart from those prefixed with `x-ably-` which are reserved for future use).

The Ably JWT must be signed with the secret part of your [Ably API key](https://ably.com/docs/auth.md#api-key) using the signature algorithm HS256 (HMAC using the SHA-256 hash algorithm). View the [JSON Web Algorithms (JWA) specification](https://tools.ietf.org/html/rfc7518) for further information.

We recommend you use one of the many [JWT libraries available for simplicity](https://jwt.io/) when creating your JWTs.

<If lang="javascript,nodejs">

The following is an example of creating an Ably JWT:

<Code>

#### Javascript

```
var header = {
  "typ":"JWT",
  "alg":"HS256",
  "kid": "{{API_KEY_NAME}}"
};
var currentTime = Math.round(Date.now()/1000);
var claims = {
  "iat": currentTime, /* current time in seconds */
  "exp": currentTime + 3600, /* time of expiration in seconds */
  "x-ably-capability": "{\"*\":[\"*\"]}"
};
var base64Header = btoa(header);
var base64Claims = btoa(claims);
/* Apply the hash specified in the header */
var signature = hash((base64Header + "." + base64Claims), "{{API_KEY_SECRET}}");
var ablyJwt = base64Header + "." + base64Claims + "." + signature;
```
</Code>

</If>

*Note:* At present Ably does not support asymmetric signatures based on a keypair belonging to a third party.

<If lang="javascript,nodejs">

### BatchResult 

A `BatchResult` contains information about the results of a batch operation.

#### Properties

| Property | Description | Type |
|----------|-------------|------|
| successCount | The number of successful operations in the request | `Number` |
| failureCount | The number of unsuccessful operations in the request | `Number` |
| messages | An array of results for the batch operation (for example, an array of [`BatchPublishSuccessResult`](https://ably.com/docs/api/realtime-sdk/types.md#batch-publish-success-result) or [`BatchPublishFailureResult`](https://ably.com/docs/api/realtime-sdk/types.md#batch-publish-failure-result) for a channel batch publish request) | `Object[]` |

### TokenRevocationTargetSpecifier 

A `TokenRevocationTargetSpecifier` describes which tokens should be affected by a token revocation request.

#### Properties

| Property | Description | Type |
|----------|-------------|------|
| type | The type of token revocation target specifier. Valid values include `clientId`, `revocationKey` and `channel` | `String` |
| value | The value of the token revocation target specifier | `String` |

### TokenRevocationOptions 

A `TokenRevocationOptions` describes the additional options accepted by revoke tokens request.

#### Properties

| Property | Description | Type |
|----------|-------------|------|
| issuedBefore | An optional Unix timestamp in milliseconds where only tokens issued before this time are revoked. The default is the current time. Requests with an `issuedBefore` in the future, or more than an hour in the past, will be rejected | `Number` |
| allowReauthMargin | _false_ If true, permits a token renewal cycle to take place without needing established connections to be dropped, by postponing enforcement to 30 seconds in the future, and sending any existing connections a hint to obtain (and upgrade the connection to use) a new token. The default is `false`, meaning that the effect is near-immediate. | `Boolean` |


### TokenRevocationSuccessResult 

A `TokenRevocationSuccessResult` contains information about the result of a successful token revocation request for a single target specifier.

#### Properties

| Property | Description | Type |
|----------|-------------|------|
| target | The target specifier | `String` |
| appliesAt | The time at which the token revocation will take effect, as a Unix timestamp in milliseconds | `Number` |
| issuedBefore | A Unix timestamp in milliseconds. Only tokens issued earlier than this time will be revoked | `Number` |

### TokenRevocationFailureResult 

A `TokenRevocationFailureResult` contains information about the result of an unsuccessful token revocation request for a single target specifier.

#### Properties

| Property | Description | Type |
|----------|-------------|------|
| target | The target specifier | `String` |
| error | Describes the reason for which token revocation failed for the given `target` as an [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) object | [`ErrorInfo`](https://ably.com/docs/api/realtime-sdk/types.md#error-info) |

</If>

## Related Topics

- [Constructor](https://ably.com/docs/api/realtime-sdk.md): Realtime Client Library SDK API reference section for the constructor object.
- [Connection](https://ably.com/docs/api/realtime-sdk/connection.md): Realtime Client Library SDK API reference section for the connection object.
- [Channels](https://ably.com/docs/api/realtime-sdk/channels.md): Realtime Client Library SDK API reference section for the channels and channel objects.
- [Channel Metadata](https://ably.com/docs/api/realtime-sdk/channel-metadata.md): Realtime Client Library SDK API reference section for channel metadata.
- [Messages](https://ably.com/docs/api/realtime-sdk/messages.md): Realtime Client Library SDK API reference section for the message object.
- [Presence](https://ably.com/docs/api/realtime-sdk/presence.md): Realtime Client Library SDK API reference section for the presence object.
- [History](https://ably.com/docs/api/realtime-sdk/history.md): Realtime Client Library SDK API reference section for the history methods.
- [Push Notifications - Admin](https://ably.com/docs/api/realtime-sdk/push-admin.md): Realtime Client Library SDK API reference section for push notifications admin.
- [Push Notifications - Devices](https://ably.com/docs/api/realtime-sdk/push.md): Realtime Client Library SDK API reference section for push notification device subscription.
- [Encryption](https://ably.com/docs/api/realtime-sdk/encryption.md): Realtime Client Library SDK API reference section for the crypto object.
- [Statistics](https://ably.com/docs/api/realtime-sdk/statistics.md): Realtime Client Library SDK API reference section for the stats object.
- [Types](https://ably.com/docs/api/realtime-sdk/types.md): Realtime Client Library SDK API reference section for types.

## Documentation Index

To discover additional Ably documentation:

1. Fetch [llms.txt](https://ably.com/llms.txt) for the canonical list of available pages.
2. Identify relevant URLs from that index.
3. Fetch target pages as needed.

Avoid using assumed or outdated documentation paths.
