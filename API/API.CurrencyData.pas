unit API.CurrencyData;

interface

type
  TCurrencyNames = record
    Singular: string;
    Plural: string;
    Genitive: string;
    SubSingular: string;
    SubPlural: string;
  end;

  TCurrencyDef = record
    CurrencyCode: string;
    SubunitFactor: Integer;
    NamesEN: TCurrencyNames;
    NamesFR: TCurrencyNames;
    NamesAR: TCurrencyNames;
    NamesDE: TCurrencyNames;
    function GetNames(const aLangCode: string): TCurrencyNames;
  end;

const
  cDZD: TCurrencyDef = (
    CurrencyCode: 'DZD';
    SubunitFactor: 100;
    NamesEN: (Singular:    'Algerian Dinar';
              Plural:      'Algerian Dinars';
              Genitive:    'Algerian Dinars';
              SubSingular: 'Centime';
              SubPlural:   'Centimes');

    NamesFR: (Singular:    'Dinar Algérien';
              Plural:      'Dinars Algériens';
              Genitive:    'Dinars Algériens';
              SubSingular: 'Centime';
              SubPlural:   'Centimes');

    NamesAR: (Singular:    'دينار جزائري';
              Plural:      'دنانير جزائرية';
              Genitive:    'دينار جزائري';
              SubSingular: 'سنتيم';
              SubPlural:   'سنتيمات');

    NamesDE: (Singular:    'Algerischer Dinar';
              Plural:      'Algerische Dinar';
              Genitive:    'Algerische Dinar';
              SubSingular: 'Centime';
              SubPlural:   'Centimes')
  );

  cEUR: TCurrencyDef = (
    CurrencyCode: 'EUR';
    SubunitFactor: 100;
    NamesEN: (Singular:    'Euro';
              Plural:      'Euros';
              Genitive:    'Euros';
              SubSingular: 'Cent';
              SubPlural:   'Cents');

    NamesFR: (Singular:    'Euro';
              Plural:      'Euros';
              Genitive:    'Euros';
              SubSingular: 'Centime';
              SubPlural:   'Centimes');

    NamesAR: (Singular:    'يورو';
              Plural:      'يورو';
              Genitive:    'يورو';
              SubSingular: 'سنت';
              SubPlural:   'سنتات');

    NamesDE: (Singular:    'Euro';
              Plural:      'Euro';
              Genitive:    'Euro';
              SubSingular: 'Cent';
              SubPlural:   'Cents')
  );

  cUSD: TCurrencyDef = (
    CurrencyCode: 'USD';
    SubunitFactor: 100;
    NamesEN: (Singular:    'US Dollar';
              Plural:      'US Dollars';
              Genitive:    'US Dollars';
              SubSingular: 'Cent';
              SubPlural:   'Cents');

    NamesFR: (Singular:    'Dollar US';
              Plural:      'Dollars US';
              Genitive:    'Dollars US';
              SubSingular: 'Cent';
              SubPlural:   'Cents');

    NamesAR: (Singular:    'دولار أمريكي';
              Plural:      'دولارات أمريكية';
              Genitive:    'دولار أمريكي';
              SubSingular: 'سنت';
              SubPlural:   'سنتات');

    NamesDE: (Singular:    'US-Dollar';
              Plural:      'US-Dollar';
              Genitive:    'US-Dollar';
              SubSingular: 'Cent';
              SubPlural:   'Cents')
  );

implementation

function TCurrencyDef.GetNames(const aLangCode: string): TCurrencyNames;
begin
  if aLangCode = 'en' then
    Result := NamesEN else
    if aLangCode = 'fr' then
      Result := NamesFR else
      if aLangCode = 'ar' then
        Result := NamesAR else
        if aLangCode = 'de' then
          Result := NamesDE else
          Result := NamesEN;
end;

end.