unit Base.View;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
//
  API.LanguageRules,
  API.CurrencyData;

type
  TBaseView = class(TForm)
  protected
    FLangRules: ILangRules;
    FCurrencyDef: TCurrencyDef;
  public
    constructor Create(
            AOwner:       TComponent;
      const aLangRules:   ILangRules;
      const aCurrencyDef: TCurrencyDef); reintroduce; virtual;

    property LangRules: ILangRules read FLangRules;
    property CurrencyDef: TCurrencyDef read FCurrencyDef;
  end;

implementation {$R *.fmx}

constructor TBaseView.Create(
        AOwner:       TComponent;
  const aLangRules:   ILangRules;
  const aCurrencyDef: TCurrencyDef);
begin inherited Create(AOwner);

  FLangRules := aLangRules;
  FCurrencyDef := aCurrencyDef;
end;

end.
