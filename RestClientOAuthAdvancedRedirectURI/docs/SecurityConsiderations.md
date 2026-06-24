# Security Considerations

The advanced redirect app handles browser messages and redirect-page communication. Token exchange remains in the core app.

## State Validation

The JavaScript generates a state value and validates the returned state before raising success to AL. Do not remove state validation; it binds the OAuth response to the initiating browser context.

## Message Validation

The control add-in accepts messages only from an origin matching the configured redirect URI and requires the expected response marker before processing the OAuth response. Keep this validation strict when modifying `src/ControlAddin/script.js`.

## Hosted Landing Page

The hosted landing page must be trusted and stable. If you host your own `oauthlanding.html`, serve it over HTTPS and keep the URL exactly aligned with Microsoft Entra ID app registration configuration.

## Redirect URI Integrity

The redirect URI used for authorization must match the redirect URI sent during token exchange. `Codeunit 50400 "Redirect URI Advanced KFM"` sets the application config redirect URI before starting authorization for that reason.

## Prompt Behavior

The control add-in first tries silent authorization unless prompt settings require interaction. Interactive fallback opens a popup. Use forced prompt values sparingly because they increase user friction.
