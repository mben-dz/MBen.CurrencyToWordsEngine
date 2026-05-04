unit API.NumberEngine;

interface

uses
  API.LanguageRules,
  System.SysUtils;

function SpellInteger(aNumber: Int64; const aLangRule: ILangRules): string;

implementation

function SpellInteger(aNumber: Int64; const aLangRule: ILangRules): string;
var
  LHundred, LRest: Integer;
  LHundredWord: string;
  LGroup: Int64;
  LScale: TScale;
  LResult: string;
  LScaleValues: array[TScale] of Int64;
begin
  if aNumber < 0 then Exit(aLangRule.NegativePrefix +
                           SpellInteger(-aNumber, aLangRule));
  if aNumber = 0 then Exit(aLangRule.ZeroWord);
  if aNumber < 20 then Exit(aLangRule.Unit_(aNumber));

  if aNumber < 100 then
  begin
    if (aNumber mod 10) = 0 then
      Exit(aLangRule.Tens(aNumber)) else
      Exit(aLangRule.CombineTens(aLangRule.Tens(aNumber),
                                 aLangRule.Unit_(aNumber mod 10),
                                 aNumber));
  end;
  
  if aNumber < 1000 then
  begin
    LHundred := aNumber div 100;
    LRest    := aNumber mod 100;
    LHundredWord := aLangRule.FormatHundred(LHundred, LRest = 0);

    if LRest > 0 then
      Exit(aLangRule.CombineHundreds(LHundredWord,
                                     SpellInteger(LRest, aLangRule)))
    else
      Exit(LHundredWord);
  end;

  LScaleValues[sThousand]    := 1000;
  LScaleValues[sMillion]     := 1000_000;
  LScaleValues[sBillion]     := 1000_000_000;
  LScaleValues[sTrillion]    := 1000_000_000_000;
  LScaleValues[sQuadrillion] := 1000_000_000_000_000;
  LScaleValues[sQuintillion] := 1000_000_000_000_000_000;

  LResult := '';
  LRest   := aNumber mod 1000;

  if LRest > 0 then LResult := SpellInteger(LRest, aLangRule);

  for LScale := Low(TScale) to High(TScale) do
  begin
    LGroup := (aNumber div LScaleValues[LScale]) mod 1000;
    if LGroup > 0 then
    begin
      if LResult <> '' then
        LResult := aLangRule
          .CombineScales(aLangRule.FormatScale(LGroup, SpellInteger(LGroup, aLangRule),
                         aLangRule.ScaleWord(LScale, LGroup)),
                         LResult)
      else
        LResult := aLangRule.FormatScale(LGroup, SpellInteger(LGroup, aLangRule),
                   aLangRule.ScaleWord(LScale, LGroup));
    end;
  end;

  Result := LResult;
end;

end.