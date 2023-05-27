page 50116 "Project List"
{
    PageType = List;
    Caption = 'Project List';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Project;
    CardPageId = "Project Card";
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field("Project No."; Rec."Project No.")
                {
                    ToolTip = 'Specifies project number';
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
                field("Project Start"; Rec."Project Start")
                {
                    ToolTip = 'Specifies project start date';
                }
                field("Project End"; Rec."Project End")
                {
                    Caption = 'Project End';
                    ToolTip = 'Specifies project end date';
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            // action(ActionName)
            // {
            //     ApplicationArea = All;
                
            //     trigger OnAction();
            //     begin
                    
            //     end;
            // }
        }
    }
}