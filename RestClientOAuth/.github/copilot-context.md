# Rest Client OAuth Copilot Context

## Project Boundary
- Main AL app: `RestClientOAuth`.
- Optional endpoint app: `RestClientOAuthEndpoints` depends on the main app and contains generic endpoint setup.
- Companion apps: `RestClientOAuthAdvancedRedirectURI` and `RestClientOAuthExamples` depend on or demonstrate the main app.
- Main app targets Business Central cloud, runtime 17.0, platform 28.0.0.0, object range `50300..50349`.
- AppSourceCop mandatory affix is `KFM`; preserve existing object names and suffixes.
- The app uses `NoImplicitWith`.

## Documentation First
- Treat `docs/Architecture.md`, `docs/Flows.md`, `docs/Configuration.md`, and `docs/SecurityConsiderations.md` as authoritative for design intent.
- For OAuth/security questions, verify Microsoft identity platform and Microsoft Graph guidance before changing behavior.
- Keep docs updated when changing public API shape, flow behavior, endpoint configuration, or security posture.

## OAuth Architecture
- `Codeunit 50306 "OAuth Application Config KFM"` is a neutral configuration object for client id, optional credentials, redirect URI metadata, and scopes.
- `Codeunit 50302 "OAuth Confidential Client KFM"` handles credentialed token requests with client secret or certificate assertion.
- `Codeunit 50329 "OAuth Public Client KFM"` handles public-client token requests without client secret or certificate assertion.
- Do not merge public-client behavior into `OAuthConfidentialClientImplKFM`; keep public and confidential clients separate.
- Authorization flows implement `Interface "OAuth Authorization Flow KFM"` and are selected by `Enum 50301 "OAuthAuthorizationFlowType KFM"`.
- Token results belong in `Codeunit 50309 "OAuth AuthenticationResult KFM"`; intermediate flow responses should generally stay inside the flow implementation.

## Source Layout
- Use feature-oriented folders under `src`; do not place AL objects directly in the root `src` folder.
- `Authentication` contains `Http Authentication OAuth2 KFM` and OAuth authentication result objects.
- `ApplicationConfig` contains the OAuth application configuration facade/implementation.
- `Certificate` contains OAuth certificate facade/implementation objects.
- `OAuthClients` contains public and confidential OAuth token clients, `Interface "OAuth Client KFM"`, and `Enum 50305 "OAuth Client Type KFM"`.
- `Authority`, `Flows`, and `Helpers` keep their existing domain-oriented layouts.
- Do not introduce folders grouped only by AL object type such as `Codeunits`, `Pages`, or `Tables`.

## Flow Decisions
- Authorization Code with PKCE is the preferred interactive user-delegation flow when redirect-based browser interaction is available.
- Authorization Code supports both public and confidential clients. Endpoint configuration, specifically `field(6; "OAuth Client Type"; Enum "OAuth Client Type KFM")`, decides which token client is used.
- Do not infer public vs confidential behavior from whether an Entra app registration currently stores credentials.
- Device Code flow is public-client only and retained as an advanced/fallback option, not the preferred Business Central interactive path.
- Client Credentials flow is confidential-client only.
- Authorization Code and Device Code flows auto-add `offline_access` to support in-memory refresh tokens.
- Access and refresh tokens are held in memory as `SecretText`; no token persistence exists yet.

## Redirect And Setup Security
- Business Central can handle redirect-based authorization through the built-in landing page or the advanced redirect URI app, so prefer Authorization Code + PKCE over Device Code in BC UI scenarios.
- Setup automation for Microsoft Entra app registrations should use a dedicated setup application owned by this module/product, authenticated as a public client with Authorization Code + PKCE and delegated Microsoft Graph permissions.
- Do not use another product's public client id, such as Azure CLI, as a bootstrap identity. It misrepresents consent, sign-in logs, audit trails, and token acquisition.
- Keep setup applications and endpoint applications as separate identities.

## Endpoint Configuration
- Endpoint configuration belongs to the optional `RestClientOAuthEndpoints` app.
- `Table 50356 "Http Endpoint OAuth 2.0 KFM"` stores endpoint-level OAuth configuration in that app.
- `OAuth Flow Type` selects the flow.
- `OAuth Client Type` applies to Authorization Code and determines public vs confidential token exchange.
- Device Code forces Public; Client Credentials forces Confidential.
- Microsoft Entra endpoint client construction must honor endpoint configuration, not registration credential discovery.

## UI And UX Patterns
- Use existing Business Central AL page/table patterns.
- Device Code uses a cancelable page with a timer control add-in; do not replace it with queued `Message` plus blocking polling.
- Avoid adding visible explanatory UI text unless it is needed for the Business Central workflow.

## Validation
- For AL code changes, run diagnostics on touched files first.
- Then run `al_build` for the current project with CodeCop and AppSourceCop when feasible.
- If symbols are missing, run symbol download before retrying the build.
- Keep changes scoped; do not refactor unrelated examples or companion apps unless the requested behavior requires it.
