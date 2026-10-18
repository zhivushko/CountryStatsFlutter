import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';

class CountryCardUI {
  final int id;
  final String code;
  final String name;
  final num popularity;
  final num gdp;

  const CountryCardUI({
    required this.id,
    required this.code,
    required this.name,
    required this.popularity,
    required this.gdp,
  });
}

extension CountryToCardUI on Country {
  CountryCardUI toCardUI() => CountryCardUI(
    id: id,
    code: code,
    name: name,
    popularity: popularity,
    gdp: gdp,
  );
}


extension CountryListToCardsUI on List<Country> {
  List<CountryCardUI> toCardsUI() => map((c) => c.toCardUI()).toList();
}
