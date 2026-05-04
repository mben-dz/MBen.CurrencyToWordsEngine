unit API.CurrencyRegistry;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.JSON,
//
  API.Types;

type
  TCurrencyRegistry = class
  private
    FCurrencies: TObjectDictionary<string, TCurrencyDef>;
    class var FInstance: TCurrencyRegistry;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TCurrencyRegistry;
    class destructor Destroy;

    procedure AddCurrency(aDef: TCurrencyDef);
    function GetCurrency(const aCode: string): TCurrencyDef;
    function GetAllCodes: TArray<string>;
    procedure LoadFromJSON(const aJSON: string);
    procedure LoadDefaults;
  end;

implementation

constructor TCurrencyRegistry.Create;
begin
  FCurrencies := TObjectDictionary<string, TCurrencyDef>.Create([doOwnsValues]);
  LoadDefaults;
end;

destructor TCurrencyRegistry.Destroy;
begin
  FCurrencies.Free;
  inherited;
end;

class function TCurrencyRegistry.Instance: TCurrencyRegistry;
begin
  if FInstance = nil then
    FInstance := TCurrencyRegistry.Create;
  Result := FInstance;
end;

class destructor TCurrencyRegistry.Destroy;
begin
  FInstance.Free;
end;

procedure TCurrencyRegistry.AddCurrency(aDef: TCurrencyDef);
begin
  FCurrencies.AddOrSetValue(aDef.CurrencyCode, aDef);
end;

function TCurrencyRegistry.GetCurrency(const aCode: string): TCurrencyDef;
begin
  if not FCurrencies.TryGetValue(aCode, Result) then
    Result := nil;
end;

function TCurrencyRegistry.GetAllCodes: TArray<string>;
begin
  Result := FCurrencies.Keys.ToArray;
end;

procedure TCurrencyRegistry.LoadDefaults;
var
  Def: TCurrencyDef;
begin
// Sorted alphabetically by Currency Code.
{$REGION '  EUR-EUROPE Euro.. '}
  Def := TCurrencyDef.Create;
  Def.CurrencyCode := 'EUR';
  Def.SubunitFactor := 100;
  Def.Names[lcAR] := TCurrencyNames.Create(
    'يورو', 'يورو',
    'يورو', 'سنت',
    'سنتات', 'سنتاً', 'يوروان', 'سنتان');
  Def.Names[lcDE] := TCurrencyNames.Create(
    'Euro', 'Euro',
    'Euro',
    'Cent', 'Cents');
  Def.Names[lcEN] := TCurrencyNames.Create(
    'Euro', 'Euros',
    'Euros',
    'Cent', 'Cents');
  Def.Names[lcFR] := TCurrencyNames.Create(
    'Euro', 'Euros',
    'Euros',
    'Centime', 'Centimes');
  Def.Names[lcHE] := TCurrencyNames.Create(
    'אירו', 'אירו',
    'אירו',
    'סנט', 'סנטים');

  AddCurrency(Def);
{$ENDREGION}

{$REGION '  ILS-Hebrew "Israeli New Shekel".. '}
  Def := TCurrencyDef.Create;
  Def.CurrencyCode := 'ILS';
  Def.SubunitFactor := 100;

  Def.Names[lcAR] := TCurrencyNames.Create(
    'شيكل إسرائيلي جديد', 'شواكل إسرائيلية جديدة',
    'شيكلاً إسرائيلياً جديداً',
    'أغورة', 'أغورات', 'أغورة', 'شيكلان إسرائيليان جديدان', 'أغورتان');
  Def.Names[lcDE] := TCurrencyNames.Create(
    'Neuer Israelischer Schekel', 'Neue Israelische Schekel',
    'Neue Israelische Schekel',
    'Agora', 'Agorot');
  Def.Names[lcEN] := TCurrencyNames.Create(
    'Israeli New Shekel', 'Israeli New Shekels',
    'Israeli New Shekels',
    'Agora', 'Agorot');
  Def.Names[lcFR] := TCurrencyNames.Create(
    'Nouveau shekel israélien', 'Nouveaux shekels israéliens',
    'Nouveaux shekels israéliens',
    'Agoura', 'Agourot');
  Def.Names[lcHE] := TCurrencyNames.Create(
    'שקל חדש', 'שקלים חדשים',
    'שקלים חדשים',
    'אגורה', 'אגורות');

  AddCurrency(Def);
{$ENDREGION}

