table 50110 "Workers"
{
    Caption = 'Workers';
    DataCaptionFields = "No.", "Search Name";
    DrillDownPageId = "Workers List";
    LookupPageId = "Workers List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if Rec."No." <> xRec."No." then begin
                    WorkerSetup.Get();

                    NoSeriesMgt.TestManual(WorkerSetup."Workers Nos.");
                    Rec."No. Series" := ''; //viide omaendale tabeli kirja vaadele
                end;
            end;
        }
        field(2; "First Name"; Text[40])
        {
            Caption = 'Employee First Name';
        }
        field(3; "Last Name"; Text[40])
        {
            Caption = 'Employee Last Name';
        }
        field(11; Initials; Text[30])
        {
            Caption = 'Initials';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '') then
                    "Search Name" := Initials;
            end;
        }
        field(4; "Search Name"; Code[250])
        {
            Editable = false;
            Caption = 'Search Name';

            trigger OnValidate()
            begin
                if "Search Name" = '' then
                    "Search Name" := SetSearchNameToFullnameAndInitials();
            end;
        }
        field(6; "Job position"; Text[35])
        {
            Caption = 'Job position';
        }
        field(7; Gender; Enum "Gender")
        {
            Caption = 'Gender';
        }
        field(8; "Email"; Text[50])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;

        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }


    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        { }
        key(Key3; "First Name", "Last Name")
        { }
    }
    procedure AssistEdit(OldW: Record "Workers") Result: Boolean
    begin
        WorkerSetup.Get();
        if WorkerSetup.Count <> 0 then
            repeat
                Workers := Rec;
                WorkerSetup.TestField("Workers Nos.");
                if NoSeriesMgt.SelectSeries(WorkerSetup."Workers Nos.", OldW."No. Series", Workers."No. Series") then begin
                    NoSeriesMgt.SetSeries(Workers."No.");
                    Rec := Workers;
                    exit(true);
                end;
            until WorkerSetup.Next() = 0;
    end;


    local procedure UpdateSearchName()
    var
        PrevSearchName: Code[250];
    begin
        PrevSearchName := xRec.FullName() + ' ' + xRec.Initials;
        if ((("First Name" <> xRec."First Name") or ("Last Name" <> xRec."Last Name") or
             (Initials <> xRec.Initials)) and ("Search Name" = PrevSearchName))
        then
            "Search Name" := SetSearchNameToFullnameAndInitials();
    end;

    local procedure SetSearchNameToFullnameAndInitials(): Code[250]
    begin
        exit(FullName() + ' ' + Initials);
    end;

    procedure FullName(): Text[100]
    var
        NewFullName: Text[100];
        Handled: Boolean;
    begin
        OnBeforeGetFullName(Rec, NewFullName, Handled);
        if Handled then
            exit(NewFullName);

        exit("First Name" + ' ' + "Last Name");
    end;

    procedure PrintWorkerTasks()
    var
        _recTaskWorkers: Record TaskWorker;
        _repWorkerTasks: Report "Worker Tasks Card";
    begin
        // _recTaskWorkers.SetRange("Worker No.", Rec."No.");  // TODO
        _repWorkerTasks.SetTableView(_recTaskWorkers);
        _repWorkerTasks.run();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetFullName(Workers: Record Workers; var NewFullName: Text[100]; var Handled: Boolean)
    begin
    end;


    var
        //    myInt: Integer;
        Workers: Record Workers;
        WorkerSetup: Record "Worker Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;


    trigger OnInsert()
    begin
        UpdateSearchName();
    end;

    trigger OnModify()
    begin
        UpdateSearchName();
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin
        UpdateSearchName();
    end;

}