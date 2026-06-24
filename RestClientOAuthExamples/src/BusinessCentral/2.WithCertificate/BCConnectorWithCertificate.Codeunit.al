codeunit 50503 "BC Connector with Certificate"
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

    local procedure CreateOAuthClientApplication() OAuthClientApplication: Codeunit "OAuth Application Config KFM"
    begin
        OAuthClientApplication.SetClientId('<YOUR_CLIENT_ID>'); // Replace with your actual client ID
        OAuthClientApplication.SetCertificate(CreateCertificate());
        OAuthClientApplication.AddScope('https://api.businesscentral.dynamics.com/user_impersonation');
    end;

    [NonDebuggable]
    local procedure CreateCertificate() OAuthCertificate: Codeunit "OAuth Certificate KFM"
    begin
        OAuthCertificate.SetPrivateKey(SecretStrSubstNo('<YOUR_RSA_PRIVATE_KEY_XML>')); // Replace with your actual RSA private key XML
        OAuthCertificate.SetCertificate('MIICvzCCAaegAwIBAgIJAOdzypAtfpU1MA0GCSqGSIb3DQEBCwUAMBUxEzARBgNVBAMTClRlc3QgT0F1dGgwHhcNMjUwODE3MjAwMDAwWhcNMzAxMjMwMjIwMDAwWjAVMRMwEQYDVQQDEwpUZXN0IE9BdXRoMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxfmY5gmc2I6lA4UiiNtMNz/IRgHeuo7Dl6dV7/9kIyPcaAV+cFkq9XjG7KBy1BuNJiZZ+h8SENUoB4yNymIeZ1/doE+yUeXnafQHJieiaefIXEhjeVm1NauyzXz1k7skWdf6QxKPvvQkBHvRQC54TVgZkjdVlgz3pZj/skL/KLHYeZP9SPsNdLBtgFVW53BfLNLQkTtXZc7uGhYwaTw+az+xclfYZNgeyvgPZBgE4Lc34abxIcQbLOiLnAHlZ3nL/CDjD/eBjr6Gwi9/OpmB0p4iYYSIHSDF4oOJNIf++5+4NaA/3rlaU4KMukHWDDQb99PV6U6H+X3+4XfOWtRBOQIDAQABoxIwEDAOBgNVHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQELBQADggEBAKSC5ikt1t2ri/zcp63qlQO5zxWsGO8dDEuHbNXm7ueRPyuzglXUXIBaorX5RUKRrlw8xEYHm3Mx0BftM5QNvsRLMvpd+pb7PG0bEsCv1FB74+6ajXp0mAN/JdxTkyL+felc7xrdJ9wVfT5cVye0Uy447UGjzUpiAJBdB6CG2vHgD2ehodhIuura6P2ikIqFYtEtAvzyoMskByjvuYU1LLOxcMqKjJzFlQRe7Xb3CNbCMZHd+AvSlqVCd8ami6fQGpe/pGbYK0SWucLKu+7gfJsVMlkm5cvfgF33Dy1l6na3OX0hp3T7wr9/7Ze4AJ3P9sEYSVmc0kSFkpQwXmg0u1M=');
    end;

    local procedure CreateOAuthAuthority() OAuthAuthority: Interface "OAuth Authority KFM"
    var
        MicrosoftEntraID: Codeunit "Microsoft Entra ID KFM";
    begin
        MicrosoftEntraID.SetTenantID('<YOUR_TENANT_ID>'); // Replace with your actual tenant ID
        OAuthAuthority := MicrosoftEntraID;
    end;

    local procedure CreateAuthCodeGrantFlow(OAuthAuthority: Interface "OAuth Authority KFM") OAuthAuthorizationFlow: Interface "OAuth Authorization Flow KFM"
    var
        AuthCodeGrantFlow: Codeunit "Auth. Code Grant Flow KFM";
    begin
        AuthCodeGrantFlow.SetAuthority(OAuthAuthority);
        AuthCodeGrantFlow.SetPromptInteraction(Enum::"Prompt Interaction"::None);
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