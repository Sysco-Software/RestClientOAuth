codeunit 50504 Demo
{

    trigger OnRun()
    var
        OAuth2: Codeunit OAuth2;
    begin
        
    end;

    local procedure GetAccessToken()
    var
        OAuth2: Codeunit OAuth2;
        AccessToken: SecretText;
        AuthCodeErr: Text;
        Scopes: List of [Text];
    begin
        Scopes.Add('https://api.businesscentral.dynamics.com/user_impersonation');
        if not OAuth2.AcquireTokenByAuthorizationCode(
                    '<YOUR_CLIENT_ID>',
                    SecretStrSubstNo('<YOUR_CLIENT_SECRET>'),
                    'https://login.microsoftonline.com/<YOUR_TENANT_ID>/oauth2/v2.0/authorize',
                    'https://<YOUR_BC_HOST>/bc/OAuthLanding.htm',
                    Scopes,
                    "Prompt Interaction"::"Select Account",
                    AccessToken,
                    AuthCodeErr
                )
        then
            Message(AuthCodeErr);
    end;

    local procedure RefreshAccessToken()
    var
        OAuth2: Codeunit OAuth2;
        Scopes: List of [Text];
        AccessToken: SecretText;
    begin
        Scopes.Add('https://api.businesscentral.dynamics.com/user_impersonation');
        if OAuth2.AcquireAuthorizationCodeTokenFromCache(
            '<YOUR_CLIENT_ID>',
            SecretStrSubstNo('<YOUR_CLIENT_SECRET>'),
            'https://<YOUR_BC_HOST>/bc/OAuthLanding.htm',
            'https://login.microsoftonline.com/<YOUR_TENANT_ID>/oauth2/v2.0/authorize',
                Scopes,
                AccessToken)
        then
            Message('Could not retrieve access token from cache');
    end;
}