import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/CountryListCubit.dart';
import 'package:country_stats_flutter/feature/countrystats/domain/ICountryRepository.dart';
import 'package:country_stats_flutter/common/widgets/AppScaffold.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/list/CountryListState.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/view/widgets/CountryList.dart';
import 'package:country_stats_flutter/l10n/app_localizations.dart';

class CountryListScreen extends StatelessWidget {
  const CountryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountryListCubit(context.read<CountryRepository>()),
      child: const _CountryListView(),
    );
  }
}

class _CountryListView extends StatelessWidget {
  const _CountryListView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = context.watch<CountryListCubit>().state;


    return AppScaffold(
      showBackButton: false,
      body: Column(
      children: [
      Padding(
      padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: l10n.search,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onChanged: (value) {
                context.read<CountryListCubit>().search(value);
              },
            ),
          ),
          Expanded(
            child: switch (state) {
              CountryListLoading() =>
                  const Center(child: CircularProgressIndicator()),
              CountryListLoaded(:final items) => CountryList(
                countries: items,
                onCountryClick: (id) => context.push('/country/$id'),
                isScrollable: true,
    ),
    },
            )
        ],
      ),
    );
  }
}