codeunit 50305 "Auth. Code Grant Flow KFM" implements "OAuth Authorization Flow KFM"
{
    var
        AuthCodeGrantFlowImpl: Codeunit AuthCodeGrantFlowImplKFM;

    procedure SetPromptInteraction(Value: Enum "Prompt Interaction")
    begin
        AuthCodeGrantFlowImpl.SetPromptInteraction(Value);
    end;

    procedure GetPromptInteraction() ReturnValue: Enum "Prompt Interaction"
    begin
        ReturnValue := AuthCodeGrantFlowImpl.GetPromptInteraction();
    end;

    procedure SetOAuthClientType(Value: Enum "OAuth Client Type KFM")
    begin
        AuthCodeGrantFlowImpl.SetOAuthClientType(Value);
    end;

    procedure GetOAuthClientType() ReturnValue: Enum "OAuth Client Type KFM"
    begin
        ReturnValue := AuthCodeGrantFlowImpl.GetOAuthClientType();
    end;

    procedure SetAuthority(Value: Interface "OAuth Authority KFM")
    begin
        AuthCodeGrantFlowImpl.SetAuthority(Value);
    end;

    procedure GetAuthority() Value: Interface "OAuth Authority KFM"
    begin
        Value := AuthCodeGrantFlowImpl.GetAuthority();
    end;

    procedure Initialize(OAuthAuthority: Interface "OAuth Authority KFM"; OAuthClientType: Enum "OAuth Client Type KFM"; PromptInteraction: Enum "Prompt Interaction");
    begin
        AuthCodeGrantFlowImpl.Initialize(OAuthAuthority, OAuthClientType, PromptInteraction);
    end;

    procedure GetAuthorizationHeader(OAuthClientApplication: Codeunit "OAuth Application Config KFM") ReturnValue: SecretText
    begin
        ReturnValue := AuthCodeGrantFlowImpl.GetAuthorizationHeader(OAuthClientApplication);
    end;

    procedure GetPKCECodeChallenge() ReturnValue: Text
    begin
        ReturnValue := AuthCodeGrantFlowImpl.GetPKCECodeChallenge();
    end;
}
