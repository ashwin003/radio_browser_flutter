import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../url_type.dart';

part 'station_check_step.g.dart';

@JsonSerializable()
class StationCheckStep extends Equatable {
  /// An unique id for this StationCheckStep
  @JsonKey(name: "stepuuid")
  final String stepUUID;

  /// An unique id for referencing another StationCheckStep. Is set if this step has a parent.
  @JsonKey(name: "parent_stepuuid")
  final String? parentStepUUID;

  /// An unique id for referencing a StationCheck
  @JsonKey(name: "checkuuid")
  final String checkUUID;

  /// An unique id for referencing a Station
  @JsonKey(name: "stationuuid")
  final String stationUUID;

  /// The url that this step of the checking process handled
  final Uri url;

  /// Does represent which kind of url it is
  @JsonKey(name: "urltype")
  final UrlType? urlType;

  /// URL to the homepage of the stream, so you can direct the user to a page with more information about the stream.
  final Uri? error;

  @JsonKey(name: "creation_iso8601")
  final String creationISO;

  const StationCheckStep(
    this.stepUUID,
    this.parentStepUUID,
    this.checkUUID,
    this.stationUUID,
    this.url,
    this.urlType,
    this.error,
    this.creationISO,
  );

  factory StationCheckStep.fromJson(Map<String, dynamic> json) =>
      _$StationCheckStepFromJson(json);

  Map<String, dynamic> toJson() => _$StationCheckStepToJson(this);

  @override
  List<Object?> get props => [
        stepUUID,
        parentStepUUID,
        checkUUID,
        stationUUID,
        url,
        urlType,
        error,
        creationISO,
      ];
}
