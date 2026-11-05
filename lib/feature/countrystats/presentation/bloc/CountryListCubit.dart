import 'package:country_stats_flutter/feature/countrystats/domain/ICountryRepository.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/list/CountryListState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryListCubit extends Cubit<CountryListState> {
  final CountryRepository repository;

  CountryListCubit(this.repository) : super(const CountryListLoading()) {
    search(null);
  }

  void search(String? query) {
    final q = query ?? '';
    emit(CountryListLoading(query: q));
    final countries = repository.getCountries(filter: q);
    emit(CountryListLoaded(query: q, items: countries));
  }
}