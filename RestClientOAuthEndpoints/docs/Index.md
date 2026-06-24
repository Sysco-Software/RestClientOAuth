# Rest Client OAuth Endpoints Documentation

This app provides the optional generic endpoint setup layer for the `Rest Client OAuth` core app.

Use these docs when you want reusable endpoint records and setup pages for anonymous, Basic, or OAuth 2.0 authentication. If your app already has its own customer, tenant, API, or endpoint setup model, depend on the core app directly instead.

## Contents

| Document | Purpose |
| --- | --- |
| [Architecture](Architecture.md) | Endpoint tables, pages, factories, and how they adapt to core OAuth objects. |
| [Getting Started](GettingStarted.md) | Create endpoint records and use them to initialize `Rest Client`. |
| [Configuration](Configuration.md) | Field-by-field endpoint setup for anonymous, Basic, and OAuth 2.0 authentication. |
| [Security Considerations](SecurityConsiderations.md) | Secret handling, endpoint data ownership, and flow-specific risk notes. |
| [Troubleshooting](Troubleshooting.md) | Common endpoint setup and runtime issues. |

## Related Apps

- Core OAuth API: [../RestClientOAuth/README.md](../../RestClientOAuth/README.md)
- Advanced redirect implementation: [../RestClientOAuthAdvancedRedirectURI/README.md](../../RestClientOAuthAdvancedRedirectURI/README.md)
- Example scenarios: [../RestClientOAuthExamples/README.md](../../RestClientOAuthExamples/README.md)
