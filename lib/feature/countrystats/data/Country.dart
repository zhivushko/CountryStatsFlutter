class Country {
  final String id;
  final String isoCode;
  final String name;
  // в апишке не у всех стран есть население
  final int? popularity;
  final String? capital;
  final String? region;
  final double? urbTot;
  final double? rurTot;
  final int? gdp;

  const Country({
    required this.id,
    required this.isoCode,
    required this.name,
    this.popularity,
    this.capital,
    this.region,
    this.urbTot,
    this.rurTot,
    this.gdp,
  });

  Country copyWith({
    int? popularity,
    int? gdp,
    double? urbTot,
    double? rurTot,
  }) {
    return Country(
      id: id,
      isoCode: isoCode,
      name: name,
      popularity: popularity ?? this.popularity,
      capital: capital,
      region: region,
      urbTot: urbTot ?? this.urbTot,
      rurTot: rurTot ?? this.rurTot,
      gdp: gdp ?? this.gdp,
    );
  }
}
