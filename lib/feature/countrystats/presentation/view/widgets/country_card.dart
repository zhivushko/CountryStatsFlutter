// lib/ui/components/country_card.dart
import 'package:flutter/material.dart';
import 'CardNum.dart';
import 'CardSurface.dart';
import 'CardStat.dart';
import 'package:country_stats_flutter/feature/countrystats/presentation/model/CountryCardUI.dart';

class CountryCard extends StatelessWidget {
  final CountryCardUI country;
  final VoidCallback? onClick;

  const CountryCard({
    super.key,
    required this.country,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return CardSurface(
      onTap: onClick,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              CardNum(country.id),
              const SizedBox(width: 12.0),
              Text(country.code),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  country.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0), // spacedBy(10.dp) между Row


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardStat(
                icon: const Icon(Icons.people), // emoji_people
                value: country.popularity,
              ),
              CardStat(
                icon: const Icon(Icons.attach_money), // attach_money
                value: country.gdp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}