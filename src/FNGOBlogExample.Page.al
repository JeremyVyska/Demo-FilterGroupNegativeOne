page 68100 "FNGO Blog Example"
{
    ApplicationArea = All;
    Caption = 'FNGO Blog Example';
    PageType = List;
    SourceTable = "FNGO Blog Example";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Process Check 01"; Rec."Process Check 01")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process Check 01 field.';
                }
                field("Process Check 02"; Rec."Process Check 02")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process Check 02 field.';
                }
                field("Process Check 03"; Rec."Process Check 03")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process Check 03 field.';
                }
                field("Process Check 04"; Rec."Process Check 04")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process Check 04 field.';
                }
                field("Process Check 05"; Rec."Process Check 05")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process Check 05 field.';
                }
                field("Due Date Calculation"; Rec."Due Date Calculation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Due Date Calculation field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RegenerateLines)
            {
                ApplicationArea = All;
                Image = CalculateLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Caption = 'Regenerate';
                ToolTip = 'This will rescramble all the Process Check Values';

                trigger OnAction()
                var
                    FNGOInstallSamples: Codeunit "FNGO Install Samples";
                begin
                    FNGOInstallSamples.GenerateDemoData();
                end;
            }
            action(TotalsAction)
            {
                ApplicationArea = All;
                Image = Totals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Caption = 'Table Counts';
                ToolTip = 'This will Count the OK entries';

                trigger OnAction()
                begin
                    CountAcrossLines();
                end;
            }

        }
    }

    local procedure CountAcrossLines()
    var
        FNGOBlogExample: Record "FNGO Blog Example";
        ResultMsg: Label 'There are\OK: %1\Pending: %2\Not OK: %3';
        TotalNoOfOK: Integer;
        TotalNoOfPending: Integer;
        TotalNoOfNotOK: Integer;
    begin
        FNGOBlogExample.FilterGroup(-1);  // Magic!  It's a Field level OR filter
        QuickApplyBatchFilters(FNGOBlogExample, Enum::"FNGO Blog Status"::OK);
        TotalNoOfOK := FNGOBlogExample.Count;

        QuickApplyBatchFilters(FNGOBlogExample, Enum::"FNGO Blog Status"::Pending);
        TotalNoOfPending := FNGOBlogExample.Count;

        QuickApplyBatchFilters(FNGOBlogExample, Enum::"FNGO Blog Status"::"Not OK");
        TotalNoOfNotOK := FNGOBlogExample.Count;

        Message(ResultMsg, TotalNoOfOK, TotalNoOfPending, TotalNoOfNotOK);
    end;

    local procedure QuickApplyBatchFilters(var FNGOBlogExample: Record "FNGO Blog Example"; NewStatus: Enum "FNGO Blog Status")
    begin
        FNGOBlogExample.SetRange("Process Check 01", NewStatus);
        FNGOBlogExample.SetRange("Process Check 02", NewStatus);
        FNGOBlogExample.SetRange("Process Check 03", NewStatus);
        FNGOBlogExample.SetRange("Process Check 04", NewStatus);
        FNGOBlogExample.SetRange("Process Check 05", NewStatus);
        FNGOBlogExample.SetRange("Process Check 06", NewStatus);
    end;
}
