# Advanced Redirect URI

Optional redirect URI implementation for [Rest Client OAuth](../RestClientOAuth/README.md).

This app extends `Enum 50304 "Redirect URI Type KFM"` with `Advanced KFM` and implements redirect handling through a Business Central control add-in and hosted landing page.

Use this app when the built-in redirect URI flow is not enough and you want a browser-session-friendly authorization experience.

## Main Objects

- `EnumExtension 50400 "Redirect URI Advanced KFM"`: adds `Advanced KFM` to `Enum 50304 "Redirect URI Type KFM"`.
- `Codeunit 50400 "Redirect URI Advanced KFM"`: implements `Interface "Redirect URI KFM"`.
- `Page 50400 AuthCodeGrantFlowAdvancedKFM`: hosts the control add-in during authorization.
- `ControlAddIn "OAuth Authorization Control KFM"`: starts authorization, receives landing-page messages, and raises AL events.
- `src/ControlAddin/oauthlanding.html`: landing page expected by the default redirect URI.

## Documentation

- [Documentation Index](docs/Index.md)
- [Architecture](docs/Architecture.md)
- [Getting Started](docs/GettingStarted.md)
- [Security Considerations](docs/SecurityConsiderations.md)
