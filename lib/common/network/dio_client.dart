import 'package:dio/dio.dart';

Dio createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.worldbank.org/v2',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),

      queryParameters: {'format': 'json'},
    ),
  );


  dio.interceptors.add(LogInterceptor(responseBody: true));

  return dio;
}