table 50102 TaskWorker
{
    LookupPageId = TaskWorkersSubpage;
    DrillDownPageId = TaskWorkersSubpage;
    fields
    {
        field(1; "Worker No."; Code[20])
        {
            Caption = 'Worker No.';
            TableRelation = Workers."No.";
        }
        field(2; "Task ID"; Integer)
        {
            Caption = 'Task ID';
            TableRelation = Task.ID;
        }
    }

    keys
    {
        key(Key1; "Worker No.", "Task ID")
        {
            Clustered = true;
        }

    }

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

    procedure getTask() _task: Record Task
    begin
        _task.Get("Task ID");
    end;

    procedure getWorker() _worker: Record Workers
    begin
        _worker.Get("Worker No.");
    end;

    procedure SendUpdatedEMail()
    var
        TaskWorkers: Record TaskWorker;
        Task: Record Task;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Recipient: Text;
        RecipientName: Text;
        Subject: Text;
        Body: Text;
        //WorkerEmail: Text;
        PostedTitle: Label 'Task workers updated: %1 ';
        PostedMsg: Label '<p>Dear %1,</p><p>A task (<strong>%2</strong>) has been updated.</p><p>%3</p><p><br></p><p>Due date: %4</p><p>Task priority: %5</p><p>Type of task: %6</p><p><br></p><p>Thank you,</p><p>Managment App</p><p><br></p><p><em>This is an automatically generated email &ndash; please do not reply to it. If you have any queries regarding your task please contact to your supervisor&nbsp;</em></p>';

    begin
        Task.Get("Task ID");
        TaskWorkers.SetRange("Task ID", Task.ID);
        if TaskWorkers.Count() <> 0 then
            repeat
                if (TaskWorkers."Worker No." <> '') AND (TaskWorkers."Task ID" <> 0) then begin
                    RecipientName := TaskWorkers.getWorker().FullName();
                    Recipient := TaskWorkers.getWorker().Email;
                    Subject := StrSubstNo(PostedTitle, Task.TaskName);
                    Body := StrSubstNo(PostedMsg, RecipientName, Task.TaskName, Task.TaskDescription, Task.Deadline, Task.Priority, Task.Type);
                    EmailMessage.Create(Recipient, Subject, Body, true);
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                end;
            until TaskWorkers.Next() = 0


    end;

}