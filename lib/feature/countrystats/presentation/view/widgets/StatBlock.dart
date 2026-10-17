import 'package:flutter/material.dart';
import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/utils/CardNumFormat.dart';
import 'package:country_stats_flutter/l10n/app_localizations.dart';

class StatBlock extends StatelessWidget {
  final Country country;

  const StatBlock({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatIndicator(
          statName: l10n.countryCode,
          value: country.code,
        ),
        _StatIndicator(
          statName: l10n.countryCapital,
          value: country.capital,
        ),
        _StatIndicator(
          statName: l10n.countryPopularity,
          value: '${country.popularity.formatThousand()} ${l10n.peopleUnit}',
        ),
        _StatIndicator(
          statName: l10n.countryRegion,
          value: country.region,
        ),
        _StatIndicator(
          statName: l10n.countryGdp,
          value: '${country.gdp.formatThousand()}\$',
        ),
      ],
    );
  }
}

class _StatIndicator extends StatelessWidget {
  final String statName;
  final String value;

  const _StatIndicator({
    required this.statName,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Text(
            '$statName:',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(width: 10.0),
          Text(value),
        ],
      ),
    );
  }
}