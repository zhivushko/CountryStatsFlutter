import 'package:country_stats_flutter/feature/countrystats/domain/ICountryRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/detail/CountryDetailState.dart';

class CountryDetailCubit extends Cubit<CountryDetailState> {
  final CountryRepository repository;

  CountryDetailCubit(this.repository) : super(const CountryDetailState());

  void loadCountry(int id) {
    emit(state.copyWith(isLoading: true));

    final country = repository.getCountry(id);
    final neighbours = repository.getNeighbours(country);

    emit(state.copyWith(
      country: country,
      neighbours: neighbours,
      isLoading: false,
    ));

  }
}