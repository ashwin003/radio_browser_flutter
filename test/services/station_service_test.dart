import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_browser_flutter/src/services/implementations/station_service.dart';
import 'package:radio_browser_flutter/src/services/station_service.dart';
import 'package:radio_browser_flutter/src/types/response/station/station.dart';

import 'station_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();

  late StationService stationService;

  final stationJson = {
    "changeuuid": "37db7735-3c86-4f5e-937a-642a8f0dbdb5",
    "stationuuid": "9615d27a-0601-11e8-ae97-52543be04c81",
    "serveruuid": null,
    "name": "ABC NewsRadio MP3",
    "url": "http://www.abc.net.au/res/streaming/audio/mp3/news_radio.pls",
    "url_resolved": "http://live-radio02.mediahubaustralia.com/PBW/mp3/",
    "homepage": "http://www.abc.net.au/newsradio/",
    "favicon": "http://www.abc.net.au/news-web/assets/touchicon.png",
    "tags": "abc,news,newsradio,public radio",
    "country": "Australia",
    "countrycode": "AU",
    "iso_3166_2": null,
    "state": "",
    "language": "english",
    "languagecodes": "en",
    "votes": 3148,
    "lastchangetime": "2022-10-01 06:58:25",
    "lastchangetime_iso8601": "2022-10-01T06:58:25Z",
    "codec": "MP3",
    "bitrate": 96,
    "hls": 0,
    "lastcheckok": 1,
    "lastchecktime": "2022-11-30 13:11:30",
    "lastchecktime_iso8601": "2022-11-30T13:11:30Z",
    "lastcheckoktime": "2022-11-30 13:11:30",
    "lastcheckoktime_iso8601": "2022-11-30T13:11:30Z",
    "lastlocalchecktime": "2022-11-29 21:13:48",
    "lastlocalchecktime_iso8601": "2022-11-29T21:13:48Z",
    "clicktimestamp": "2022-11-30 15:25:47",
    "clicktimestamp_iso8601": "2022-11-30T15:25:47Z",
    "clickcount": 366,
    "clicktrend": 8,
    "ssl_error": 0,
    "geo_lat": null,
    "geo_long": null,
    "has_extended_info": false
  };

  Station station = Station(
    "37db7735-3c86-4f5e-937a-642a8f0dbdb5",
    "9615d27a-0601-11e8-ae97-52543be04c81",
    "",
    "ABC NewsRadio MP3",
    Uri.parse("http://www.abc.net.au/res/streaming/audio/mp3/news_radio.pls"),
    Uri.parse("http://live-radio02.mediahubaustralia.com/PBW/mp3/"),
    Uri.parse("http://www.abc.net.au/newsradio/"),
    Uri.parse("http://www.abc.net.au/news-web/assets/touchicon.png"),
    "abc,news,newsradio,public radio".split(","),
    "Australia",
    "AU",
    "",
    "english".split(","),
    "en".split(","),
    3148,
    "2022-10-01 06:58:25",
    "2022-10-01 06:58:25",
    "MP3",
    96,
    false,
    true,
    "2022-11-30 13:11:30",
    "2022-11-30T13:11:30Z",
    "2022-11-30 13:11:30",
    "2022-11-30T13:11:30Z",
    "2022-11-29 21:13:48",
    "2022-11-29T21:13:48Z",
    "2022-11-30 15:25:47",
    "2022-11-30T15:25:47Z",
    366,
    8,
    false,
    null,
    null,
    false,
  );

  setUpAll(() {
    stationService = StationServiceImpl(dio: dio);
  });

  test('Should return the expected results - Search', () async {
    when(
      dio.get(
        'json/stations/search',
        queryParameters: {
          "bitrateMin": 0,
          "bitrateMax": 1000000,
          "order": "name",
          "reverse": false,
          "hidebroken": false,
          "offset": 0,
          "limit": 100000,
        },
        options: anyNamed('options'),
      ),
    ).thenAnswer(
      (realInvocation) async => Response(
        statusCode: 200,
        data: [stationJson],
        requestOptions: RequestOptions(
          path: 'json/stations/search',
        ),
      ),
    );

    expect(await stationService.search(), [station]);

    verify(
      dio.get(
        'json/stations/search',
        queryParameters: {"seconds": 0, "limit": 999999},
        options: anyNamed('options'),
      ),
    ).called(1);
  });
}
