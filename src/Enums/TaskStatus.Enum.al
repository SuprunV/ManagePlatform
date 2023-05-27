enum 50104 TaskStatus
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; Created) { Caption = 'Created'; }
    value(1; TODO) { Caption = 'TO DO'; }
    value(2; Doing) { Caption = 'In process'; }
    value(3; "Closed") { Caption = 'Closed'; }
    value(4; "Done") { Caption = 'Done'; }
}