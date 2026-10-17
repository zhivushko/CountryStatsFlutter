import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/LocaleProvider.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/bloc/ThemeProvide.dart';
import 'package:country_stats_flutter/feature/countrystats/data/CountryRepositoryImpl.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/view/widgets/CountryList.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/CountryCardUI.dart';
import 'package:country_stats_flutter/l10n/app_localizations.dart';

class CountryListScreen extends StatelessWidget {
  const CountryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final repo = context.read<CountryRepositoryImpl>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        elevation: 4,
        actions: [
          IconButton(
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
            icon: const Icon(Icons.tonality),
          ),
          IconButton(
            onPressed: () => context.read<LocaleProvider>().toggleLocale(),
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: CountryList(
        countries: repo.getCountries().toCardsUI(),
        onCountryClick: (id) => context.push('/country/$id'),
        isScrollable: true, // Здесь скроллится сам
      ),
    );
  }
}