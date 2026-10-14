// lib/ui/components/card_stat.dart
import 'package:flutter/material.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/utils/CardNumFormat.dart';

class CardStat extends StatelessWidget {
  final Widget icon;
  final num value;

  const CardStat({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 1.0), // Spacer(Modifier.width(1.dp))
        Text(value.formatThousand()),
      ],
    );
  }
}