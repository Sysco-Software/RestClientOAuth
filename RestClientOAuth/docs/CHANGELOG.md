## Changelog

All notable changes to this project will be documented in this file. This format is based on Keep a Changelog.

### Unreleased
#### Added
- Public-client Authorization Code + PKCE token and refresh exchange support.
- Optional `Rest Client OAuth Endpoints` app containing generic endpoint tables, pages, and factories.
- Dedicated documentation sets for the core, endpoint, advanced redirect, and examples apps.
- Redesign documentation describing the split app architecture.

#### Changed
- Authorization Code public/confidential selection is controlled by endpoint OAuth Client Type configuration.
- `Rest Client OAuth` is now the core app and no longer depends on endpoint records; endpoint records adapt to core OAuth objects from the optional endpoint app.
- Endpoint app object range moved to `50350..50399`.

### [1.0] - 2025-08-29
#### Added
- Core Authorization Code Grant and Client Credentials flows with PKCE, state, offline_access auto-add, certificate/secret support.
- In-memory token & refresh handling.
- Advanced redirect URI SSO-like sample.
- Examples
- Initial documentation suite (README, architecture, flows, examples, advanced redirect, extensibility, security, configuration, troubleshooting, FAQ, future improvements).

#### Security
- SecretText storage for tokens.
