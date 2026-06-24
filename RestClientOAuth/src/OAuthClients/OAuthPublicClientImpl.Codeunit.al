codeunit 50330 OAuthPublicClientImplKFM
{
    Access = Internal;

    var
        RestClient: Codeunit "Rest Client";
        RestClientInitialized: Boolean;
        TokenRequestErr: Label 'The token request failed. Error: %1. Description: %2', Comment = '%1 = The OAuth error code, %2 = The OAuth error description';

    procedure AcquireTokenByAuthorizationCode(AuthorizationCode: SecretText; VerifierCode: SecretText; OAuthAuthority: Interface "OAuth Authority KFM"; OAuthClientApplication: Codeunit "OAuth Application Config KFM") AuthenticationResult: Codeunit "OAuth AuthenticationResult KFM"
    var
        AccessTokenRequest: TextBuilder;
        AccessTokenRequestTxt: SecretText;
        ErrorCode: Text;
        ErrorDescription: Text;
    begin
        AccessTokenRequest.Append('grant_type=authorization_code');
        AccessTokenRequest.Append('&client_id=');
        AccessTokenRequest.Append(OAuthClientApplication.GetClientId());
        AccessTokenRequest.Append('&scope=');
        AccessTokenRequest.Append(OAuthClientApplication.GetUrlEncodedScopes());
        AccessTokenRequest.Append('&code=%1');
        AccessTokenRequest.Append('&redirect_uri=');
        AccessTokenRequest.Append(OAuthClientApplication.GetRedirectUri());
        if not VerifierCode.IsEmpty() then
            AccessTokenRequest.Append('&code_verifier=%2');

        AccessTokenRequestTxt := SecretStrSubstNo(AccessTokenRequest.ToText(), AuthorizationCode, VerifierCode);
        if not SendTokenRequest(AccessTokenRequestTxt, OAuthAuthority, AuthenticationResult, ErrorCode, ErrorDescription) then
            Error(TokenRequestErr, ErrorCode, ErrorDescription);
    end;

    procedure AcquireDeviceAuthorization(OAuthAuthority: Interface "OAuth Authority KFM"; OAuthClientApplication: Codeunit "OAuth Application Config KFM") DeviceAuthorizationResponse: JsonObject
    var
        HttpContent: Codeunit "Http Content";
        HttpResponseMessage: Codeunit "Http Response Message";
        DeviceAuthorizationRequest: TextBuilder;
    begin
        DeviceAuthorizationRequest.Append('client_id=');
        DeviceAuthorizationRequest.Append(OAuthClientApplication.GetClientId());
        DeviceAuthorizationRequest.Append('&scope=');
        DeviceAuthorizationRequest.Append(OAuthClientApplication.GetUrlEncodedScopes());

        HttpContent := HttpContent.Create(DeviceAuthorizationRequest.ToText(), 'application/x-www-form-urlencoded');

        InitializeRestClient();
        HttpResponseMessage := RestClient.Post(OAuthAuthority.GetDeviceAuthorizationEndpoint(), HttpContent);

        if not HttpResponseMessage.GetIsSuccessStatusCode() then
            Error(ErrorInfo.Create(HttpResponseMessage.GetErrorMessage(), true))
        else
            DeviceAuthorizationResponse := HttpResponseMessage.GetContent().AsJson().AsObject();
    end;

    procedure AcquireTokenByDeviceCode(DeviceCode: SecretText; OAuthAuthority: Interface "OAuth Authority KFM"; OAuthClientApplication: Codeunit "OAuth Application Config KFM"; var ErrorCode: Text; var ErrorDescription: Text) AuthenticationResult: Codeunit "OAuth AuthenticationResult KFM"
    var
        AccessTokenRequest: TextBuilder;
        AccessTokenRequestTxt: SecretText;
    begin
        Clear(ErrorCode);
        Clear(ErrorDescription);

        AccessTokenRequest.Append('grant_type=urn:ietf:params:oauth:grant-type:device_code');
        AccessTokenRequest.Append('&client_id=');
        AccessTokenRequest.Append(OAuthClientApplication.GetClientId());
        AccessTokenRequest.Append('&device_code=%1');

        AccessTokenRequestTxt := SecretStrSubstNo(AccessTokenRequest.ToText(), DeviceCode);
        SendTokenRequest(AccessTokenRequestTxt, OAuthAuthority, AuthenticationResult, ErrorCode, ErrorDescription);
    end;

    procedure AcquireTokenByRefreshToken(RefreshToken: SecretText; OAuthAuthority: Interface "OAuth Authority KFM"; OAuthClientApplication: Codeunit "OAuth Application Config KFM") AuthenticationResult: Codeunit "OAuth AuthenticationResult KFM"
    var
        AccessTokenRequest: TextBuilder;
        AccessTokenRequestTxt: SecretText;
        ErrorCode: Text;
        ErrorDescription: Text;
    begin
        AccessTokenRequest.Append('grant_type=refresh_token');
        AccessTokenRequest.Append('&client_id=');
        AccessTokenRequest.Append(OAuthClientApplication.GetClientId());
        AccessTokenRequest.Append('&scope=');
        AccessTokenRequest.Append(OAuthClientApplication.GetUrlEncodedScopes());
        AccessTokenRequest.Append('&refresh_token=%1');

        AccessTokenRequestTxt := SecretStrSubstNo(AccessTokenRequest.ToText(), RefreshToken);
        if not SendTokenRequest(AccessTokenRequestTxt, OAuthAuthority, AuthenticationResult, ErrorCode, ErrorDescription) then
            Error(TokenRequestErr, ErrorCode, ErrorDescription);
    end;

    local procedure SendTokenRequest(AccessTokenRequest: SecretText; OAuthAuthority: Interface "OAuth Authority KFM"; var AuthenticationResult: Codeunit "OAuth AuthenticationResult KFM"; var ErrorCode: Text; var ErrorDescription: Text): Boolean
    var
        HttpContent: Codeunit "Http Content";
        HttpResponseMessage: Codeunit "Http Response Message";
    begin
        HttpContent := HttpContent.Create(AccessTokenRequest, 'application/x-www-form-urlencoded');

        InitializeRestClient();
        HttpResponseMessage := RestClient.Post(OAuthAuthority.GetTokenEndpoint(), HttpContent);

        if not HttpResponseMessage.GetIsSuccessStatusCode() then begin
            SetOAuthError(HttpResponseMessage, ErrorCode, ErrorDescription);
            exit(false);
        end;

        AuthenticationResult.SetResponse(HttpResponseMessage.GetContent().AsJson().AsObject());
        exit(true);
    end;

    local procedure SetOAuthError(HttpResponseMessage: Codeunit "Http Response Message"; var ErrorCode: Text; var ErrorDescription: Text)
    var
        AuthenticationResponse: JsonObject;
    begin
        AuthenticationResponse := HttpResponseMessage.GetContent().AsJson().AsObject();
        ErrorCode := GetJsonToken('error', AuthenticationResponse).AsValue().AsText();
        ErrorDescription := GetJsonToken('error_description', AuthenticationResponse).AsValue().AsText();
    end;

    local procedure GetJsonToken(Path: Text; JsonObject: JsonObject) Result: JsonToken
    var
        DummyJsonValue: JsonValue;
    begin
        if not JsonObject.SelectToken(Path, Result) then begin
            DummyJsonValue.SetValue('');
            Result := DummyJsonValue.AsToken();
        end;
    end;

    local procedure InitializeRestClient()
    var
        HttpClientHandler: Codeunit "Http Client Handler KFM";
    begin
        if RestClientInitialized then
            exit;

        RestClient.Initialize(HttpClientHandler);
        RestClientInitialized := true;
    end;
}