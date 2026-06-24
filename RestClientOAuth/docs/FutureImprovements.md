## Future Improvements

Potential enhancements (not implemented yet):

- Persistent secure token cache (e.g., encrypted isolated storage) with opt-in configuration.
- Telemetry hooks (token acquisition duration, refresh counts, error taxonomy).
- Additional authority implementations (e.g., other OAuth-compliant IdPs) with validation test suites.
- Pluggable token persistence strategy interface.
- Enhanced secret management guidance & integration with secure storage providers.
- Automatic retry/backoff for transient HTTP failures.
- Structured logging / diagnostics events.
- Setup wizard for Microsoft Entra app registrations using a dedicated public setup application, Authorization Code + PKCE, and delegated Microsoft Graph permissions. This should create/configure endpoint app registrations directly from Business Central without reusing another product's public client id.

## Design Candidates

- Token persistence interface with explicit opt-in storage.
- Performance considerations for high-volume API callers.
- Graph-based Microsoft Entra setup automation using a dedicated public setup application.
