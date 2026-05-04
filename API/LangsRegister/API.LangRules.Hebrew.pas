unit API.LangRules.Hebrew;

interface

uses
  System.SysUtils,
//
  API.Types,
  API.LanguageRules;

type
  THebrewRules = class(TInterfacedObject, ILangRules)
  public
    function GetLangCode: TLangCode;
    function GetIsRTL: Boolean;
    function GetAndWord: string;
    function GetZeroWord: string;
    function Unit_(aUnit: Integer): string;
    function Tens(aTen: Integer): string;
    function FormatHundred(aHundred: Integer; isPlural: Boolean): string;
    function ScaleWord(aScale: TScale; aCount: Int64): string;
    function CombineTens(const aTens, aUnits: string; aNumber: Integer): string;
    function CombineHundreds(const aHundred, aRest: string): string;
    function FormatScale(aCount: Int64; const aCountWord, aScaleWord: string): string;
    function CombineScales(const aScaleWord, aRest: string): string;
    function NegativePrefix: string;
  end;

implementation

function THebrewRules.GetLangCode: TLangCode; begin Result := lcHE; end;
function THebrewRules.GetIsRTL: Boolean; begin Result := True; end;
function THebrewRules.GetAndWord: string; begin Result := 'ו'; end;
function THebrewRules.GetZeroWord: string; begin Result := 'אפס'; end;
function THebrewRules.NegativePrefix: string; begin Result := 'מינוס '; end;

function THebrewRules.Unit_(aUnit: Integer): string;
const
  cUnits: array[0..19] of string = (
    'אפס', 'אחד', 'שניים', 'שלושה', 'ארבעה', 'חמישה',
    'שישה', 'שבעה', 'שמונה', 'תשעה', 'עשרה', 'אחד עשר',
    'שנים עשר', 'שלושה עשר', 'ארבעה עשר', 'חמישה עשר',
    'שישה עשר', 'שבעה עשר', 'שמונה עשר', 'תשעה עשר');
begin
  if (aUnit >= 0) and (aUnit <= 19) then
    Result := cUnits[aUnit] else
    Result := '';
end;

function THebrewRules.Tens(aTen: Integer): string;
const
  cTens: array[2..9] of string = (
    'עשרים', 'שלושים', 'ארבעים', 'חמישים',
    'שישים', 'שבעים', 'שמונים', 'תשעים');
begin
  if (aTen >= 20) and (aTen <= 99) then
    Result := cTens[aTen div 10] else
    Result := '';
end;

function THebrewRules.FormatHundred(
  aHundred: Integer;
  isPlural: Boolean): string;
begin
  if aHundred = 1 then Result := 'מאה'
  else if aHundred = 2 then Result := 'מאתיים'
  else Result := Unit_(aHundred) + ' מאות';
end;

function THebrewRules.ScaleWord(
  aScale: TScale;
  aCount: Int64): string;
const
  cScales: array[TScale] of string = (
    'אלף', 'מיליון', 'מיליארד', 'טריליון', 'קוודריליון', 'קווינטיליון');
begin
  Result := cScales[aScale];
end;

function THebrewRules.CombineTens(
  const aTens,
        aUnits:  string;
        aNumber: Integer): string;
begin
  if aUnits = '' then Result := aTens
  else Result := aTens + ' ו' + aUnits;
end;

function THebrewRules.CombineHundreds(const aHundred, aRest: string): string;
begin
  Result := aHundred + ' ו' + aRest;
end;

function THebrewRules.FormatScale(
        aCount:      Int64;
  const aCountWord,
        aScaleWord:  string): string;
begin
  if (aScaleWord = 'אלף') and (aCount = 2) then Result := 'אלפיים'
  else if aCount = 1 then Result := aScaleWord
  else Result := aCountWord + ' ' + aScaleWord;
end;

function THebrewRules.CombineScales(const aScaleWord, aRest: string): string;
begin
  Result := aScaleWord + ' ו' + aRest;
end;

end.
