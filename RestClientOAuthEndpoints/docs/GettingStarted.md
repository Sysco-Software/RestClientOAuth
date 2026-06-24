# Getting Started

Use this app when you want generic HTTP endpoint records and setup pages. If your extension already has a setup table for external APIs, use the core app directly instead.

## 1. Install Dependencies

This app depends on:

- `System Application`
- `Rest Client OAuth`

Build or publish the core app before this app.

## 2. Create An Endpoint

Create a `Table 50351 "Http Endpoint KFM"` record through `Page 50357 "Http Endpoint Card KFM"` or in AL.

```al
var
	HttpEndpoint: Record "Http Endpoint KFM";
begin
	HttpEndpoint.Init();
	HttpEndpoint.Code := 'BCAPI';
	HttpEndpoint.Description := 'Business Central API';
	HttpEndpoint."Base Url" := 'https://api.businesscentral.dynamics.com/v2.0/<environment>/api/';
	HttpEndpoint.Authentication := HttpEndpoint.Authentication::OAuth20;
	HttpEndpoint.Insert(true);
end;
```

Valid authentication options are `Anonymous`, `Basic`, and `OAuth20`.

## 3. Configure OAuth 2.0

For OAuth 2.0, create or edit `Table 50356 "Http Endpoint OAuth 2.0 KFM"` for the endpoint code.

```al
var
	HttpEndpointOAuth20: Record "Http Endpoint OAuth 2.0 KFM";
begin
	HttpEndpointOAuth20.Get('BCAPI');
	HttpEndpointOAuth20."OAuth Authority" := HttpEndpointOAuth20."OAuth Authority"::MicrosoftEntraID;
	HttpEndpointOAuth20."OAuth Application Code" := '<entra-app-code>';
	HttpEndpointOAuth20."OAuth Flow Type" := HttpEndpointOAuth20."OAuth Flow Type"::AuthorizationCode;
	HttpEndpointOAuth20."OAuth Client Type" := HttpEndpointOAuth20."OAuth Client Type"::Confidential;
	HttpEndpointOAuth20."Prompt Interaction" := HttpEndpointOAuth20."Prompt Interaction"::"Select Account";
	HttpEndpointOAuth20.Modify(true);
end;
```

Add scopes through `Table 50357 "Http Endpoint OAuth Scope KFM"` or `Page 50361 HttpEndpointOAuthScopesKFM`.

## 4. Use The Endpoint

```al
var
	HttpClientHandler: Codeunit "Http Client Handler KFM";
	HttpEndpoint: Record "Http Endpoint KFM";
	RestClient: Codeunit "Rest Client";
begin
	HttpEndpoint.Get('BCAPI');
	RestClient := HttpEndpoint.GetRestClient(HttpClientHandler);
	RestClient.Get('v2.0/companies');
end;
```

## Notes

- Changing `Authentication` creates the corresponding settings record when needed.
- Deleting `Table 50351 "Http Endpoint KFM"` also deletes related Basic-auth and OAuth settings.
- OAuth app registration storage is provided by the core app.
