

import 'package:ecom_app/features/product/domain/models/product_model.dart';

abstract class IProductService {
  Future<ProductModel> getProducts(Map<String,dynamic> query);
}