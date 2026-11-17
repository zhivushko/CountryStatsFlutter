// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryDto _$CountryDtoFromJson(Map<String, dynamic> json) => CountryDto(
  id: json['id'] as String,
  iso2Code: json['iso2Code'] as String,
  name: json['name'] as String,
  capital: json['capitalCity'] as String?,
  region: json['region'] == null
      ? null
      : RegionDto.fromJson(json['region'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CountryDtoToJson(CountryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iso2Code': instance.iso2Code,
      'name': instance.name,
      'capitalCity': instance.capital,
      'region': instance.region,
    };

RegionDto _$RegionDtoFromJson(Map<String, dynamic> json) =>
    RegionDto(value: json['value'] as String?);

Map<String, dynamic> _$RegionDtoToJson(RegionDto instance) => <String, dynamic>{
  'value': instance.value,
};
