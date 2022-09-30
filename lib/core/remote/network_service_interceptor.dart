
import 'package:dio/dio.dart';

class NetworkServiceInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.headers['Accept'] = 'application/json';
    options.headers['Accept-Language'] = 'en';
    
    super.onRequest(options, handler);
  }
}