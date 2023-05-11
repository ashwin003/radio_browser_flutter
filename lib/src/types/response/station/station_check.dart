import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station_check.g.dart';

/// This struct is used in a represent an online check of a stream.
/// Most of the information got extracted by checking the http headers of the stream.
@JsonSerializable()
class StationCheck extends Equatable {
  /// An unique id for this StationCheck
  @JsonKey(name: "checkuuid")
  final String checkUUID;

  /// An unique id for referencing a Station
  @JsonKey(name: "stationuuid")
  final String stationUUID;

  /// DNS Name of the server that did the stream check.
  final String source;

  /// High level name of the used codec of the stream. May have the format AUDIO or AUDIO/VIDEO.
  final String codec;

  /// Bitrate 1000 bits per second (kBit/s) of the stream. (Audio + Video)
  final int bitrate;

  /// Mark if this stream is using HLS distribution or non-HLS.
  @JsonKey(fromJson: _intToBool)
  final bool hls;

  /// Whether or not the stream is reachable
  @JsonKey(fromJson: _intToBool)
  final bool ok;

  /// Date and time of check creation
  @JsonKey(name: "timestamp")
  final String timestamp;

  /// Date and time of check creation
  @JsonKey(name: "timestamp_iso8601")
  final String timestampISO;

  /// Direct stream url that has been resolved from the main stream url.
  /// HTTP redirects and playlists have been decoded. If hls==1 then this is still a HLS-playlist.
  @JsonKey(name: "urlcache")
  final String urlCache;

  /// Whether or not the stream has provided extended information and it should be used to override the local database
  @JsonKey(name: "metainfo_overrides_database", fromJson: _intToBool)
  final bool metainfoOverridesDatabase;

  /// Whether or not this stream appears in the public shoutcast/icecast directory
  @JsonKey(name: "public", fromJson: _intToBool)
  final bool isPublic;

  /// The name extracted from the stream header.
  @JsonKey(defaultValue: "")
  final String name;

  /// The description extracted from the stream header.
  @JsonKey(defaultValue: "")
  final String description;

  /// Komma separated list of tags. (genres of this stream)
  @JsonKey(fromJson: _splitByComma)
  final List<String> tags;

  /// Official countrycodes as in ISO 3166-1 alpha-2
  @JsonKey(name: "countrycode", defaultValue: "")
  final String countryCode;

  /// Official country subdivision codes as in ISO 3166-2
  @JsonKey(name: "countrysubdivisioncode", defaultValue: "")
  final String countrySubdivisionCode;

  /// The homepage extracted from the stream header.
  @JsonKey(name: "homepage", defaultValue: "")
  final String homePage;

  /// The favicon extracted from the stream header.
  @JsonKey(defaultValue: "")
  final String favicon;

  /// The loadbalancer extracted from the stream header
  @JsonKey(name: "loadbalancer", defaultValue: "")
  final String loadBalancer;

  /// The name of the server software used.
  @JsonKey(name: "server_software", defaultValue: "")
  final String serverSoftware;

  /// Audio sampling frequency in Hz
  final int? sampling;

  /// Timespan in miliseconds this check needed to be finished.
  @JsonKey(name: "timing_ms")
  final int timingMs;

  /// The description extracted from the stream header.
  @JsonKey(name: "languagecodes", fromJson: _splitByComma)
  final List<String> languageCodes;

  /// whether or not there was an ssl error while connecting to the stream url
  @JsonKey(fromJson: _intToBool)
  final bool sslError;

  /// Latitude on earth where the stream is located.
  @JsonKey(name: "geo_lat")
  final double? lattitude;

  /// Longitude on earth where the stream is located.
  @JsonKey(name: "geo_long")
  final double? longitude;

  const StationCheck(
    this.checkUUID,
    this.stationUUID,
    this.source,
    this.codec,
    this.bitrate,
    this.hls,
    this.ok,
    this.timestamp,
    this.timestampISO,
    this.urlCache,
    this.metainfoOverridesDatabase,
    this.isPublic,
    this.name,
    this.description,
    this.tags,
    this.countryCode,
    this.countrySubdivisionCode,
    this.homePage,
    this.favicon,
    this.loadBalancer,
    this.serverSoftware,
    this.sampling,
    this.timingMs,
    this.languageCodes,
    this.sslError,
    this.lattitude,
    this.longitude,
  );

  static List<String> _splitByComma(String? value) => value?.split(",") ?? [];

  static bool _intToBool(int? value) => value == 1;

  factory StationCheck.fromJson(Map<String, dynamic> json) =>
      _$StationCheckFromJson(json);

  Map<String, dynamic> toJson() => _$StationCheckToJson(this);

  @override
  List<Object?> get props => [
        checkUUID,
        stationUUID,
        source,
        codec,
        bitrate,
        hls,
        ok,
        timestamp,
        timestampISO,
        urlCache,
        metainfoOverridesDatabase,
        isPublic,
        name,
        description,
        tags,
        countryCode,
        countrySubdivisionCode,
        homePage,
        favicon,
        loadBalancer,
        serverSoftware,
        sampling,
        timingMs,
        languageCodes,
        sslError,
        lattitude,
        longitude,
      ];
}
