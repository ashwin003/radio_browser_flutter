import 'package:radio_browser_flutter/src/types/response/tag.dart';

import 'package:radio_browser_flutter/src/types/request/sort_order.dart';

import '../tag_service.dart';
import 'api_service.dart';

class TagServiceImpl extends ApiService implements TagService {
  TagServiceImpl({required super.dio});

  @override
  Future<List<Tag>> fetch({
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
    final response = await processListRequest('json/tags', queryParameters);
    return response.map((e) => Tag.fromJson(e)).toList();
  }
}
