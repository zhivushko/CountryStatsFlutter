class Country {
  final int id;
  final String code;
  final String name;
  final String capital;
  final String region;
  final int popularity;
  final double urbTot;
  final double rurTot;
  final int gdp;

  const Country({
    required this.id,
    required this.code,
    required this.name,
    required this.capital,
    required this.region,
    required this.popularity,
    required this.urbTot,
    required this.rurTot,
    required this.gdp,
  });
}