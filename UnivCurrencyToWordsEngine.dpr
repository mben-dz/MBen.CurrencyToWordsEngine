program UnivCurrencyToWordsEngine;

uses
  System.StartUpCopy,
  FMX.Forms,
  API.Types in 'API\Core\API.Types.pas',
  API.LanguageRules in 'API\Core\API.LanguageRules.pas',
  API.LangRules.Factory in 'API\Core\API.LangRules.Factory.pas',
  API.NumberEngine in 'API\Core\API.NumberEngine.pas',
  API.CurrencyConverter in 'API\Core\API.CurrencyConverter.pas',
  API.LangRules.English in 'API\LangsRegister\API.LangRules.English.pas',
  API.LangRules.French in 'API\LangsRegister\API.LangRules.French.pas',
  API.LangRules.Arabic in 'API\LangsRegister\API.LangRules.Arabic.pas',
  API.LangRules.German in 'API\LangsRegister\API.LangRules.German.pas',
  API.LangRules.Hebrew in 'API\LangsRegister\API.LangRules.Hebrew.pas',
  API.CurrencyRegistry in 'API\LangsRegister\CurrencyRegister\API.CurrencyRegistry.pas',
  Main.View in 'Main.View.pas' {MainView};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
