# Documentation Index

This folder documents the core `Rest Client OAuth` app. Endpoint records, advanced redirect hosting, and runnable samples now have their own app-level documentation.

## Core App Docs

| Doc | Purpose |
|-----|---------|
| [Architecture](Architecture.md) | Core components, public objects, and runtime call path. |
| [Redesign Notes](Redesign.md) | What changed in the redesign and why the app split exists. |
| [Getting Started](GettingStarted.md) | Direct AL composition of application config, authority, flow, OAuth authentication, and Rest Client. |
| [Configuration](Configuration.md) | Core configuration values and flow-specific rules. |
| [Flows](Flows.md) | Comparison of Authorization Code, Client Credentials, and Device Code flows. |
| [Device Code Flow](DeviceCodeFlow.md) | Current Device Code behavior, polling, errors, and security notes. |
| [examples](examples.md) | Short direct-AL snippets. Runnable samples live in the examples app. |
| [Extensibility](Extensibility.md) | Custom authorities, redirect strategies, token flows, and endpoint integration contracts. |
| [Security Considerations](SecurityConsiderations.md) | PKCE, state, credentials, token storage, Device Code risks, and setup identity guidance. |
| [Troubleshooting](Troubleshooting.md) | Core flow and token-acquisition problems. |
| [FAQ](FAQ.md) | Common design and usage questions. |
| [Changelog](CHANGELOG.md) | Versioned change notes. |
| [Future Improvements](FutureImprovements.md) | Roadmap ideas and known follow-up areas. |

## Related App Docs

| App | Documentation |
|-----|---------------|
| Rest Client OAuth Endpoints | [Endpoint documentation](../../RestClientOAuthEndpoints/docs/Index.md) |
| Advanced Redirect URI | [Advanced redirect documentation](../../RestClientOAuthAdvancedRedirectURI/docs/Index.md) |
| Rest Client OAuth Examples | [Examples documentation](../../RestClientOAuthExamples/docs/Index.md) |

## Suggested Reading Order

1. [Redesign Notes](Redesign.md)
2. [Architecture](Architecture.md)
3. [Flows](Flows.md)
4. [Getting Started](GettingStarted.md)
5. [Configuration](Configuration.md) and [Security Considerations](SecurityConsiderations.md)
6. Related app documentation if you use endpoint records, advanced redirect, or examples
