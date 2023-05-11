import 'package:radio_browser_flutter/src/types/response/station/index.dart';

import '../../types/request/sort_order.dart';
import '../station_service.dart';
import 'api_service.dart';

class StationServiceImpl extends ApiService implements StationService {
  StationServiceImpl({required super.dio});

  @override
  Future<List<Station>> fetch({
    SortOrder? order,
    bool? reverse,
    bool? hideBroken,
    int? offset,
    int? limit,
  }) async {
    Map<String, dynamic> queryParameters = {
      "order": order?.name,
      "reverse": reverse,
      "hidebroken": hideBroken,
      "offset": offset,
      "limit": limit
    };
    var response = await processListRequest('json/stations', queryParameters);
    return response.map((e) => Station.fromJson(e)).toList();
  }

  @override
  Future<StationClick> registerClick({required String stationUUID}) async {
    var response = await processObjectRequest('json/url/$stationUUID', {});
    return StationClick.fromJson(response);
  }

  @override
  Future<StationVote> registerVote({required String stationUUID}) async {
    var response = await processObjectRequest('json/vote/$stationUUID', {});
    return StationVote.fromJson(response);
  }

  @override
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
  }) async {
    Map<String, dynamic> queryParameters = {
      "name": name,
      "nameExact": nameExact,
      "country": country,
      "countryExact": countryExact,
      "countrycode": countryCode,
      "state": state,
      "stateExact": stateExact,
      "language": language,
      "languageExact": languageExact,
      "tag": tag,
      "tagExact": tagExact,
      "tagList": tagList,
      "codec": codec,
      "bitrateMin": minimumBitrate,
      "bitrateMax": maximumBitrate,
      "has_geo_info": hasGeoInfo,
      "has_extended_info": hasExtendedInfo,
      "is_https": isHTTPS,
      "order": order.name,
      "reverse": reverse,
      "hidebroken": hideBroken,
      "offset": offset,
      "limit": limit,
    };
    var response =
        await processListRequest('json/stations/search', queryParameters);
    return response.map((e) => Station.fromJson(e)).toList();
  }
}
