import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';
import 'package:country_stats_flutter/feature/countrystats/data/CountryRepositoryImpl.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/CountryCardUI.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/detail/CountryDetailState.dart';

class CountryDetailCubit extends Cubit<CountryDetailState> {
  final CountryRepositoryImpl repository;

  CountryDetailCubit(this.repository) : super(const CountryDetailState());

  void loadCountry(int id) {
    emit(state.copyWith(isLoading: true));

    try {
      final country = repository.getCountry(id);
      final neighbours = repository.getNeighbours(country);

      emit(state.copyWith(
        country: country,
        neighbours: neighbours.toCardsUI(),
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}