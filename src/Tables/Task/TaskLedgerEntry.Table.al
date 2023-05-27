table 50112 "Task Ledger Entry"
{
    Caption = 'Task Ledger Entry';
    // DrillDownPageID = "Task List";
    // LookupPageID = "Task List";

    fields
    {
        field(1; "ID"; Integer)
        {
            Caption = 'Task ID';
            AutoIncrement = true;
        }
        field(2; "TaskName"; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "TaskDescription"; Text[500])
        {
            Caption = 'Description';
        }
        field(4; "Status"; Enum "TaskStatus")
        {
            Caption = 'Status';
            InitValue = Created;
        }
        field(5; "Type"; Enum "TaskType")
        {
            Caption = 'Type';
            InitValue = Task;
        }
        field(6; "Sprint No."; Code[10])
        {
            Caption = 'Sprint No.';
            TableRelation = Sprint."Sprint No." where("Sprint No." = field("Sprint No."));
        }
        field(7; "Sprint Name"; Text[80])
        {
            Caption = 'Sprint Name';
        }
        field(9; "Deadline"; Date)
        {
            Caption = 'Deadline';
        }
        field(10; "Time Left"; Integer)
        {
            Caption = 'Time left in days';
        }
        field(11; "Archive date"; Date)
        {
            Caption = 'Archive date';
        }
        field(12; "Count of Workers"; Integer)
        {
            Caption = 'Count of Workers';
        }

    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
        key(SprintNo; "Sprint No.")
        {

        }
    }

    var
    //  myInt: Integer;


    procedure CheckDurationDays()
    var
    begin
        if ("Time Left" < 0) then
            Error('Duration can not be negative');
    end;

    procedure CheckStartAndEndDate()
    var
    begin
        if ("Deadline" <> 0D) AND (System.Today > "Deadline") then
            Error('Deadline must be greater than date now');
    end;

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