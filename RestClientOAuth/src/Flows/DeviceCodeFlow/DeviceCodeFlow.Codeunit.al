codeunit 50326 "Device Code Flow KFM" implements "OAuth Authorization Flow KFM"
{
    var
        DeviceCodeFlowImpl: Codeunit DeviceCodeFlowImplKFM;

    procedure SetAuthority(Value: Interface "OAuth Authority KFM")
    begin
        DeviceCodeFlowImpl.SetAuthority(Value);
    end;

    procedure Initialize(OAuthAuthority: Interface "OAuth Authority KFM"; OAuthClientType: Enum "OAuth Client Type KFM"; PromptInteraction: Enum "Prompt Interaction");
    begin
        DeviceCodeFlowImpl.Initialize(OAuthAuthority);
    end;

    procedure GetAuthorizationHeader(OAuthClientApplication: Codeunit "OAuth Application Config KFM") ReturnValue: SecretText
    begin
        ReturnValue := DeviceCodeFlowImpl.GetAuthorizationHeader(OAuthClientApplication);
    end;
}