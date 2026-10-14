import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';

abstract interface class CountryRepository {
  List<Country> getCountries({String? filter});
  Country getCountry(int id);
}