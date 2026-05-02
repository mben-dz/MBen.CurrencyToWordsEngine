unit Main.View;

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
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Edit,
  FMX.ListBox,
  FMX.Layouts,
//
  Base.View,
  API.LanguageRules,
  API.CurrencyData,
  API.CurrencyConverter, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TMainView = class(TBaseView)
    LayoutTop: TLayout;
    cbLanguage: TComboBox;
    cbCurrency: TComboBox;
    edtAmount: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MemoResult: TMemo;
    procedure edtAmountChange(Sender: TObject);
    procedure cbLanguageChange(Sender: TObject);
    procedure cbCurrencyChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure RefreshAll;
    procedure UpdateLang;
  public
    constructor Create(
            AOwner:       TComponent;
      const aLangRules:   ILangRules;
      const aCurrencyDef: TCurrencyDef); override;
  end;

var
  MainView: TMainView;

implementation {$R *.fmx}

uses
  API.LangRules.English,
  API.LangRules.French,
  API.LangRules.Arabic,
  API.LangRules.German;

constructor TMainView.Create(
        AOwner:       TComponent;
  const aLangRules:   ILangRules;
  const aCurrencyDef: TCurrencyDef);
begin
  inherited Create(AOwner, aLangRules, aCurrencyDef);
end;

procedure TMainView.FormCreate(Sender: TObject);
begin
  cbLanguage.ItemIndex := 0;
  cbCurrency.ItemIndex := 0;
  RefreshAll;
end;

procedure TMainView.UpdateLang;
var
  LLangRule:    ILangRules;
  LCurrencyDef: TCurrencyDef;
begin
  case cbLanguage.ItemIndex of
    0: LLangRule := TEnglishRules.Create;
    1: LLangRule := TFrenchRules.Create;
    2: LLangRule := TArabicRules.Create;
    3: LLangRule := TGermanRules.Create;
    else LLangRule := TEnglishRules.Create;
  end;

  case cbCurrency.ItemIndex of
    0: LCurrencyDef := cUSD;
    1: LCurrencyDef := cEUR;
    2: LCurrencyDef := cDZD;
    else LCurrencyDef := cUSD;
  end;

  FLangRules   := LLangRule;
  FCurrencyDef := LCurrencyDef;

  RefreshAll;
end;

procedure TMainView.cbLanguageChange(Sender: TObject);
begin
  UpdateLang;
end;

procedure TMainView.cbCurrencyChange(Sender: TObject);
begin
  UpdateLang;
end;

procedure TMainView.edtAmountChange(Sender: TObject);
begin
  RefreshAll;
end;

procedure TMainView.RefreshAll;
var
  LAmount: Currency;
begin
  if TryStrToCurr(edtAmount.Text, LAmount) then
  begin
    MemoResult.Text := TCurrencyConverter.CurrencyToWords(LAmount, FLangRules, FCurrencyDef);
    if FLangRules.IsRTL then
      MemoResult.TextSettings.HorzAlign := TTextAlign.Trailing
    else
      MemoResult.TextSettings.HorzAlign := TTextAlign.Leading;
  end
  else
    MemoResult.Text := 'Invalid Amount';
end;

end.
