
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecom_app/common/extensions/string_hardcoded.dart';
import 'package:ecom_app/core/exception/failure.dart';
import 'package:ecom_app/features/auth/login/data/api/login_api_service.dart';
import 'package:ecom_app/features/auth/login/data/dto/response/login_response.dart';
import 'package:ecom_app/features/auth/login/data/repository/ilogin_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRepositoryProvider = Provider.autoDispose<ILoginRepository>((ref) {
  final loginApiService = ref.watch(loginApiServiceProvider);

  return LoginRepository(loginApiService);

});

class LoginRepository implements ILoginRepository {
  final LoginApiService _loginApiService;

  LoginRepository(this._loginApiService);

  @override
  Future<LoginResponse> login(Map<String, dynamic> request) async {

    try {

      return await _loginApiService.login(request);
      
    } on DioError catch (e,s) {

      if (e.error is SocketDirection) {
        throw Failure(
          message: e.message,
          statusCode: e.response?.statusCode,
          exception: e,
          stackTrace: s,
        );

      }

      if (e.response?.statusCode == 401) {
        throw Failure(
          message: '401 Something went wrong, PLease try later'.hardcoded,
          statusCode: e.response?.statusCode,
          exception: e,
          stackTrace: s,
        );

      }

      throw Failure(
        message: e.response?.statusMessage ?? 'Something went wrong, PLease try later'.hardcoded,
        statusCode: e.response?.statusCode,
        exception: e,
        stackTrace: s,
      );      
      
    }
    
   
  }
  
}