page 50111 "Worker Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration; // määrab et Page tuleb otsinguga välja
    SourceTable = "Worker Setup";
    Editable = true;
    InsertAllowed = true;
    DeleteAllowed = true;
    ModifyAllowed = true;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Caption = 'Numbering';
                field("Workers Nos."; Rec."Workers Nos.")
                {
                    ToolTip = 'Specifies the code for the number series that will be used to assgin numbers to workers.';

                }
            }
        }
    }

    actions
    { }

    var
        // myInt: Integer;

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
