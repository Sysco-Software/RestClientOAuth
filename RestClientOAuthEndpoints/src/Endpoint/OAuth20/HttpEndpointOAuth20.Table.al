table 50356 "Http Endpoint OAuth 2.0 KFM"
{
    Caption = 'Http Endpoint OAuth';

    fields
    {
        field(1; "Http Endpoint Code"; Code[50])
        {
            Caption = 'Http Endpoint Code';
            DataClassification = CustomerContent;
            TableRelation = "Http Endpoint KFM";
        }
        field(2; "OAuth Authority"; Enum "OAuth Authority KFM")
        {
            Caption = 'OAuth Authority';
            DataClassification = CustomerContent;
        }
        field(3; "OAuth Application Code"; Code[20])
        {
            Caption = 'OAuth Application';
            TableRelation = if ("OAuth Authority" = const(MicrosoftEntraID)) "Entra App Registration KFM";

            trigger OnValidate()
            var
                EntraAppRegistration: Record "Entra App Registration KFM";
            begin
                if "OAuth Application Code" <> '' then begin
                    if "OAuth Authority" = "OAuth Authority"::MicrosoftEntraID then begin
                        Rec."Target Entra Tenant Id" := '';
                        if EntraAppRegistration.Get(Rec."OAuth Application Code") then
                            if EntraAppRegistration."Supported Account Types" = EntraAppRegistration."Supported Account Types"::MyOrg then
                                Rec."Target Entra Tenant Id" := EntraAppRegistration."Publisher Tenant Id";
                    end;
                end else begin
                    Rec."Target Entra Tenant Id" := '';
                end;
            end;
        }
        field(4; "OAuth Flow Type"; Enum "OAuthAuthorizationFlowType KFM")
        {
            Caption = 'OAuth Flow Type';
            InitValue = AuthorizationCode;

            trigger OnValidate()
            begin
                case Rec."OAuth Flow Type" of
                    Rec."OAuth Flow Type"::ClientCredentials:
                        begin
                            Rec.TestField("Target Entra Tenant Id");
                            Rec."OAuth Client Type" := Rec."OAuth Client Type"::Confidential;
                            Rec."Prompt Interaction" := Rec."Prompt Interaction"::None;
                        end;
                    Rec."OAuth Flow Type"::DeviceCode:
                        begin
                            Rec."OAuth Client Type" := Rec."OAuth Client Type"::Public;
                            Rec."Prompt Interaction" := Rec."Prompt Interaction"::None;
                        end;
                end;
            end;
        }
        field(6; "OAuth Client Type"; Enum "OAuth Client Type KFM")
        {
            Caption = 'OAuth Client Type';
            DataClassification = CustomerContent;
            InitValue = Confidential;
            ToolTip = 'Specifies whether Authorization Code flow connects as a public or confidential OAuth client.';

            trigger OnValidate()
            begin
                case Rec."OAuth Flow Type" of
                    Rec."OAuth Flow Type"::ClientCredentials:
                        Rec.TestField("OAuth Client Type", Rec."OAuth Client Type"::Confidential);
                    Rec."OAuth Flow Type"::DeviceCode:
                        Rec.TestField("OAuth Client Type", Rec."OAuth Client Type"::Public);
                end;
            end;
        }
        field(5; "Prompt Interaction"; Enum "Prompt Interaction")
        {
            Caption = 'Prompt Interaction';
            InitValue = None;
            ValuesAllowed = None, Login, "Select Account";

            trigger OnValidate()
            begin
                Rec.TestField("OAuth Flow Type", Rec."OAuth Flow Type"::AuthorizationCode);
            end;
        }
        field(100; "Entra Supported Account Types"; Enum EntraSupportedAccountTypesKFM)
        {
            Caption = 'Entra Supported account types';
            FieldClass = FlowField;
            CalcFormula = lookup("Entra App Registration KFM"."Supported Account Types" where(Code = field("OAuth Application Code")));
            Editable = false;
        }
        field(101; "Target Entra Tenant Id"; Text[250])
        {
            Caption = 'Target Entra Tenant Id';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Target Entra Tenant Id" = '' then begin
                    if Rec."OAuth Flow Type" = Rec."OAuth Flow Type"::ClientCredentials then
                        Rec.TestField("Target Entra Tenant Id");
                    exit;
                end;
                Rec.CalcFields("Entra Supported Account Types");
                Rec.TestField("Entra Supported Account Types", Rec."Entra Supported Account Types"::MultipleOrgs);
            end;
        }
    }

    keys
    {
        key(PK; "Http Endpoint Code") { Clustered = true; }
    }

    procedure GetHttpAuthentication(): Interface "Http Authentication"
    var
        HttpAuthenticationOAuth2: Codeunit "Http Authentication OAuth2 KFM";
        OAuthApplicationConfig: Codeunit "OAuth Application Config KFM";
        OAuthAuthorizationFlow: Interface "OAuth Authorization Flow KFM";
    begin
        OAuthApplicationConfig := Rec.GetApplicationConfig();
        OAuthAuthorizationFlow := Rec.GetAuthorizationFlow();
        HttpAuthenticationOAuth2.Initialize(OAuthApplicationConfig, OAuthAuthorizationFlow);
        exit(HttpAuthenticationOAuth2);
    end;

    procedure GetApplicationConfig() OAuthApplicationConfig: Codeunit "OAuth Application Config KFM"
    var
        OAuthAuthorityImpl: Interface "OAuth Authority KFM";
        ScopesList: List of [Text];
    begin
        OAuthAuthorityImpl := Rec."OAuth Authority";
        ScopesList := Rec.GetScopes();
        OAuthApplicationConfig := OAuthAuthorityImpl.GetApplicationConfig(Rec."OAuth Application Code", ScopesList);
    end;

    procedure GetAuthorizationFlow() OAuthAuthorizationFlow: Interface "OAuth Authorization Flow KFM"
    var
        OAuthAuthority: Interface "OAuth Authority KFM";
        OAuthClientType: Enum "OAuth Client Type KFM";
        PromptInteraction: Enum "Prompt Interaction";
    begin
        OAuthAuthorizationFlow := Rec."OAuth Flow Type";
        OAuthAuthority := Rec.GetAuthority();
        OAuthClientType := Rec."OAuth Client Type";
        PromptInteraction := Rec."Prompt Interaction";
        OAuthAuthorizationFlow.Initialize(OAuthAuthority, OAuthClientType, PromptInteraction);
    end;

    procedure GetAuthority() OAuthAuthority: Interface "OAuth Authority KFM"
    var
        OAuthApplicationCode: Code[20];
        TargetTenantId: Text;
    begin
        OAuthAuthority := Rec."OAuth Authority";
        OAuthApplicationCode := Rec."OAuth Application Code";
        TargetTenantId := Rec."Target Entra Tenant Id";
        OAuthAuthority.Initialize(OAuthApplicationCode, TargetTenantId);
    end;

    internal procedure GetScopes() ScopesList: List of [Text]
    var
        HttpEndpointOAuthScope: Record "Http Endpoint OAuth Scope KFM";
    begin
        HttpEndpointOAuthScope.SetRange("Http Endpoint Code", Rec."Http Endpoint Code");
        if HttpEndpointOAuthScope.FindSet() then
            repeat
                ScopesList.Add(HttpEndpointOAuthScope.Scope);
            until HttpEndpointOAuthScope.Next() = 0;
    end;
}