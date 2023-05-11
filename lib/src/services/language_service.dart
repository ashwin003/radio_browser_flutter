import '../types/request/sort_order.dart';
import '../types/response/language.dart';

abstract class LanguageService {
  Future<List<Language>> fetch({
    SortOrder order = SortOrder.name,
    bool reverse = false,
    bool hideBroken = false,
    int offset = 0,
    int limit = 100000,
  });
}
