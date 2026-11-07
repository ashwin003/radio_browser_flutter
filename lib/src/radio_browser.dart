import 'package:dio/dio.dart';
import 'package:radio_browser_flutter/src/base_url/base_url.dart';
import 'package:radio_browser_flutter/src/services/implementations/index.dart';
import 'package:radio_browser_flutter/src/services/implementations/tag_service.dart';
import 'package:radio_browser_flutter/src/services/index.dart';

/// Radio Browser client instance
///
/// It must be initialized before being used, otherwise an error is thrown
///
/// Initialization:
/// ```dart
/// RadioBrowserClient.initialize(...)
/// ```
///
/// Usage:
///
/// final instance = RadioBrowserClient.instance;
class RadioBrowserClient {
  static Future<void> initialize(String userAgent) async {
    assert(!_instance._initialized, 'This instance is already initialized');
    await _instance._init(userAgent);
    _instance._initialized = true;
  }

  static RadioBrowserClient get instance {
    assert(_instance._initialized,
        'You must initialize Radio Browser client before accessing the instance');
    return _instance;
  }

  RadioBrowserClient._();
  static final RadioBrowserClient _instance = RadioBrowserClient._();

  bool _initialized = false;

  late CodecService codecs;

  late CountryService countries;

  late LanguageService languages;

  late ServerService servers;

  late TagService tags;

  late StationCheckService stationChecks;

  late StationService stations;

  Future<void> _init(String userAgent) async {
    final baseUrl = await fetchBaseUrl();
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          "User-Agent": userAgent,
        },
      ),
    );

    codecs = CodecServiceImpl(dio: dio);

    countries = CountryServiceImpl(dio: dio);

    languages = LanguageServiceImpl(dio: dio);

    servers = ServerServiceImpl(dio: dio);

    tags = TagServiceImpl(dio: dio);

    stationChecks = StationCheckServiceImpl(dio: dio);

    stations = StationServiceImpl(dio: dio);
  }
}
