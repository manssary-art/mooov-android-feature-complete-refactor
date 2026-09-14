import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

extension HttpResponseExt<T> on Future<HttpResponse<T>> {
  Future<Result<T>> asHttpResponseResult() async {
    try {
      final response = await this;
      return Result.value(response.data);
    } on DioError catch (e, s) {
      return Result.error(e, s);
    }
  }
}

