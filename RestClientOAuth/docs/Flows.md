## Flows

| Flow | Credentials | PKCE | Refresh Token | offline_access | Token Persistence |
|------|-------------|------|---------------|----------------|------------------|
| Authorization Code Grant | None for public client, or Secret/Certificate for confidential client | Yes (S256) | Yes (in-memory) | Auto-added | In-memory only |
| Client Credentials | Secret or Certificate | N/A | No (re-acquire) | Not used | In-memory (access token) |
| Device Code | Public client only | N/A | Yes (in-memory) | Auto-added | In-memory only |

### Authorization Code Grant Flow
Interactive user delegation and the preferred flow when redirect-based browser interaction is available. Implements PKCE (S256) and state for CSRF mitigation. Automatically appends `offline_access` scope when first requesting an authorization code to obtain a refresh token. Endpoint configuration selects Public or Confidential OAuth Client Type for token and refresh exchange. Public-client exchange sends no client credential; confidential-client exchange sends the configured secret or certificate assertion. Refresh token & access token exist only in memory.

### Client Credentials Flow
Service-to-service. No refresh token. Access token re-acquired when expired.

### Device Code Flow
Interactive user delegation for public client applications that cannot use redirect-based browser interaction. The flow requests a device code, opens a cancelable dialog with the authority-provided instructions, polls the token endpoint from that dialog, and uses an in-memory refresh token when one is returned. Client secrets and certificates are not sent for this flow.

### Secret vs Certificate
- Secret: simpler setup, rotate regularly.
- Certificate: stronger credential, JWT client assertion using RS256 signed with private key.

### Access and refresh Tokens
All tokens are stored as `SecretText` in memory only. When the Rest Client instance is disposed or reinitialized, a fresh authorization (Authorization Code or Device Code) or token acquisition (Client Credentials) occurs.
