import '../types/response/station/station_vote.dart';
import '../types/request/sort_order.dart';
import '../types/response/station/station.dart';
import '../types/response/station/station_click.dart';

abstract class StationService {
  Future<List<Station>> fetch({
    SortOrder? order,
    bool? reverse,
    bool? hideBroken,
    int? offset,
    int? limit,
  });

  Future<List<Station>> search({
    String? name,
    bool? nameExact,
    String? country,
    bool? countryExact,
    String? countryCode,
    String? state,
    bool? stateExact,
    String? language,
    bool? languageExact,
    String? tag,
    bool? tagExact,
    String? tagList,
    String? codec,
    int minimumBitrate = 0,
    int maximumBitrate = 1000000,
    bool? hasGeoInfo,
    bool? hasExtendedInfo,
    bool? isHTTPS,
    StationSortOrder order = StationSortOrder.name,
    bool reverse = false,
    bool hideBroken = false,
    int offset = 0,
    int limit = 100000,
  });

  Future<StationClick> registerClick({
    required String stationUUID,
  });

  Future<StationVote> registerVote({
    required String stationUUID,
  });
}
