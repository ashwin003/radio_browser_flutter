import '../../types/response/server/server_stat.dart';
import '../../types/response/server/server_mirror.dart';
import '../../types/response/server/server_config.dart';

import '../server_service.dart';
import 'api_service.dart';

class ServerServiceImpl extends ApiService implements ServerService {
  ServerServiceImpl({required super.dio});

  @override
  Future<ServerConfig> fetchConfig() async {
    final response = await processObjectRequest('json/config', {});
    return ServerConfig.fromJson(response);
  }

  @override
  Future<List<ServerMirror>> fetchMirrors() async {
    final response = await processListRequest('json/servers', {});
    return response.map((e) => ServerMirror.fromJson(e)).toList();
  }

  @override
  Future<ServerStat> fetchStats() async {
    final response = await processObjectRequest('json/stats', {});
    return ServerStat.fromJson(response);
  }
}
