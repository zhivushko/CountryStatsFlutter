import 'package:country_stats_flutter/feature/countrystats/data/dto/country_dto.dart';

abstract interface class ICountryDataSource {
  Future<({List<CountryDto> items, int page, int pages})> getCountriesPage({
    int page = 1,
    int perPage = 20,
  });
  Future<List<CountryDto>> getCountries();
  Future<Map<String, num>> getIndicatorValues(String indicatorCode, {String? date});
  Future<CountryDto?> getCountry(String code);
  Future<num?> getCountryIndicator(
    String countryCode,
    String indicatorCode, {
    String? date,
  });
}
