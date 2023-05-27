page 50113 "Worker Card"
{
    PageType = Card;
    Caption = 'Worker Card';
    Editable = true;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Workers;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = 'Personal Information';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies worker No.';
                    Caption = 'Worker No.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then // poordume tabelifunktsiooni poole
                            CurrPage.Update();
                    end;

                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies worker First Name';
                    Caption = 'First Name';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies worker Last Name';
                    Caption = 'Last Name';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies worker Search Name';
                    Caption = 'Search Name';
                }
                field("Job Position"; Rec."Job Position")
                {
                    ToolTip = 'Specifies worker Job Position';
                    Caption = 'Job Position';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies worker Gender';
                    Caption = 'Gender';
                }
                field("Email"; Rec."Email")
                {
                    ToolTip = 'Specifies worker Email';
                    Caption = 'Email';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies worker Phone No.';
                    Caption = 'Phone No.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies worker No. Series';
                    Caption = 'No. Series';
                }
            }
            // part(WorkerTasks; "Worker Tasks Sub Page")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Worker Tasks';
            //     SubPageLink = "Worker No." = FIELD("No."); // TODO
            // }
        }
    }

    actions
    {
        area(Reporting)
        {
            action(PrintWorkerTasks)
            {
                Caption = 'Print Worker Tasks';
                ToolTip = 'Allows to print Worker Tasks';

                trigger OnAction();
                begin
                    Rec.PrintWorkerTasks();
                end;
            }
        }
    }

    var
    //   myInt: Integer;
}