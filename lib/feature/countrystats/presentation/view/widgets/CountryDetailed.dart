import 'package:flutter/material.dart';
import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';
import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';
import 'package:country_stats_flutter/l10n/app_localizations.dart';
import 'CountryList.dart';
import 'StatBlock.dart';
import 'UrbGraphic.dart';

class CountryDetailed extends StatelessWidget {
  final Country country;
  final List<Country> neighbours;
  final void Function(int id) onCountryClick;

  const CountryDetailed({
    super.key,
    required this.country,
    required this.neighbours,
    required this.onCountryClick,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          country.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16.0),

        StatBlock(country: country),
        const SizedBox(height: 16.0),

        UrbGraphic(country: country),

        if (neighbours.isNotEmpty) ...[
          const SizedBox(height: 16.0),
          Text('${l10n.countryNeighbours}:', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16.0),
          CountryList(
            countries: neighbours,
            onCountryClick: onCountryClick,
            isScrollable: false,
          ),
        ],
      ],
    );
  }
}