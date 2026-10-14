import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/CountryCardUI.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/ThemeProvide.dart';
import 'package:country_stats_flutter/feature/countrystats/data/CountryRepositoryImpl.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/view/widgets/CountryList.dart';

class AppScaffold extends StatelessWidget {
  AppScaffold({super.key});

  final repo = CountryRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Country Stats',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4,
        actions: [
          IconButton(
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
            icon: const Icon(Icons.eighteen_mp_rounded),
          ),
        ],
      ),
      body: CountryList(
        countries: repo.getCountries().toCardsUI(),
        onCountryClick: (id) => print('Click: $id'),
      ),
    );
  }
}