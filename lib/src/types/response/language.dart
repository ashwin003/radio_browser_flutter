import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class Language extends Equatable {
  final String name;

  @JsonKey(name: "iso_639")
  final String? languageCode;

  @JsonKey(name: "stationcount")
  final int stationCount;

  const Language(
    this.name,
    this.languageCode,
    this.stationCount,
  );

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  @override
  List<Object?> get props => [
        name,
        languageCode,
        stationCount,
      ];
}
