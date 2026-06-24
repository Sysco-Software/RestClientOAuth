interface "OAuth Client KFM"
{
    procedure AcquireTokenByAuthorizationCode(AuthorizationCode: SecretText; VerifierCode: SecretText; OAuthAuthority: Interface "OAuth Authority KFM"; OAuthApplicationConfig: Codeunit "OAuth Application Config KFM") AuthenticationResult: Codeunit "OAuth AuthenticationResult KFM"
    procedure AcquireTokenByRefreshToken(RefreshToken: SecretText; OAuthAuthority: Interface "OAuth Authority KFM"; OAuthApplicationConfig: Codeunit "OAuth Application Config KFM") AuthenticationResult: Codeunit "OAuth AuthenticationResult KFM"
}