// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryDto _$CountryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CountryDto', json, ($checkedConvert) {
      final val = CountryDto(
        id: $checkedConvert('id', (v) => v as String),
        iso2Code: $checkedConvert('iso2Code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        capital: $checkedConvert('capitalCity', (v) => v as String?),
        region: $checkedConvert(
          'region',
          (v) =>
              v == null ? null : RegionDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'capital': 'capitalCity'});

Map<String, dynamic> _$CountryDtoToJson(CountryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iso2Code': instance.iso2Code,
      'name': instance.name,
      'capitalCity': instance.capital,
      'region': instance.region,
    };

RegionDto _$RegionDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'RegionDto',
  json,
  ($checkedConvert) {
    final val = RegionDto(value: $checkedConvert('value', (v) => v as String?));
    return val;
  },
);

Map<String, dynamic> _$RegionDtoToJson(RegionDto instance) => <String, dynamic>{
  'value': instance.value,
};
