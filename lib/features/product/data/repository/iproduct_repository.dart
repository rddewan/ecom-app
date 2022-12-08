

import 'package:ecom_app/features/product/data/dto/response/product_response.dart';

abstract class IProductRepository {
  Future<ProductResponse> getProducts(Map<String,dynamic> query);
}