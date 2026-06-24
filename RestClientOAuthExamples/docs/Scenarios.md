# Scenarios

The examples app demonstrates Business Central API calls through different authentication styles.

## Shared Data Objects

| Object | Purpose |
| --- | --- |
| `Table 50500 "BC Environment"` | Stores environment names returned from the Business Central environments API. |
| `Table 50501 "BC Company"` | Stores companies returned from the selected environment. |
| `Table 50502 "BC Customer"` | Stores customers returned from the selected company. |
| `Codeunit 50501 "Http Client Handler Examples"` | Example HTTP client handler for `Rest Client`. |

## Authorization Code With Secret

Objects:

- `Codeunit 50500 "BC Connector With Secret"`
- `Page 50500 "BC APIs with Secret"`

This scenario composes the core app directly. It creates `Codeunit 50306 "OAuth Application Config KFM"`, sets a client secret, uses `Codeunit 50305 "Auth. Code Grant Flow KFM"` as confidential client, and initializes `Codeunit 50301 "Http Authentication OAuth2 KFM"`.

## Authorization Code With Certificate

Objects:

- `Codeunit 50503 "BC Connector with Certificate"`
- `Page 50502 "BC APIs With Certificate"`

This scenario is the certificate equivalent of the secret sample. It creates `Codeunit 50310 "OAuth Certificate KFM"` and uses a certificate-backed confidential client assertion.

## Endpoint Records

Objects:

- `Codeunit 50502 "BC Connector with Endpoint"`
- `Page 50501 "BC APIs with Endpoint"`

This scenario depends on `Rest Client OAuth Endpoints`. It uses `Record "Http Endpoint KFM"/GetRestClient` to obtain an authenticated `Rest Client` from endpoint setup records instead of composing the OAuth objects directly.

## Device Code

Objects:

- `Codeunit 50505 "BC Connector With Azure CLI"`
- `Page 50504 "BC APIs with Azure CLI"`

This scenario demonstrates `Codeunit 50326 "Device Code Flow KFM"` with a public client. It is useful for learning the flow mechanics, but production setup automation should use an application owned by your product rather than another product's public client id.

## Demo Codeunit

`Codeunit 50504 Demo` contains small comparison snippets for the platform `OAuth2` codeunit. It is not part of the main redesigned OAuth abstraction.
