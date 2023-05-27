page 50122 "SprintOverviewList"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Sprint Overview List';
    UsageCategory = Administration;
    SourceTable = "Sprint";
    Editable = true;
    CardPageId = "SprintOverview";

    layout
    {
        area(Content)
        {
            repeater(Sprints)
            {
                Caption = 'Sprints';
                ShowCaption = false;
                field("Sprint No."; Rec."Sprint No.")
                {
                    Caption = 'Sprint No.';
                    ToolTip = 'Specifies sprint number';
                }
                field("Sprint Name"; Rec."Sprint Name")
                {
                    Caption = 'Sprint Name';
                    ToolTip = 'Specifies sprint name';
                }
                field("Project No."; Rec."Project No.")
                {
                    Caption = 'Project No.';
                    ToolTip = 'Specifies project No.';
                }
                field("Project Name"; Rec."Project Name")
                {
                    Caption = 'Project Name';
                    ToolTip = 'Specifies project name';
                }
                field("Sprint Start"; Rec."Sprint Start")
                {
                    Caption = 'Sprint Start';
                    ToolTip = 'Specifies sprint start date';
                }
                field("SprintEnd"; Rec."SprintEnd")
                {
                    Caption = 'Sprint End';
                    ToolTip = 'Specifies sprint end date';
                }
            }
        }
    }

    actions
    {
    }
}