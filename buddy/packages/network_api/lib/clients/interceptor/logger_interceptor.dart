import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioLoggerInterceptor extends InterceptorsWrapper {
  final logger = PrettyDioLogger(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
    maxWidth: 120,
  );

  DioLoggerInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    try {
      logger.onRequest(options, handler);
    } catch (_) {
      super.onRequest(options, handler);
    }
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      logger.onError(err, handler);
    } catch (_) {
      return super.onError(err, handler);
    }
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    try {
      logger.onResponse(response, handler);
    } catch (_) {
      return super.onResponse(response, handler);
    }
  }
}
