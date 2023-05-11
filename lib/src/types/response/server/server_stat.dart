import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server_stat.g.dart';

@JsonSerializable()
class ServerStat extends Equatable {
  @JsonKey(name: "supported_version")
  final int supportedVersion;

  @JsonKey(name: "software_version")
  final String softwareVersion;

  final String status;

  final int stations;

  @JsonKey(name: "stations_broken")
  final int brokenStations;

  final int tags;

  @JsonKey(name: "clicks_last_hour")
  final int lastHourClicks;

  @JsonKey(name: "clicks_last_day")
  final int lastDayClicks;

  final int languages;

  final int countries;

  const ServerStat(
    this.supportedVersion,
    this.softwareVersion,
    this.status,
    this.stations,
    this.brokenStations,
    this.tags,
    this.lastHourClicks,
    this.lastDayClicks,
    this.languages,
    this.countries,
  );

  factory ServerStat.fromJson(Map<String, dynamic> json) =>
      _$ServerStatFromJson(json);

  Map<String, dynamic> toJson() => _$ServerStatToJson(this);

  @override
  List<Object?> get props => [
        supportedVersion,
        softwareVersion,
        status,
        stations,
        brokenStations,
        tags,
        lastHourClicks,
        lastDayClicks,
        languages,
        countries,
      ];
}
