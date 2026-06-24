codeunit 50304 "Client Credentials Flow KFM" implements "OAuth Authorization Flow KFM"
{
    var
        ClientCredentialsFlowImpl: Codeunit ClientCredentialsFlowImplKFM;

    procedure SetAuthority(Value: Interface "OAuth Authority KFM")
    begin
        ClientCredentialsFlowImpl.SetAuthority(Value);
    end;

    procedure Initialize(OAuthAuthority: Interface "OAuth Authority KFM"; OAuthClientType: Enum "OAuth Client Type KFM"; PromptInteraction: Enum "Prompt Interaction");
    begin
        ClientCredentialsFlowImpl.Initialize(OAuthAuthority);
    end;

    procedure GetAuthorizationHeader(OAuthClientApplication: Codeunit "OAuth Application Config KFM") ReturnValue: SecretText;
    begin
        ReturnValue := ClientCredentialsFlowImpl.GetAuthorizationHeader(OAuthClientApplication);
    end;
}