codeunit 50329 "OAuth Public Client KFM" implements "OAuth Client KFM"
{
    var
        OAuthPublicClientImpl: Codeunit OAuthPublicClientImplKFM;

    internal procedure AcquireDeviceAuthorization(OAuthAuthority: Interface "OAuth Authority KFM"; OAuthClientApplication: Codeunit "OAuth Application Config KFM") DeviceAuthorizationResponse: JsonObject
    begin
        DeviceAuthorizationResponse := OAuthPublicClientImpl.AcquireDeviceAuthorization(OAuthAuthority, OAuthClientApplication);
    end;

    procedure AcquireTokenByAuthorizationCode(AuthorizationCode: SecretText; VerifierCode: SecretText; OAuthAuthority: Interface "OAuth Authority KFM"; OAuthClientApplication: Codeunit "OAuth Application Config KFM") AuthenticationResult: Codeunit "OAuth AuthenticationResult KFM"
    begin
        AuthenticationResult := OAuthPublicClientImpl.AcquireTokenByAuthorizationCode(AuthorizationCode, VerifierCode, OAuthAuthority, OAuthClientApplication);
    end;

    procedure AcquireTokenByDeviceCode(DeviceCode: SecretText; OAuthAuthority: Interface "OAuth Authority KFM"; OAuthClientApplication: Codeunit "OAuth Application Config KFM"; var ErrorCode: Text; var ErrorDescription: Text) AuthenticationResult: Codeunit "OAuth AuthenticationResult KFM"
    begin
        AuthenticationResult := OAuthPublicClientImpl.AcquireTokenByDeviceCode(DeviceCode, OAuthAuthority, OAuthClientApplication, ErrorCode, ErrorDescription);
    end;

    procedure AcquireTokenByRefreshToken(RefreshToken: SecretText; OAuthAuthority: Interface "OAuth Authority KFM"; OAuthClientApplication: Codeunit "OAuth Application Config KFM") AuthenticationResult: Codeunit "OAuth AuthenticationResult KFM"
    begin
        AuthenticationResult := OAuthPublicClientImpl.AcquireTokenByRefreshToken(RefreshToken, OAuthAuthority, OAuthClientApplication);
    end;
}