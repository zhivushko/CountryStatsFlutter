// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indicator_row_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndicatorRowDto _$IndicatorRowDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('IndicatorRowDto', json, ($checkedConvert) {
  final val = IndicatorRowDto(
    indicator: $checkedConvert(
      'indicator',
      (v) => v == null
          ? null
          : IndicatorRefDto.fromJson(v as Map<String, dynamic>),
    ),
    country: $checkedConvert(
      'country',
      (v) =>
          v == null ? null : CountryRefDto.fromJson(v as Map<String, dynamic>),
    ),
    countryIso3Code: $checkedConvert('countryiso3code', (v) => v as String?),
    date: $checkedConvert('date', (v) => v as String?),
    value: $checkedConvert('value', (v) => v as num?),
  );
  return val;
}, fieldKeyMap: const {'countryIso3Code': 'countryiso3code'});

Map<String, dynamic> _$IndicatorRowDtoToJson(IndicatorRowDto instance) =>
    <String, dynamic>{
      'indicator': instance.indicator,
      'country': instance.country,
      'countryiso3code': instance.countryIso3Code,
      'date': instance.date,
      'value': instance.value,
    };

IndicatorRefDto _$IndicatorRefDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('IndicatorRefDto', json, ($checkedConvert) {
      final val = IndicatorRefDto(
        id: $checkedConvert('id', (v) => v as String?),
        value: $checkedConvert('value', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$IndicatorRefDtoToJson(IndicatorRefDto instance) =>
    <String, dynamic>{'id': instance.id, 'value': instance.value};

CountryRefDto _$CountryRefDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CountryRefDto', json, ($checkedConvert) {
      final val = CountryRefDto(
        id: $checkedConvert('id', (v) => v as String?),
        value: $checkedConvert('value', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$CountryRefDtoToJson(CountryRefDto instance) =>
    <String, dynamic>{'id': instance.id, 'value': instance.value};