{$REGION '  DZ Algerian Dinar.. '}
  Def := TCurrencyDef.Create;
  Def.CurrencyCode := 'DZD';
  Def.SubunitFactor := 100;
  Def.Names[lcAR] := TCurrencyNames.Create(
    'دينار جزائري', 'دنانير جزائرية',
    'ديناراً جزائرياً',
    'سنتيم', 'سنتيمات',
    'سنتيماً', 'ديناران جزائريان', 'سنتيمان');
  Def.Names[lcDE] := TCurrencyNames.Create(
    'Algerischer Dinar', 'Algerische Dinar',
    'Algerische Dinar',
    'Centime', 'Centimes');
  Def.Names[lcEN] := TCurrencyNames.Create(
    'Algerian Dinar', 'Algerian Dinars',
    'Algerian Dinars',
    'Centime', 'Centimes');
  Def.Names[lcFR] := TCurrencyNames.Create(
    'Dinar algérien', 'Dinars algériens',
    'Dinars algériens',
    'Centime', 'Centimes');
  Def.Names[lcHE] := TCurrencyNames.Create(
    'דינר אלג׳יראי', 'דינרים אלג׳יראיים',
    'דינרים אלג׳יראיים',
    'סנט', 'סנטים');

  AddCurrency(Def);
{$ENDREGION}

{$REGION '  USD US-Dollar.. '}
  Def := TCurrencyDef.Create;
  Def.CurrencyCode := 'USD';
  Def.SubunitFactor := 100;
  Def.Names[lcEN] := TCurrencyNames.Create(
    'US Dollar', 'US Dollars',
    'US Dollars',
    'Cent', 'Cents');
  Def.Names[lcFR] := TCurrencyNames.Create(
    'Dollar américain', 'Dollars américains',
    'Dollars américains',
    'Centime', 'Centimes');
  Def.Names[lcAR] := TCurrencyNames.Create(
    'دولار أمريكي', 'دولارات أمريكية',
    'دولاراً أمريكياً',
    'سنت', 'سنتات', 'سنتاً', 'دولاران أمريكيان', 'سنتان');
  Def.Names[lcDE] := TCurrencyNames.Create(
    'US-Dollar', 'US-Dollar',
    'US-Dollar',
    'Cent', 'Cents');
  Def.Names[lcHE] := TCurrencyNames.Create(
    'דולר אמריקאי', 'דולרים אמריקאיים',
    'דולרים אמריקאיים',
    'סנט', 'סנטים');

  AddCurrency(Def);
{$ENDREGION}

end;

procedure TCurrencyRegistry.LoadFromJSON(const aJSON: string);
var
  LJSONObj, LCurObj, LNamesObj, LLangObj: TJSONObject;
  LArr: TJSONArray;
  I: Integer;
  LDef: TCurrencyDef;
  LLangStr: string;
  LNames: TCurrencyNames;
  LLangCode: TLangCode;
begin
  LJSONObj := TJSONObject.ParseJSONValue(aJSON) as TJSONObject;
  if not Assigned(LJSONObj) then Exit;
  try
    LArr := LJSONObj.GetValue<TJSONArray>('currencies');
    if Assigned(LArr) then
    begin
      for I := 0 to LArr.Count - 1 do
      begin
        LCurObj := LArr.Items[I] as TJSONObject;
        LDef := TCurrencyDef.Create;
        LDef.CurrencyCode := LCurObj.GetValue<string>('code');
        LDef.SubunitFactor := LCurObj.GetValue<Integer>('subunit');

        LNamesObj := LCurObj.GetValue<TJSONObject>('names');
        if Assigned(LNamesObj) then
        begin
          for var LPair in LNamesObj do
          begin
            LLangStr := LPair.JsonString.Value;
            LLangObj := LPair.JsonValue as TJSONObject;

            LNames.Singular    := LLangObj.GetValue<string>('singular', '');
            LNames.Plural      := LLangObj.GetValue<string>('plural', '');
            LNames.Genitive    := LLangObj.GetValue<string>('genitive', LNames.Plural);
            LNames.SubSingular := LLangObj.GetValue<string>('sub_singular', '');
            LNames.SubPlural   := LLangObj.GetValue<string>('sub_plural', '');
            LNames.SubGenitive := LLangObj.GetValue<string>('sub_genitive', LNames.SubPlural);
            LNames.Dual        := LLangObj.GetValue<string>('dual', LNames.Plural);
            LNames.SubDual     := LLangObj.GetValue<string>('sub_dual', LNames.SubPlural);

            if SameText(LLangStr, 'en') then LLangCode := lcEN
            else if SameText(LLangStr, 'fr') then LLangCode := lcFR
            else if SameText(LLangStr, 'ar') then LLangCode := lcAR
            else if SameText(LLangStr, 'de') then LLangCode := lcDE
            else if SameText(LLangStr, 'he') then LLangCode := lcHE
            else LLangCode := lcUnknown;

            if LLangCode <> lcUnknown then
              LDef.Names[LLangCode] := LNames
            else
              LDef.DynamicNames.Add(LLangStr, LNames);
          end;
        end;
        AddCurrency(LDef);
      end;
    end;
  finally
    LJSONObj.Free;
  end;
end;

end.
