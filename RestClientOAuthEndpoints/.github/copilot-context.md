# Rest Client OAuth Endpoints Copilot Context

## Project Boundary
- AL app: `RestClientOAuthEndpoints`.
- Depends on core app `Rest Client OAuth`.
- Contains generic HTTP endpoint tables, pages, and endpoint-to-authentication factories.
- Uses object range `50350..50399` and mandatory affix `KFM`.

## Architecture
- This app is the optional endpoint configuration layer.
- Do not place core OAuth token clients, flows, authorities, or Entra app-registration storage here.
- Map endpoint records to core objects by creating `OAuth Application Config KFM`, configuring an `OAuth Authorization Flow KFM`, and initializing `Http Authentication OAuth2 KFM`.

## Source Layout
- Use feature-oriented folders under `src/Endpoint`.
- `HttpEndpoint` contains the generic endpoint table, pages, and Rest Client factory.
- `Authentication` contains shared authentication selection objects and anonymous authentication.
- `BasicAuth` contains Basic authentication table, subpage, and factory implementation.
- `OAuth20` contains OAuth endpoint configuration, scopes, pages, and factory implementation.
- Do not reintroduce folders grouped by AL object type such as `Codeunits`, `Pages`, or `Tables`.
