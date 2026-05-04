unit API.LangRules.Arabic;

interface

uses
  System.SysUtils,
//
  API.Types,
  API.LanguageRules;

type
  TArabicRules = class(TInterfacedObject, ILangRules)
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

function TArabicRules.GetLangCode: TLangCode; begin Result := lcAR; end;
function TArabicRules.GetIsRTL: Boolean; begin Result := True; end;
function TArabicRules.GetAndWord: string; begin Result := 'و'; end;
function TArabicRules.GetZeroWord: string; begin Result := 'صفر'; end;
function TArabicRules.NegativePrefix: string; begin Result := 'سالب '; end;

function TArabicRules.Unit_(aUnit: Integer): string;
const
  cUnits: array[0..19] of string = (
    'صفر', 'واحد', 'اثنان', 'ثلاثة', 'أربعة', 'خمسة', 'ستة', 'سبعة',
    'ثمانية', 'تسعة', 'عشرة', 'أحد عشر', 'اثنا عشر', 'ثلاثة عشر', 'أربعة عشر',
    'خمسة عشر', 'ستة عشر', 'سبعة عشر', 'ثمانية عشر', 'تسعة عشر');
begin
  if (aUnit >= 0) and (aUnit <= 19) then
    Result := cUnits[aUnit] else
    Result := '';
end;

function TArabicRules.Tens(aTen: Integer): string;
const
  cTens: array[2..9] of string = (
    'عشرون', 'ثلاثون', 'أربعون', 'خمسون', 'ستون', 'سبعون', 'ثمانون', 'تسعون');
begin
  if (aTen >= 20) and (aTen <= 99) then
    Result := cTens[aTen div 10] else
    Result := '';
end;

function TArabicRules.FormatHundred(aHundred: Integer; isPlural: Boolean): string;
begin
  case aHundred of
    1: Result := 'مائة';
    2: Result := 'مائتان';
    3: Result := 'ثلاثمائة';
    4: Result := 'أربعمائة';
    5: Result := 'خمسمائة';
    6: Result := 'ستمائة';
    7: Result := 'سبعمائة';
    8: Result := 'ثمانمائة';
    9: Result := 'تسعمائة';
    else Result := '';
  end;
end;

function TArabicRules.ScaleWord(aScale: TScale; aCount: Int64): string;
const
  cSingular: array[TScale] of string = (
    'ألف', 'مليون', 'مليار', 'تريليون', 'كوادريليون', 'كوينتيليون');

  cDual: array[TScale] of string = (
    'ألفان', 'مليونان', 'ملياران', 'تريليونان', 'كوادريليونان', 'كوينتيليونان');

  cPlural: array[TScale] of string = (
    'آلاف', 'ملايين', 'مليارات', 'تريليونات', 'كوادريليونات', 'كوينتيليونات');

  cGenitive: array[TScale] of string = (
    'ألفاً', 'مليوناً', 'ملياراً', 'تريليوناً', 'كوادريليوناً', 'كوينتيليوناً');
begin
  if aCount = 2 then Result := cDual[aScale]
  else if (aCount >= 3) and (aCount <= 10) then Result := cPlural[aScale]
  else if (aCount >= 11) and (aCount <= 99) then Result := cGenitive[aScale]
  else Result := cSingular[aScale];
end;

function TArabicRules.CombineTens(
  const aTens,
        aUnits:  string;
        aNumber: Integer): string;
begin
  if aUnits = '' then Result := aTens
  else Result := aUnits + ' و ' + aTens;
end;

function TArabicRules.CombineHundreds(const aHundred, aRest: string): string;
begin
  Result := aHundred + ' و ' + aRest;
end;

function TArabicRules.FormatScale(
        aCount:     Int64;
  const aCountWord,
        aScaleWord: string): string;
begin
  if aCount = 1 then Result := aScaleWord
  else if aCount = 2 then Result := aScaleWord
  else Result := aCountWord + ' ' + aScaleWord;
end;

function TArabicRules.CombineScales(const aScaleWord, aRest: string): string;
begin
  Result := aScaleWord + ' و ' + aRest;
end;

end.
