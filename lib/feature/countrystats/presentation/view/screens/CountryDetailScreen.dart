import 'package:country_stats_flutter/feature/countrystats/domain/ICountryRepository.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/CountryDetailCubit.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/detail/CountryDetailState.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/view/widgets/invalid_country_screen.dart';
import 'package:country_stats_flutter/common/widgets/AppScaffold.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/view/widgets/CountryDetailed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:country_stats_flutter/l10n/app_localizations.dart';

class CountryDetailScreen extends StatelessWidget {
  final int? id;

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
    final l10n = AppLocalizations.of(context)!;

    return switch (state) {
      CountryDetailLoading() => const Center(child: CircularProgressIndicator()),
      CountryDetailNotFound() => const NotFoundScreen(),
      CountryDetailLoaded(:final country, :final neighbours) => AppScaffold(
        showBackButton: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: CountryDetailed(
            country: country,
            neighbours: neighbours,
            onCountryClick: (newId) => context.push('/country/$newId'),
          ),
        ),
      ),
    };
  }
}