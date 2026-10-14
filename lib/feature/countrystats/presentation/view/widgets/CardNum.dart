// lib/ui/components/card_num.dart
import 'package:flutter/material.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/color_scheme.dart'; // или используйте Theme.of(context)

class CardNum extends StatelessWidget {
  final int value;

  const CardNum(this.value, {super.key});

  @override
  Widget build(BuildContext context) {

    final formatted = '#${value.toString().padLeft(3, '0')}';

    return Container(

      decoration: BoxDecoration(
        color: cardNumColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 0.0,
      ),
      child: Text(
        formatted,
      ),
    );
  }
}