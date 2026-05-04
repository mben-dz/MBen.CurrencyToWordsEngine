unit API.CurrencyConverter;

interface

uses
  System.SysUtils,
//
  API.Types,
  API.LanguageRules,
  API.LangRules.Factory,
  API.NumberEngine;

type
  TCurrencyConverter = record
    class function CurrencyToWords(
      aAmount:      Currency;
      aLang:        TLangCode;
      aCurrencyDef: TCurrencyDef): string; static;
  end;

implementation

class function TCurrencyConverter.CurrencyToWords(
  aAmount:      Currency;
  aLang:        TLangCode;
  aCurrencyDef: TCurrencyDef): string;
var
  LIntPart: Int64;
  LSubPart: Integer;
  LIntWords, LSubWords: string;
  LNames: TCurrencyNames;
  LCurrencyWord, LSubWord: string;
  LRules: ILangRules;
  LFinalInt, LFinalSub: string;
begin
  if not Assigned(aCurrencyDef) then Exit('');

  LRules   := TLangRulesFactory.GetRules(aLang);
  LIntPart := Trunc(aAmount);
  LSubPart := Round(Frac(aAmount) * aCurrencyDef.SubunitFactor);

  LNames    := aCurrencyDef.GetNames(aLang);
  LIntWords := SpellInteger(LIntPart, LRules);

  if aLang = lcAR then
  begin
    if LIntPart = 0 then LCurrencyWord := LNames.Plural
    else if LIntPart = 1 then LCurrencyWord := LNames.Singular
    else if LIntPart = 2 then LCurrencyWord := LNames.Dual
    else if (LIntPart >= 3) and (LIntPart <= 10) then
      LCurrencyWord := LNames.Plural
    else if (LIntPart >= 11) and (LIntPart <= 99) then
      LCurrencyWord := LNames.Genitive
    else LCurrencyWord := LNames.Singular;
  end
  else
  begin
    if LIntPart = 1 then LCurrencyWord := LNames.Singular
    else LCurrencyWord := LNames.Plural;
  end;

  if LSubPart > 0 then
  begin
    LSubWords := SpellInteger(LSubPart, LRules);
    if aLang = lcAR then
    begin
      if LSubPart = 1 then LSubWord := LNames.SubSingular
      else if LSubPart = 2 then LSubWord := LNames.SubDual
      else if (LSubPart >= 3) and (LSubPart <= 10) then
        LSubWord := LNames.SubPlural
      else if (LSubPart >= 11) and (LSubPart <= 99) then
        LSubWord := LNames.SubGenitive
      else LSubWord := LNames.SubSingular;
    end
    else
    begin
      if LSubPart = 1 then LSubWord := LNames.SubSingular
      else LSubWord := LNames.SubPlural;
    end;
  end;

//  if (aLang in [lcAR, lcHE]) and (LIntPart = 1) then
//    LFinalInt := LCurrencyWord + ' ' + LIntWords else
  if (aLang = lcAR) and (LIntPart = 2) then
    LFinalInt := LCurrencyWord + ' ' + LIntWords
  else if LIntPart = 0 then
    LFinalInt := LRules.ZeroWord + ' ' + LCurrencyWord
  else
    LFinalInt := LIntWords + ' ' + LCurrencyWord;

  if LSubPart > 0 then
  begin
    if (aLang in [lcAR, lcHE]) and (LSubPart = 1) then
      LFinalSub := LSubWord + ' ' + LSubWords
    else if (aLang = lcAR) and (LSubPart = 2) then
      LFinalSub := LSubWord + ' ' + LSubWords
    else
      LFinalSub := LSubWords + ' ' + LSubWord;

    Result := LFinalInt + ' ' + LRules.AndWord + ' ' + LFinalSub;
  end
  else
    Result := LFinalInt;

  Result := Result.Replace('  ', ' ', [rfReplaceAll]).Trim;
end;

end.
