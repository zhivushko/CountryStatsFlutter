import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';

enum GdpStatus { loading, loaded, failed }

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
  final GdpStatus gdpStatus;

  const CountryListLoaded({
    required this.query,
    required this.items,
    required this.total,
    required this.hasMore,
    this.isLoadingMore = false,
    this.gdpStatus = GdpStatus.loading,
  });

  CountryListLoaded copyWith({
    List<Country>? items,
    int? total,
    bool? hasMore,
    bool? isLoadingMore,
    GdpStatus? gdpStatus,
  }) {
    return CountryListLoaded(
      query: query,
      items: items ?? this.items,
      total: total ?? this.total,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      gdpStatus: gdpStatus ?? this.gdpStatus,
    );
  }
}

final class CountryListError extends CountryListState {
  final String query;
  const CountryListError({this.query = ''});
}
