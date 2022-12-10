

import 'package:ecom_app/core/exception/failure.dart';
import 'package:ecom_app/features/product/domain/models/product_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IProductService {
  Future<Result<ProductModel,Failure>> getProducts(Map<String,dynamic> query);
}