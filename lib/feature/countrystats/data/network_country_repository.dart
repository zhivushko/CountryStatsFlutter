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

  List<Country>? _countries;

  Future<void>? _baseFuture;
  Future<void>? _gdpFuture;

  bool _gdpLoaded = false;

  @override
  Future<CountryPage> getCountries({
    int page = 1,
    int perPage = _defaultPerPage,
    String? filter,
    bool withGdp = false,
  }) async {
    await _ensureBase();
    if (withGdp) await _ensureGdp();

    final filtered = _filteredCountries(filter);
    final total = filtered.length;

    final size = perPage > 0 ? perPage : _defaultPerPage;
    final pageNumber = page < 1 ? 1 : page;
    final start = (pageNumber - 1) * size;
    final end = min(start + size, total);
    final items = start >= total
        ? const <Country>[]
        : filtered.sublist(start, end);

    return CountryPage(
      items: items,
      page: pageNumber,
      total: total,
      hasMore: end < total,
      isGdpLoaded: _gdpLoaded,
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

    await _ensureBase();
    await _ensureGdp();

    final countries = _countries ?? const <Country>[];
    final neighbours = countries
        .where(
          (neighbour) =>
              neighbour.region == region &&
              neighbour.id != country.id &&
              _hasEnoughData(neighbour),
        )
        .toList()
      ..sort(_byName);

    return neighbours.take(_neighboursLimit).toList(growable: false);
  }

  Future<void> _ensureBase() {
    final cached = _baseFuture;
    if (cached != null) return cached;

    final future = _loadBase();
    _baseFuture = future;
    return future;
  }

  Future<void> _loadBase() async {
    try {
      final dtos = await _dataSource.getCountries();
      final population = await _dataSource.getIndicatorValues(
        WorldBankIndicators.population,
        date: WorldBankIndicators.year,
      );

      final countries = <Country>[];
      for (final dto in dtos) {
        if (dto.isAggregate) continue;

        final name = dto.name.trim();
        final id = dto.id.trim().toUpperCase();
        if (name.isEmpty || id.isEmpty) continue;

        countries.add(dto.toModel(popularity: population[id]?.round()));
      }

      _countries = countries;
    } catch (_) {
      _baseFuture = null;
      rethrow;
    }
  }

  Future<void> _ensureGdp() {
    if (_gdpLoaded) return Future<void>.value();

    final cached = _gdpFuture;
    if (cached != null) return cached;

    final future = _loadGdp();
    _gdpFuture = future;
    return future;
  }

  Future<void> _loadGdp() async {
    try {
      final values = await _dataSource.getIndicatorValues(
        WorldBankIndicators.gdp,
        date: WorldBankIndicators.year,
      );

      final countries = _countries;
      if (countries != null) {
        _countries = countries
            .map(
              (country) => country.copyWith(
                gdp: values[country.id.toUpperCase()]?.round(),
              ),
            )
            .toList(growable: false);
      }

      _gdpLoaded = true;
    } catch (_) {
      _gdpFuture = null;
      rethrow;
    }
  }

  bool _hasEnoughData(Country country) {
    final population = country.popularity;
    if (population == null || population <= 0) return false;

    if (!_gdpLoaded) return true;

    final gdp = country.gdp;
    return gdp != null && gdp > 0;
  }

  List<Country> _filteredCountries(String? filter) {
    final source = _countries ?? const <Country>[];
    final needle = (filter ?? '').trim().toLowerCase();

    return source
        .where((country) {
          if (!_hasEnoughData(country)) return false;

          if (needle.isEmpty) return true;

          return country.name.toLowerCase().contains(needle) ||
              country.id.toLowerCase().contains(needle) ||
              country.isoCode.toLowerCase().contains(needle);
        })
        .toList()
      ..sort(_byName);
  }

  static int _byName(Country a, Country b) {
    final byName = a.name.toLowerCase().compareTo(b.name.toLowerCase());
    return byName != 0 ? byName : a.id.compareTo(b.id);
  }
}
