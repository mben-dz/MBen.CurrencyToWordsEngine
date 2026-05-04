<div align="center">

# 💱 Universal CurrencyToWords Engine

**Convert currency amounts into written words — in any language.**

*A universal, extensible Delphi FMX engine built around a single interface contract and zero engine changes when adding new languages or currencies.*

[![Delphi](https://img.shields.io/badge/Delphi-Athens%2012-EE1F35?style=flat-square&logo=embarcadero&logoColor=white)](https://www.embarcadero.com/products/delphi)
[![FMX](https://img.shields.io/badge/Framework-FireMonkey%20(FMX)-FF6B35?style=flat-square)](https://docwiki.embarcadero.com/RADStudio/en/FireMonkey_Application_Platform)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Android%20%7C%20iOS%20%7C%20macOS-0078D4?style=flat-square)](https://www.embarcadero.com)
[![License](https://img.shields.io/badge/License-MIT-22C55E?style=flat-square)](LICENSE)

---

</div>

## ✨ What It Does

Enter any currency amount and instantly see it spelled out in full, natural-language text — with grammatically correct forms for every supported language, including RTL script, dual forms, genitive cases, and gender agreement.

```
1,234.56  →  "One Thousand Two Hundred Thirty-Four US Dollars and Fifty-Six Cents"
1,234.56  →  "Mille Deux Cent Trente-Quatre Dollars américains et Cinquante-Six Centimes"
1,234.56  →  "ألف ومئتان وأربعة وثلاثون دولاراً أمريكياً وستة وخمسون سنتاً"
1,234.56  →  "Eintausend Zweihundertvierunddreißig US-Dollar und Sechsundfünfzig Cents"
1,234.56  →  "אלף מאתיים ושלושים וארבעה דולרים אמריקאיים וחמישים ושישה סנטים"
```

---

## 🌍 Supported Languages & Currencies

| Language | Code | RTL | Notes |
|----------|------|-----|-------|
| 🇬🇧 English | `lcEN` | No | Standard rules |
| 🇫🇷 French | `lcFR` | No | Liaison & gender rules |
| 🇸🇦 Arabic | `lcAR` | **Yes** | Singular / dual / plural / genitive forms |
| 🇩🇪 German | `lcDE` | No | Compound number words |
| 🇮🇱 Hebrew | `lcHE` | **Yes** | Dual scale forms (e.g. *אלפיים* for 2,000) |

| Currency | Code | Subunit |
|----------|------|---------|
| 🇺🇸 US Dollar | `USD` | Cent |
| 🇪🇺 Euro | `EUR` | Cent / Centime |
| 🇩🇿 Algerian Dinar | `DZD` | Centime |
| 🇮🇱 Israeli New Shekel | `ILS` | Agora |

> Currencies live in a **singleton registry** and can also be loaded at runtime from **JSON** — no recompilation needed.

---

## 🚀 Getting Started

### Prerequisites

- [Delphi 10.4 Sydney](https://www.embarcadero.com/products/delphi) (RAD Studio 10.4)
- Any supported target platform SDK (optional for mobile)

### Build & Run

```bash
# 1. Clone the repository
git clone https://github.com/mben-dz/MBen.CurrencyToWordsEngine.git
cd MBen.CurrencyToWordsEngine

# 2. Open the project in Delphi
#    File → Open → UnivCurrencyToWordsEngine.dpr

# 3. Select your target platform
#    (Windows 32/64, Android, iOS, macOS)

# 4. Press F9 — Build and Run
```

> 💡 Windows 64-bit is the recommended starting platform for a quick first run.

### Older Delphi Versions (< Sydney 10.4)

Two manual fixes are needed — tracked in [issue #1](https://github.com/mben-dz/MBen.CurrencyToWordsEngine/issues/1):

**1 — Numeric literal underscores** (introduced in Delphi 10.4)

Replace the underscore-separated literals in `API.NumberEngine.pas`:

```delphi
// Before (Sydney 10.4+)
LScaleValues[sMillion]      := 1000_000;
LScaleValues[sBillion]      := 1000_000_000;
LScaleValues[sTrillion]     := 1000_000_000_000;
LScaleValues[sQuadrillion]  := 1000_000_000_000_000;
LScaleValues[sQuintillion]  := 1000_000_000_000_000_000;

// After (all versions)
LScaleValues[sMillion]      := 1000000;
LScaleValues[sBillion]      := 1000000000;
LScaleValues[sTrillion]     := 1000000000000;
LScaleValues[sQuadrillion]  := 1000000000000000;
LScaleValues[sQuintillion]  := 1000000000000000000;
```

**2 — Inline variable declarations** (introduced in Delphi 10.3)

In `API.CurrencyRegistry.pas`, move the inline `var` to the method's declaration block:

```delphi
// Before (Sydney 10.4+)
for var LPair in LNamesObj do ...

// After (all versions)
var
  LPair: TJSONPair;
...
for LPair in LNamesObj do ...
```

---

## 🏗️ Architecture

The project is split into two clear zones: a **Core** that never changes, and a **Register** where all extensions live.

```
UnivCurrencyToWordsEngine/
│
├── API/
│   │
│   ├── Core/                            # Stable — only touched to extend the contract
│   │   ├── API.Types.pas                # TLangCode, TCurrencyNames, TCurrencyDef
│   │   ├── API.LanguageRules.pas        # ILangRules interface contract
│   │   ├── API.LangRules.Factory.pas    # Singleton factory — lazy instantiation per language
│   │   ├── API.NumberEngine.pas         # Recursive SpellInteger — language-agnostic
│   │   └── API.CurrencyConverter.pas    # Orchestrates engine + rules + registry
│   │
│   └── LangsRegister/                   # Open — drop new languages & currencies here
│       ├── API.LangRules.English.pas
│       ├── API.LangRules.French.pas
│       ├── API.LangRules.Arabic.pas
│       ├── API.LangRules.German.pas
│       ├── API.LangRules.Hebrew.pas
│       └── CurrencyRegister/
│           └── API.CurrencyRegistry.pas # Singleton registry + JSON loader
│
└── Main.View.pas                        # Thin UI — dropdowns, input, RTL-aware result
```

### Layer Responsibilities

**`API.Types` — Shared Types**
Declares `TLangCode` (`lcAR`, `lcDE`, `lcEN`, `lcFR`, `lcHE`, `lcUnknown`), the `TCurrencyNames` record (singular, plural, genitive, dual — for both main unit and subunit), and `TCurrencyDef` which holds a static names array for all known language codes plus a `DynamicNames` dictionary for languages registered at runtime.

**`API.LanguageRules` — The Contract**
Defines `ILangRules`: the single interface every language must implement. It covers unit words, tens, hundreds, scale words, combination rules, RTL flag, and zero/negative words. The engine talks to this interface only — it is completely language-agnostic.

**`API.LangRules.Factory` — Lazy Singleton Factory**
`TLangRulesFactory.GetRules(aLang)` returns a cached `ILangRules` instance per language, creating it on first use. Adding a new language means one extra `case` branch here — nothing else in Core changes.

**`API.NumberEngine` — The Core Algorithm**
A single recursive function `SpellInteger` that decomposes any `Int64` (up to quintillions, 10¹⁸) into scale groups and delegates every wording decision to the injected `ILangRules`. Zero language awareness.

**`API.CurrencyConverter` — The Orchestrator**
Splits the amount into integer and subunit parts, picks the correct grammatical form (singular / dual / plural / genitive) from `TCurrencyDef.GetNames`, and assembles the final string — fully driven by the registry and the rules interface.

**`API.CurrencyRegistry` — Dynamic Currency Store**
A singleton `TObjectDictionary` of `TCurrencyDef` objects. Ships with built-in defaults (USD, EUR, DZD, ILS) and exposes `LoadFromJSON(aJSON)` to register any additional currency at runtime without recompiling.

**`Main.View` — Thin UI**
Language and currency combo boxes, an amount input, and a result memo. Text alignment flips to right-to-left automatically when Arabic or Hebrew is selected.

---

## 🔌 Extending the Engine

### ➕ Adding a New Language

1. Create `API\LangsRegister\API.LangRules.YourLang.pas`
2. Implement `ILangRules` — use any existing language file as a template
3. Add `lcYL` to `TLangCode` in `API.Types.pas`
4. Add one `case` branch in `TLangRulesFactory.GetRules`
5. Add the entry to the UI combo box

**The engine, converter, and registry need zero changes.**

### ➕ Adding a New Currency (in code)

Open `API.CurrencyRegistry.pas`, construct a `TCurrencyDef`, fill `Names[lcXX]` for each language, and call `AddCurrency(Def)` in `LoadDefaults`.

### ➕ Adding a New Currency (via JSON — no recompile)

```json
{
  "currencies": [
    {
      "code": "GBP",
      "subunit": 100,
      "names": {
        "en": { "singular": "Pound Sterling", "plural": "Pounds Sterling", "sub_singular": "Penny", "sub_plural": "Pence" },
        "fr": { "singular": "Livre sterling",  "plural": "Livres sterling",  "sub_singular": "Penny", "sub_plural": "Pence" },
        "ar": { "singular": "جنيه إسترليني", "plural": "جنيهات إسترلينية", "dual": "جنيهان إسترلينيان", "sub_singular": "بنس", "sub_plural": "بنسات" },
        "de": { "singular": "Pfund Sterling",  "plural": "Pfund Sterling",   "sub_singular": "Penny", "sub_plural": "Pence" },
        "he": { "singular": "לירה שטרלינג",   "plural": "לירות שטרלינג",    "sub_singular": "פני",  "sub_plural": "פנסים" }
      }
    }
  ]
}
```

```delphi
TCurrencyRegistry.Instance.LoadFromJSON(MyJSONString);
```

---

## 🧠 Design Highlights

- **One interface, any language** — `ILangRules` is the only contract the engine ever sees
- **Factory with lazy singletons** — language rule objects are created once and reused for the application lifetime
- **Dynamic currency registry** — currencies registered at compile time *or* injected at runtime via JSON, with no code changes
- **Graceful fallback in `GetNames`** — known `TLangCode` → static array; unknown language string → `DynamicNames` dictionary; anything else → English
- **Recursive engine up to 10¹⁸** — quintillions handled correctly in every language
- **Both RTL scripts** — Arabic and Hebrew, with automatic UI alignment switching
- **Full Arabic & Hebrew grammar** — singular / dual / 3–10 plural / 11+ genitive, including special forms like *אלפיים* (Hebrew for 2,000)
- **Zero circular dependencies** — Core has no reference to FMX or the View layer
- **Memory leak detection** — `ReportMemoryLeaksOnShutdown := True` enabled in all builds

---

## 📸 Screenshot

<img width="960" height="546" alt="image" src="https://github.com/user-attachments/assets/9ddc3cf9-6370-4df0-80a7-e9d7ba6ec4bf" />

## 🎬 Video

https://github.com/user-attachments/assets/56bce9eb-17c6-4744-a5ae-744ed4801cef

---

## 📄 License

This project is licensed under the [MIT License](LICENSE). Feel free to use, adapt, and extend it.

---

<div align="center">

Made with ❤️ in Delphi · *Because numbers deserve to be heard — in every language.*

</div>
