


import 'package:dio/dio.dart';
import 'package:ecom_app/core/remote/network_service.dart';
import 'package:ecom_app/features/auth/login/data/dto/response/login_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'login_api_service.g.dart';

final loginApiServiceProvider = Provider.autoDispose<LoginApiService>((ref) {
  final dio = ref.watch(networkServiceProvider);

  return LoginApiService(dio);

});

@RestApi()
abstract class LoginApiService {
  factory LoginApiService(Dio dio) => _LoginApiService(dio);

  @POST('api/v1/login')
  Future<LoginResponse> login(@Body() Map<String,dynamic> request);
}