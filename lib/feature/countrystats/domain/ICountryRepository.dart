import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';

abstract interface class CountryRepository {
  List<Country> getCountries({String? filter});
  List<Country> getNeighbours(Country country);
  Country getCountry(int id);

}