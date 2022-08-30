codeunit 68100 "FNGO Install Samples"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        FNGOBlogExample: Record "FNGO Blog Example";
    begin
        GenerateDemoData();
    end;

    local procedure QuickAddEntry(NewCode: Code[10]; NewDateForm: Text)
    var
        FNGOBlogExample: Record "FNGO Blog Example";
    begin
        if not FNGOBlogExample.Get(NewCode) then begin
            FNGOBlogExample.Code := NewCode;
            Evaluate(FNGOBlogExample."Due Date Calculation", NewDateForm);
            FNGOBlogExample.Insert(true);
        end;
        FNGOBlogExample.Validate("Process Check 01", RandomEnum());
        FNGOBlogExample.Validate("Process Check 02", RandomEnum());
        FNGOBlogExample.Validate("Process Check 03", RandomEnum());
        FNGOBlogExample.Validate("Process Check 04", RandomEnum());
        FNGOBlogExample.Validate("Process Check 05", RandomEnum());
        FNGOBlogExample.Validate("Process Check 06", RandomEnum());
        FNGOBlogExample.Modify(true);
    end;

    local procedure RandomEnum() Result: Enum "FNGO Blog Status"
    var
        OptionList: List of [Text];
        Selected: Text;
    begin
        OptionList := Result.Names;
        OptionList.Get(Random(OptionList.Count), Selected);
        Evaluate(Result, Selected);
    end;

    internal procedure GenerateDemoData()
    begin
        QuickAddEntry('10 DAYS', '10D');
        QuickAddEntry('14 DAYS', '14D');
        QuickAddEntry('15 DAYS', '15D');
        QuickAddEntry('TEST02', '');
        QuickAddEntry('1M(8D)', '1M');
        QuickAddEntry('2 DAYS', '2D');
        QuickAddEntry('21 DAYS', '21D');
        QuickAddEntry('30 DAYS', '30D');
        QuickAddEntry('60 DAYS', '60D');
        QuickAddEntry('7 DAYS', '7D');
        QuickAddEntry('CM', 'CM');
    end;
}
