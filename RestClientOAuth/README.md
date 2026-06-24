# Rest Client OAuth

Core OAuth 2.0 app for Microsoft Dynamics 365 Business Central outbound REST calls. This app contains the reusable OAuth building blocks: application configuration, Microsoft Entra ID authority support, public and confidential token clients, authorization flows, redirect URI contracts, token result handling, and Microsoft Entra app-registration storage.

This app intentionally does not contain generic HTTP endpoint tables or pages. Those live in the optional [Rest Client OAuth Endpoints](../RestClientOAuthEndpoints/README.md) app.

## When To Use This App

Depend on the core app directly when your extension already owns its setup model for tenants, customers, applications, base URLs, or API connections. You can compose the OAuth objects in AL and inject the resulting `Interface "Http Authentication"` into `Codeunit "Rest Client"`.

Add the endpoint app only when you want generic endpoint records and setup UI.

## Main Public Objects

- `Codeunit 50306 "OAuth Application Config KFM"`: client id, optional secret/certificate, redirect URI, and scopes.
- `Codeunit 50315 "Microsoft Entra ID KFM"`: built-in authority implementation.
- `Codeunit 50305 "Auth. Code Grant Flow KFM"`: Authorization Code with PKCE as public or confidential client.
- `Codeunit 50304 "Client Credentials Flow KFM"`: confidential client-credentials flow.
- `Codeunit 50326 "Device Code Flow KFM"`: public-client Device Code flow.
- `Codeunit 50301 "Http Authentication OAuth2 KFM"`: authentication facade consumed by `Rest Client`.
- `Codeunit 50310 "OAuth Certificate KFM"`: certificate and private-key wrapper for JWT client assertions.
- `Enum 50305 "OAuth Client Type KFM"`: selects public or confidential token exchange for Authorization Code flow.
- `Enum 50304 "Redirect URI Type KFM"`: selects built-in or extension-provided redirect handling.

## Supported Flows

| Flow | Client type | Typical use |
|------|-------------|-------------|
| Authorization Code with PKCE | Public or confidential | Interactive user delegation when redirect-based browser sign-in is available. |
| Client Credentials | Confidential | Service-to-service calls using application permissions. |
| Device Code | Public | Fallback user delegation when a code must be shown for sign-in on another device. |

Tokens are held in `SecretText` in memory only. There is no persistent token cache.

## Documentation

- [Documentation Index](docs/Index.md)
- [Architecture](docs/Architecture.md)
- [Redesign Notes](docs/Redesign.md)
- [Getting Started](docs/GettingStarted.md)
- [Configuration](docs/Configuration.md)
- [Flows](docs/Flows.md)
- [Device Code Flow](docs/DeviceCodeFlow.md)
- [Examples](docs/examples.md)
- [Extensibility](docs/Extensibility.md)
- [Security Considerations](docs/SecurityConsiderations.md)
- [Troubleshooting](docs/Troubleshooting.md)
- [FAQ](docs/FAQ.md)
- [Changelog](docs/CHANGELOG.md)
- [Future Improvements](docs/FutureImprovements.md)

Related app documentation:

- [Endpoint app documentation](../RestClientOAuthEndpoints/docs/Index.md)
- [Advanced redirect URI documentation](../RestClientOAuthAdvancedRedirectURI/docs/Index.md)
- [Examples app documentation](../RestClientOAuthExamples/docs/Index.md)
