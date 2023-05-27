page 50123 "TasksSprintSubPage"
{
    PageType = List;
    Caption = 'Tasks in Sprint';
    Editable = true;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Task;

    layout
    {
        area(Content)
        {
            repeater(Tasks)
            {
                Caption = 'Tasks';
                field(TaskName; Rec.TaskName) { 
                    Editable = false;
                    ToolTip = 'Specifies the Task Name';
                    Caption = 'Task Name'; 
                }
                field(TaskDescription; Rec.TaskDescription) { 
                    Editable = false;
                    ToolTip = 'Specifies Task Description';
                    Caption = 'Task Description'; 
                }
                field(Status; Rec.Status) { 
                    Editable = true; 
                    ToolTip = 'Specifies the Task Status';
                    Caption = 'Status';
                }
                field("Type"; Rec."Type") { 
                    Editable = true; 
                    ToolTip = 'Specifies the Task Type';
                    Caption = 'Type';
                }
                field("Task workers count"; Rec.getWorkersCount()) {
                    Caption = 'Task workers count';
                    ToolTip = 'Specifies the Task workers count';
                    Editable = true;
                }
                field("Deadline"; Rec."Deadline") { 
                    Editable = true; 
                    ToolTip = 'Specifies the deadline';
                    Caption = 'Deadline';
                }
            }
        }
    }


}