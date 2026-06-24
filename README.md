# Rest Client OAuth

Business Central OAuth 2.0 helper solution for outbound REST calls. The repository is split into focused AL apps so consuming extensions can depend only on the layer they need.

## Apps

| App | Folder | Purpose |
|-----|--------|---------|
| Rest Client OAuth | [RestClientOAuth](RestClientOAuth/README.md) | Core OAuth application config, authorities, token clients, flows, redirect contracts, and Microsoft Entra app registration storage. |
| Rest Client OAuth Endpoints | [RestClientOAuthEndpoints](RestClientOAuthEndpoints/README.md) | Optional generic HTTP endpoint setup tables, pages, and factories that adapt endpoint records to the core OAuth app. |
| Advanced Redirect URI | [RestClientOAuthAdvancedRedirectURI](RestClientOAuthAdvancedRedirectURI/README.md) | Optional redirect URI strategy implemented with a control add-in and hosted landing page. |
| Rest Client OAuth Examples | [RestClientOAuthExamples](RestClientOAuthExamples/README.md) | Example pages and connector codeunits that demonstrate direct core usage, endpoint usage, certificate usage, and Device Code flow. |

## Redesign Summary

The core app is now focused on OAuth composition and no longer owns generic endpoint setup. Endpoint tables and pages live in the optional endpoint app with object range `50350..50399`. The examples app depends on all companion apps so it can demonstrate each usage style without forcing those dependencies on production apps.

Use the core app directly when your extension already has its own API setup model. Add the endpoint app only when you want reusable endpoint records and setup pages.

## Documentation Map

- Core API and architecture: [RestClientOAuth/docs/Index.md](RestClientOAuth/docs/Index.md)
- Endpoint app: [RestClientOAuthEndpoints/docs/Index.md](RestClientOAuthEndpoints/docs/Index.md)
- Advanced redirect URI app: [RestClientOAuthAdvancedRedirectURI/docs/Index.md](RestClientOAuthAdvancedRedirectURI/docs/Index.md)
- Examples app: [RestClientOAuthExamples/docs/Index.md](RestClientOAuthExamples/docs/Index.md)

## Build Order

Build `RestClientOAuth` first. Build `RestClientOAuthEndpoints` and `RestClientOAuthAdvancedRedirectURI` after the core app. Build `RestClientOAuthExamples` last because it depends on all other apps.