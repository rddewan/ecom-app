

import 'package:dio/dio.dart';
import 'package:ecom_app/core/remote/network_service.dart';
import 'package:ecom_app/features/product/data/dto/response/product_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_api_service.g.dart';

/// Provide the instance on ProductApiService(dio)
final productApiServiceProvider = Provider.autoDispose<ProductApiService>((ref) {
  final dio = ref.watch(networkServiceProvider);

  return ProductApiService(dio);

});

@RestApi()
abstract class ProductApiService {
  factory ProductApiService(Dio dio) => _ProductApiService(dio);

  @GET('api/v1/product/getProducts')
  Future<ProductResponse> getProducts(@Queries() Map<String,dynamic> query);

}