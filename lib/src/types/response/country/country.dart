import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country extends Equatable {
  final String name;

  @JsonKey(name: "iso_3166_1")
  final String countryCode;

  @JsonKey(name: "stationcount")
  final int stationCount;

  const Country(
    this.name,
    this.countryCode,
    this.stationCount,
  );

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  List<Object?> get props => [
        name,
        countryCode,
        stationCount,
      ];
}
