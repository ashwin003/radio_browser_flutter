import 'package:dio/dio.dart';

abstract class ApiService {
  final Dio dio;

  ApiService({
    required this.dio,
  });

  bool _isEmpty(dynamic value) {
    if (value == null) {
      return true;
    }
    if (value is String) {
      return value.isEmpty;
    }
    return false;
  }

  Future<Response> _processRequestAsync(
    String requestUri,
    Map<String, dynamic> queryParameters,
  ) async {
    queryParameters.removeWhere((key, value) => _isEmpty(value));
    final response = await dio.get(
      requestUri,
      queryParameters: queryParameters,
    );
    if (response.statusCode != 200) {
      throw Error();
    }
    return response;
  }

  Future<Iterable> processListRequest(
    String resourceUri,
    Map<String, dynamic> queryParameters,
  ) async {
    final response = await _processRequestAsync(
      resourceUri,
      queryParameters,
    );
    return response.data;
  }

  Future<dynamic> processObjectRequest(
    String resourceUri,
    Map<String, dynamic> queryParameters,
  ) async {
    final response = await _processRequestAsync(
      resourceUri,
      queryParameters,
    );
    return response.data;
  }
}
