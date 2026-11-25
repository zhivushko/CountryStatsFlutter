
import 'package:flutter/material.dart';
import 'package:country_stats_flutter/common/theme/color_scheme.dart';

class CardID extends StatelessWidget {
  final String value;

  const CardID(this.value, {super.key});

  @override
  Widget build(BuildContext context) {

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
        value
      ),
    );
  }
}