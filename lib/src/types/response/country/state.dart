import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class RadioState extends Equatable {
  final String name;

  final String country;

  @JsonKey(name: "stationcount")
  final int stationCount;

  const RadioState(
    this.name,
    this.country,
    this.stationCount,
  );

  factory RadioState.fromJson(Map<String, dynamic> json) =>
      _$RadioStateFromJson(json);

  Map<String, dynamic> toJson() => _$RadioStateToJson(this);

  @override
  List<Object?> get props => [
        name,
        country,
        stationCount,
      ];
}
