page 50504 "BC APIs with Device Code Flow"
{
    PageType = Card;
    Caption = 'BC APIs with Device Code Flow';
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(BusinessCentral)
            {
                Caption = 'Business Central';
                field(BCEnvironmentName; BCEnvironmentName)
                {
                    Caption = 'BC Environment';
                    TableRelation = "BC Environment";

                    trigger OnAssistEdit()
                    var
                        BCEnvironment: Record "BC Environment";
                    begin
                        BCEnvironment.DeleteAll();
                        Commit();

                        BusinessCentralConnector1.GetEnvironments();
                    end;

                    trigger OnValidate()
                    begin
                        BusinessCentralConnector1.SetBCEnvironmentName(BCEnvironmentName);
                    end;
                }
                field(BCCompanyName; BCCompanyName)
                {
                    Caption = 'BC Company';
                    TableRelation = "BC Company";
                    trigger OnAssistEdit()
                    var
                        BCCompany: Record "BC Company";
                    begin
                        BCCompany.DeleteAll();
                        Commit();

                        BusinessCentralConnector1.GetCompanies();
                    end;

                    trigger OnValidate()
                    var
                        BCCompany: Record "BC Company";
                    begin
                        BCCompany.Get(BCCompanyName);
                        BCCompanyId := BCCompany.Id;
                    end;
                }
            }
            part(Customers; BCCustomers)
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GetCustomers)
            {
                Caption = 'Get Customers';
                Image = ChangeCustomer;

                trigger OnAction()
                begin
                    BusinessCentralConnector1.GetCustomers(BCCompanyId);
                end;
            }
        }
        area(Promoted)
        {
            actionref(GetCustomersRef; GetCustomers)
            {
            }
        }
    }

    var
        BCEnvironmentName: Text;
        BCCompanyName: Text;
        BCCompanyId: Text;
        BusinessCentralConnector1: Codeunit "BC Connector Device Code Flow";

    trigger OnOpenPage()
    var
        BCCustomer: Record "BC Customer";
    begin
        BCCustomer.DeleteAll();
    end;
}