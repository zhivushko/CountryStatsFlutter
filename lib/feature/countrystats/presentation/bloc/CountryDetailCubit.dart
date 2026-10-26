import 'package:country_stats_flutter/feature/countrystats/domain/ICountryRepository.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/detail/CountryDetailState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryDetailCubit extends Cubit<CountryDetailState> {
  final CountryRepository repository;

  CountryDetailCubit(this.repository) : super(const CountryDetailState.loading());

  void loadCountry(int id) {
    emit(const CountryDetailState.loading());

    final country = repository.getCountry(id);

    if (country == null) {
      emit(const CountryDetailState.notFound());
      return;
    }

    final neighbours = repository.getNeighbours(country);
    emit(CountryDetailState.success(country: country, neighbours: neighbours));
  }
}