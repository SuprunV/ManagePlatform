page 50108 "TaskWorkersSubpage"
{
    PageType = List;
    Caption = 'Task Workers Subpage';
    Editable = true;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = TaskWorker;
    InsertAllowed = true;
    Extensible = true;

    layout
    {
        area(Content)
        {
            repeater(TaskWorkers)
            {

                Caption = 'Task workers';
                field(TaskID; Rec."Task ID")
                {
                    Caption = 'Task ID';
                    ToolTip = 'Specifies the task ID';
                    Editable = false;
                }
                field(WorkerNo; Rec."Worker No.")
                {
                    Caption = 'Worker No.';
                    ToolTip = 'Specifies the Worker No.';
                    Editable = true;
                }
                field(WorkerFullName; Rec.getWorker().FullName())
                {
                    Caption = 'Worker FullName';
                    ToolTip = 'Specifies the Worker Full Name';
                    Editable = false;
                }
                field(WorkerJobPosition; Rec.getWorker()."Job position")
                {
                    Caption = 'Worker Job position';
                    ToolTip = 'Specifies Worker Job position';
                    Editable = false;
                }

            }
        }
    }
    var
        IsCreated: Boolean;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IsCreated := true
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IsCreated := true
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IsCreated := true
    end;

    trigger OnClosePage()
    begin

        if Rec."Task ID" = 0 then
            exit;
        if IsCreated then
            rec.SendUpdatedEMail();

    end;


}