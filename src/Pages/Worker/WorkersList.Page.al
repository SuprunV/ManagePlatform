page 50110 "Workers List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Workers List';
    UsageCategory = Administration;
    SourceTable = Workers;
    CardPageId = "Worker Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies No. of a worker.';
                }
                field("First Name"; Rec."First Name")
                {
                    Caption = 'First Name';
                    ToolTip = 'Specifies First Name of a worker.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    Caption = 'Last Name';
                    NotBlank = true;
                    ToolTip = 'Specifies Last Name of a worker.';

                }
                field("Job Position"; Rec."Job Position")
                {
                    Caption = 'Job Position';
                    ToolTip = 'Specifies a Job Position of a worker.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    Caption = 'No. Series';
                    ToolTip = 'Specifies a No. series of a worker.';
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