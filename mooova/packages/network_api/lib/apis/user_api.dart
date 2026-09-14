import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/user_create_dto.dart';
import '../dtos/user_dto.dart';
import '../dtos/user_update_dto.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(
    Dio dio, {
     String? baseUrl,
  }) = _UserApi;

  @GET("/v1/users/lookup/{userId}")
  Future<HttpResponse<UserDto>> getUserById({
    @Path('userId') required String userId,
  });

  @POST("/v1/users/create")
  Future<HttpResponse<UserDto>> createUser({
    @Body() required UserCreateDto body,
  });

  @PUT("/v1/users/update/{userId}")
  Future<HttpResponse<UserDto>> updateUser({
    @Path('userId') required String userId,
    @Body() required UserUpdateDto body,
  });
}
