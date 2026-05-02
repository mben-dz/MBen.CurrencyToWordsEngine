program CurrToWords;

uses
  System.StartUpCopy,
  FMX.Forms,
  API.LanguageRules in 'API\API.LanguageRules.pas',
  API.LangRules.English in 'API\API.LangRules.English.pas',
  API.LangRules.French in 'API\API.LangRules.French.pas',
  API.LangRules.Arabic in 'API\API.LangRules.Arabic.pas',
  API.LangRules.German in 'API\API.LangRules.German.pas',
  API.CurrencyData in 'API\API.CurrencyData.pas',
  API.NumberEngine in 'API\API.NumberEngine.pas',
  API.CurrencyConverter in 'API\API.CurrencyConverter.pas',
  Base.View in 'View\Views\Base\Base.View.pas' {BaseView},
  Main.View in 'Main.View.pas' {MainView};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
