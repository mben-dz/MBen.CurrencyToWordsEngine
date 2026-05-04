unit API.LangRules.Factory;

interface

uses
  API.Types,
  API.LanguageRules;

type
  TLangRulesFactory = class
  private
    class var FInstances: array[TLangCode] of ILangRules;
  public
    class function GetRules(aLang: TLangCode): ILangRules;
  end;

implementation

uses
  API.LangRules.Arabic,
  API.LangRules.English,
  API.LangRules.French,
  API.LangRules.German,
  API.LangRules.Hebrew;

class function TLangRulesFactory.GetRules(aLang: TLangCode): ILangRules;
begin
  if FInstances[aLang] = nil then
  begin
    case aLang of
      lcAR: FInstances[aLang] := TArabicRules.Create;
      lcDE: FInstances[aLang] := TGermanRules.Create;
      lcEN: FInstances[aLang] := TEnglishRules.Create;
      lcFR: FInstances[aLang] := TFrenchRules.Create;
      lcHE: FInstances[aLang] := THebrewRules.Create;
      else  FInstances[aLang] := TEnglishRules.Create;
    end;
  end;
  Result := FInstances[aLang];
end;

end.
