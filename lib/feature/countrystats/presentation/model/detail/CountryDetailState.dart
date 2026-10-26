import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';
import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';

class CountryDetailState {
  final Country? country;
  final List<Country> neighbours;
  final bool isLoading;

  const CountryDetailState({
    this.country,
    this.neighbours = const [],
    this.isLoading = true,
  });

  CountryDetailState copyWith({
    Country? country,
    List<Country>? neighbours,
    bool? isLoading,
  }) {
    return CountryDetailState(
      country: country ?? this.country,
      neighbours: neighbours ?? this.neighbours,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}