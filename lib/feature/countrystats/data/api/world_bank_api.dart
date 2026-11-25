import 'package:dio/dio.dart';
import 'package:country_stats_flutter/common/network/load_exception.dart';
import 'package:country_stats_flutter/feature/countrystats/data/dto/country_dto.dart';
import 'package:country_stats_flutter/feature/countrystats/data/dto/indicator_row_dto.dart';

class WorldBankApi {
  final Dio _dio;

  WorldBankApi(this._dio);

  static const int countriesPerPage = 300;
  static const int indicatorPerPage = 500;

  /// Запрос списка стран с пагинацией
  Future<({List<CountryDto> items, int page, int pages})> getCountriesPage({
    int page = 1,
    int perPage = countriesPerPage,
  }) async {
    final response = await _dio.get(
      '/country',
      queryParameters: {'page': page, 'per_page': perPage},
    );

    final (meta, rows) = _split(response.data);
    final items = rows
        .whereType<Map<String, dynamic>>()
        .map(CountryDto.fromJson)
        .toList(growable: false);

    return (
      items: items,
      page: _asInt(meta['page'], page),
      pages: _asPages(meta),
    );
  }

  Future<({List<IndicatorRowDto> items, int page, int pages})> getIndicatorPage(
    String indicatorCode, {
    int page = 1,
    int perPage = indicatorPerPage,
    String? date,
  }) async {
    final response = await _dio.get(
      '/country/all/indicator/$indicatorCode',
      queryParameters: {'page': page, 'per_page': perPage, 'date': ?date},
    );

    final (meta, rows) = _split(response.data);
    final items = rows
        .whereType<Map<String, dynamic>>()
        .map(IndicatorRowDto.fromJson)
        .toList(growable: false);

    return (
      items: items,
      page: _asInt(meta['page'], page),
      pages: _asPages(meta),
    );
  }

  Future<CountryDto?> getCountry(String code) async {
    final response = await _dio.get('/country/$code');
    final data = response.data;
    if (_hasApiMessage(data)) return null;

    final (_, rows) = _split(data);
    if (rows.isEmpty) return null;

    final row = rows.first;
    if (row is! Map<String, dynamic>) return null;

    return CountryDto.fromJson(row);
  }

  Future<num?> getCountryIndicator(
    String countryCode,
    String indicatorCode, {
    String? date,
  }) async {
    final response = await _dio.get(
      '/country/$countryCode/indicator/$indicatorCode',
      queryParameters: {'date': ?date},
    );
    final data = response.data;
    if (_hasApiMessage(data)) return null;

    final (_, rows) = _split(data);
    for (final row in rows) {
      if (row is! Map<String, dynamic>) continue;
      final dto = IndicatorRowDto.fromJson(row);
      if (dto.value != null) return dto.value;
    }

    return null;
  }

  bool _hasApiMessage(Object? data) =>
      data is List &&
      data.isNotEmpty &&
      data.first is Map &&
      (data.first as Map).containsKey('message');

  (Map<String, dynamic>, List<dynamic>) _split(Object? data) {
    if (data is! List || data.length < 2) {
      throw const ServerLoadException();
    }

    final meta = data[0];
    final rows = data[1];

    return (
      meta is Map<String, dynamic> ? meta : <String, dynamic>{},
      rows is List ? rows : <dynamic>[],
    );
  }

  int _asPages(Map<String, dynamic> meta) {
    final pages = _asInt(meta['pages'], 1);
    return pages < 1 ? 1 : pages;
  }

  int _asInt(Object? value, int fallback) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse('$value') ?? fallback;
  }
}
