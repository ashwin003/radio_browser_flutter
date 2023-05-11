import 'package:radio_browser_flutter/src/types/response/country/state.dart';

import 'package:radio_browser_flutter/src/types/response/country/country.dart';

import 'package:radio_browser_flutter/src/types/request/sort_order.dart';

import '../country_service.dart';
import 'api_service.dart';

class CountryServiceImpl extends ApiService implements CountryService {
  CountryServiceImpl({required super.dio});

  @override
  Future<List<Country>> fetchCountries({
    SortOrder order = SortOrder.name,
    bool reverse = false,
    bool hideBroken = false,
    int offset = 0,
    int limit = 100000,
  }) async {
    Map<String, dynamic> queryParameters = {
      "order": order.name,
      "reverse": reverse,
      "hidebroken": hideBroken,
      "offset": offset,
      "limit": limit
    };
    var response = await processListRequest('json/countries', queryParameters);
    return response.map((e) => Country.fromJson(e)).toList();
  }

  @override
  Future<List<RadioState>> fetchStates({
    SortOrder order = SortOrder.name,
    bool reverse = false,
    bool hideBroken = false,
    int offset = 0,
    int limit = 100000,
    String country = "",
  }) async {
    Map<String, dynamic> queryParameters = {
      "order": order.name,
      "reverse": reverse,
      "hidebroken": hideBroken,
      "offset": offset,
      "limit": limit,
      "country": country
    };
    var response = await processListRequest('json/states', queryParameters);
    return response.map((e) => RadioState.fromJson(e)).toList();
  }
}
