import 'dart:math';

import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';
import 'package:country_stats_flutter/feature/countrystats/data/api/world_bank_indicators.dart';
import 'package:country_stats_flutter/feature/countrystats/data/data_sources/i_country_data_source.dart';
import 'package:country_stats_flutter/feature/countrystats/data/dto/country_dto.dart';
import 'package:country_stats_flutter/feature/countrystats/data/mappers/country_mapper.dart';
import 'package:country_stats_flutter/feature/countrystats/domain/country_page.dart';
import 'package:country_stats_flutter/feature/countrystats/domain/i_network_country_repository.dart';

class NetworkCountryRepositoryImpl implements INetworkCountryRepository {
  static const int _defaultPerPage = 20;
  static const int _neighboursLimit = 5;

  final ICountryDataSource _dataSource;

  NetworkCountryRepositoryImpl(this._dataSource);

  @override
  Future<CountryPage> getCountries({
    int page = 1,
    int perPage = _defaultPerPage,
    String? filter,
    bool withGdp = false,
  }) async {
    final size = perPage > 0 ? perPage : _defaultPerPage;
    final pageNumber = page < 1 ? 1 : page;
    final needle = (filter ?? '').trim().toLowerCase();

    if (needle.isNotEmpty) {
      return _searchCountries(
        needle: needle,
        page: pageNumber,
        perPage: size,
        withGdp: withGdp,
      );
    }

    final pageResult = await _dataSource.getCountriesPage(
      page: pageNumber,
      perPage: size,
    );

    final validDtos = _validCountryDtos(pageResult.items);
    final enriched = await Future.wait(
      validDtos.map((dto) => _enrichSummary(dto, withGdp: withGdp)),
    );

    final items = enriched
        .where((country) => _hasEnoughData(country, withGdp: withGdp))
        .toList(growable: false);

    return CountryPage(
      items: items,
      page: pageResult.page,
      total: items.length,
      hasMore: pageResult.page < pageResult.pages,
      isGdpLoaded: withGdp,
    );
  }

  @override
  Future<Country?> getCountry(String code) async {
    final normalized = code.trim().toUpperCase();
    if (normalized.isEmpty) return null;

    final results = await Future.wait<Object?>([
      _dataSource.getCountry(normalized),
      _dataSource.getCountryIndicator(
        normalized,
        WorldBankIndicators.population,
        date: WorldBankIndicators.year,
      ),
      _dataSource.getCountryIndicator(
        normalized,
        WorldBankIndicators.gdp,
        date: WorldBankIndicators.year,
      ),
      _dataSource.getCountryIndicator(
        normalized,
        WorldBankIndicators.urbanShare,
        date: WorldBankIndicators.year,
      ),
      _dataSource.getCountryIndicator(
        normalized,
        WorldBankIndicators.ruralShare,
        date: WorldBankIndicators.year,
      ),
    ]);

    final dto = results[0] as CountryDto?;
    if (dto == null || dto.isAggregate) return null;

    return dto.toModel(
      popularity: (results[1] as num?)?.round(),
      gdp: (results[2] as num?)?.round(),
      urbTot: (results[3] as num?)?.toDouble(),
      rurTot: (results[4] as num?)?.toDouble(),
    );
  }

  @override
  Future<List<Country>> getNeighbours(Country country) async {
    final region = country.region;
    if (region == null) return const [];

    final dtos = await _dataSource.getCountries();
    final sameRegion = _validCountryDtos(dtos)
        .where(
          (dto) =>
              dto.region?.value?.trim() == region &&
              dto.id.trim().toUpperCase() != country.id.toUpperCase(),
        )
        .toList()
      ..sort((a, b) => _byDtoName(a, b));

    final candidates = sameRegion.take(_neighboursLimit);
    return Future.wait(
      candidates.map((dto) => _enrichSummary(dto, withGdp: true)),
    );
  }

  Future<CountryPage> _searchCountries({
    required String needle,
    required int page,
    required int perPage,
    required bool withGdp,
  }) async {
    final dtos = await _dataSource.getCountries();
    final matched = _validCountryDtos(dtos)
        .where(
          (dto) =>
              dto.name.toLowerCase().contains(needle) ||
              dto.id.toLowerCase().contains(needle) ||
              dto.iso2Code.toLowerCase().contains(needle),
        )
        .toList()
      ..sort(_byDtoName);

    final total = matched.length;
    final start = (page - 1) * perPage;
    final end = min(start + perPage, total);
    final slice = start >= total ? const <CountryDto>[] : matched.sublist(start, end);

    final enriched = await Future.wait(
      slice.map((dto) => _enrichSummary(dto, withGdp: withGdp)),
    );
    final items = enriched
        .where((country) => _hasEnoughData(country, withGdp: withGdp))
        .toList(growable: false);

    return CountryPage(
      items: items,
      page: page,
      total: total,
      hasMore: end < total,
      isGdpLoaded: withGdp,
    );
  }

  Future<Country> _enrichSummary(CountryDto dto, {required bool withGdp}) async {
    final code = dto.id.trim().toUpperCase();
    final results = await Future.wait<num?>([
      _dataSource.getCountryIndicator(
        code,
        WorldBankIndicators.population,
        date: WorldBankIndicators.year,
      ),
      if (withGdp)
        _dataSource.getCountryIndicator(
          code,
          WorldBankIndicators.gdp,
          date: WorldBankIndicators.year,
        ),
    ]);

    return dto.toModel(
      popularity: results[0]?.round(),
      gdp: withGdp ? results[1]?.round() : null,
    );
  }

  List<CountryDto> _validCountryDtos(List<CountryDto> dtos) {
    return dtos
        .where(
          (dto) =>
              !dto.isAggregate &&
              dto.name.trim().isNotEmpty &&
              dto.id.trim().isNotEmpty,
        )
        .toList(growable: false);
  }

  bool _hasEnoughData(Country country, {required bool withGdp}) {
    final population = country.popularity;
    if (population == null || population <= 0) return false;
    if (!withGdp) return true;

    final gdp = country.gdp;
    return gdp != null && gdp > 0;
  }

  static int _byDtoName(CountryDto a, CountryDto b) {
    final byName = a.name.toLowerCase().compareTo(b.name.toLowerCase());
    return byName != 0 ? byName : a.id.compareTo(b.id);
  }
}
