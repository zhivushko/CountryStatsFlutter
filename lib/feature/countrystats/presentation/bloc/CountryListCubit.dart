import 'package:country_stats_flutter/feature/countrystats/domain/ICountryRepository.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/CountryCardUI.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/list/CountryListState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryListCubit extends Cubit<CountryListState> {
  final CountryRepository repository;

  CountryListCubit(this.repository) : super(const CountryListState()) {
    search(null);
  }

  void search(String? query) {
    emit(state.copyWith(isLoading: true, query: query ?? ''));

    final countries = repository.getCountries(filter: query).toCardsUI();
    emit(state.copyWith(items: countries, isLoading: false));

  }
}