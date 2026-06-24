# Examples

These are compact direct-AL snippets for the core app. Runnable pages and connectors live in [Rest Client OAuth Examples](../../RestClientOAuthExamples/docs/Index.md).

## Authorization Code As Public Client

```al
OAuthApplicationConfig.SetClientId('<client-id>');
OAuthApplicationConfig.SetRedirectUri('<redirect-uri>');
OAuthApplicationConfig.SetRedirectUriType(Enum::"Redirect URI Type KFM"::"Built-in");
OAuthApplicationConfig.AddScope('https://api.businesscentral.dynamics.com/user_impersonation');

AuthCodeGrantFlow.SetAuthority(OAuthAuthority);
AuthCodeGrantFlow.SetOAuthClientType(Enum::"OAuth Client Type KFM"::Public);
AuthCodeGrantFlow.SetPromptInteraction(Enum::"Prompt Interaction"::"Select Account");
```

Public-client Authorization Code flow sends no client secret or certificate assertion.

## Authorization Code As Confidential Client With Secret

```al
OAuthApplicationConfig.SetClientId('<client-id>');
OAuthApplicationConfig.SetClientSecret(SecretStrSubstNo('<client-secret>'));
OAuthApplicationConfig.AddScope('https://api.businesscentral.dynamics.com/user_impersonation');

AuthCodeGrantFlow.SetAuthority(OAuthAuthority);
AuthCodeGrantFlow.SetOAuthClientType(Enum::"OAuth Client Type KFM"::Confidential);
```

## Authorization Code As Confidential Client With Certificate

```al
OAuthApplicationConfig.SetClientId('<client-id>');
OAuthCertificate.SetPrivateKey(SecretStrSubstNo('<private-key-xml>'));
OAuthCertificate.SetCertificate('<base64-certificate>');
OAuthApplicationConfig.SetCertificate(OAuthCertificate);
OAuthApplicationConfig.AddScope('https://api.businesscentral.dynamics.com/user_impersonation');

AuthCodeGrantFlow.SetAuthority(OAuthAuthority);
AuthCodeGrantFlow.SetOAuthClientType(Enum::"OAuth Client Type KFM"::Confidential);
```

## Client Credentials

```al
OAuthApplicationConfig.SetClientId('<client-id>');
OAuthApplicationConfig.SetClientSecret(SecretStrSubstNo('<client-secret>'));
OAuthApplicationConfig.AddScope('https://graph.microsoft.com/.default');

ClientCredentialsFlow.SetAuthority(OAuthAuthority);
HttpAuthenticationOAuth2.Initialize(OAuthApplicationConfig, ClientCredentialsFlow);
RestClient.Initialize(HttpClientHandler, HttpAuthenticationOAuth2);
```

## Device Code

```al
OAuthApplicationConfig.SetClientId('<public-client-id>');
OAuthApplicationConfig.AddScope('https://api.businesscentral.dynamics.com/user_impersonation');

DeviceCodeFlow.SetAuthority(OAuthAuthority);
HttpAuthenticationOAuth2.Initialize(OAuthApplicationConfig, DeviceCodeFlow);
RestClient.Initialize(HttpClientHandler, HttpAuthenticationOAuth2);
```

Device Code flow is public-client only and ignores any configured secret or certificate.

## Endpoint Records

Endpoint-record examples moved to the endpoint app documentation: [Endpoint Getting Started](../../RestClientOAuthEndpoints/docs/GettingStarted.md).
