import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';

sealed class CountryListState {
  const CountryListState();
}

final class CountryListLoading extends CountryListState {
  final String query;
  const CountryListLoading({this.query = ''});
}

final class CountryListLoaded extends CountryListState {
  final String query;
  final List<Country> items;
  final int total;
  final bool hasMore;
  final bool isLoadingMore;
  final bool isGdpLoading;
  final bool isGdpLoaded;
  final bool gdpFailed;

  const CountryListLoaded({
    required this.query,
    required this.items,
    required this.total,
    required this.hasMore,
    this.isLoadingMore = false,
    this.isGdpLoading = false,
    this.isGdpLoaded = false,
    this.gdpFailed = false,
  });

  CountryListLoaded copyWith({
    List<Country>? items,
    int? total,
    bool? hasMore,
    bool? isLoadingMore,
    bool? isGdpLoading,
    bool? isGdpLoaded,
    bool? gdpFailed,
  }) {
    return CountryListLoaded(
      query: query,
      items: items ?? this.items,
      total: total ?? this.total,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isGdpLoading: isGdpLoading ?? this.isGdpLoading,
      isGdpLoaded: isGdpLoaded ?? this.isGdpLoaded,
      gdpFailed: gdpFailed ?? this.gdpFailed,
    );
  }
}

final class CountryListError extends CountryListState {
  final String query;
  const CountryListError({this.query = ''});
}
