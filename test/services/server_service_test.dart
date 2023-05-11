import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_browser_flutter/src/services/implementations/server_service.dart';
import 'package:radio_browser_flutter/src/services/server_service.dart';
import 'package:radio_browser_flutter/src/types/response/server/server_config.dart';
import 'package:radio_browser_flutter/src/types/response/server/server_mirror.dart';
import 'package:radio_browser_flutter/src/types/response/server/server_stat.dart';

import 'server_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();

  late ServerService serverService;

  final statsJson = {
    "supported_version": 1,
    "software_version": "0.5.0",
    "status": "OK",
    "stations": 4047,
    "stations_broken": 45,
    "tags": 677,
    "clicks_last_hour": 65,
    "clicks_last_day": 1822,
    "languages": 59,
    "countries": 81
  };

  const stats = ServerStat(
    1,
    "0.5.0",
    "OK",
    4047,
    45,
    677,
    65,
    1822,
    59,
    81,
  );

  final mirrorsJson = [
    {"ip": "95.179.139.106", "name": "nl1.api.radio-browser.info"},
    {"ip": "89.58.16.19", "name": "at1.api.radio-browser.info"}
  ];

  const mirrors = [
    ServerMirror("95.179.139.106", "nl1.api.radio-browser.info"),
    ServerMirror("89.58.16.19", "at1.api.radio-browser.info")
  ];

  final configJson = {
    "check_enabled": false,
    "prometheus_exporter_enabled": true,
    "pull_servers": [
      "http://www.radio-browser.info/webservice",
      "http://de1.api.radio-browser.info"
    ],
    "tcp_timeout_seconds": 10,
    "broken_stations_never_working_timeout_seconds": 259200,
    "broken_stations_timeout_seconds": 2592000,
    "checks_timeout_seconds": 2592000,
    "click_valid_timeout_seconds": 86400,
    "clicks_timeout_seconds": 2592000,
    "mirror_pull_interval_seconds": 300,
    "update_caches_interval_seconds": 300,
    "server_name": "gaia",
    "server_location": "Datacenter 2 in coolstreet",
    "server_country_code": "DE",
    "check_retries": 5,
    "check_batchsize": 100,
    "check_pause_seconds": 60,
    "api_threads": 5,
    "cache_type": "redis",
    "cache_ttl": 60
  };

  const config = ServerConfig(
    false,
    true,
    [
      "http://www.radio-browser.info/webservice",
      "http://de1.api.radio-browser.info"
    ],
    10,
    259200,
    2592000,
    2592000,
    86400,
    2592000,
    300,
    300,
    "gaia",
    "Datacenter 2 in coolstreet",
    "DE",
    5,
    100,
    60,
    5,
    "redis",
    60,
  );

  setUpAll(() {
    serverService = ServerServiceImpl(dio: dio);
  });

  test("Should return the expected results - Server Stats", () async {
    when(
      dio.get(
        'json/stats',
        queryParameters: {},
        options: anyNamed('options'),
      ),
    ).thenAnswer(
      (realInvocation) async => Response(
        statusCode: 200,
        data: statsJson,
        requestOptions: RequestOptions(
          path: 'json/states',
        ),
      ),
    );

    expect(await serverService.fetchStats(), stats);

    verify(
      dio.get(
        'json/stats',
        queryParameters: {},
        options: anyNamed('options'),
      ),
    ).called(1);
  });

  test("Should return the expected results - Server Mirrors", () async {
    when(
      dio.get(
        'json/servers',
        queryParameters: {},
        options: anyNamed('options'),
      ),
    ).thenAnswer(
      (realInvocation) async => Response(
        statusCode: 200,
        data: mirrorsJson,
        requestOptions: RequestOptions(
          path: 'json/mirrors',
        ),
      ),
    );

    expect(await serverService.fetchMirrors(), mirrors);

    verify(
      dio.get(
        'json/servers',
        queryParameters: {},
        options: anyNamed('options'),
      ),
    ).called(1);
  });

  test("Should return the expected results - Server Config", () async {
    when(
      dio.get(
        'json/config',
        queryParameters: {},
        options: anyNamed('options'),
      ),
    ).thenAnswer(
      (realInvocation) async => Response(
        statusCode: 200,
        data: configJson,
        requestOptions: RequestOptions(
          path: 'json/mirrors',
        ),
      ),
    );

    expect(await serverService.fetchConfig(), config);

    verify(
      dio.get(
        'json/config',
        queryParameters: {},
        options: anyNamed('options'),
      ),
    ).called(1);
  });
}
