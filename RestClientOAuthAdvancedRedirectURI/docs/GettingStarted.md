# Getting Started

Use this app when you want to select the advanced redirect URI strategy for Authorization Code flow.

## 1. Add The App Dependency

Your extension must depend on:

- `Rest Client OAuth`
- `Advanced Redirect URI`

## 2. Register The Redirect URI

Register the advanced redirect URI in Microsoft Entra ID:

```text
https://msdyn365bc.z6.web.core.windows.net/oauthlanding.html
```

If you host your own copy of `oauthlanding.html`, register that URL instead and update `Codeunit 50400 "Redirect URI Advanced KFM"` accordingly.

## 3. Select The Redirect Type

Direct AL configuration:

```al
OAuthApplicationConfig.SetRedirectUriType(Enum::"Redirect URI Type KFM"::"Advanced KFM");
```

Microsoft Entra app-registration storage:

- Open `Page 50305 "Entra App Registr. Card KFM"` from the core app.
- Set `Redirect Uri Type` to `Advanced KFM`.
- Confirm the redirect URI matches the registered value.

Endpoint app configuration references the same app-registration record, so endpoint records pick up the selected redirect type from the core app registration.

## 4. Use Authorization Code Flow

The advanced redirect strategy is used only by Authorization Code flow. Client Credentials and Device Code do not use redirect URI handling.
