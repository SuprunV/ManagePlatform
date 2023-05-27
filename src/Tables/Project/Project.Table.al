table 50119 Project
{
    DataCaptionFields = "Project No.", "Project Name";
    DataClassification = ToBeClassified;
    Caption = 'Project';
    DrillDownPageID = "Project List";
    LookupPageID = "Project List";

    fields
    {
        field(1; "Project No."; Code[10])
        {
            Caption = 'Project No.';
            NotBlank = True; 
        }
        field(2; "Project Name"; Text[80])
        {
            Caption = 'Project Name';
        }
        field(3; "Project Description"; Text[80])
        {
            Caption = 'Project Description';
        }
        field(6; "Status"; Enum "ProjectStatus")
        {
            Caption = 'Status';
        }
        field(9; "Project manager"; Code[20])
        {
            Caption = 'Project manager No.';
            TableRelation = Workers."No.";

            trigger OnValidate()
            var
                Workers: Record Workers;
            begin
                if "Project manager" <> '' then begin
                    Workers.Get("Project manager");

                    Validate("Project Managers Name", Workers."Search Name");
                end;
            end;
        }
        field(24; "Project Managers Name"; Text[40])
        {
            Caption = 'Project Managers Name';
        }

        field(4; "Project Start"; Date)
        {
            Caption = 'Project Start Period';
            trigger OnValidate()
            begin
                CheckStartAndEndDate();
            end;
        }
        field(5; "Project End"; Date)
        {
            Caption = 'Project End Period';
            trigger OnValidate()
            begin
                CheckStartAndEndDate();
            end;
        }

        field(7; "Total Hours Spent On Project"; Integer)
        {
            Caption = 'Total Hours Spent On Project';
            Editable = false;
        }
        field(8; "Baseline Cost"; Integer)
        {
            Caption = 'Baseline Cost';
        }

    }

    keys
    {
        key(Key1; "Project No.")
        {
            Clustered = true;
        }
    }

    procedure CheckStartAndEndDate()
    var
    begin
        if ("Project End" <> 0D) AND ("Project Start" <> 0D) AND ("Project Start" > "Project End") then
            Error('Project End Date must be greater than Project Start Date');
    end;


    var
     //   myInt: Integer;

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