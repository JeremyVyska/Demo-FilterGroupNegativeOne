table 68100 "FNGO Blog Example"
{
    Caption = 'Blog Example';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(11; "Process Check 01"; Enum "FNGO Blog Status")
        {
            Caption = 'Process Check 01';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CountProcessedStatus();
            end;
        }
        field(12; "Process Check 02"; Enum "FNGO Blog Status")
        {
            Caption = 'Process Check 02';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CountProcessedStatus();
            end;
        }
        field(13; "Process Check 03"; Enum "FNGO Blog Status")
        {
            Caption = 'Process Check 03';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CountProcessedStatus();
            end;
        }
        field(14; "Process Check 04"; Enum "FNGO Blog Status")
        {
            Caption = 'Process Check 04';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CountProcessedStatus();
            end;
        }
        field(15; "Process Check 05"; Enum "FNGO Blog Status")
        {
            Caption = 'Process Check 05';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CountProcessedStatus();
            end;
        }
        field(16; "Process Check 06"; Enum "FNGO Blog Status")
        {
            Caption = 'Process Check 06';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CountProcessedStatus();
            end;
        }
        field(20; "Total No. of OK"; Integer)
        {
            Caption = 'Total No. of OK';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Total No. of Pending"; Integer)
        {
            Caption = 'Total No. of Pending';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Total No. of Not OK"; Integer)
        {
            Caption = 'Total No. of Not OK';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Due Date Calculation"; DateFormula)
        {
            Caption = 'Due Date Calculation';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }


    procedure CountProcessedStatus()
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
        FieldRec: Record Field;
        TotalNoOfOK: Integer;
        TotalNoOfPending: Integer;
        TotalNoOfNotOK: Integer;
    begin
        TotalNoOfOK := 0;
        TotalNoOfPending := 0;
        TotalNoOfNotOK := 0;
        Clear(RecRef);
        Clear(FldRef);
        RecRef.Open(Rec.RecordId.TableNo);
        RecRef.Get(Rec.RecordId);
        FieldRec.Reset();
        FieldRec.SetRange(TableNo, Rec.RecordId.TableNo);
        FieldRec.SetRange(Enabled, true);
        FieldRec.SetRange(Class, FieldRec.Class::Normal);
        if FieldRec.FindSet() then
            repeat
                FldRef := RecRef.Field(FieldRec."No.");
                case Format(FldRef.Value) of
                    Format(Enum::"FNGO Blog Status"::OK):
                        TotalNoOfOK += 1;
                    Format(Enum::"FNGO Blog Status"::Pending):
                        TotalNoOfPending += 1;
                    Format(Enum::"FNGO Blog Status"::"Not OK"):
                        TotalNoOfNotOK += 1;
                end;
            until FieldRec.Next() = 0;
        Rec."Total No. of OK" := TotalNoOfOK;
        Rec."Total No. of Pending" := TotalNoOfPending;
        Rec."Total No. of Not OK" := TotalNoOfNotOK;
    end;
}
