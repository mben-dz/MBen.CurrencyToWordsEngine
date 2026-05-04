unit API.LangRules.English;

interface

uses
  System.SysUtils,
//
  API.Types,
  API.LanguageRules;

type
  TEnglishRules = class(TInterfacedObject, ILangRules)
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

function TEnglishRules.GetLangCode: TLangCode; begin Result := lcEN; end;
function TEnglishRules.GetIsRTL: Boolean; begin Result := False; end;
function TEnglishRules.GetAndWord: string; begin Result := 'and'; end;
function TEnglishRules.GetZeroWord: string; begin Result := 'zero'; end;
function TEnglishRules.NegativePrefix: string; begin Result := 'negative '; end;

function TEnglishRules.Unit_(aUnit: Integer): string;
const
  cUnits: array[0..19] of string = (
    'zero', 'one', 'two', 'three', 'four', 'five',
    'six', 'seven', 'eight', 'nine', 'ten', 'eleven',
    'twelve', 'thirteen', 'fourteen', 'fifteen',
    'sixteen', 'seventeen', 'eighteen', 'nineteen');
begin
  if (aUnit >= 0) and (aUnit <= 19) then
    Result := cUnits[aUnit] else
    Result := '';
end;

function TEnglishRules.Tens(aTen: Integer): string;
const
  cTens: array[2..9] of string = (
    'twenty', 'thirty', 'forty', 'fifty',
    'sixty', 'seventy', 'eighty', 'ninety');
begin
  if (aTen >= 20) and (aTen <= 99) then
    Result := cTens[aTen div 10] else
    Result := '';
end;

function TEnglishRules.FormatHundred(aHundred: Integer; isPlural: Boolean): string;
begin
  Result := Unit_(aHundred) + ' hundred';
end;

function TEnglishRules.ScaleWord(aScale: TScale; aCount: Int64): string;
const
  cScales: array[TScale] of string = (
    'thousand', 'million', 'billion', 'trillion', 'quadrillion', 'quintillion');
begin
  Result := cScales[aScale];
end;

function TEnglishRules.CombineTens(
  const aTens,
        aUnits:  string;
        aNumber: Integer): string;
begin
  if aUnits = '' then Result := aTens
  else Result := aTens + '-' + aUnits;
end;

function TEnglishRules.CombineHundreds(const aHundred, aRest: string): string;
begin
  Result := aHundred + ' and ' + aRest;
end;

function TEnglishRules.FormatScale(
        aCount:      Int64;
  const aCountWord,
        aScaleWord:  string): string;
begin
  Result := aCountWord + ' ' + aScaleWord;
end;

function TEnglishRules.CombineScales(const aScaleWord, aRest: string): string;
begin
  Result := aScaleWord + ' ' + aRest;
end;

end.
