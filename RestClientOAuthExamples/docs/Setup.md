# Setup Notes

The examples app is intentionally broad: it depends on `Rest Client OAuth`, `Rest Client OAuth Endpoints`, and `Advanced Redirect URI` so it can demonstrate all companion apps.

## Before Running Samples

- Replace sample client IDs, secrets, certificates, tenants, and URLs with values from your own Microsoft Entra app registrations.
- Do not commit real secrets or private keys.
- Verify redirect URIs in Microsoft Entra ID match the redirect implementation you select.
- Grant the required Business Central API permissions and admin consent where needed.
- Enable public client flows if you run the Device Code sample.

## Business Central API Permissions

The samples use the Business Central API scope:

```text
https://api.businesscentral.dynamics.com/user_impersonation
```

The examples call:

- `https://api.businesscentral.dynamics.com/environments/v1.1`
- `https://api.businesscentral.dynamics.com/v2.0/<environment>/api/v2.0/companies`
- `https://api.businesscentral.dynamics.com/v2.0/<environment>/api/v2.0/customers`

## Endpoint Sample Setup

The endpoint sample expects a configured `Table 50351 "Http Endpoint KFM"` record. See [Endpoint Getting Started](../../RestClientOAuthEndpoints/docs/GettingStarted.md) for setup details.

## Device Code Warning

The Device Code example currently demonstrates use of a known public client id. This can be useful as a local learning shortcut, but it is not the recommended design for product setup or production automation. Product setup should use a dedicated public setup application owned by your product.
