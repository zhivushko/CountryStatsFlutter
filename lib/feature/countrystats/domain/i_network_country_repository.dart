import 'package:country_stats_flutter/feature/countrystats/domain/country_page.dart';
import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';

abstract interface class INetworkCountryRepository {
  Future<CountryPage> getCountries({
    int page = 1,
    int perPage = 20,
    String? filter,
    bool withGdp = false,
  });

  Future<Country?> getCountry(String code);
  Future<List<Country>> getNeighbours(Country country);
}
