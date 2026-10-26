// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Статистика стран';

  @override
  String get countryName => 'Название';

  @override
  String get countryCapital => 'Столица';

  @override
  String get countryRegion => 'Регион';

  @override
  String get countryPopularity => 'Население';

  @override
  String get countryUrb => 'Городское население';

  @override
  String get countryRur => 'Сельское население';

  @override
  String get countryGdp => 'ВВП';

  @override
  String get countryCode => 'Код страны';

  @override
  String get peopleUnit => 'чел.';

  @override
  String get countryNeighbours => 'Страны-соседи';

  @override
  String get noResults => 'Не найдено :(';

  @override
  String get urbanization => 'Урбанизация';

  @override
  String get search => 'Поиск';
}
