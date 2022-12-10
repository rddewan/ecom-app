

import 'package:ecom_app/core/env/env_reader.dart';
import 'package:ecom_app/core/exception/failure.dart';
import 'package:ecom_app/features/product/application/iproduct_service.dart';
import 'package:ecom_app/features/product/data/dto/response/product_response.dart';
import 'package:ecom_app/features/product/data/repository/iproduct_repository.dart';
import 'package:ecom_app/features/product/data/repository/product_repository.dart';
import 'package:ecom_app/features/product/domain/mappers/product_model_mapper.dart';
import 'package:ecom_app/features/product/domain/models/page.dart';
import 'package:ecom_app/features/product/domain/models/product.dart';
import 'package:ecom_app/features/product/domain/models/product_model.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final productServiceProvider = Provider.autoDispose<IProductService>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  final envReader = ref.watch(envReaderProvider);

  return ProductService(productRepository,envReader.getBaseUrl()) ;
});

class ProductService implements IProductService, ProductModelMapper {
  final IProductRepository _productRepository;
  final String _baseUrl;

  ProductService(this._productRepository, this._baseUrl);

  @override
  Future<Result<ProductModel,Failure>> getProducts(Map<String, dynamic> query) async {
    
    try {

      final response = await _productRepository.getProducts(query);
      final result = mapToProductModel(response);

      return Success(result);
      
    } on Failure catch (e) {
      return Error(e);      
    }
    
    
  }

  @override
  ProductModel mapToProductModel(ProductResponse response) {
    return ProductModel(
      page: Page(
        currentPage: response.currentPage, 
        perPage: response.perPage, 
        lastPage: response.lastPage, 
        total: response.total,
      ), 
      products: response.data.map((e) => 
        Product(
          id: e.id, 
          categoryId: e.categoryId, 
          brandId: e.brandId, 
          sku: e.sku, 
          name: e.name, 
          shortDescription: e.shortDescription, 
          longDescription: e.longDescription, 
          thumbnail: '$_baseUrl${e.thumbnail}', 
          images: '$_baseUrl${e.images}', 
          isActive: int.parse(e.isActive), 
          price: e.price, 
          discount: e.discount,
        ),
      ).toList(),
    );
  }
  
}