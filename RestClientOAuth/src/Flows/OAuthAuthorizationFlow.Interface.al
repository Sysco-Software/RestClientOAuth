interface "OAuth Authorization Flow KFM"
{
    procedure Initialize(OAuthAuthority: Interface "OAuth Authority KFM"; OAuthClientType: Enum "OAuth Client Type KFM"; PromptInteraction: Enum "Prompt Interaction")
    procedure GetAuthorizationHeader(OAuthClientApplication: Codeunit "OAuth Application Config KFM"): SecretText
}