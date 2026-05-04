unit API.LangRules.French;

interface

uses
  System.SysUtils,
//
  API.Types,
  API.LanguageRules;

type
  TFrenchRules = class(TInterfacedObject, ILangRules)
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

function TFrenchRules.GetLangCode: TLangCode; begin Result := lcFR; end;
function TFrenchRules.GetIsRTL: Boolean; begin Result := False; end;
function TFrenchRules.GetAndWord: string; begin Result := 'et'; end;
function TFrenchRules.GetZeroWord: string; begin Result := 'zéro'; end;
function TFrenchRules.NegativePrefix: string; begin Result := 'moins '; end;

function TFrenchRules.Unit_(aUnit: Integer): string;
const
  cUnits: array[0..19] of string = (
    'zéro', 'un', 'deux', 'trois', 'quatre', 'cinq', 'six', 'sept',
    'huit', 'neuf', 'dix', 'onze', 'douze', 'treize', 'quatorze',
    'quinze', 'seize', 'dix-sept', 'dix-huit', 'dix-neuf');
begin
  if (aUnit >= 0) and (aUnit <= 19) then
    Result := cUnits[aUnit] else
    Result := '';
end;

function TFrenchRules.Tens(aTen: Integer): string;
begin
  case aTen div 10 of
    2: Result := 'vingt';
    3: Result := 'trente';
    4: Result := 'quarante';
    5: Result := 'cinquante';
    6: Result := 'soixante';
    7: Result := 'soixante';
    8: Result := 'quatre-vingt';
    9: Result := 'quatre-vingt';
    else Result := '';
  end;
end;

function TFrenchRules.FormatHundred(
  aHundred: Integer;
  isPlural: Boolean): string;
begin
  if aHundred = 1 then Result := 'cent'
  else if isPlural then Result := Unit_(aHundred) + ' cents'
  else Result := Unit_(aHundred) + ' cent';
end;

function TFrenchRules.ScaleWord(aScale: TScale; aCount: Int64): string;
const
  cScalesSingular: array[TScale] of string = (
    'mille', 'million', 'milliard', 'billion', 'billiard', 'trillion');

  cScalesPlural: array[TScale] of string = (
    'mille', 'millions', 'milliards', 'billions', 'billiards', 'trillions');
begin
  if aCount > 1 then
    Result := cScalesPlural[aScale] else
    Result := cScalesSingular[aScale];
end;

function TFrenchRules.CombineTens(
  const aTens,
        aUnits:  string;
        aNumber: Integer): string;
begin
  if (aNumber >= 70) and (aNumber <= 79) then
  begin
    if aNumber = 71 then Result := 'soixante et onze'
    else Result := 'soixante-' + Unit_(aNumber - 60);
  end
  else if (aNumber >= 90) and (aNumber <= 99) then
  begin
    Result := 'quatre-vingt-' + Unit_(aNumber - 80);
  end
  else if (aNumber mod 10 = 1) and (aNumber < 70) then
    Result := aTens + ' et un'
  else if aNumber mod 10 = 0 then
  begin
    if aNumber = 80 then Result := 'quatre-vingts' else Result := aTens;
  end
  else Result := aTens + '-' + aUnits;
end;

function TFrenchRules.CombineHundreds(
  const aHundred,
        aRest: string): string;
begin
  Result := aHundred + ' ' + aRest;
end;

function TFrenchRules.FormatScale(
        aCount:      Int64;
  const aCountWord,
        aScaleWord:  string): string;
begin
  if (aScaleWord = 'mille') and (aCount = 1) then Result := aScaleWord
  else Result := aCountWord + ' ' + aScaleWord;
end;

function TFrenchRules.CombineScales(const aScaleWord, aRest: string): string;
begin
  Result := aScaleWord + ' ' + aRest;
end;

end.
