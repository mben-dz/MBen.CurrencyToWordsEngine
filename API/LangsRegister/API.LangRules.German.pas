unit API.LangRules.German;

interface

uses
  System.SysUtils,
//
  API.Types,
  API.LanguageRules;

type
  TGermanRules = class(TInterfacedObject, ILangRules)
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

function TGermanRules.GetLangCode: TLangCode; begin Result := lcDE; end;
function TGermanRules.GetIsRTL: Boolean; begin Result := False; end;
function TGermanRules.GetAndWord: string; begin Result := 'und'; end;
function TGermanRules.GetZeroWord: string; begin Result := 'null'; end;
function TGermanRules.NegativePrefix: string; begin Result := 'minus '; end;

function TGermanRules.Unit_(aUnit: Integer): string;
const U: array[0..19] of string = (
  'null','eins','zwei','drei','vier','fünf','sechs','sieben','acht','neun',
  'zehn','elf','zwölf','dreizehn','vierzehn','fünfzehn','sechzehn','siebzehn',
  'achtzehn','neunzehn');
begin
  if (aUnit >= 0) and (aUnit <= 19) then
    Result := U[aUnit] else
    Result := '';
end;

function TGermanRules.Tens(aTen: Integer): string;
const T: array[2..9] of string = (
  'zwanzig','dreißig','vierzig','fünfzig',
  'sechzig','siebzig','achtzig','neunzig');
begin
  if (aTen >= 20) and (aTen <= 99) then
    Result := T[aTen div 10] else
    Result := '';
end;

function TGermanRules.FormatHundred(
  aHundred: Integer;
  isPlural: Boolean): string;
begin
  if aHundred = 1 then Result := 'einhundert '
  else Result := Unit_(aHundred) + 'hundert ';
end;

function TGermanRules.ScaleWord(
  aScale: TScale;
  aCount: Int64): string;

const cScalesSingular: array[TScale] of string = (
  'tausend','Million','Milliarde','Billion','Billiarde','Trillion');

const cScalesPlural: array[TScale] of string = (
  'tausend','Millionen','Milliarden','Billionen','Billiarden','Trillionen');
begin
  if aCount > 1 then
    Result := cScalesPlural[aScale] else
    Result := cScalesSingular[aScale];
end;

function TGermanRules.CombineTens(
  const aTens,
        aUnits:  string;
        aNumber: Integer): string;
begin
  if aUnits = '' then Result := aTens
  else if (aNumber mod 10) = 1 then Result := 'einund' + aTens
  else Result := aUnits + 'und' + aTens;
end;

function TGermanRules.CombineHundreds(const aHundred, aRest: string): string;
begin
  Result := aHundred + aRest;
end;

function TGermanRules.FormatScale(
        aCount:      Int64;
  const aCountWord,
        aScaleWord:  string): string;
begin
  if (aScaleWord = 'tausend') and (aCount = 1) then Result := 'eintausend'
  else if aScaleWord = 'tausend' then Result := aCountWord + aScaleWord
  else if aCount = 1 then Result := 'eine ' + aScaleWord
  else Result := aCountWord + ' ' + aScaleWord;
end;

function TGermanRules.CombineScales(const aScaleWord, aRest: string): string;
begin
  if aScaleWord.EndsWith('tausend') then Result := aScaleWord + aRest
  else Result := aScaleWord + ' ' + aRest;
end;

end.
