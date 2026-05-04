unit API.LanguageRules;

interface

uses
  API.Types;

type
  TScale = (sThousand, sMillion, sBillion, sTrillion, sQuadrillion, sQuintillion);
  
  ILangRules = interface
    ['{A1B2C3D4-E5F6-47A8-9B0C-1D2E3F4A5B6C}']
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
    
    property LangCode: TLangCode read GetLangCode;
    property IsRTL: Boolean read GetIsRTL;
    property AndWord: string read GetAndWord;
    property ZeroWord: string read GetZeroWord;
  end;

implementation

end.