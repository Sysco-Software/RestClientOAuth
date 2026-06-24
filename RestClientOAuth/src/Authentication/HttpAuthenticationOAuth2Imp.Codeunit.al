codeunit 50303 HttpAuthenticationOAuth2ImpKFM
{
    Access = Internal;

    var
        OAuthClientApplication: Codeunit "OAuth Application Config KFM";
        OAuthAuthorizationFlow: Interface "OAuth Authorization Flow KFM";

    procedure Initialize(ClientApplication: Codeunit "OAuth Application Config KFM"; AuthorizationFlow: Interface "OAuth Authorization Flow KFM")
    begin
        OAuthClientApplication := ClientApplication;
        OAuthAuthorizationFlow := AuthorizationFlow;
    end;

    procedure IsAuthenticationRequired(): Boolean;
    begin
        exit(true);
    end;

    procedure GetAuthorizationHeaders() Headers: Dictionary of [Text, SecretText];
    begin
        Headers.Add('Authorization', OAuthAuthorizationFlow.GetAuthorizationHeader(OAuthClientApplication));
    end;
}