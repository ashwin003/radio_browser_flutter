import 'package:radio_browser_flutter/src/types/response/codec.dart';

import 'package:radio_browser_flutter/src/types/request/sort_order.dart';

import '../codec_service.dart';
import 'api_service.dart';

class CodecServiceImpl extends ApiService implements CodecService {
  final String _resourceUri = 'json/codecs';
  CodecServiceImpl({required super.dio});

  @override
  Future<List<Codec>> fetch({
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
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => Codec.fromJson(e)).toList();
  }
}
