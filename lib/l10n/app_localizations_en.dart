// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Country Stats';

  @override
  String get countryName => 'Name';

  @override
  String get countryCapital => 'Capital';

  @override
  String get countryRegion => 'Region';

  @override
  String get countryPopularity => 'Population';

  @override
  String get countryUrb => 'Urban population';

  @override
  String get countryRur => 'Rural population';

  @override
  String get countryGdp => 'GDP';

  @override
  String get countryCode => 'Country Code';

  @override
  String get peopleUnit => 'people';

  @override
  String get countryNeighbours => 'Country neighbours';

  @override
  String get noResults => 'Not found :(';

  @override
  String get urbanization => 'Urbanization';

  @override
  String get search => 'Search';
}
