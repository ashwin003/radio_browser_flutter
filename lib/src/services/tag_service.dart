import '../types/request/sort_order.dart';
import '../types/response/tag.dart';

abstract class TagService {
  Future<List<Tag>> fetch({
    SortOrder order = SortOrder.name,
    bool reverse = false,
    bool hideBroken = false,
    int offset = 0,
    int limit = 100000,
  });
}
