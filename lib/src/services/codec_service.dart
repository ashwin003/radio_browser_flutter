import '../types/request/sort_order.dart';
import '../types/response/codec.dart';

abstract class CodecService {
  Future<List<Codec>> fetch({
    SortOrder order = SortOrder.name,
    bool reverse = false,
    bool hideBroken = false,
    int offset = 0,
    int limit = 100000,
  });
}
