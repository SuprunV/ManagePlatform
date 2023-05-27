page 50103 "Worker Tasks Sub Page"
{
    PageType = List;
    Caption = 'Worker Tasks Sub Page';
    Editable = false;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = TaskWorker;

    layout
    {
        area(Content)
        {
            repeater(Tasks)
            {
                Caption = 'Tasks';
                field(TaskID; Rec."Task ID") { 
                    Caption = 'Task ID';
                    ToolTip = 'Specifies the No. of a task.';
                }
                field(TaskName; Rec.getTask().TaskName) { 
                    Caption = 'Task Name';
                    ToolTip = 'Specifies the name of a task.';
                }
                field(TaskDescription; Rec.getTask().TaskDescription) {
                    Caption = 'Task Description';
                    ToolTip = 'Specifies the description of a task.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }
}