import 'package:json_annotation/json_annotation.dart';

part 'indicator_row_dto.g.dart';

@JsonSerializable()
class IndicatorRowDto {
  @JsonKey(name: 'indicator')
  final IndicatorRefDto? indicator;

  @JsonKey(name: 'country')
  final CountryRefDto? country;

  @JsonKey(name: 'countryiso3code')
  final String? countryIso3Code;

  @JsonKey(name: 'date')
  final String? date;

  @JsonKey(name: 'value')
  final num? value;

  const IndicatorRowDto({
    this.indicator,
    this.country,
    this.countryIso3Code,
    this.date,
    this.value,
  });

  factory IndicatorRowDto.fromJson(Map<String, dynamic> json) =>
      _$IndicatorRowDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IndicatorRowDtoToJson(this);
}

@JsonSerializable()
class IndicatorRefDto {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'value')
  final String? value;

  const IndicatorRefDto({this.id, this.value});

  factory IndicatorRefDto.fromJson(Map<String, dynamic> json) =>
      _$IndicatorRefDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IndicatorRefDtoToJson(this);
}

@JsonSerializable()
class CountryRefDto {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'value')
  final String? value;

  const CountryRefDto({this.id, this.value});

  factory CountryRefDto.fromJson(Map<String, dynamic> json) =>
      _$CountryRefDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CountryRefDtoToJson(this);
}
