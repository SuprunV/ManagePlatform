codeunit 50100 "Task-Archive"
{
    TableNo = Task;

    trigger OnRun()

    begin
        ClearAll();
        TaskList.Copy(Rec);
        Post();
    end;

    var
        TaskList: Record Task;

    local procedure Post()
    var
        ArchivedTask: Record "Task Ledger Entry";
        archivedCount: Integer;
    begin
        archivedCount := 0;
        Repeat
            if (TaskList.ID <> 0) then begin
                Clear(ArchivedTask);
                ArchivedTask.TaskName := TaskList.TaskName;
                ArchivedTask.TaskDescription := TaskList.TaskDescription;
                ArchivedTask.Status := TaskList.Status;
                ArchivedTask.Type := TaskList.Type;
                ArchivedTask."Sprint No." := TaskList."Sprint No.";
                ArchivedTask."Sprint Name" := TaskList."Sprint Name";
                ArchivedTask.Deadline := TaskList.Deadline;
                ArchivedTask."Count of Workers" := TaskList.getWorkersCount();
                ArchivedTask."Time Left" := TaskList."Time Left";
                ArchivedTask."Archive date" := System.Today();

                ArchivedTask.Insert();
                TaskList.Delete(true);
                archivedCount += 1;
            end;
        Until TaskList.Next() = 0;
    end;
}