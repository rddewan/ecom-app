
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecom_app/common/extensions/string_hardcoded.dart';
import 'package:ecom_app/core/exception/failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

mixin DioExceptionMixin {

  Future<T> callApi<T>(FutureOr<T> Function() call) async {
    try {

      return await call();
      
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
          message: e.response?.data['error'].toString() ?? '',
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