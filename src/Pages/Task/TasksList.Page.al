page 50109 TasksList
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Tasks List';
    UsageCategory = Lists;
    SourceTable = "Task";
    Editable = true;
    CardPageId = "Task Card Page";

    layout
    {
        area(Content)
        {
            repeater(Tasks)
            {
                Caption = 'Tasks List';

                field("Task ID"; rec.ID)
                {
                    Caption = 'Task ID';
                    ToolTip = 'Specifies the Task ID';
                }
                field("Task Name"; Rec.TaskName)
                {
                    Caption = 'Task Name';
                    ToolTip = 'Specifies the Task Name';
                }
                field("Type"; Rec."Type")
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the task Type';

                }
                field("Priority"; Rec."Priority")
                {
                    Caption = 'Priority';
                    ToolTip = 'Specifies the task Priority';
                    Style = Strong;
                    StyleExpr = StyleExprText;
                }
                field("Status"; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the task Status';
                }
                field("Sprint No."; Rec."Sprint No.")
                {
                    Caption = 'Sprint No.';
                    ToolTip = 'Specifies the Sprint No.';
                }
                field("Sprint Name"; Rec."Sprint Name")
                {
                    Caption = 'Sprint Name';
                    ToolTip = 'Specifies the Sprint Name';
                    TableRelation = Sprint."Sprint Name";
                }
                field("Task workers count"; Rec.getWorkersCount())
                {
                    ToolTip = 'Specifies the Worker No.';
                    Caption = 'Task workers count';
                }
                field("Deadline"; Rec.Deadline)
                {
                    Caption = 'Deadline';
                    ToolTip = 'Specifies the Deadline';
                }
                field("Time left"; Rec."Time Left")
                {
                    Caption = 'Time left';
                    ToolTip = 'Specifies theTime left until deadline';
                }
                field("Hours spent on a task"; Rec."Hours spent on a task")
                {
                    Caption = 'Hours spent on a task';
                    ToolTip = 'Specifies Hours spent on a task';
                }

            }
        }

    }


    actions
    {

        area(Processing)
        {
            action(Archive)
            {
                Caption = 'Archive Task';
                ToolTip = 'Allows to archive certain tasks';

                trigger OnAction()
                var
                    //ItemList: Record Task;
                    totalSelectedCount: Integer;
                    validSelectedCount: Integer;
                begin
                    Clear(ItemList);
                    CurrPage.SetSelectionFilter(ItemList);
                    totalSelectedCount := ItemList.Count();

                    ItemList.SetFilter(Status, '%1|%2', TaskStatus::Closed, TaskStatus::Done);
                    validSelectedCount := ItemList.Count();

                    if (totalSelectedCount <> validSelectedCount) then begin
                        Message('You selected %1 task(s), but only %2 task(s) is valid. You can archive only tasks with status "Done" or "Close"', totalSelectedCount, validSelectedCount);
                    end else begin

                        CODEUNIT.Run(CODEUNIT::"Task-Archive (Yes/No)", ItemList);

                    end;
                end;
            }
        }

    }
    trigger OnAfterGetRecord()
    var
    begin
        StyleExprText := Rec.ChangeTaskPriorityColor();
    end;

    var
        StyleExprText: Text[50];
        ItemList: Record Task;
}


