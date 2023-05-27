table 50111 "Worker Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'Worker Setup';
    LookupPageId = "Worker Setup";
    DrillDownPageId = "Worker Setup";


    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            NotBlank = true;
        }
        field(2; "Workers Nos."; Code[20])
        {
            Caption = 'Workers Nos.';
            TableRelation = "No. Series";
            trigger OnValidate()
            begin
                "Primary Key" := "Workers Nos.";
            end;

        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }

    }

    var
    //  myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}