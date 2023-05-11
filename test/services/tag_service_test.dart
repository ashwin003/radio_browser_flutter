import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_browser_flutter/src/services/implementations/tag_service.dart';
import 'package:radio_browser_flutter/src/services/tag_service.dart';
import 'package:radio_browser_flutter/src/types/response/tag.dart';

import 'tag_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String resourceUrl = 'json/tags';

  late TagService tagService;

  final tagJson = [
    {"name": "#", "stationcount": 4},
    {"name": "#101", "stationcount": 2}
  ];

  const tags = [
    Tag("#", 4),
    Tag("#101", 2),
  ];

  setUpAll(() {
    tagService = TagServiceImpl(dio: dio);
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
        data: tagJson,
        requestOptions: RequestOptions(
          path: resourceUrl,
        ),
      ),
    );

    expect(await tagService.fetch(), tags);

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
