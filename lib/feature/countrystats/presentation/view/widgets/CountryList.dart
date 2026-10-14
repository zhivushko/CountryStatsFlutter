import 'package:flutter/material.dart';

import '../../model/CountryCardUI.dart';
import 'country_card.dart';

class CountryList extends StatelessWidget {
  final List<CountryCardUI> countries;
  final void Function(int id) onCountryClick;

  const CountryList({
    super.key,
    required this.countries,
    required this.onCountryClick,
  });

  @override
  Widget build(BuildContext context) {

    if (countries.isEmpty) {
      return Center(
        child: Text(
          'Нет результатов',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }


    return ListView.separated(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0),
      itemCount: countries.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final country = countries[index];
        return CountryCard(
          country: country,
          onClick: () => onCountryClick(country.id),
        );
      },
    );
  }
}