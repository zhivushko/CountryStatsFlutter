import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';

sealed class CountryDetailState {
  const CountryDetailState();
}


final class CountryDetailLoading extends CountryDetailState {
  const CountryDetailLoading();
}


final class CountryDetailLoaded extends CountryDetailState {
  final Country country;
  final List<Country> neighbours;

  const CountryDetailLoaded({required this.country, required this.neighbours});
}

// Состояние "не найдено"
final class CountryDetailNotFound extends CountryDetailState {
  const CountryDetailNotFound();
}