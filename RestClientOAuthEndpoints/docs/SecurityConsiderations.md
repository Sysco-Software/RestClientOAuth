# Security Considerations

This app stores endpoint configuration and adapts it to the core OAuth app. Token acquisition and token storage rules are defined by the core app.

## Endpoint Data

`Table 50351 "Http Endpoint KFM"`, `Table 50355 "Http Endpoint Basic Auth. KFM"`, `Table 50356 "Http Endpoint OAuth 2.0 KFM"`, and `Table 50357 "Http Endpoint OAuth Scope KFM"` contain setup data. Treat base URLs, tenants, app registration codes, scopes, and usernames as configuration data that may reveal integration details.

## Basic Passwords

Basic-auth passwords are not stored directly in normal table fields. `Table 50355 "Http Endpoint Basic Auth. KFM"` stores an isolated-storage reference in `Password ID`; `SetPassword` writes the password to isolated storage and uses encrypted isolated storage when encryption is enabled.

## OAuth Secrets

OAuth client secrets and certificate private keys are owned by the core app's Microsoft Entra app-registration storage, not by endpoint records. Endpoint OAuth setup references the app registration by code.

## Flow Selection

Endpoint validation intentionally prevents confidential/public-client mismatch for flow types:

- Client Credentials is confidential only.
- Device Code is public only.
- Authorization Code can be public or confidential.

Do not bypass these validations in data migration or setup automation.

## Device Code Phishing Risk

When an endpoint uses Device Code flow, users should verify that the displayed code belongs to the expected application and request. Device Code should not be used for unattended service-to-service calls.

## Tenant Selection

`Target Entra Tenant Id` controls which tenant is used for multi-tenant app registrations. Incorrect tenant setup can send users to the wrong tenant or cause token failures. Client Credentials requires a concrete target tenant.
