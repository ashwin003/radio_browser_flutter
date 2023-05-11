import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station_vote.g.dart';

@JsonSerializable()
class StationVote extends Equatable {
  @JsonKey(fromJson: _stringToBool)
  final bool ok;

  final String message;

  const StationVote(
    this.ok,
    this.message,
  );

  static bool _stringToBool(String value) => value == "true";

  factory StationVote.fromJson(Map<String, dynamic> json) =>
      _$StationVoteFromJson(json);

  Map<String, dynamic> toJson() => _$StationVoteToJson(this);

  @override
  List<Object?> get props => [
        ok,
        message,
      ];
}
