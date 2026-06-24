# Rest Client OAuth Endpoints

Optional generic HTTP endpoint configuration app for [Rest Client OAuth](../RestClientOAuth/README.md).

This app depends on the core `Rest Client OAuth` app and adds reusable endpoint tables, pages, and factories for anonymous, Basic, and OAuth 2.0 REST endpoints. Apps that already own their endpoint or domain model can depend on the core app directly without taking this layer.

## Main Objects

- `Enum 50350 "HTTP Authentication KFM"`: selects anonymous, Basic, or OAuth 2.0 endpoint authentication.
- `Table 50351 "Http Endpoint KFM"`: endpoint header with code, description, base URL, and authentication type.
- `Table 50355 "Http Endpoint Basic Auth. KFM"`: Basic-auth settings and password storage reference.
- `Table 50356 "Http Endpoint OAuth 2.0 KFM"`: endpoint OAuth authority, app registration, flow, client type, prompt, and tenant settings.
- `Table 50357 "Http Endpoint OAuth Scope KFM"`: endpoint OAuth scopes.
- `Codeunit 50368 "Http Endpoint Rest Client KFM"`: creates authenticated `Rest Client` instances from endpoint records.
- `Codeunit 50370 "Http Endpoint Basic Auth. KFM"`, `Codeunit 50371 "Http Endpoint Anonymous KFM"`, and `Codeunit 50372 "Http Endpoint OAuth 2.0 KFM"`: authentication factories.

## Documentation

- [Documentation Index](docs/Index.md)
- [Architecture](docs/Architecture.md)
- [Getting Started](docs/GettingStarted.md)
- [Configuration](docs/Configuration.md)
- [Security Considerations](docs/SecurityConsiderations.md)
- [Troubleshooting](docs/Troubleshooting.md)
