
import 'dart:math';
import 'package:country_stats_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/utils/CardNumFormat.dart';

class CardStat extends StatelessWidget {
  final Widget icon;
  final num? value;
  const CardStat({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 1.0),
        Text(value?.formatThousand() ?? l10n.noResults),
      ],
    );
  }
}