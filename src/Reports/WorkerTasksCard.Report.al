report 50104 "Worker Tasks Card"
{
    Caption = 'Worker Tasks Card';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;

    WordLayout = './Docs/WorkerTasksCard.docx';
    DefaultLayout = Word;
    PreviewMode = PrintLayout;
    WordMergeDataItem = TaskWorker;

    dataset
    {
        dataitem(TaskWorker; TaskWorker)
        {
            DataItemTableView = sorting("Worker No.", "Task ID");
            // RequestFilterFields = "Assignee Worker No.", "Workers Name"; // TODO

            column(TaskID; "Task ID") { }
            column(TaskName; getTask().TaskName) { }
            column(TaskType; getTask().Type) { }
            column(Status; getTask().Status) { }
            // TODO
            // column(AssigneeNo; "Assignee Worker No.") { }
            // column(WorkersName; "Workers Name") { }
            column(SprintNo; getTask()."Sprint No.") { }
            column(Deadline; getTask()."Deadline") { }

            dataitem(Workers; Workers)
            {
                DataItemTableView = sorting("No.");
                DataItemLinkReference = TaskWorker;
                // DataItemLink = "No." = field("Assignee Worker No."); // TODO
                column(WorkerNo; "No.") { }
                column(FirstName; "First Name") { }
                column(LastName; "Last Name") { }
                column(JobPosition; "Job position") { }
            }
        }
    }
}