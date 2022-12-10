
import 'package:ecom_app/features/product/domain/models/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {

  const factory ProductState({
    @Default(true)
    bool isLoading,
    @Default(false)
    bool isFetching,
    @Default(0)
    int currentPage,
    @Default(0)
    int totalPage,
    @Default(0)
    int total,
    @Default([])
    List<Product> products,
    String? errorMsg,

  }) = _ProductState;
}