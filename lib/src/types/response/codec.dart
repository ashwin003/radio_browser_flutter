import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'codec.g.dart';

@JsonSerializable()
class Codec extends Equatable {
  final String name;
  @JsonKey(name: "stationcount")
  final int stationCount;

  const Codec(
    this.name,
    this.stationCount,
  );

  factory Codec.fromJson(Map<String, dynamic> json) => _$CodecFromJson(json);

  Map<String, dynamic> toJson() => _$CodecToJson(this);

  @override
  List<Object?> get props => [
        name,
        stationCount,
      ];
}
