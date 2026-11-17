import 'package:country_stats_flutter/feature/countrystats/domain/i_network_country_repository.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/detail/CountryDetailState.dart';
import 'package:country_stats_flutter/common/network/load_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryDetailCubit extends Cubit<CountryDetailState> {
  final INetworkCountryRepository repository;

  CountryDetailCubit(this.repository) : super(const CountryDetailLoading());

  Future<void> loadCountry(String? id) async {
    if (id == null || id.isEmpty) {
      emit(const CountryDetailNotFound());
      return;
    }

    emit(const CountryDetailLoading());
    try {
      final country = await repository.getCountry(id);
      if (country == null) {
        if (isClosed) return;
        emit(const CountryDetailNotFound());
        return;
      }

      final neighbours = await repository.getNeighbours(country);
      if (isClosed) return;

      emit(CountryDetailLoaded(
        country: country,
        neighbours: neighbours,
      ));
    } on LoadException {
      if (isClosed) return;
      emit(const CountryDetailError());
    }
  }
}