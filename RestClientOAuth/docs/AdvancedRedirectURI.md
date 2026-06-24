# Advanced Redirect URI

This documentation moved to the optional `Advanced Redirect URI` app because the implementation lives outside the core app.

Use the dedicated docs here: [Advanced Redirect URI documentation](../../RestClientOAuthAdvancedRedirectURI/docs/Index.md).

The core app still owns the redirect URI interface and built-in redirect implementation. The advanced app extends `Enum 50304 "Redirect URI Type KFM"` and implements `Interface "Redirect URI KFM"` as an optional companion dependency.
