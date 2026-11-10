import 'package:flutter/material.dart';
import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/utils/ChartUtils.dart';
import 'package:country_stats_flutter/l10n/app_localizations.dart';
import 'bar.dart';

const Color _urbColor = Color(0xFF10C300);
const Color _rurColor = Color(0xFF4A90E2);

class UrbGraphic extends StatelessWidget {
  final Country country;

  const UrbGraphic({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.urbanization}:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Bar(
              value: country.urbTot,
              height: country.urbTot.calculateBarHeight(),
              color: _urbColor,
              name: l10n.countryUrb,
            ),
            Bar(
              value: country.rurTot,
              height: country.rurTot.calculateBarHeight(),
              color: _rurColor,
              name: l10n.countryRur,
            ),
          ],
        ),
      ],
    );
  }
}