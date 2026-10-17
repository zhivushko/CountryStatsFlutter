import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/CountryCardUI.dart';

class CountryDetailState {
  final Country? country;
  final List<CountryCardUI> neighbours;
  final bool isLoading;

  const CountryDetailState({
    this.country,
    this.neighbours = const [],
    this.isLoading = true,
  });

  CountryDetailState copyWith({
    Country? country,
    List<CountryCardUI>? neighbours,
    bool? isLoading,
  }) {
    return CountryDetailState(
      country: country ?? this.country,
      neighbours: neighbours ?? this.neighbours,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}