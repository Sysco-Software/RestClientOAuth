# Configuration

This page documents direct core-app configuration. Endpoint record configuration belongs to the optional [Rest Client OAuth Endpoints](../../RestClientOAuthEndpoints/docs/Configuration.md) app.

## Core Values

| Value | Object / method | Required for |
|-------|-----------------|--------------|
| Client ID | `Codeunit 50306 "OAuth Application Config KFM"/SetClientId` | All flows |
| Client secret | `SetClientSecret` | Confidential Authorization Code or Client Credentials when no certificate is used |
| Certificate | `SetCertificate` with `Codeunit 50310 "OAuth Certificate KFM"` | Confidential Authorization Code or Client Credentials when no secret is used |
| Scopes | `AddScope` or `SetScopes` | All flows |
| Tenant ID | `Codeunit 50315 "Microsoft Entra ID KFM"/SetTenantID` | Recommended for all flows; required by some tenant-specific scenarios |
| Redirect URI type | `SetRedirectUriType` on application config | Authorization Code flow |
| Redirect URI | `SetRedirectUri` on application config | Authorization Code token exchange |
| Prompt interaction | `Codeunit 50305 "Auth. Code Grant Flow KFM"/SetPromptInteraction` | Authorization Code flow |
| OAuth client type | `SetOAuthClientType` | Authorization Code flow |

## Scope Formatting

Add plain OAuth scope strings, for example `https://api.businesscentral.dynamics.com/user_impersonation`. Do not pre-encode the scope values before passing them into `Codeunit 50306 "OAuth Application Config KFM"`. The current HTTP request flow expects the scope list to remain space-delimited when sent to Microsoft Entra ID.

## Authorization Code Flow

- Uses PKCE with S256.
- Uses state for response validation.
- Adds `offline_access` if it is not already present.
- Can run as public or confidential client.
- Public-client exchange uses `Codeunit 50329 "OAuth Public Client KFM"` and sends no secret or certificate assertion.
- Confidential-client exchange uses `Codeunit 50302 "OAuth Confidential Client KFM"` and sends a client secret or JWT client assertion.
- Redirect handling is selected by `Enum 50304 "Redirect URI Type KFM"`.

## Client Credentials Flow

- Uses `Codeunit 50304 "Client Credentials Flow KFM"`.
- Always uses confidential-client token exchange.
- Does not request or use refresh tokens.
- Reacquires an access token when the cached in-memory token expires.

## Device Code Flow

- Uses `Codeunit 50326 "Device Code Flow KFM"`.
- Always uses public-client token exchange.
- Adds `offline_access` if it is not already present.
- Does not use redirect URI or prompt interaction settings.
- Opens `Page 50312 "Device Code Authorization KFM"` to show the user code, verification URI, status, and cancel action.

## Microsoft Entra App Registration Storage

The core app includes Microsoft Entra app-registration tables and pages for reusable metadata:

- `Table 50304 "Entra App Registration KFM"`
- `Table 50302 "Entra Secret KFM"`
- `Table 50303 "Entra Certificate KFM"`
- `Page 50305 "Entra App Registr. Card KFM"`
- `Page 50306 "Entra App Registr. List KFM"`

This storage is optional for direct AL callers. Endpoint records use it when the endpoint app is installed.
