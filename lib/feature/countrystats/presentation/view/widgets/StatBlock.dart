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

    final pop = country.popularity;
    final gdp = country.gdp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _stat(l10n.countryCode, country.isoCode),
          _stat(l10n.countryCapital, country.capital),
          _stat(l10n.countryRegion, country.region),
          _stat(l10n.countryPopularity, pop != null ? '${pop.formatThousand()} ${l10n.peopleUnit}' : null),
          _stat(l10n.countryGdp, gdp != null ? '${gdp.formatThousand()}\$' : null),
          ].whereType<Widget>().toList()
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

Widget? _stat(String statName, String? value)
{
  if (value == null || value.isEmpty) return null;
  return _StatIndicator(statName: statName, value: value);
}