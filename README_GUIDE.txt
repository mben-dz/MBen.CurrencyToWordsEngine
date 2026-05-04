=========================================================
UnivCurrencyToWordsEngine - Delphi FMX Project
=========================================================

1. Open UnivCurrencyToWordsEngine.dpr in Delphi Athens 12.
2. Select your target platform (Windows, Android, etc.).
3. Build and Run.

Old Architecture:
- API.LanguageRules: Contains the ILangRules interface.
- API.LangRules.*: Concrete implementations for each language.
- API.NumberEngine: The core recursive algorithm (SpellInteger).
- API.CurrencyData: Currency metadata (TCurrencyDef).
- API.CurrencyConverter: Ties everything together.
- View Layer: Clean MVVM-like separation with dependency injection.

Architecture Improvements (Performance & Flexibility):
- Enum-based language selection (TLangCode) for maximum performance (zero string comparisons in hot path).
- TCurrencyRegistry for dynamic JSON-driven currency loading and O(1) dictionary lookups.
- Singleton Factory (TLangRulesFactory) for ILangRules to avoid recreating objects on every UI change.
- Improved Arabic and Hebrew grammar rules (RTL, Duals, Genitives, Accusatives).
- Clean separation of concerns (MVVM/MVC pattern).
- Optimized NumberEngine to minimize string concatenations and avoid repeated recursion.

Enjoy!