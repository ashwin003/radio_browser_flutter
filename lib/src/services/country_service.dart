import '../types/request/sort_order.dart';
import '../types/response/country/country.dart';
import '../types/response/country/state.dart';

abstract class CountryService {
  Future<List<Country>> fetchCountries({
    SortOrder order = SortOrder.name,
    bool reverse = false,
    bool hideBroken = false,
    int offset = 0,
    int limit = 100000,
  });

  Future<List<RadioState>> fetchStates({
    SortOrder order = SortOrder.name,
    bool reverse = false,
    bool hideBroken = false,
    int offset = 0,
    int limit = 100000,
    String country = "",
  });
}
