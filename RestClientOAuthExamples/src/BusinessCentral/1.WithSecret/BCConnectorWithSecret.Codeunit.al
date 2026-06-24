codeunit 50500 "BC Connector With Secret"
{
    var
        RestClient: Codeunit "Rest Client";
        RestClientInitialized: Boolean;

    procedure GetEnvironments()
    var
        BCEnvironment: Record "BC Environment";
        Response: JsonObject;
        JsonToken: JsonToken;
    begin
        InitializeRestClient();

        Response := RestClient.GetAsJson('https://api.businesscentral.dynamics.com/environments/v1.1').AsObject();

        BCEnvironment.DeleteAll();
        foreach JsonToken in Response.GetArray('value') do begin
            BCEnvironment.Name := JsonToken.AsObject().GetText('name');
            BCEnvironment.Insert();
        end;
    end;

    procedure SetBCEnvironmentName(EnvironmentName: Text)
    begin
        RestClientInitialized := false;
        InitializeRestClient();
        RestClient.SetBaseAddress(StrSubstNo('https://api.businesscentral.dynamics.com/v2.0/%1/api/', EnvironmentName));
    end;

    procedure GetCompanies()
    var
        BCCompany: Record "BC Company";
        Response: JsonObject;
        JsonToken: JsonToken;
        JsonObject: JsonObject;
    begin
        InitializeRestClient();

        Response := RestClient.GetAsJson('v2.0/companies').AsObject();
        BCCompany.DeleteAll();

        foreach JsonToken in Response.GetArray('value') do begin
            JsonObject := JsonToken.AsObject();
            BCCompany.Init();
            BCCompany.Name := JsonObject.GetText('name');
            BCCompany."Display Name" := JsonObject.GetText('displayName');
            BCCompany.Id := JsonObject.GetText('id');
            BCCompany.Insert();
        end;
    end;

    procedure GetCustomers(CompanyId: Text)
    var
        BCCustomer: Record "BC Customer";
        Response: JsonObject;
        JsonToken: JsonToken;
        JsonObject: JsonObject;
    begin
        InitializeRestClient();

        Response := RestClient.GetAsJson('v2.0/customers?company=' + CompanyId).AsObject();

        BCCustomer.DeleteAll();
        foreach JsonToken in Response.GetArray('value') do begin
            JsonObject := JsonToken.AsObject();
            BCCustomer.Init();
            BCCustomer.SystemId := JsonObject.GetText('id');
            BCCustomer."No." := JsonObject.GetText('number');
            BCCustomer.Name := JsonObject.GetText('displayName');
            BCCustomer.Insert(false, true);
        end;
    end;

    local procedure InitializeRestClient()
    var
        OAuthClientApplication: Codeunit "OAuth Application Config KFM";
        OAuthAuthority: Interface "OAuth Authority KFM";
        OAuthAuthorizationFlow: Interface "OAuth Authorization Flow KFM";
        HttpAuthentication: Interface "Http Authentication";
        HttpClientHandlerExamples: Codeunit "Http Client Handler Examples";
    begin
        if RestClientInitialized then
            exit;

        // Step 1: Initialize OAuth application config
        OAuthClientApplication := CreateOAuthClientApplication();

        // Step 2: Initialize OAuth authority
        OAuthAuthority := CreateOAuthAuthority();

        // Step 3: Initialize OAuth flow
        OAuthAuthorizationFlow := CreateAuthCodeGrantFlow(OAuthAuthority);

        // Step 4: Initialize http authentication with the client application and flow
        HttpAuthentication := CreateHttpAuthentication(OAuthClientApplication, OAuthAuthorizationFlow);

        // Step 5: Initialize Rest Client with the http handler and authentication
        RestClient.Initialize(HttpClientHandlerExamples, HttpAuthentication);

        RestClientInitialized := true;
    end;

    [NonDebuggable]
    local procedure CreateOAuthClientApplication() OAuthClientApplication: Codeunit "OAuth Application Config KFM"
    begin
        OAuthClientApplication.SetClientId('<YOUR_CLIENT_ID>'); // Replace with your actual client ID
        OAuthClientApplication.SetClientSecret(SecretStrSubstNo('<YOUR_CLIENT_SECRET>')); // Replace with your actual client secret
        OAuthClientApplication.AddScope('https://api.businesscentral.dynamics.com/user_impersonation');
    end;

    local procedure CreateOAuthAuthority() OAuthAuthority: Interface "OAuth Authority KFM"
    var
        MicrosoftEntraID: Codeunit "Microsoft Entra ID KFM";
    begin
        // Optional: set a tenant ID (or domain) to bypass the account picker / organizations endpoint behavior.
        // MicrosoftEntraID.SetTenantID('<YOUR_TENANT_ID>'); // Replace with your actual tenant ID
        OAuthAuthority := MicrosoftEntraID;
    end;

    local procedure CreateAuthCodeGrantFlow(OAuthAuthority: Interface "OAuth Authority KFM") OAuthAuthorizationFlow: Interface "OAuth Authorization Flow KFM"
    var
        AuthCodeGrantFlow: Codeunit "Auth. Code Grant Flow KFM";
    begin
        AuthCodeGrantFlow.SetAuthority(OAuthAuthority);
        AuthCodeGrantFlow.SetPromptInteraction(Enum::"Prompt Interaction"::"Select Account");
        AuthCodeGrantFlow.SetOAuthClientType(Enum::"OAuth Client Type KFM"::Confidential);
        OAuthAuthorizationFlow := AuthCodeGrantFlow;
    end;

    local procedure CreateHttpAuthentication(OAuthClientApplication: Codeunit "OAuth Application Config KFM"; OAuthAuthorizationFlow: Interface "OAuth Authorization Flow KFM") HttpAuthentication: Interface "Http Authentication"
    var
        HttpAuthenticationOAuth2: Codeunit "Http Authentication OAuth2 KFM";
    begin
        HttpAuthenticationOAuth2.Initialize(OAuthClientApplication, OAuthAuthorizationFlow);
        HttpAuthentication := HttpAuthenticationOAuth2;
    end;
}