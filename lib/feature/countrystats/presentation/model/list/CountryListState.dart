import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';
class CountryListState {
  final String query;
  final List<Country> items;
  final bool isLoading;

  const CountryListState({
    this.query = '',
    this.items = const [],
    this.isLoading = true,
  });

  CountryListState copyWith({
    String? query,
    List<Country>? items,
    bool? isLoading,
  }) {
    return CountryListState(
      query: query ?? this.query,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}