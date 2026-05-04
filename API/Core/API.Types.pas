unit API.Types;

interface

uses
  System.Generics.Collections;

type
  TLangCode = (lcAR, lcDE, lcEN, lcFR, lcHE, lcUnknown);

  TCurrencyNames = record
    Singular: string;
    Plural: string;
    Genitive: string;
    SubSingular: string;
    SubPlural: string;
    SubGenitive: string;
    Dual: string;
    SubDual: string;
    constructor Create(
      const aSingular,
            aPlural,
            aGenitive,
            aSubSingular,
            aSubPlural:   string;
      const aSubGenitive: string = '';
      const aDual:        string = '';
      const aSubDual:     string = '');
  end;

  TCurrencyDef = class
  public
    CurrencyCode: string;
    SubunitFactor: Integer;
    Names: array[lcAR..lcHE] of TCurrencyNames;
    DynamicNames: TDictionary<string, TCurrencyNames>;
    constructor Create;
    destructor Destroy; override;
    function GetNames(
            aLang:    TLangCode;
      const aLangStr: string = ''): TCurrencyNames;
  end;

implementation

constructor TCurrencyNames.Create(
  const aSingular,
        aPlural,
        aGenitive,
        aSubSingular,
        aSubPlural,
        aSubGenitive,
        aDual,
        aSubDual:      string);
begin
  Singular := aSingular;
  Plural   := aPlural;
  Genitive := aGenitive;

  if aGenitive = '' then
    Genitive := aPlural;

  SubSingular := aSubSingular;
  SubPlural   := aSubPlural;
  SubGenitive := aSubGenitive;

  if SubGenitive = '' then
    SubGenitive := aSubPlural;

  Dual := aDual;

  if Dual = '' then
    Dual := aPlural;

  SubDual := aSubDual;

  if SubDual = '' then
    SubDual := aSubPlural;
end;

constructor TCurrencyDef.Create;
begin
  DynamicNames := TDictionary<string, TCurrencyNames>.Create;
end;

destructor TCurrencyDef.Destroy;
begin
  DynamicNames.Free;
  inherited;
end;

function TCurrencyDef.GetNames(
        aLang:    TLangCode;
  const aLangStr: string = ''): TCurrencyNames;
begin
  if aLang <> lcUnknown then
    Exit(Names[aLang]);

  if (aLangStr <> '') and DynamicNames.TryGetValue(aLangStr, Result) then
    Exit(Result);

  Result := Names[lcEN];
end;

end.