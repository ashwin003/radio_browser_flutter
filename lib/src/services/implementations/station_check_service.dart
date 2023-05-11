import 'package:radio_browser_flutter/src/types/response/station/station_check_step.dart';

import 'package:radio_browser_flutter/src/types/response/station/station_check.dart';

import '../station_check_service.dart';
import 'api_service.dart';

class StationCheckServiceImpl extends ApiService
    implements StationCheckService {
  StationCheckServiceImpl({required super.dio});

  @override
  Future<List<StationCheck>> fetchCheckResults({
    String? stationUUID,
    String? lastCheckUUID,
    int seconds = 0,
    int limit = 999999,
  }) async {
    Map<String, dynamic> queryParameters = {
      "stationuuid": stationUUID,
      "lastcheckuuid": lastCheckUUID,
      "seconds": seconds,
      "limit": limit
    };
    var response = await processListRequest('json/checks', queryParameters);
    return response.map((e) => StationCheck.fromJson(e)).toList();
  }

  @override
  Future<List<StationCheckStep>> fetchCheckSteps(
      {required String? uuids}) async {
    Map<String, dynamic> queryParameters = {
      "uuids": uuids,
    };
    var response = await processListRequest('json/checksteps', queryParameters);
    return response.map((e) => StationCheckStep.fromJson(e)).toList();
  }
}
