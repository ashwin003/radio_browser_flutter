import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_browser_flutter/src/services/implementations/language_service.dart';
import 'package:radio_browser_flutter/src/services/language_service.dart';
import 'package:radio_browser_flutter/src/types/response/language.dart';

import 'language_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String resourceUrl = 'json/languages';

  late LanguageService languageService;

  final languagesJson = [
    {"name": "aave", "iso_639": null, "stationcount": 1},
    {"name": "afrikaans", "iso_639": "af", "stationcount": 21}
  ];

  const languages = [
    Language("aave", null, 1),
    Language("afrikaans", "af", 21)
  ];

  setUpAll(() {
    languageService = LanguageServiceImpl(
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
        data: languagesJson,
        requestOptions: RequestOptions(
          path: resourceUrl,
        ),
      ),
    );

    expect(await languageService.fetch(), languages);

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
