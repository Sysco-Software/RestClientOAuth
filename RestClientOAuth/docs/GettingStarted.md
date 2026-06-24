# Getting Started

This guide uses the core app directly from AL. Use the endpoint app instead when you want generic endpoint records and setup pages.

Minimum target for this repository is Business Central runtime 17.0 / platform 28.0.0.0.

## 1. Create An OAuth Application Config

`Codeunit 50306 "OAuth Application Config KFM"` stores the client id, optional credentials, redirect URI metadata, and scopes.

```al
var
    OAuthApplicationConfig: Codeunit "OAuth Application Config KFM";
begin
    OAuthApplicationConfig.SetClientId('<client-id>');
    OAuthApplicationConfig.AddScope('https://api.businesscentral.dynamics.com/user_impersonation');
end;
```

For confidential flows with a secret:

```al
OAuthApplicationConfig.SetClientSecret(SecretStrSubstNo('<client-secret>'));
```

For confidential flows with a certificate:

```al
var
    OAuthCertificate: Codeunit "OAuth Certificate KFM";
begin
    OAuthCertificate.SetPrivateKey(SecretStrSubstNo('<private-key-xml>'));
    OAuthCertificate.SetCertificate('<base64-certificate>');
    OAuthApplicationConfig.SetCertificate(OAuthCertificate);
end;
```

## 2. Create The Authority

`Codeunit 50315 "Microsoft Entra ID KFM"` is the built-in authority.

```al
var
    MicrosoftEntraID: Codeunit "Microsoft Entra ID KFM";
    OAuthAuthority: Interface "OAuth Authority KFM";
begin
    MicrosoftEntraID.SetTenantID('<tenant-id-or-domain>');
    OAuthAuthority := MicrosoftEntraID;
end;
```

If no tenant is set, the Microsoft Entra ID authority falls back to `organizations`.

## 3. Choose A Flow

Authorization Code with PKCE:

```al
var
    AuthCodeGrantFlow: Codeunit "Auth. Code Grant Flow KFM";
    OAuthAuthorizationFlow: Interface "OAuth Authorization Flow KFM";
begin
    AuthCodeGrantFlow.SetAuthority(OAuthAuthority);
    AuthCodeGrantFlow.SetOAuthClientType(Enum::"OAuth Client Type KFM"::Public);
    AuthCodeGrantFlow.SetPromptInteraction(Enum::"Prompt Interaction"::"Select Account");
    OAuthAuthorizationFlow := AuthCodeGrantFlow;
end;
```

Client Credentials:

```al
var
    ClientCredentialsFlow: Codeunit "Client Credentials Flow KFM";
    OAuthAuthorizationFlow: Interface "OAuth Authorization Flow KFM";
begin
    ClientCredentialsFlow.SetAuthority(OAuthAuthority);
    OAuthAuthorizationFlow := ClientCredentialsFlow;
end;
```

Device Code:

```al
var
    DeviceCodeFlow: Codeunit "Device Code Flow KFM";
    OAuthAuthorizationFlow: Interface "OAuth Authorization Flow KFM";
begin
    DeviceCodeFlow.SetAuthority(OAuthAuthority);
    OAuthAuthorizationFlow := DeviceCodeFlow;
end;
```

## 4. Initialize OAuth Authentication And Rest Client

```al
var
    HttpAuthenticationOAuth2: Codeunit "Http Authentication OAuth2 KFM";
    HttpAuthentication: Interface "Http Authentication";
    HttpClientHandler: Codeunit "Http Client Handler KFM";
    RestClient: Codeunit "Rest Client";
begin
    HttpAuthenticationOAuth2.Initialize(OAuthApplicationConfig, OAuthAuthorizationFlow);
    HttpAuthentication := HttpAuthenticationOAuth2;

    RestClient.Initialize(HttpClientHandler, HttpAuthentication);
end;
```

## 5. Call The API

```al
var
    Response: JsonObject;
begin
    RestClient.SetBaseAddress('https://api.businesscentral.dynamics.com/v2.0/<environment>/api/');
    Response := RestClient.GetAsJson('v2.0/companies').AsObject();
end;
```

## Notes

- Authorization Code and Device Code flows add `offline_access` automatically to allow in-memory refresh tokens.
- Authorization Code flow defaults to confidential-client behavior unless you call `SetOAuthClientType` with `Public`.
- Device Code flow is always public-client and ignores configured secrets or certificates.
- Tokens are held in memory only; object disposal, service restart, or new session context requires a new acquisition path.
- Endpoint setup is documented in [Rest Client OAuth Endpoints](../../RestClientOAuthEndpoints/docs/GettingStarted.md).