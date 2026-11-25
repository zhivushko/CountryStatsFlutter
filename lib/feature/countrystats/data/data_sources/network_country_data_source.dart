import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:country_stats_flutter/common/network/load_exception.dart';
import 'package:country_stats_flutter/feature/countrystats/data/api/world_bank_api.dart';
import 'package:country_stats_flutter/feature/countrystats/data/dto/country_dto.dart';
import 'package:country_stats_flutter/feature/countrystats/data/dto/indicator_row_dto.dart';
import 'package:country_stats_flutter/feature/countrystats/data/data_sources/i_country_data_source.dart';

class NetworkCountryDataSource implements ICountryDataSource {
  static const int _maxPages = 50;

  final WorldBankApi _api;

  NetworkCountryDataSource(this._api);

  @override
  Future<List<CountryDto>> getCountries() async {
    try {
      final countries = <CountryDto>[];
      var page = 1;
      var pages = 1;

      do {
        final result = await _api.getCountriesPage(page: page);
        countries.addAll(result.items);
        pages = result.pages;
        page++;
      } while (page <= pages && page <= _maxPages);

      return countries;
    } on DioException {
      throw const NetworkLoadException();
    } on CheckedFromJsonException {
      throw const ServerLoadException();
    } on FormatException {
      throw const ServerLoadException();
    }
  }

  @override
  Future<Map<String, num>> getIndicatorValues(
    String indicatorCode, {
    String? date,
  }) async {
    try {
      final values = <String, num>{};
      var page = 1;
      var pages = 1;

      do {
        final result = await _api.getIndicatorPage(
          indicatorCode,
          page: page,
          date: date,
        );
        _collectValues(result.items, values);
        pages = result.pages;
        page++;
      } while (page <= pages && page <= _maxPages);

      return values;
    } on DioException {
      throw const NetworkLoadException();
    } on CheckedFromJsonException {
      throw const ServerLoadException();
    } on FormatException {
      throw const ServerLoadException();
    }
  }

  @override
  Future<CountryDto?> getCountry(String code) async {
    try {
      return await _api.getCountry(code);
    } on DioException {
      throw const NetworkLoadException();
    } on CheckedFromJsonException {
      throw const ServerLoadException();
    } on FormatException {
      throw const ServerLoadException();
    }
  }

  @override
  Future<num?> getCountryIndicator(
    String countryCode,
    String indicatorCode, {
    String? date,
  }) async {
    try {
      return await _api.getCountryIndicator(
        countryCode,
        indicatorCode,
        date: date,
      );
    } on DioException {
      throw const NetworkLoadException();
    } on CheckedFromJsonException {
      throw const ServerLoadException();
    } on FormatException {
      throw const ServerLoadException();
    }
  }

  void _collectValues(List<IndicatorRowDto> rows, Map<String, num> target) {
    for (final row in rows) {
      final value = row.value;
      final code = row.countryIso3Code?.trim().toUpperCase();

      if (value == null || code == null || code.isEmpty) continue;

      target[code] = value;
    }
  }
}
