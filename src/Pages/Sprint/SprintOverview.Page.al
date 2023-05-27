page 50121 SprintOverview
{
    DataCaptionFields = "Sprint No.", "Sprint Name";
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Sprint;
    Caption = 'Sprint Overview';
    Editable = true;

    layout
    {
        area(Content)
        {
            group(ProjectInfo)
            {
                Caption = 'Connected project';
                field("Project No."; Rec."Project No.")
                {
                    Caption = 'Project No.';
                    ToolTip = 'Shows the project No. that the sprint is connected to.';
                    ShowMandatory = true;
                }
                field("Project Name"; Rec."Project Name")
                {
                    Caption = 'Project Name';
                    ToolTip = 'Shows the project name.';
                }
            }
            group(overview)
            {
                Caption = 'Tasks overview';
                cuegroup(TaskOverview)
                {
                    CuegroupLayout = wide;
                    field(TaskCount; tasksCount)
                    {
                        Caption = 'Tasks Count';
                        ToolTip = 'Shows the number of all tasks';
                        Image = Calculator;
                    }
                    field(InProgressTaskCount; inProgressTaskCount)
                    {
                        ToolTip = 'Shows the number of tasks in status "In Process.';
                        Caption = 'In Process Tasks Count';
                        Editable = false;
                        Image = Calculator;
                        Style = Strong;
                        StyleExpr = StyleProgress;
                    }
                    field(TotalTasksDuration; totalTaskDuration)
                    {
                        Caption = 'Total Tasks Duration';
                        ToolTip = 'Shows the number of all tasks';
                        Image = Time;
                    }
                    field(AvgTasksDuration; avgTaskDuration)
                    {
                        Caption = 'Average Tasks Duration';
                        ToolTip = 'Shows the Average Tasks Duration';
                        Image = Time;
                    }
                    field(InProgressTaskPerc; inProgressTaskPerc)
                    {
                        ToolTip = 'Shows the percentage of tasks in status "In Process". Shows green if the percentage is more than 60%"';
                        Caption = 'In Process Tasks Percentage';
                        Editable = false;
                        Image = Chart;
                        StyleExpr = StyleProgress;
                    }
                    field(CompletedTasksPerc; completedTasksPerc)
                    {
                        ToolTip = 'Shows the percentage of tasks in status "Done" or "Closed". Shows green if the perventage is more than 50%';
                        Caption = 'Completed Tasks Percentage';
                        Editable = false;
                        Image = Checklist;
                        StyleExpr = StyleCompleted;
                    }
                }
            }
            part(TaskSprintSubpage; "TasksSprintSubPage")
            {
                ApplicationArea = All;
                Caption = 'Tasks';
                SubPageLink = "Sprint No." = FIELD("Sprint No.");
            }
        }
    }
    var
        tasksCount: Integer;
        totalTaskDuration: Integer;
        avgTaskDuration: Decimal;
        completedTasksPerc: Integer;
        inProgressTaskPerc: Integer;
        inProgressTaskCount: Integer;
        //completedTasksPercText: Text;
        Tasks: Record Task;
        StyleCompleted: Text;
        StyleProgress: Text;

    trigger OnOpenPage()
    var
        completedTasksCount: integer;
    begin
        totalTaskDuration := 0;
        tasksCount := 0;
        completedTasksPerc := 0;
        inProgressTaskPerc := 0;
        if (Tasks.count() <> 0) then begin
            Repeat
                if (Tasks."Sprint No." = Rec."Sprint No.") then begin

                    if (Tasks.Status = "TaskStatus"::Closed) or (Tasks.Status = "TaskStatus"::Done) then begin
                        completedTasksCount := completedTasksCount + 1;
                    end;
                    if (Tasks.Status = "TaskStatus"::Doing) then begin
                        inProgressTaskCount := inProgressTaskCount + 1;
                    end;
                    tasksCount := tasksCount + 1;
                    totalTaskDuration := totalTaskDuration + Tasks."Time Left";
                end;
            Until Tasks.Next() = 0;
            if tasksCount = 0 then begin
                avgTaskDuration := 0;
                completedTasksPerc := 0;
                inProgressTaskPerc := 0;
            end else begin
                avgTaskDuration := totalTaskDuration / tasksCount;
                completedTasksPerc := completedTasksCount / tasksCount * 100;
                inProgressTaskPerc := inProgressTaskCount / tasksCount * 100;
            end;
        end;
        //completedTasksPercText := Format(completedTasksPerc) + ' %';
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if completedTasksPerc < 50 then
            StyleCompleted := 'Unfavorable'
        else
            StyleCompleted := 'Favorable';

        if inProgressTaskPerc < 60 then
            StyleProgress := 'Unfavorable'
        else
            StyleProgress := 'Favorable';
    end;



}