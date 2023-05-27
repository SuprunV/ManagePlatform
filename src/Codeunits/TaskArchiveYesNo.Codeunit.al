codeunit 50118 "Task-Archive (Yes/No)"
{
    TableNo = Task;

    trigger OnRun()
    begin
        ClearAll();
        Task.Copy(Rec);
        Archive();
        //Rec := Task;
    end;

    var
        Task: Record Task;
        Text000: Label 'Do you want to archive %1 selected task(s)?';
        Text003: Label 'Successfully archived %1 task(s).';

    local procedure Archive()
    begin
        if not Confirm(Text000, false, Task.Count) then
            exit;

        CODEUNIT.Run(CODEUNIT::"Task-Archive", Task);

        Message(Text003, false, Task.Count);
    end;
}