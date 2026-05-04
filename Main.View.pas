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
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,
//
  API.Types,
  API.CurrencyRegistry,
  API.CurrencyConverter,
  API.LangRules.Factory,
  API.LanguageRules;

type
  TMainView = class(TForm)
    LayoutTop: TLayout;
    cbLanguage: TComboBox;
    cbCurrency: TComboBox;
    edtAmount: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MemoResult: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure InputChange(Sender: TObject);
  private
    procedure RefreshAll;
  end;

var
  MainView: TMainView;

implementation

{$R *.fmx}

procedure TMainView.FormCreate(Sender: TObject);
var
  LCodes: TArray<string>;
  LCode: string;
begin
  cbLanguage.Items.Clear;
  cbLanguage.Items.Add('Arabic');
  cbLanguage.Items.Add('Deutsh');
  cbLanguage.Items.Add('English');
  cbLanguage.Items.Add('French');
  cbLanguage.Items.Add('Hebrew');
  cbLanguage.ItemIndex := 0;

  cbCurrency.Items.Clear;
  LCodes := TCurrencyRegistry.Instance.GetAllCodes;
  for LCode in LCodes do
    cbCurrency.Items.Add(LCode);
  if cbCurrency.Items.Count > 0 then
    cbCurrency.ItemIndex := 1;

  RefreshAll;
end;

procedure TMainView.InputChange(Sender: TObject);
begin
  RefreshAll;
end;

procedure TMainView.RefreshAll;
var
  LAmount: Currency;
  LLang: TLangCode;
  LCurrencyCode: string;
  LDef: TCurrencyDef;
  LRules: ILangRules;
begin
  if cbLanguage.ItemIndex < 0 then Exit;
  if cbCurrency.ItemIndex < 0 then Exit;

  LLang         := TLangCode(cbLanguage.ItemIndex);
  LCurrencyCode := cbCurrency.Items[cbCurrency.ItemIndex];
  LDef          := TCurrencyRegistry.Instance
                     .GetCurrency(LCurrencyCode);

  if not Assigned(LDef) then Exit;

  if TryStrToCurr(edtAmount.Text, LAmount) then
  begin
    MemoResult.Text := TCurrencyConverter
                         .CurrencyToWords(LAmount, LLang, LDef);

    LRules := TLangRulesFactory.GetRules(LLang);

    if LRules.IsRTL then
      MemoResult.TextSettings.HorzAlign := TTextAlign.Trailing
    else
      MemoResult.TextSettings.HorzAlign := TTextAlign.Leading;
  end
  else
    MemoResult.Text := 'Invalid Amount';
end;

end.
