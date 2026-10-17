import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/CountryDetailCubit.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/view/widgets/CountryDetailed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CountryDetailScreen extends StatelessWidget {
  final int id;

  const CountryDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CountryDetailCubit>().state;

    if (state.isLoading || state.country == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
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