page 50359 HttpEndpointOAuthSubformKFM
{
    PageType = CardPart;
    Caption = 'OAuth 2.0';
    SourceTable = "Http Endpoint OAuth 2.0 KFM";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            field("OAuth Authority"; Rec."OAuth Authority") { }
            field("OAuth Application Code"; Rec."OAuth Application Code")
            {
                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;

            }
            field("OAuth Flow Type"; Rec."OAuth Flow Type")
            {
                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;
            }
            field("OAuth Client Type"; Rec."OAuth Client Type")
            {
                Enabled = Rec."OAuth Flow Type" = Rec."OAuth Flow Type"::AuthorizationCode;
                Visible = Rec."OAuth Flow Type" = Rec."OAuth Flow Type"::AuthorizationCode;
            }
            field("Prompt Interaction"; Rec."Prompt Interaction")
            {

                Enabled = Rec."OAuth Flow Type" = Rec."OAuth Flow Type"::AuthorizationCode;
            }
            group(EntraIDSupportedAccountTypes)
            {
                ShowCaption = false;
                Visible = Rec."OAuth Authority" = Rec."OAuth Authority"::MicrosoftEntraID;
                field("Entra Supported Account Types"; Rec."Entra Supported Account Types") { }
            }
            group(EntraIDTargetTenantId)
            {
                ShowCaption = false;
                Visible = Rec."OAuth Authority" = Rec."OAuth Authority"::MicrosoftEntraID;
                field("Tenant Id"; Rec."Target Entra Tenant Id")
                {
                    Enabled = Rec."Entra Supported Account Types" = Rec."Entra Supported Account Types"::MultipleOrgs;
                }
            }
        }
    }
}