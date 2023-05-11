import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server_config.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ServerConfig extends Equatable {
  final bool checkEnabled;

  final bool prometheusExporterEnabled;

  final List<String> pullServers;

  final int tcpTimeoutSeconds;

  final int brokenStationsNeverWorkingTimeoutSeconds;

  final int brokenStationsTimeoutSeconds;

  final int checksTimeoutSeconds;

  final int clickValidTimeoutSeconds;

  final int clicksTimeoutSeconds;

  final int mirrorPullIntervalSeconds;

  final int updateCachesIntervalSeconds;

  final String serverName;

  final String serverLocation;

  final String serverCountryCode;

  final int checkRetries;

  final int checkBatchsize;

  final int checkPauseSeconds;

  final int apiThreads;

  final String cacheType;

  final int cacheTtl;

  const ServerConfig(
    this.checkEnabled,
    this.prometheusExporterEnabled,
    this.pullServers,
    this.tcpTimeoutSeconds,
    this.brokenStationsNeverWorkingTimeoutSeconds,
    this.brokenStationsTimeoutSeconds,
    this.checksTimeoutSeconds,
    this.clickValidTimeoutSeconds,
    this.clicksTimeoutSeconds,
    this.mirrorPullIntervalSeconds,
    this.updateCachesIntervalSeconds,
    this.serverName,
    this.serverLocation,
    this.serverCountryCode,
    this.checkRetries,
    this.checkBatchsize,
    this.checkPauseSeconds,
    this.apiThreads,
    this.cacheType,
    this.cacheTtl,
  );

  factory ServerConfig.fromJson(Map<String, dynamic> json) =>
      _$ServerConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ServerConfigToJson(this);

  @override
  List<Object?> get props => [
        checkEnabled,
        prometheusExporterEnabled,
        pullServers,
        tcpTimeoutSeconds,
        brokenStationsNeverWorkingTimeoutSeconds,
        brokenStationsTimeoutSeconds,
        checksTimeoutSeconds,
        clickValidTimeoutSeconds,
        clicksTimeoutSeconds,
        mirrorPullIntervalSeconds,
        updateCachesIntervalSeconds,
        serverName,
        serverLocation,
        serverCountryCode,
        checkRetries,
        checkBatchsize,
        checkPauseSeconds,
        apiThreads,
        cacheType,
        cacheTtl,
      ];
}
