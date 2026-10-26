import 'package:flutter/material.dart';
import 'CardNum.dart';
import 'CardSurface.dart';
import 'CardStat.dart';
import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';

class CountryCard extends StatelessWidget {
  final Country country;
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
          const SizedBox(height: 10.0),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardStat(
                icon: const Icon(Icons.people),
                value: country.popularity,
              ),
              CardStat(
                icon: const Icon(Icons.attach_money),
                value: country.gdp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}