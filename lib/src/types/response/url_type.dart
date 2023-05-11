import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum UrlType {
  @JsonValue("STREAM")
  strean,
  @JsonValue("REDIRECT")
  redirect,
  @JsonValue("PLAYLIST")
  playlist
}
