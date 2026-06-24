# Device Code Flow

Device Code flow is implemented and supported as an advanced or fallback user-delegation flow. Prefer Authorization Code with PKCE when redirect-based browser interaction is available.

## Public Objects

- `Codeunit 50326 "Device Code Flow KFM"`: flow facade implementing `Interface "OAuth Authorization Flow KFM"`.
- `Codeunit 50327 DeviceCodeFlowImplKFM`: internal orchestration and refresh preference.
- `Page 50312 "Device Code Authorization KFM"`: user-facing dialog with instructions, status, and cancel action.
- `ControlAddIn "Device Code Polling Timer KFM"`: schedules polling ticks while the dialog is open.
- `Codeunit 50329 "OAuth Public Client KFM"`: sends public-client device authorization, polling, and refresh requests.

## Runtime Behavior

1. The caller initializes `Codeunit 50326 "Device Code Flow KFM"` with an authority.
2. `GetAuthorizationHeader` returns the cached access token if it is still valid.
3. If the access token expired and a refresh token exists, the flow tries public-client refresh first.
4. If refresh is not possible, the flow adds `offline_access` when missing.
5. The flow requests a device authorization response from the authority device endpoint.
6. `Page 50312 "Device Code Authorization KFM"` shows the authority message, user code, verification URI, status, and Cancel action.
7. The dialog polls the token endpoint until success, cancellation, expiry, denial, or an unrecoverable OAuth error.
8. A successful token response is stored in memory and returned as a bearer authorization header.

## Microsoft Entra ID Notes

- Public client flows must be enabled on the app registration.
- The flow uses `/oauth2/v2.0/devicecode` for the device authorization request.
- The token poll uses `grant_type=urn:ietf:params:oauth:grant-type:device_code`.
- Microsoft Entra ID does not require or use a redirect URI for Device Code flow.

## Error Handling

| OAuth result | Behavior |
|--------------|----------|
| `authorization_pending` | Continue polling at the current interval. |
| `slow_down` | Increase the polling interval by 5 seconds. |
| `authorization_declined` or `access_denied` | Stop polling and show a declined authorization error. |
| `bad_verification_code` | Stop polling and show a verification-code error. |
| `expired_token` | Stop polling and show an expiry error. |

## Security Notes

- The user-facing `user_code`, `verification_uri`, and message can be shown.
- The back-channel `device_code` is held as `SecretText` and is not displayed.
- Device Code is not a service-to-service flow. Use Client Credentials for unattended application access.
- Do not use another product's public client id as a bootstrap identity for setup automation.