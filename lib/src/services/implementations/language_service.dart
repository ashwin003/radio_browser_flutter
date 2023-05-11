import '../../types/response/language.dart';
import '../../types/request/sort_order.dart';
import '../language_service.dart';
import 'api_service.dart';

class LanguageServiceImpl extends ApiService implements LanguageService {
  final String _resourceUri = 'json/languages';
  LanguageServiceImpl({required super.dio});

  @override
  Future<List<Language>> fetch({
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
    return response.map((e) => Language.fromJson(e)).toList();
  }
}
