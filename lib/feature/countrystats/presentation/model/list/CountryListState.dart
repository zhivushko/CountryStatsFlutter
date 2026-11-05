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

  const CountryListLoaded({required this.query, required this.items});
}