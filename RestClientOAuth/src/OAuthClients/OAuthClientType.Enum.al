enum 50305 "OAuth Client Type KFM" implements "OAuth Client KFM"
{
    Extensible = false;

    value(0; Confidential)
    {
        Caption = 'Confidential';
        Implementation = "OAuth Client KFM" = "OAuth Confidential Client KFM";
    }
    value(1; Public)
    {
        Caption = 'Public';
        Implementation = "OAuth Client KFM" = "OAuth Public Client KFM";
    }
}