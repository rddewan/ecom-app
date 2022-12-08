

import 'package:ecom_app/features/product/application/iproduct_service.dart';
import 'package:ecom_app/features/product/application/product_service.dart';
import 'package:ecom_app/features/product/presentation/state/product_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// provide the instance of ProductController
final productControllerProvider = StateNotifierProvider.autoDispose<ProductController,ProductState>((ref) {
  final productService = ref.watch(productServiceProvider);

  return ProductController(productService, const ProductState());
});


class ProductController extends StateNotifier<ProductState> {
  final IProductService _productService;

  ProductController(this._productService, super.state);

  void getProducts() async {
    
    if(state.isFetching) return;

    state = state.copyWith(isFetching: true);

    final pageNumber = state.currentPage == 0 ? 1 : state.currentPage + 1;
    final query = {'perPage':20,'pageNumber':pageNumber};
    final oldProduct = state.products;

    final result = await _productService.getProducts(query);
    state = state.copyWith(
      isFetching: false,
      isLoading: false,
      products: [...oldProduct, ...result.products],
      currentPage: result.page.currentPage,
      totalPage: result.page.lastPage,
      total: result.page.total,
    );

  }
  
}