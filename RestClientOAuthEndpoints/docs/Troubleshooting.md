# Troubleshooting

| Symptom | Likely cause | Resolution |
| --- | --- | --- |
| Endpoint returns unauthenticated requests | Authentication is `Anonymous` or settings record was not created | Revalidate `Authentication` on `Table 50351 "Http Endpoint KFM"` or open the endpoint card and save the selected authentication. |
| Basic authentication fails | Missing username, domain mismatch, or missing password in isolated storage | Verify `Table 50355 "Http Endpoint Basic Auth. KFM"` and reset the password with `SetPassword`. |
| OAuth endpoint cannot find app registration | `OAuth Application Code` does not exist in `Table 50304 "Entra App Registration KFM"` | Create or correct the app registration in the core app. |
| Client Credentials validation fails | `Target Entra Tenant Id` is blank | Set `Target Entra Tenant Id` for the endpoint OAuth record. |
| Device Code sends confidential credentials | Endpoint data was inserted without validation | Revalidate `OAuth Flow Type`; Device Code must force `OAuth Client Type` to Public. |
| Prompt Interaction cannot be edited | Selected flow is not Authorization Code | Prompt interaction is only supported for Authorization Code flow. |
| OAuth scope error | Missing or incorrect scope line | Review `Table 50357 "Http Endpoint OAuth Scope KFM"` and ensure consent has been granted. |
| Redirect URI mismatch | Referenced app registration uses a redirect URI that does not match the selected redirect implementation | Correct the core app registration record or Entra app registration. |

For token acquisition errors, also see the core troubleshooting guide: [Rest Client OAuth troubleshooting](../../RestClientOAuth/docs/Troubleshooting.md).
