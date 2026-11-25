import 'package:country_stats_flutter/feature/countrystats/data/Country.dart';

class CountryPage {
  final List<Country> items;
  final int page;
  final int total;
  final bool hasMore;
  final bool isGdpLoaded;

  const CountryPage({
    required this.items,
    required this.page,
    required this.total,
    required this.hasMore,
    required this.isGdpLoaded,
  });
}
