

import 'package:ecom_app/features/product/data/dto/response/product_response.dart';
import 'package:ecom_app/features/product/domain/models/product_model.dart';

abstract class ProductModelMapper {
  ProductModel mapToProductModel(ProductResponse response);
}