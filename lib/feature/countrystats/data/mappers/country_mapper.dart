import 'package:country_stats_flutter/feature/countrystats/data/dto/country_dto.dart';
import 'package:country_stats_flutter/feature/countrystats/data/Country.dart' ;

extension CountryDtoMapper on CountryDto {
  Country toModel({int? popularity, int? gdp, double? urbTot, double? rurTot}) {
    final capitalName = _nonEmpty(capital);
    final regionName = _nonEmpty(region?.value);

    return Country(
      id: id.trim(),
      isoCode: iso2Code.trim(),
      name: name.trim(),
      capital: capitalName,
      region: regionName,
      popularity: popularity,
      gdp: gdp,
      urbTot: urbTot,
      rurTot: rurTot,
    );
  }

  static String? _nonEmpty(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
