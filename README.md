<div align="center">

# 💱 CurrToWords

**Convert currency amounts into written words — in multiple languages.**

*A clean, extensible Delphi FMX application built with solid architecture and real linguistic precision.*

[![Delphi](https://img.shields.io/badge/Delphi-Athens%2012-EE1F35?style=flat-square&logo=embarcadero&logoColor=white)](https://www.embarcadero.com/products/delphi)
[![FMX](https://img.shields.io/badge/Framework-FireMonkey%20(FMX)-FF6B35?style=flat-square)](https://docwiki.embarcadero.com/RADStudio/en/FireMonkey_Application_Platform)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Android%20%7C%20iOS%20%7C%20macOS-0078D4?style=flat-square)](https://www.embarcadero.com)
[![License](https://img.shields.io/badge/License-MIT-22C55E?style=flat-square)](LICENSE)

---

</div>

## ✨ What It Does

Enter any currency amount and instantly see it spelled out in full, natural-language text — handling the grammatical rules of each language correctly, including Arabic's complex plural forms, RTL text direction, and gender agreement.

```
1,234.56  →  "One Thousand Two Hundred Thirty-Four US Dollars and Fifty-Six Cents"
1,234.56  →  "Mille Deux Cent Trente-Quatre Dollars US et Cinquante-Six Cents"
1,234.56  →  "ألف ومئتان وأربعة وثلاثون دولاراً أمريكياً وستة وخمسون سنتاً"
1,234.56  →  "Eintausend Zweihundertvierunddreißig US-Dollar und Sechsundfünfzig Cents"
```

---

## 🌍 Supported Languages & Currencies

| Language | Code | RTL | Notes |
|----------|------|-----|-------|
| 🇬🇧 English | `en` | No | Standard rules |
| 🇫🇷 French | `fr` | No | Liaison & gender rules |
| 🇸🇦 Arabic | `ar` | **Yes** | Dual, plural & genitive forms |
| 🇩🇪 German | `de` | No | Compound number words |

| Currency | Code | Subunit |
|----------|------|---------|
| 🇺🇸 US Dollar | `USD` | Cent |
| 🇪🇺 Euro | `EUR` | Cent / Centime |
| 🇩🇿 Algerian Dinar | `DZD` | Centime |

---

## 🚀 Getting Started

### Prerequisites

- [Delphi Athens 12](https://www.embarcadero.com/products/delphi) (RAD Studio 12)
- Any supported target platform SDK (optional for mobile)

### Build & Run

```bash
# 1. Clone the repository
git clone https://github.com/your-username/CurrToWords.git
cd CurrToWords

# 2. Open the project in Delphi
#    File → Open → CurrToWords.dpr

# 3. Select your target platform
#    (Windows 32/64, Android, iOS, macOS)

# 4. Press F9 — Build and Run
```

> 💡 Windows 64-bit is the recommended starting platform for a quick first run.

---

## 🏗️ Architecture

The project follows a clean **MVVM-inspired** layered architecture with **dependency injection** and **interface-based polymorphism**.

```
CurrToWords/
│
├── API/                          # Core business logic (no UI dependency)
│   ├── API.LanguageRules.pas     # ILangRules interface contract
│   ├── API.LangRules.English.pas # English implementation
│   ├── API.LangRules.French.pas  # French implementation
│   ├── API.LangRules.Arabic.pas  # Arabic implementation (RTL + grammar)
│   ├── API.LangRules.German.pas  # German implementation
│   ├── API.NumberEngine.pas      # Core recursive spelling algorithm
│   ├── API.CurrencyData.pas      # Currency definitions & name tables
│   └── API.CurrencyConverter.pas # Orchestrates engine + rules + currency
│
└── View/                         # Presentation layer
    ├── Base.View.pas             # Abstract base view (DI constructor)
    └── Main.View.pas             # Concrete UI — combos, input, result memo
```

### Layer Responsibilities

**`API.LanguageRules` — The Contract**
Defines the `ILangRules` interface that every language must implement: number units, tens, hundreds, scale words (thousands → quintillions), combination rules, RTL flag, zero/and/negative words.

**`API.LangRules.*` — Language Implementations**
Each language class implements `ILangRules` with its own linguistic rules. Arabic, for example, handles the dual form (*ألفان* for 2,000), the 3–10 plural (*آلاف*), and the 11+ genitive (*ألف*) — fully correctly.

**`API.NumberEngine` — The Core Algorithm**
A single recursive function `SpellInteger` that breaks any `Int64` into scale groups (units → quintillions) and delegates all wording decisions to the injected `ILangRules`. Language-agnostic by design.

**`API.CurrencyData` — Currency Metadata**
`TCurrencyDef` records hold singular, plural, genitive, and subunit names in all four languages. Adding a new currency is as simple as declaring a new constant.

**`API.CurrencyConverter` — The Orchestrator**
Combines the number engine, language rules, and currency definitions into one clean call: `TCurrencyConverter.CurrencyToWords(Amount, LangRules, CurrencyDef)`.

**`View Layer` — Clean UI**
`TBaseView` receives its dependencies through a typed constructor (dependency injection). `TMainView` drives the UI: language/currency dropdowns, amount input, and a result memo that automatically switches text alignment for RTL languages.

---

## 🔌 Extending the Project

### ➕ Adding a New Language

1. Create `API.LangRules.YourLang.pas`
2. Implement `ILangRules` (all methods)
3. Add your class to the `uses` clause in `Main.View.pas`
4. Add an entry to the `cbLanguage` ComboBox and the `case` statement in `UpdateLang`

### ➕ Adding a New Currency

1. Open `API.CurrencyData.pas`
2. Declare a new `TCurrencyDef` constant with names in all supported languages
3. Add it to the `cbCurrency` ComboBox and the `case` statement in `UpdateLang`

No changes to the engine or language rules are needed.

---

## 🧠 Design Highlights

- **Interface-based polymorphism** — the engine never knows which language it's using
- **Recursive number spelling** — handles up to quintillions (10¹⁸) correctly
- **Arabic grammatical correctness** — dual, 3–10 plural, and 11+ genitive cases
- **RTL-aware UI** — result text alignment flips automatically for Arabic
- **Zero circular dependencies** — API layer has no reference to FMX or Views
- **Memory leak detection** — `ReportMemoryLeaksOnShutdown := True` enabled in debug builds

---

## 📸 Screenshot
<img width="960" height="546" alt="image" src="https://github.com/user-attachments/assets/9ddc3cf9-6370-4df0-80a7-e9d7ba6ec4bf" />


---

## 📄 License

This project is licensed under the [MIT License](LICENSE). Feel free to use, adapt, and extend it.

---

<div align="center">

Made with ❤️ in Delphi · *Because numbers deserve to be heard.*

</div>
