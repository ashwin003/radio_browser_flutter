import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_browser_flutter/src/services/codec_service.dart';
import 'package:radio_browser_flutter/src/services/implementations/index.dart';
import 'package:radio_browser_flutter/src/types/response/codec.dart';

import 'codec_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String resourceUrl = 'json/codecs';

  late CodecService codecService;

  final codecsJson = [
    {"name": "AAC", "stationcount": 3091},
    {"name": "AAC+", "stationcount": 6118},
  ];

  const codecs = [
    Codec("AAC", 3091),
    Codec("AAC+", 6118),
  ];

  setUpAll(() {
    codecService = CodecServiceImpl(
      dio: dio,
    );
  });

  test("Should return the expected results", () async {
    when(
      dio.get(
        resourceUrl,
        queryParameters: {
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
        data: codecsJson,
        requestOptions: RequestOptions(
          path: resourceUrl,
        ),
      ),
    );

    expect(await codecService.fetch(), codecs);

    verify(
      dio.get(
        resourceUrl,
        queryParameters: {
          "order": "name",
          "reverse": false,
          "hidebroken": false,
          "offset": 0,
          "limit": 100000,
        },
        options: anyNamed('options'),
      ),
    ).called(1);
  });
}
