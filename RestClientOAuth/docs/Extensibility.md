# Extensibility

The core app exposes interfaces and enums so companion apps or consuming extensions can plug in authorities, redirect strategies, and flows.

## Core Extension Points

| Object | Purpose |
| --- | --- |
| `Interface "OAuth Authority KFM"` | Supplies application configuration and authorization, device authorization, and token endpoints. |
| `Enum 50303 "OAuth Authority KFM"` | Maps authority enum values to authority implementations. |
| `Interface "OAuth Authorization Flow KFM"` | Common flow surface for initialization and authorization-header retrieval. |
| `Enum 50301 "OAuthAuthorizationFlowType KFM"` | Maps flow enum values to flow implementations. |
| `Interface "OAuth Client KFM"` | Common public/confidential token-client surface. |
| `Enum 50305 "OAuth Client Type KFM"` | Selects public or confidential token client implementation. |
| `Interface "Redirect URI KFM"` | Obtains authorization codes for Authorization Code flow. |
| `Enum 50304 "Redirect URI Type KFM"` | Selects redirect URI implementation. |

The endpoint configuration layer is intentionally separate. Apps can compose these objects directly or depend on the optional `Rest Client OAuth Endpoints` app for generic endpoint tables and pages.

## Adding A New Authority

1. Implement `Interface "OAuth Authority KFM"`.
2. Return authorization, device authorization, and token endpoints.
3. Map stored application code and target tenant data to `Codeunit 50306 "OAuth Application Config KFM"` when endpoint integration is needed.
4. Add a value to `Enum 50303 "OAuth Authority KFM"` or an enum extension with your implementation.
5. Set that authority on the desired flow before token acquisition.

## Adding A New Redirect URI Strategy

1. Implement `Interface "Redirect URI KFM"`.
2. Return a default redirect URI when applicable.
3. Set the actual redirect URI on `Codeunit 50306 "OAuth Application Config KFM"` before returning an authorization code.
4. Preserve state and PKCE behavior.
5. Add a value to `Enum 50304 "Redirect URI Type KFM"` or an enum extension.

See the optional advanced redirect app for a complete companion-app implementation.

## Adding A New Flow

1. Implement `Interface "OAuth Authorization Flow KFM"`.
2. Keep flow orchestration separate from token HTTP exchange.
3. Delegate token requests to `Codeunit 50329 "OAuth Public Client KFM"` or `Codeunit 50302 "OAuth Confidential Client KFM"` as appropriate.
4. Store successful `Codeunit 50309 "OAuth AuthenticationResult KFM"` in memory if the flow supports reuse.
5. Add a value to `Enum 50301 "OAuthAuthorizationFlowType KFM"` or an enum extension.

## Endpoint App Integration

The endpoint app initializes flows through `Interface "OAuth Authorization Flow KFM"`. Any new flow exposed through `Enum 50301 "OAuthAuthorizationFlowType KFM"` can be selected by endpoint records, but endpoint validation may need to be extended when the new flow has special public/confidential or tenant requirements.
