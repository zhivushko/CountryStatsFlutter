import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';

class CountryDetailState {
  final Country? country;
  final List<Country> neighbours;
  final bool isLoading;

  const CountryDetailState._({
    required this.country,
    required this.neighbours,
    required this.isLoading,
  });

  /// когда стейт просто грузится
  const CountryDetailState.loading()
      : this._(country: null, neighbours: const [], isLoading: true);

  /// загрузка прошла успешно
  CountryDetailState.success({
    required Country this.country,
    this.neighbours = const [],
  }) : isLoading = false;

  /// если репозиторий не выдал страну
  const CountryDetailState.notFound()
      : this._(country: null, neighbours: const [], isLoading: false);
}