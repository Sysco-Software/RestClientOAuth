## Troubleshooting

| Symptom | Possible Cause | Resolution |
|---------|----------------|-----------|
| Authorization page repeats login | Missing/incorrect state handling (custom redirect) | Ensure state is preserved through round-trip |
| Access token expires & no silent refresh | Refresh token lost (new instance) | Re-run Authorization Code flow; design persistent layer if needed |
| invalid_client error | Secret/certificate mismatch or wrong tenant | Verify credential and tenant ID |
| invalid_scope error | Scope not consented / typo | Correct scope, ensure admin consent if required |
| redirect_uri_mismatch | Redirect URI differs from registration | Align configured URI with actual request |
| certificate signature error | Incorrect private key or key format | Confirm key XML & certificate correspond |
| admin consent required | Lacking permissions | Use Prompt Interaction::"Admin Consent" or grant in portal |
| invalid_client during Device Code Flow | Public client flows are not enabled for the app registration, or the authority rejects public-client use | Enable public client flows / mobile and desktop flows and verify the client id |
| authorization_declined or access_denied | User denied the device-code request | Start the flow again and approve the requested consent if appropriate |
| expired_token during Device Code Flow | User did not complete sign-in before the device code expired | Start a new device-code authorization request |
| authorization_pending repeats | User has not completed sign-in yet | Wait for the polling interval; the flow continues until completion or expiry |

### Logs & Diagnostics
Leverage error messages raised via `ErrorInfo` from HTTP responses for detailed diagnostics. Endpoint-record setup issues are covered in the endpoint app troubleshooting guide: [Rest Client OAuth Endpoints troubleshooting](../../RestClientOAuthEndpoints/docs/Troubleshooting.md).
