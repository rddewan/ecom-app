
import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:ecom_app/core/env/env_reader.dart';
import 'package:ecom_app/core/remote/network_service_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkServiceProvider = Provider<Dio>((ref) {
  final envReader = ref.watch(envReaderProvider);

  final options = BaseOptions(
    baseUrl: envReader.getBaseUrl(),
    connectTimeout: 1000 * 60,
    sendTimeout: 1000 * 60,
    receiveTimeout: 1000 * 60,
  );

  final _dio = Dio(options)
    ..interceptors.addAll([
      HttpFormatter(),
      NetworkServiceInterceptor(),
    ]);

  return _dio;
});