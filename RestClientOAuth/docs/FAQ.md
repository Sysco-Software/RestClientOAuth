## FAQ

**Q: All objects do have a suffix KFM. Why is that and should I change it?**
All extension objects for Business Central should have a prefix or suffix. Chances are that this module will be adopted in the system app of Business Central. Then the suffixes will be removed. To avoid possible conflicts when that happens, it is recommended to have a suffix on all objects. You may change KFM to any other suffix you prefer. 

**Q: The object number range is in the PTE range. Should I change this?**
Feel free to renumber the objects to a range that fits your apps.

**Q: Why do I need to re-authenticate after a restart?**  
Tokens are in-memory only; refresh token disappears when the Rest Client instance is disposed.

**Q: Why is offline_access automatically added?**  
To obtain a refresh token enabling silent refresh (within object lifetime) for the Authorization Code flow.

**Q: Why use PKCE with Authorization Code flow?**  
PKCE is recommended for public and confidential clients. It is essential for public clients and still useful as defense-in-depth for confidential clients because it mitigates authorization-code interception.

**Q: Can Authorization Code flow be used as a public-client flow?**  
Yes. Authorization Code with PKCE is supported for public clients and is preferred when redirect-based browser interaction is available. In this module, the endpoint's `OAuth Client Type` setting chooses whether Authorization Code flow uses the public or confidential client.

**Q: When should I choose a certificate over a secret?**  
When you want stronger credential assurance and easier rotation without secret string exposure.

**Q: Can I support another identity provider?**  
Design is pluggable via `OAuth Authority`, but only Microsoft Entra ID is tested. Additional providers would need a new authority implementation (see Extensibility).

**Q: How do I handle an expired token in Client Credentials flow?**  
The flow simply requests a fresh token—no refresh token concept exists.

**Q: When should I choose Device Code flow?**  
Prefer Authorization Code with PKCE when the user can complete a redirect-based browser interaction. Use Device Code flow for user-delegated access when the Business Central session should display a code for sign-in on another device instead of opening a redirect-based authorization window. It is public-client only and does not use a client secret or certificate.

**Q: Should setup automation reuse the Azure CLI client id?**  
No. Setup automation should use a dedicated public setup application owned by this module or product, authenticated with Authorization Code and PKCE. Reusing the Azure CLI client id would make consent, sign-in logs, audit trails, and token acquisition identify Azure CLI rather than the Business Central setup experience.

**Q: Can I persist tokens?**  
Not currently; would require adding a persistence layer (see Future Improvements).

**Q: Why does the advanced redirect sometimes avoid a popup?**  
It leverages a control add-in within the existing browser session (SSO-like behavior) if the user is already authenticated.

**Q: How do I force re-consent?**  
Set `Prompt Interaction` to Consent or Admin Consent.

**Q: Where is endpoint setup documented now?**
Endpoint setup is documented in the optional endpoint app: [Rest Client OAuth Endpoints](../../RestClientOAuthEndpoints/docs/Index.md).

**Q: Where is the advanced redirect implementation documented now?**
The implementation is documented in the companion app: [Advanced Redirect URI](../../RestClientOAuthAdvancedRedirectURI/docs/Index.md).
