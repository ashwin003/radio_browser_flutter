import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_browser_flutter/src/services/country_service.dart';
import 'package:radio_browser_flutter/src/services/implementations/country_service.dart';
import 'package:radio_browser_flutter/src/types/response/country/country.dart';
import 'package:radio_browser_flutter/src/types/response/country/state.dart';

import 'country_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();

  late CountryService countryService;

  final countryJson = [
    {"name": "Andorra", "iso_3166_1": "AD", "stationcount": 5},
    {"name": "Antarctica", "iso_3166_1": "AQ", "stationcount": 6}
  ];

  final countryStateJson = [
    {"name": " Zürich", "country": "Switzerland", "stationcount": 1},
    {"name": " Campania", "country": "Italy", "stationcount": 1}
  ];

  const countries = [
    Country("Andorra", "AD", 5),
    Country("Antarctica", "AQ", 6),
  ];

  const states = [
    RadioState(" Zürich", "Switzerland", 1),
    RadioState(" Campania", "Italy", 1),
  ];

  setUpAll(() {
    countryService = CountryServiceImpl(dio: dio);
  });

  test("Should return the expected results - Country", () async {
    when(
      dio.get(
        'json/countries',
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
        data: countryJson,
        requestOptions: RequestOptions(
          path: 'json/countries',
        ),
      ),
    );

    expect(await countryService.fetchCountries(), countries);

    verify(
      dio.get(
        'json/countries',
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

  test("Should return the expected results - Country States", () async {
    when(
      dio.get(
        'json/states',
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
        data: countryStateJson,
        requestOptions: RequestOptions(
          path: 'json/states',
        ),
      ),
    );

    expect(await countryService.fetchStates(), states);

    verify(
      dio.get(
        'json/states',
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
