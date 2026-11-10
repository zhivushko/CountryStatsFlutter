import 'package:country_stats_flutter/feature/countrystats/domain/ICountryRepository.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/detail/CountryDetailState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryDetailCubit extends Cubit<CountryDetailState> {
  final CountryRepository repository;

  CountryDetailCubit(this.repository) : super( CountryDetailLoading());

  void loadCountry(int? id) {
    if (id==null)
      {
        emit(const CountryDetailNotFound());
        return;
      }
    emit(const CountryDetailLoading());
    final country = repository.getCountry(id);
    if (country == null) {
      emit(const CountryDetailNotFound());
      return;
    }
    emit(CountryDetailLoaded(
      country: country,
      neighbours: repository.getNeighbours(country),
    ));
  }
}