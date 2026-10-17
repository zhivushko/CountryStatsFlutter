import 'package:country_stats_flutter/feature/countrystats/domain/ICountryRepository.dart';

import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';
import 'package:country_stats_flutter/feature/countrystats/data/Mocks.dart';

/// Реализация CountryRepository на мок-данных.
/// Интерфейс синхронный, поэтому задержка имитируется только там, где нужно.
class CountryRepositoryImpl implements CountryRepository {

  final Duration delay;

  CountryRepositoryImpl({this.delay = const Duration(milliseconds: 300)});

  @override
  List<Country> getCountries({String? filter}) {
    // Интерфейс синхронный — delay здесь не применим.
    // Если нужна имитация задержки, оберните вызов в Future.delayed на уровне UI.
    final all = List<Country>.unmodifiable(mockCountries);
    return all.filterByName(filter);
  }

  @override
  Country getCountry(int id) {
    return mockCountries.firstWhere(
          (c) => c.id == id,
      orElse: () => throw StateError('Country with id=$id not found'),
    );
  }
}


extension CountryRepositoryNeighbours on CountryRepository {
  List<Country> getNeighbours(Country country) {
    const maxSize = 5;
    final all = getCountries();
    return all
        .where((c) => c.region == country.region && c.id != country.id)
        .take(maxSize)
        .toList();
  }
}


extension CountryListFilter on List<Country> {
  List<Country> filterByName(String? filter) {
    final needle = filter?.trim() ?? '';
    if (needle.isEmpty) return this;
    final lower = needle.toLowerCase();
    return where((c) => c.name.toLowerCase().contains(lower)).toList();
  }
}