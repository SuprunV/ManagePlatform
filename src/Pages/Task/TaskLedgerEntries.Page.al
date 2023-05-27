page 50107 "Task Ledger Entries"
{
    Caption = 'Tasks Ledger Entries List';
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Task Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(Tasks)
            {
                Caption = 'Tasks List';
                field("Task Name"; Rec.TaskName)
                {
                    Caption = 'Task Name';
                    ToolTip = 'Specifies the Task Name';
                }
                field("Count of Workers"; Rec."Count of Workers")
                {
                    Caption = 'Count of Workers';
                    ToolTip = 'Specifies the Task workers count';
                }
                field("Type"; Rec."Type")
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the Task Type';
                }
                field("Status"; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the Task Status';
                }
                field("Sprint Name"; Rec."Sprint Name")
                {
                    Caption = 'Sprint Name';
                    ToolTip = 'Specifies the Sprint Name';
                }
                field("Archive date"; rec."Archive date")
                {
                    Caption = 'Archive date';
                    ToolTip = 'Specifies the Archive date';
                }
                field("Deadline"; Rec.Deadline)
                {
                    Caption = 'Deadline';
                    ToolTip = 'Specifies the Deadline';
                }
                field("Time left"; Rec."Time Left")
                {
                    Caption = 'Time left';
                    ToolTip = 'Specifies the Time left';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
        }
    }
}