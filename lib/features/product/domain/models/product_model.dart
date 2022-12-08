

import 'package:equatable/equatable.dart';

import 'package:ecom_app/features/product/domain/models/page.dart';
import 'package:ecom_app/features/product/domain/models/product.dart';

class ProductModel extends Equatable {
  final Page page;
  final List<Product> products;

  const ProductModel({required this.page, required this.products});

  @override
  List<Object> get props => [page, products];

  @override
  bool? get stringify => true;
}
