import 'package:country_stats_flutter/feature/countrystats/domain/ICountryRepository.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/CountryDetailCubit.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/view/widgets/AppScaffold.dart'; // ИМПОРТ
import 'package:country_stats_flutter/feature/countrystats/presentation/view/widgets/CountryDetailed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CountryDetailScreen extends StatelessWidget {
  final int id;

  const CountryDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountryDetailCubit(context.read<CountryRepository>())
        ..loadCountry(id),
      child: const _CountryDetailView(),
    );
  }
}

class _CountryDetailView extends StatelessWidget {
  const _CountryDetailView();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CountryDetailCubit>().state;

    if (state.isLoading || state.country == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // ОБОРАЧИВАЕМ В APPSCAFFOLD
    return AppScaffold(
      showBackButton: true, // Здесь кнопка назад нужна
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: CountryDetailed(
          country: state.country!,
          neighbours: state.neighbours,
          onCountryClick: (newId) => context.push('/country/$newId'),
        ),
      ),
    );
  }
}