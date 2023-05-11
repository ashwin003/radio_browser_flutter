import '../types/response/server/server_config.dart';
import '../types/response/server/server_mirror.dart';
import '../types/response/server/server_stat.dart';

abstract class ServerService {
  Future<ServerStat> fetchStats();

  Future<List<ServerMirror>> fetchMirrors();

  Future<ServerConfig> fetchConfig();
}
