import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag extends Equatable {
  final String name;
  @JsonKey(name: "stationcount")
  final int stationCount;

  const Tag(
    this.name,
    this.stationCount,
  );

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);

  @override
  List<Object?> get props => [
        name,
        stationCount,
      ];
}
