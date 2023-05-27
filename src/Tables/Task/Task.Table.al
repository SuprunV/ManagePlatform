table 50105 Task
{
    DataClassification = ToBeClassified;
    Caption = 'Task';
    DrillDownPageID = "Task List";
    LookupPageID = "Task List";

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
            NotBlank = true;
        }
        field(3; "TaskDescription"; Text[500])
        {
            Caption = 'Description';
            NotBlank = true;

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
        field(8; Priority; Enum "Priority")
        {
            Caption = 'Priority';
            InitValue = Low;
        }


        //     trigger OnValidate()
        //     var
        //         Workers: Record Workers;
        //     begin
        //         //   CreateDimFromDefaultDim(Rec.FieldNo("Assignee Worker"));

        //         if "Assignee Worker No." <> '' then begin
        //             Workers.Get("Assignee Worker No.");

        //             Validate("Workers Name", Workers."Search Name");
        //             Validate("Worker Job Position", Workers."Job position");
        //         end;
        //     end;
        // }
        // field(24; "Workers Name"; Text[40])
        // {
        //     Caption = 'Worker First Name';
        // }
        // field(25; "Worker Job Position"; Text[35])
        // {
        //     Caption = 'Worker Job Position';
        // }
        field(6; "Sprint No."; Code[10])
        {
            Caption = 'Sprint No.';
            TableRelation = Sprint."Sprint No.";
            trigger OnValidate()
            var
                Sprint: Record Sprint;
            begin

                if "Sprint No." <> '' then begin
                    Sprint.Get("Sprint No.");

                    Validate("Sprint Name", Sprint."Sprint Name");
                end;
            end;
        }
        field(7; "Sprint Name"; Text[80])
        {
            Editable = false;
            Caption = 'Sprint Name';
        }
        field(9; "Deadline"; Date)
        {
            Caption = 'Deadline';
            NotBlank = true;
            trigger OnValidate()
            begin
                CheckStartAndEndDate();
                CalculateDuration();
            end;

        }
        field(10; "Time Left"; Integer)
        {
            Caption = 'Time left in days';
            NotBlank = true;
            trigger OnValidate()
            begin
                CheckDurationDays();
                "Deadline" := System.Today + "Time Left";
            end;
        }
        field(11; "Hours spent on a task"; Integer)
        {
            Caption = 'Hours spent on a task';
            NotBlank = true;
            trigger OnValidate()
            begin
                CheckHours();
            end;
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

    procedure ChangeTaskPriorityColor(): Text[50]
    var
    begin
        case Priority of
            Priority::Low:
                exit('Favorable');
            Priority::Medium:
                exit('StrongAccent');
            Priority::High:
                exit('Unfavorable');
        end;
    end;

    procedure CheckHours()
    var
    begin
        if ("Hours spent on a task" < 0) then
            Error('Hours spent on a task can not be negative');
    end;

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

    procedure CalculateDuration()
    var
    begin
        if ("Deadline" <> 0D) then
            "Time Left" := "Deadline" - System.Today;

        if ("Deadline" = 0D) then
            "Time Left" := 0;
    end;

    procedure getWorkersCount() workersCount: Integer
    var
        _taskWorkers: Record TaskWorker;
    begin
        _taskWorkers.SetRange("Task ID", ID);
        workersCount := _taskWorkers.Count();
    end;

    procedure deleteWorkersFromTask()
    var
        _taskWorkers: Record TaskWorker;
    begin
        _taskWorkers.SetRange("Task ID", ID);
        if _taskWorkers.FindFirst() then
            _taskWorkers.DeleteAll();

    end;

    var
    trigger OnInsert()
    begin

        //SendNewTaskEMail();
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

    procedure SendNewTaskEMail()
    var
        TaskWorkers: Record TaskWorker;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Recipient: Text;
        RecipientName: Text;
        //WorkerEmail: Text;
        Subject: Text;
        Body: Text;
        PostedTitle: Label 'New task: %1 ';
        PostedMsg: Label '<p>Dear %1,</p><p>A new task (<strong>%2</strong>) has been assigned to you.</p><p>%3</p><p><br></p><p>Due date: %4</p><p>Task priority: %5</p><p>Type of task: %6</p><p><br></p><p>Thank you,</p><p>Managment App</p><p><br></p><p><em>This is an automatically generated email &ndash; please do not reply to it. If you have any queries regarding your task please contact to your supervisor&nbsp;</em></p>';

    begin
        TaskWorkers.SetRange("Task ID", Rec.ID);
        if TaskWorkers.Count() <> 0 then
            repeat
                RecipientName := TaskWorkers.getWorker().FullName();
                Recipient := TaskWorkers.getWorker().Email;
                Subject := StrSubstNo(PostedTitle, Rec.TaskName);
                Body := StrSubstNo(PostedMsg, RecipientName, rec.TaskName, rec.TaskDescription, Rec.Deadline, Rec.Priority, Rec.Type);
                EmailMessage.Create(Recipient, Subject, Body, true);
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
            until TaskWorkers.Next() = 0;

    end;

    procedure SendUpdatedEMail()
    var
        TaskWorkers: Record TaskWorker;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Recipient: Text;
        RecipientName: Text;
        //WorkerEmail: Text;
        Subject: Text;
        Body: Text;
        PostedTitle: Label 'Your task updated: %1 ';
        PostedMsg: Label '<p>Dear %1,</p><p>A task (<strong>%2</strong>) has been updated.</p><p>%3</p><p><br></p><p>Due date: %4</p><p>Task priority: %5</p><p>Type of task: %6</p><p><br></p><p>Thank you,</p><p>Managment App</p><p><br></p><p><em>This is an automatically generated email &ndash; please do not reply to it. If you have any queries regarding your task please contact to your supervisor&nbsp;</em></p>';

    begin
        TaskWorkers.SetRange("Task ID", Rec.ID);
        if TaskWorkers.Count() <> 0 then
            repeat
                if (TaskWorkers."Worker No." <> '') AND (TaskWorkers."Task ID" <> 0) then begin
                    RecipientName := TaskWorkers.getWorker().FullName();
                    Recipient := TaskWorkers.getWorker().Email;
                    Subject := StrSubstNo(PostedTitle, Rec.TaskName);
                    Body := StrSubstNo(PostedMsg, RecipientName, rec.TaskName, rec.TaskDescription, Rec.Deadline, Rec.Priority, Rec.Type);
                    EmailMessage.Create(Recipient, Subject, Body, true);
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                end;
            until TaskWorkers.Next() = 0


    end;

    // procedure setTasksToArchive(Tasks: Record Task)
    // begin
    //     TasksToArchive := Tasks;
    // end;

    // procedure getTasksToArchive() toArchive: Record Task
    // begin
    //     toArchive := TasksToArchive;
    // end;

    // var
    //     TasksToArchive: Record Task;
}