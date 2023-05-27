page 50115 "Project Card"
{
    PageType = Card;
    Caption = 'Project Card';
    Editable = true;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Project;
    
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = 'Project Information';
                field("Project No."; Rec."Project No.")
                {
                    ToolTip = 'Shows the project No.';
                }
                field("Project Name"; Rec."Project Name")
                {
                    ToolTip = 'Specifies project name';
                }
                field("Project Description"; Rec."Project Description")
                {
                    ToolTip = 'Specifies project description';
                }
                field("Project Status"; Rec."Status")
                {
                    ToolTip = 'Specifies project status';
                }
                field("Baseline Cost"; Rec."Baseline Cost")
                {
                    ToolTip = 'Specifies project Baseline Cost';
                }
            }
            group(ProjectManager){
                Caption = 'Responsible for the project';

                field("Project manager"; Rec."Project manager")
                {
                    ToolTip = 'Specifies project manager no.';
                }
                 field("Project Managers Name"; Rec."Project Managers Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies project managers name';
                }
            }
            group(Timeline){
                Caption = 'Timeline';
                field("Project Start"; Rec."Project Start")
                {
                    ToolTip = 'Specifies project start date';
                }
                field("Project End"; Rec."Project End")
                {
                    Caption = 'Project End';
                    ToolTip = 'Specifies project end date';
                }
                field("Total Hours Spent On Project"; Rec."Total Hours Spent On Project")
                {
                    Caption = 'Total Hours Spent On Project';
                    ToolTip = 'Specifies project sum hours spent on all tasks';
                }
            }
        }
    }
    
    actions
    {}
    
    var
        _task: Record Task;
        _sprint: Record Sprint;
        _totalHoursSpent: Integer;
    trigger OnOpenPage()
    begin
        if Rec."Project No." = '' then begin  
            exit;
        end; 
        _totalHoursSpent := 0;
        _sprint.Reset();
        _sprint.SetRange("Project No.", Rec."Project No.");
        if _sprint.FindSet() then begin
            repeat 
                _task.Reset();
                _task.SetRange("Sprint No.", _sprint."Sprint No.");
                _task.SetFilter("Hours spent on a task", '>=0');
                if _task.FindFirst() then begin
                    repeat
                        _totalHoursSpent += _task."Hours spent on a task";
                    until _task.Next() = 0;
                end;
            until _sprint.Next() = 0;
        end;
        Rec."Total Hours Spent On Project" := _totalHoursSpent;
        Rec.Modify();
    end;
}