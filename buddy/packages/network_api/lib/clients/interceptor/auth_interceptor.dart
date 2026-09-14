import 'package:dio/dio.dart';

class DioAuthInterceptor extends Interceptor {
  static const _retryKey = 'auth_interceptor_retry';

  static Future<String?> Function(bool force) getAccessToken = (_) => Future.value(null);

  final Dio httpClient;

  DioAuthInterceptor(this.httpClient);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final currentToken = await _onGetToken(false);
    final headers = options.headers;
    headers.addAll(_applyToken(currentToken));
    options.headers = headers;

    if (!options.extra.containsKey(_retryKey)) {
      final extras = options.extra;
      extras[_retryKey] = 0;
      options.extra = extras;
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    int attempt = 0;
    final extras = response.requestOptions.extra;
    attempt = (extras[_retryKey] as int?) ?? 0;
    if (!_onShouldRefresh(response, attempt)) {
      handler.next(response);
      return;
    }

    handler.next(await _tryRefresh(response, attempt));
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    int attempt = 0;
    if (err.response?.requestOptions.extra != null) {
      final extras = err.response?.requestOptions.extra ?? <String, dynamic>{};
      attempt = (extras[_retryKey] as int?) ?? 0;
    }

    final Response? response = err.response;
    if (response == null || !_onShouldRefresh(response, attempt)) {
      handler.next(err);
      return;
    }

    handler.resolve(await _tryRefresh(response, attempt));
  }

  Future<dynamic> _tryRefresh(Response response, int attempt) async {
    String? refreshedToken;
    try {
      refreshedToken = await _onGetToken(true);
      if (refreshedToken == null) {
        throw Exception('Not authenticated');
      }
    } catch (error) {
      return DioError(
        error: error,
        requestOptions: response.requestOptions,
        response: response,
      );
    }

    final extras = response.requestOptions.extra;
    extras[_retryKey] = attempt + 1;
    response.requestOptions.extra = extras;

    final headers = response.requestOptions.headers;
    headers.addAll(_applyToken(refreshedToken));
    response.requestOptions.headers = headers;

    return await httpClient.request<dynamic>(
      response.requestOptions.path,
      cancelToken: response.requestOptions.cancelToken,
      data: response.requestOptions.data,
      onReceiveProgress: response.requestOptions.onReceiveProgress,
      onSendProgress: response.requestOptions.onSendProgress,
      queryParameters: response.requestOptions.queryParameters,
      options: Options(
        method: response.requestOptions.method,
        sendTimeout: response.requestOptions.sendTimeout,
        receiveTimeout: response.requestOptions.receiveTimeout,
        extra: response.requestOptions.extra,
        headers: response.requestOptions.headers,
        responseType: response.requestOptions.responseType,
        contentType: response.requestOptions.contentType,
        validateStatus: response.requestOptions.validateStatus,
        receiveDataWhenStatusError: response.requestOptions.receiveDataWhenStatusError,
        followRedirects: response.requestOptions.followRedirects,
        maxRedirects: response.requestOptions.maxRedirects,
        requestEncoder: response.requestOptions.requestEncoder,
        responseDecoder: response.requestOptions.responseDecoder,
        listFormat: response.requestOptions.listFormat,
      ),
    );
  }

  Future<String?> _onGetToken(bool force) async {
    try {
      if (force) {
        await Future.delayed(const Duration(seconds: 2));
      }

      return await getAccessToken(force);
    } catch (_) {
      return null;
    }
  }

  Map<String, String> _applyToken(String? token) {
    if (token == null) {
      return {};
    }

    return {'authorization': 'bearer $token'};
  }

  bool _onShouldRefresh(Response? response, int attempt) {
    return attempt < 3 && response != null && (response.statusCode == 401 || response.statusCode == 403);
  }
}
