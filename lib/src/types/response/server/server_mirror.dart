import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server_mirror.g.dart';

@JsonSerializable()
class ServerMirror extends Equatable {
  final String ip;
  final String name;

  const ServerMirror(
    this.ip,
    this.name,
  );

  factory ServerMirror.fromJson(Map<String, dynamic> json) =>
      _$ServerMirrorFromJson(json);

  Map<String, dynamic> toJson() => _$ServerMirrorToJson(this);

  @override
  List<Object?> get props => [
        ip,
        name,
      ];
}
