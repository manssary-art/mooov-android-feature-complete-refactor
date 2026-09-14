import 'dart:async';

import 'package:dio/dio.dart';

import 'interceptor/auth_interceptor.dart';
import 'interceptor/client_info_interceptor.dart';
import 'interceptor/logger_interceptor.dart';

class DioClient {
  static FutureOr<Dio> authedClient({
    required String baseUrl,
  }) async {
    final options = BaseOptions(
      responseType: ResponseType.json,
      baseUrl: baseUrl ?? "",
    );

    final dio = Dio(options);
    dio.interceptors.addAll([
      DioClientInfoInterceptor(),
      DioAuthInterceptor(dio),
      DioLoggerInterceptor(),
    ]);

    return dio;
  }

  static FutureOr<Dio> unAuthedClient({
    String? baseUrl,
  }) async {
    final options = BaseOptions(
      responseType: ResponseType.json,
      baseUrl: baseUrl ?? "",
    );

    final dio = Dio(options);
    dio.interceptors.addAll([
      DioLoggerInterceptor(),
    ]);

    return dio;
  }
}
