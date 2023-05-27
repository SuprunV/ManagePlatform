report 50100 "Sprint Overview"
{
    Caption = 'Sprint Overview Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    // DefaultRenderingLayout = LayoutName;
    WordLayout = './Docs/SprintOverview.docx';
    DefaultLayout = Word;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Task;


    dataset
    {
        dataitem(Task; Task)
        {
            RequestFilterFields = "Sprint No.", "Sprint Name";
            DataItemTableView = sorting("ID");


            column(TaskID; "ID") { }
            column(TaskName; "TaskName") { }
            column(TaskType; "Type") { }
            column(TaskStatus; "Status") { }
            column(TaskWorkersCount; getWorkersCount()) {}  // TODO: except to display worker data, the count of workers is shown. Add to repord docx the fild for displaying count.
            column(Deadline; "Deadline") { }
            column(TimeLeft; "Time Left") { }
            dataitem(Sprint; "Sprint")
            {
                DataItemLinkReference = "Task";
                DataItemLink = "Sprint No." = field("Sprint No."), "Sprint Name" = field("Sprint Name");
                DataItemTableView = sorting("Sprint No.");
                column(SprintNo; "Sprint No.") { }
                column(SprintName; "Sprint Name") { }
                column(SprintStart; "Sprint Start") { }
                column(SprintEnd; "SprintEnd") { }
                column(DurationInDays; "Duration in days") { }
            }
        }
    }
}