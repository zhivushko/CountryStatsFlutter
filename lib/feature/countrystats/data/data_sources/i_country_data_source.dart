import 'package:country_stats_flutter/feature/countrystats/data/dto/country_dto.dart';

abstract interface class ICountryDataSource {
  Future<List<CountryDto>> getCountries();
  Future<Map<String, num>> getIndicatorValues(String indicatorCode, {String? date});
  Future<CountryDto?> getCountry(String code);
  Future<num?> getCountryIndicator(
    String countryCode,
    String indicatorCode, {
    String? date,
  });
}
