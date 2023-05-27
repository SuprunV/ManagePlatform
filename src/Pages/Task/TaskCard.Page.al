page 50106 "Task Card Page"
{
    Caption = 'Task Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Task;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Task Form';
                field("ID"; Rec.ID)
                {
                    Caption = 'Task No.';
                    ToolTip = 'Shows Task No.';
                    Editable = false;
                }
                field("Task Name"; Rec.TaskName)
                {
                    Caption = 'Task Name';
                    ToolTip = 'Shows Task Name';
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Task Description"; Rec.TaskDescription)
                {
                    Caption = 'Task Description';
                    ToolTip = 'Shows Task Description';
                    RowSpan = 10;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Status"; Rec."Status")
                {
                    Caption = 'Status';
                    ToolTip = 'Shows task status';
                }
                field("Type"; Rec."Type")
                {
                    Caption = 'Task type';
                    ToolTip = 'Shows task type';
                }
                field("Priority"; Rec."Priority")
                {
                    Caption = 'Priority';
                    ToolTip = 'Shows priority of the task';
                    Style = Strong;
                    StyleExpr = StyleExprText;

                    trigger OnValidate()
                    var
                    begin
                        StyleExprText := Rec.ChangeTaskPriorityColor();
                    end;
                }
                field("Sprint No."; Rec."Sprint No.")
                {
                    Caption = 'Sprint No.';
                    ToolTip = 'Shows the sprint No. connected with this task';
                }
                field("Sprint Name"; Rec."Sprint Name")
                {
                    Caption = 'Sprint Name';
                    ToolTip = 'Shows the sprint name connected with this task';
                }
                field("Deadline"; Rec."Deadline")
                {
                    Caption = 'Task Deadline';
                    ToolTip = 'Shows the deadline of the task';
                }
                field("Time Left"; Rec."Time Left")
                {
                    Caption = 'Time Left';
                    ToolTip = 'Shows days left until the deadline';
                }

                field("Hours spent on a task"; Rec."Hours spent on a task")
                {
                    Caption = 'Hours spent on a task';
                    ToolTip = 'Shows the hours spent on this task';
                }
                field("Workers Count"; Rec.getWorkersCount())
                {
                    Caption = 'Workers Count';
                    ToolTip = 'Shows the number of workers connected to this task';
                }

            }
            part(TaskWorkers; TaskWorkersSubpage)
            {
                ApplicationArea = All;
                Caption = 'Worker Tasks';
                SubPageLink = "Task ID" = FIELD(ID);

            }
        }
    }
    actions
    {
        area(Processing)
        {

            action(Delete)
            {
                ApplicationArea = all;
                Image = Delete;
                Caption = 'Remove worker';
                ToolTip = 'Allows to remove certain worker';

                trigger OnAction()
                begin
                    Rec.deleteWorkersFromTask();
                end;

            }
        }
    }
    var
        IsCreated: Boolean;
        IsModified: Boolean;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IsCreated := true
    end;

    trigger OnClosePage()
    begin
        Rec.TestField(TaskDescription);
        Rec.TestField(TaskName);
        Rec.TestField("Sprint No.");
        if Rec.ID = 0 then
            exit;
        if IsCreated then
            rec.SendNewTaskEMail();
        if not IsCreated and IsModified then
            rec.SendUpdatedEMail();

    end;


    trigger OnModifyRecord(): Boolean
    begin
        IsModified := true;
    end;

    trigger OnAfterGetRecord()
    var
    begin
        StyleExprText := Rec.ChangeTaskPriorityColor();
    end;

    var
        StyleExprText: Text[50];
}
