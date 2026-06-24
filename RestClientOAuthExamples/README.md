# Rest Client OAuth Examples

Sample app for the `Rest Client OAuth` solution.

This app depends on the core app, the endpoint app, and the advanced redirect app so it can demonstrate multiple integration styles. Do not take a dependency on this app from production code.

## Included Scenarios

- Authorization Code with confidential client secret.
- Authorization Code with certificate client assertion.
- Generic endpoint-record based authentication through `Rest Client OAuth Endpoints`.
- Device Code flow using a public client.
- Business Central API calls for environments, companies, and customers.

## Main Objects

- `Codeunit 50500 "BC Connector With Secret"`
- `Codeunit 50503 "BC Connector with Certificate"`
- `Codeunit 50502 "BC Connector with Endpoint"`
- `Codeunit 50505 "BC Connector With Azure CLI"`
- `Page 50500 "BC APIs with Secret"`
- `Page 50501 "BC APIs with Endpoint"`
- `Page 50502 "BC APIs With Certificate"`
- `Page 50504 "BC APIs with Azure CLI"`

## Documentation

- [Documentation Index](docs/Index.md)
- [Scenarios](docs/Scenarios.md)
- [Setup Notes](docs/Setup.md)
