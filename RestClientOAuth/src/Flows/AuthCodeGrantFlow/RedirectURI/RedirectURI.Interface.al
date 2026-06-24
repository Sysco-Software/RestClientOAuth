interface "Redirect URI KFM"
{
    procedure RedirectURIEditable(): Boolean;
    procedure GetDefaultRedirectURI(): Text;
    procedure GetAuthorizationCode(OAuthClientApplication: Codeunit "OAuth Application Config KFM"; OAuthAuthority: Interface "OAuth Authority KFM"; PromptInteraction: Enum "Prompt Interaction"; PKCECodeChallenge: Text): Text;
}