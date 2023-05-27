table 50100 Sprint
{
    DataCaptionFields = "Sprint No.", "Sprint Name";
    DataClassification = ToBeClassified;
    Caption = 'Sprint';
    DrillDownPageID = "Sprint List";
    LookupPageID = "Sprint List";

    fields
    {
        field(1; "Sprint No."; Code[10])
        {
            Caption = 'Sprint No.';
            NotBlank = true;
        }
        field(2; "Sprint Name"; Text[80])
        {
            Caption = 'Sprint Name';
        }
         field(7; "Project No."; Code[10])
        {
            Caption = 'Project No.';
            TableRelation = Project."Project No.";
            trigger OnValidate()
            var
                Project: Record Project;
            begin

                if "Project No." <> '' then begin
                    Project.Get("Project No.");

                    Validate("Project Name", Project."Project Name");
                end;
            end;
        }
          field(8; "Project Name"; Text[80])
        {
            Editable = false;
            Caption = 'Project Name';
        }
        field(3; "Sprint Start"; Date)
        {
            Caption = 'Sprint Start';
            trigger OnValidate()
            begin
                CheckStartAndEndDate();
                //TestField("Sprint Name");
                CalculateDuration();
            end;
        }
        field(4; "SprintEnd"; Date)
        {
            Caption = 'Sprint End';
            trigger OnValidate()
            begin
                CheckStartAndEndDate();
                CalculateDuration();
            end;

        }
        field(5; "Duration in days"; Integer)
        {
            Caption = 'Duration in days';
            trigger OnValidate()
            begin
                CheckDurationDays();
                //TestField("Sprint Name");
                //if ("Sprint Start" <> 0D) AND ("Sprint End" <> 0D) AND ("Duration in days" = 0) then
                //"Sprint End" := "Sprint Start";
                //AND ("Duration in days" <> 0)
                if ("Sprint Start" <> 0D) then
                    "SprintEnd" := "Sprint Start" + "Duration in days";
                if ("SprintEnd" <> 0D) then
                    "Sprint Start" := "SprintEnd" - "Duration in days";
            end;
        }
    }

    keys
    {
        key(Key1; "Sprint No.")
        {
            Clustered = true;
        }

    }

    var
    //myInt: Integer;


    procedure CheckDurationDays()
    var
    begin
        if ("Duration in days" < 0) then
            Error('Duration can not be negative');
    end;

    procedure CheckStartAndEndDate()
    var
    begin
        if ("SprintEnd" <> 0D) AND ("Sprint Start" <> 0D) AND ("Sprint Start" > "SprintEnd") then
            Error('Sprint End Date must be greater than Sprint Start Date');
    end;

    procedure CalculateDuration()
    var
    begin
        if ("SprintEnd" <> 0D) AND ("Sprint Start" <> 0D) then
            "Duration in days" := "SprintEnd" - "Sprint Start";

        if ("SprintEnd" = 0D) OR ("Sprint Start" = 0D) then
            "Duration in days" := 0;
    end;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin
        //TestField("Sprint Name");
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}