unit API.CurrencyConverter;

interface

uses
  API.LanguageRules,
  API.CurrencyData,
  API.NumberEngine,
  System.SysUtils,
  System.Math;

type
  TCurrencyConverter = record
    class function CurrencyToWords(
            aAmount:      Currency;
      const aLangRules:    ILangRules;
      const aCurrencyDef: TCurrencyDef): string; static;
  end;

implementation

class function TCurrencyConverter.CurrencyToWords(
        aAmount:      Currency;
  const aLangRules:    ILangRules;
  const aCurrencyDef: TCurrencyDef): string;
var
  LIntPart: Int64;
  LSubPart: Integer;
  LIntWords, LSubWords: string;
  LNames: TCurrencyNames;
  LCurrencyWord, LSubWord: string;
  LFinalStr: string;
begin
  LIntPart := Trunc(aAmount);
  LSubPart := Round(Frac(aAmount) * aCurrencyDef.SubunitFactor);

  LNames := aCurrencyDef.GetNames(aLangRules.LangCode);

  LIntWords := SpellInteger(LIntPart, aLangRules);

  if LIntPart = 1 then LCurrencyWord := LNames.Singular
  else if (aLangRules.LangCode = 'ar') and (LIntPart = 2) then
    LCurrencyWord := LNames.Singular
  else if (aLangRules.LangCode = 'ar') and (LIntPart >= 3) and
          (LIntPart <= 10) then LCurrencyWord := LNames.Plural
  else if (aLangRules.LangCode = 'ar') and (LIntPart > 10) then
    LCurrencyWord := LNames.Genitive
  else LCurrencyWord := LNames.Plural;

  if LSubPart > 0 then
  begin
    LSubWords := SpellInteger(LSubPart, aLangRules);
    if LSubPart = 1 then LSubWord := LNames.SubSingular
    else if (aLangRules.LangCode = 'ar') and (LSubPart = 2) then
      LSubWord := LNames.SubSingular
    else if (aLangRules.LangCode = 'ar') and (LSubPart >= 3) and
            (LSubPart <= 10) then LSubWord := LNames.SubPlural
    else if (aLangRules.LangCode = 'ar') and (LSubPart > 10) then
      LSubWord := LNames.SubSingular
    else LSubWord := LNames.SubPlural;
  end;

  if LSubPart > 0 then
  begin
    if LIntPart = 0 then
      LFinalStr := aLangRules.ZeroWord + ' ' + LCurrencyWord + ' ' +
      aLangRules.AndWord + ' ' + LSubWords + ' ' + LSubWord
    else
      LFinalStr := LIntWords + ' ' + LCurrencyWord + ' ' +
      aLangRules.AndWord + ' ' + LSubWords + ' ' + LSubWord;
  end
  else
  begin
    if LIntPart = 0 then
      LFinalStr := aLangRules.ZeroWord + ' ' + LCurrencyWord
    else
      LFinalStr := LIntWords + ' ' + LCurrencyWord;
  end;

  LFinalStr := LFinalStr.Replace('  ', ' ', [rfReplaceAll]).Trim;
  Result := LFinalStr;
end;

end.
