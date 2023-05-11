import '../types/response/station/station_check.dart';
import '../types/response/station/station_check_step.dart';

abstract class StationCheckService {
  Future<List<StationCheck>> fetchCheckResults({
    String? stationUUID,
    String? lastCheckUUID,
    int seconds = 0,
    int limit = 999999,
  });

  Future<List<StationCheckStep>> fetchCheckSteps({
    required String? uuids,
  });
}
