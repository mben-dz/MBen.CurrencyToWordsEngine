=========================================================
CurrToWords - Delphi FMX Project
=========================================================

1. Open CurrToWords.dpr in Delphi Athens 12.
2. Select your target platform (Windows, Android, etc.).
3. Build and Run.

Architecture:
- API.LanguageRules: Contains the ILangRules interface.
- API.LangRules.*: Concrete implementations for each language.
- API.NumberEngine: The core recursive algorithm (SpellInteger).
- API.CurrencyData: Currency metadata (TCurrencyDef).
- API.CurrencyConverter: Ties everything together.
- View Layer: Clean MVVM-like separation with dependency injection.

Enjoy!