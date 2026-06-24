codeunit 50324 "Redirect URI None KFM" implements "Redirect URI KFM"
{
    procedure RedirectURIEditable(): Boolean
    begin
        exit(false);
    end;

    procedure GetDefaultRedirectURI(): Text
    begin
        exit('');
    end;

    procedure GetAuthorizationCode(OAuthClientApplication: Codeunit "OAuth Application Config KFM"; OAuthAuthority: Interface "OAuth Authority KFM"; PromptInteraction: Enum "Prompt Interaction"; PKCECodeChallenge: Text): Text
    begin
        exit('');
    end;
}