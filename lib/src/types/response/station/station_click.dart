import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station_click.g.dart';

@JsonSerializable()
class StationClick extends Equatable {
  @JsonKey(fromJson: _stringToBool)
  final bool ok;

  final String message;

  @JsonKey(name: "stationuuid")
  final String stationUUID;

  final Uri url;

  const StationClick(
    this.ok,
    this.message,
    this.stationUUID,
    this.url,
  );

  static bool _stringToBool(String value) => value == "true";

  factory StationClick.fromJson(Map<String, dynamic> json) =>
      _$StationClickFromJson(json);

  Map<String, dynamic> toJson() => _$StationClickToJson(this);

  @override
  List<Object?> get props => [
        ok,
        message,
        stationUUID,
        url,
      ];
}
