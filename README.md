# Отчёт по лабораторной работе

## Тема

Разработка кроссплатформенного приложения **Country Stats** на Flutter с использованием BLoC (Cubit), go_router и flutter_localizations.

## Предметная область

Приложение представляет собой каталог стран с основной статистикой. Для каждой страны отображаются:

- название, код, столица, регион;
- население, городское и сельское население (в процентах);
- ВВП.

Список стран можно фильтровать по названию. При выборе страны открывается детальный экран с полной информацией и списком стран-соседей по региону. Данные на текущий момент берутся из моков (`Mocks.dart`) — 20 стран, покрывающих разные регионы.

## Архитектура

Проект разделён на три слоя:

### `data/`

- `Country` — иммутабельная модель данных с `const`-конструктором.
- `Mocks.dart` — список моковых стран (`mockCountries`).
- `CountryRepositoryImpl` — реализация репозитория с extension-функцией `filterByName`.

### `domain/`

- `ICountryRepository.dart` — абстрактный интерфейс `CountryRepository` с методами `getCountries({String? filter})`, `getCountry(int id)`, `getNeighbours(Country)`.

### `presentation/`

- `bloc/` — Cubit'ы: `CountryListCubit`, `CountryDetailCubit`, `ThemeProvider`, `LocaleProvider`.
- `model/` — состояния (`CountryListState`, `CountryDetailState`) и UI-модели (`CountryCardUI`) с расширениями для маппинга.
- `view/screens/` — экраны (`CountryListScreen`, `CountryDetailScreen`).
- `view/widgets/` — переиспользуемые компоненты (`AppScaffold`, `CountryList`, `country_card`, `CountryDetailed`, `StatBlock`, `UrbGraphic`, `Bar`, `CardNum`, `CardStat`, `CardSurface`).
- `utils/` — утилиты (`CardNumFormat`, `ChartUtils`).
- `color_scheme.dart` — `lightTheme`, `darkTheme`, `cardNumColor`.
- `navigation/app_router.dart` — конфигурация go_router.

## Как устроен поток данных

Экраны не знают про Cubit и репозиторий напрямую — они получают состояние через `context.watch` и вызывают методы Cubit через `context.read`:

```dart
final state = context.watch<CountryListCubit>().state;
// ...
onChanged: (value) => context.read<CountryListCubit>().search(value),