

import 'package:ecom_app/core/exception/mixin/dio_exception_mixin.dart';
import 'package:ecom_app/features/product/data/api/product_api_service.dart';
import 'package:ecom_app/features/product/data/dto/response/product_response.dart';
import 'package:ecom_app/features/product/data/repository/iproduct_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository.g.dart';

@riverpod
ProductRepository productRepository(ProductRepositoryRef ref) {
  final productApiService = ref.watch(productApiServiceProvider);
  
  return ProductRepository(productApiService);
}

class ProductRepository with DioExceptionMixin implements IProductRepository {
  final ProductApiService _productApiService;

  ProductRepository(this._productApiService);
   

  @override
  Future<ProductResponse> getProducts(Map<String, dynamic> query) async{
    return callApi<ProductResponse>(() => _productApiService.getProducts(query));
    
  }
  
}