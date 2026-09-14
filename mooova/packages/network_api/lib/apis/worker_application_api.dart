import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/worker_application_create_dto.dart';
import '../dtos/worker_application_dto.dart';
import '../dtos/worker_application_update_dto.dart';

part 'worker_application_api.g.dart';

@RestApi()
abstract class WorkerApplicationApi {
  factory WorkerApplicationApi(
    Dio dio, {
        String? baseUrl,
  }) = _WorkerApplicationApi;

  @GET("/v1/users/{userId}/application")
  Future<HttpResponse<WorkerApplicationDto>> getWorkerApplication({
    @Path('userId') required String userId,
  });

  @POST("/v1/users/apply-mooover")
  Future<HttpResponse<void>> createWorkerApplication({
    @Body() required WorkerApplicationCreateDto body,
  });

  @PUT("/v1/users/{userId}/application")
  Future<HttpResponse<void>> updateWorkerApplication({
    @Path('userId') required String userId,
    @Body() required WorkerApplicationUpdateDto body,
  });
}
