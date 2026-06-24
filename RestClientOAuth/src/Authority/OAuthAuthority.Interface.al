interface "OAuth Authority KFM"
{
    procedure Initialize(OAuthApplicationCode: Code[20]; TargetTenantId: Text)
    procedure GetApplicationConfig(OAuthApplicationCode: Code[20]; ScopesList: List of [Text]) OAuthApplicationConfig: Codeunit "OAuth Application Config KFM"
    procedure GetAuthorizationEndpoint(OAuthClientApplication: Codeunit "OAuth Application Config KFM"): Text
    procedure GetDeviceAuthorizationEndpoint(): Text
    procedure GetTokenEndpoint(): Text
}