import 'package:json_annotation/json_annotation.dart';

part 'country_dto.g.dart';

@JsonSerializable()
class CountryDto {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'iso2Code')
  final String iso2Code;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'capitalCity')
  final String? capital;

  @JsonKey(name: 'region')
  final RegionDto? region;

  const CountryDto({
    required this.id,
    required this.iso2Code,
    required this.name,
    this.capital,
    this.region,
  });

  factory CountryDto.fromJson(Map<String, dynamic> json) =>
      _$CountryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CountryDtoToJson(this);

  bool get isAggregate => region?.value?.trim() == 'Aggregates';
}

@JsonSerializable()
class RegionDto {
  @JsonKey(name: 'value')
  final String? value;

  const RegionDto({this.value});

  factory RegionDto.fromJson(Map<String, dynamic> json) =>
      _$RegionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegionDtoToJson(this);
}
