# Configuration

This page documents endpoint-record setup. Core OAuth object setup is documented in [Rest Client OAuth configuration](../../RestClientOAuth/docs/Configuration.md).

## Endpoint Header

`Table 50351 "Http Endpoint KFM"` stores the generic endpoint header.

| Field | Purpose |
| --- | --- |
| `Code` | Primary key used by AL callers and related setup records. |
| `Description` | Human-readable endpoint description. |
| `Base Url` | Optional base URL applied to the `Rest Client`. |
| `Authentication` | Selects `Anonymous`, `Basic`, or `OAuth20`. |

Changing `Authentication` calls the selected settings factory and creates the matching settings record when needed.

## Anonymous Authentication

`Enum 50350 "HTTP Authentication KFM"` value `Anonymous` uses `Codeunit 50371 "Http Endpoint Anonymous KFM"`. No additional setup is required.

## Basic Authentication

`Enum 50350 "HTTP Authentication KFM"` value `Basic` uses `Table 50355 "Http Endpoint Basic Auth. KFM"` and `Codeunit 50370 "Http Endpoint Basic Auth. KFM"`.

| Field | Purpose |
| --- | --- |
| `Http Endpoint Code` | Parent endpoint code. |
| `Username` | User name for Basic authentication. |
| `Domain` | Optional domain. |
| `Password ID` | Internal isolated-storage reference. |

Use `SetPassword` on `Table 50355 "Http Endpoint Basic Auth. KFM"` to store the password through isolated storage.

## OAuth 2.0 Authentication

`Enum 50350 "HTTP Authentication KFM"` value `OAuth20` uses `Table 50356 "Http Endpoint OAuth 2.0 KFM"`, `Table 50357 "Http Endpoint OAuth Scope KFM"`, and `Codeunit 50372 "Http Endpoint OAuth 2.0 KFM"`.

| Field | Purpose |
| --- | --- |
| `OAuth Authority` | Authority implementation, currently Microsoft Entra ID. |
| `OAuth Application Code` | Core app Microsoft Entra app registration code. |
| `OAuth Flow Type` | Authorization Code, Client Credentials, or Device Code. |
| `OAuth Client Type` | Public or Confidential for Authorization Code flow. |
| `Prompt Interaction` | Authorization Code prompt hint. |
| `Target Entra Tenant Id` | Tenant used for multi-tenant Entra registrations and Client Credentials. |

## Flow Rules

| Flow | Endpoint rules |
| --- | --- |
| Authorization Code | `OAuth Client Type` can be Public or Confidential. `Prompt Interaction` is allowed. |
| Client Credentials | `OAuth Client Type` is forced to Confidential. `Prompt Interaction` is set to None. `Target Entra Tenant Id` is required. |
| Device Code | `OAuth Client Type` is forced to Public. `Prompt Interaction` is set to None. |

## Scopes

Scopes are stored in `Table 50357 "Http Endpoint OAuth Scope KFM"`. Add plain scope strings such as `https://api.businesscentral.dynamics.com/user_impersonation`; do not pre-encode them.

Authorization Code and Device Code flows add `offline_access` at runtime when it is missing.

## Microsoft Entra App Registration

Endpoint OAuth configuration references `Table 50304 "Entra App Registration KFM"` from the core app. That record supplies the client id, redirect URI metadata, optional secret, and optional certificate.
