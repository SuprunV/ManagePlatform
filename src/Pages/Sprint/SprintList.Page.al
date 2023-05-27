page 50100 "Sprint List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Sprint List';
    UsageCategory = Lists;
    SourceTable = "Sprint";
    //Editable = false;
    //CardPageId = "Sprint";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
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
                field("Sprint Start"; Rec."Sprint Start")
                {
                    Caption = 'Sprint Start';
                    ToolTip = 'Specifies sprint start date';
                }
                field("SprintEnd"; Rec."SprintEnd")
                {
                    Caption = 'Sprint End';
                    ApplicationArea = All;
                    ToolTip = 'Specifies sprint end date';
                }
                field("Duration in days"; Rec."Duration in days")
                {
                    Caption = 'Duration in days';
                    ToolTip = 'Specifies sprint duration in days';
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

        }
    }
}