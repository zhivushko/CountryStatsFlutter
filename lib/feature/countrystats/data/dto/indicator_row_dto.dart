class IndicatorRowDto {
  final String indicatorId;
  final String countryCode;
  final String? countryIso3Code;
  final String? date;
  final num? value;

  const IndicatorRowDto({
    required this.indicatorId,
    required this.countryCode,
    this.countryIso3Code,
    this.date,
    this.value,
  });

  factory IndicatorRowDto.fromJson(Map<String, dynamic> json) {
    final indicator = json['indicator'];
    final country = json['country'];

    return IndicatorRowDto(
      indicatorId: indicator is Map<String, dynamic>
          ? '${indicator['id'] ?? ''}'
          : '',
      countryCode: country is Map<String, dynamic>
          ? '${country['id'] ?? ''}'
          : '',
      countryIso3Code: json['countryiso3code'] as String?,
      date: json['date'] as String?,
      value: _asNum(json['value']),
    );
  }

  static num? _asNum(Object? raw) {
    if (raw is num) return raw;
    if (raw is String) return num.tryParse(raw);
    return null;
  }
}
