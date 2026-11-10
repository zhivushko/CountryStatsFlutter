import 'package:flutter/material.dart';
import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';
import 'country_card.dart';
import 'package:country_stats_flutter/l10n/app_localizations.dart';

class CountryList extends StatelessWidget {
  final List<Country> countries;
  final void Function(int id) onCountryClick;
  final bool isScrollable;

  const CountryList({
    super.key,
    required this.countries,
    required this.onCountryClick,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (countries.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            l10n.noResults,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }

    if (isScrollable) {
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final country = countries[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: CountryCard(
              country: country,
              onClick: () => onCountryClick(country.id),
            ),
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12.0,
      children: countries.map((country) {
        return CountryCard(
          country: country,
          onClick: () => onCountryClick(country.id),
        );
      }).toList(),
    );
  }
}