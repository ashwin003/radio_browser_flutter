import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_browser_flutter/src/services/implementations/station_check_service.dart';
import 'package:radio_browser_flutter/src/services/station_check_service.dart';
import 'package:radio_browser_flutter/src/types/response/station/station_check.dart';
import 'package:radio_browser_flutter/src/types/response/station/station_check_step.dart';
import 'package:radio_browser_flutter/src/types/response/url_type.dart';

import 'station_check_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();

  late StationCheckService stationCheckService;

  final checkJson = {
    "stationuuid": "e37ca106-4aa7-48dc-8862-1af602d49101",
    "checkuuid": "d8ccf920-be6b-4da8-ba1a-95b8676b288e",
    "source": "nl1.api.radio-browser.info",
    "codec": "AAC",
    "bitrate": 0,
    "hls": 0,
    "ok": 1,
    "timestamp_iso8601": "2022-11-29T04:36:28",
    "timestamp": "2022-11-29 04:36:28",
    "urlcache":
        "http://stream-47.zeno.fm/3khgtfrpktzuv?zs=FLhWfEZmRe2yIHOFMu26yA",
    "metainfo_overrides_database": 0,
    "public": null,
    "name": "RadioTV-ESN",
    "description": null,
    "tags": null,
    "countrycode": null,
    "homepage": null,
    "favicon": null,
    "loadbalancer": null,
    "do_not_index": null,
    "countrysubdivisioncode": null,
    "server_software": null,
    "sampling": null,
    "timing_ms": 422,
    "languagecodes": "",
    "ssl_error": 0,
    "geo_lat": null,
    "geo_long": null
  };

  const stationCheck = StationCheck(
    "d8ccf920-be6b-4da8-ba1a-95b8676b288e",
    "e37ca106-4aa7-48dc-8862-1af602d49101",
    "nl1.api.radio-browser.info",
    "AAC",
    0,
    false,
    true,
    "2022-11-29 04:36:28",
    "2022-11-29T04:36:28",
    "http://stream-47.zeno.fm/3khgtfrpktzuv?zs=FLhWfEZmRe2yIHOFMu26yA",
    false,
    false,
    "RadioTV-ESN",
    "",
    [],
    "",
    "",
    "",
    "",
    "",
    "",
    null,
    422,
    [],
    false,
    null,
    null,
  );

  final checkStepJson = {
    "stepuuid": "d8ccf920-be6b-4da8-ba1a-95b8676b288e",
    "parent_stepuuid": "e37ca106-4aa7-48dc-8862-1af602d49101",
    "checkuuid": "d8ccf920-be6b-4da8-ba1a-95b8676b288e",
    "stationuuid": "e37ca106-4aa7-48dc-8862-1af602d49101",
    "url": "http://stream-47.zeno.fm/3khgtfrpktzuv?zs=FLhWfEZmRe2yIHOFMu26yA",
    "urltype": "REDIRECT",
    "error": "http://stream-47.zeno.fm/3khgtfrpktzuv?zs=FLhWfEZmRe2yIHOFMu26yA",
    "creation_iso8601": "2022-11-29T04:36:28",
  };

  StationCheckStep checkStep = StationCheckStep(
    "d8ccf920-be6b-4da8-ba1a-95b8676b288e",
    "e37ca106-4aa7-48dc-8862-1af602d49101",
    "d8ccf920-be6b-4da8-ba1a-95b8676b288e",
    "e37ca106-4aa7-48dc-8862-1af602d49101",
    Uri.parse(
        "http://stream-47.zeno.fm/3khgtfrpktzuv?zs=FLhWfEZmRe2yIHOFMu26yA"),
    UrlType.redirect,
    Uri.parse(
        "http://stream-47.zeno.fm/3khgtfrpktzuv?zs=FLhWfEZmRe2yIHOFMu26yA"),
    "2022-11-29T04:36:28",
  );

  setUpAll(() {
    stationCheckService = StationCheckServiceImpl(dio: dio);
  });

  test('Should return the expected results - Station Checks', () async {
    when(
      dio.get(
        'json/checks',
        queryParameters: {"seconds": 0, "limit": 999999},
        options: anyNamed('options'),
      ),
    ).thenAnswer(
      (realInvocation) async => Response(
        statusCode: 200,
        data: [checkJson],
        requestOptions: RequestOptions(
          path: 'json/checks',
        ),
      ),
    );

    expect(await stationCheckService.fetchCheckResults(), [stationCheck]);

    verify(
      dio.get(
        'json/checks',
        queryParameters: {"seconds": 0, "limit": 999999},
        options: anyNamed('options'),
      ),
    ).called(1);
  });

  test('Should return the expected results - Station Check Steps', () async {
    when(
      dio.get(
        'json/checksteps',
        queryParameters: {"uuids": "d8ccf920-be6b-4da8-ba1a-95b8676b288e"},
        options: anyNamed('options'),
      ),
    ).thenAnswer(
      (realInvocation) async => Response(
        statusCode: 200,
        data: [checkStepJson],
        requestOptions: RequestOptions(
          path: 'json/checksteps',
        ),
      ),
    );

    expect(
        await stationCheckService.fetchCheckSteps(
            uuids: "d8ccf920-be6b-4da8-ba1a-95b8676b288e"),
        [checkStep]);

    verify(
      dio.get(
        'json/checksteps',
        queryParameters: {"uuids": "d8ccf920-be6b-4da8-ba1a-95b8676b288e"},
        options: anyNamed('options'),
      ),
    ).called(1);
  });
}
