
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_response.freezed.dart';
part 'product_response.g.dart';


@freezed
class ProductResponse with _$ProductResponse {
  const factory ProductResponse({
    @Default(0)
    @JsonKey(name: 'current_page')
    int currentPage,
    @Default([])
    List<ProductData> data,  
    @Default(0)
    @JsonKey(name: 'last_page')
    int lastPage,
    @Default(0) 
    @JsonKey(name: 'per_page')  
    int perPage, 
    @Default(0) 
    int total,
  }) = _ProductResponse;

  factory ProductResponse.fromJson(Map<String, dynamic> json) => _$ProductResponseFromJson(json);
}

@freezed
class ProductData with _$ProductData {
  const factory ProductData({
    required String id,
    @JsonKey(name: 'category_id')
    required String categoryId,
    @JsonKey(name: 'brand_id')
    required String brandId,
    required String sku,
    required String name,
    @JsonKey(name: 'short_description')
    required String shortDescription,
    @JsonKey(name: 'long_description')
    required String longDescription,
    required String thumbnail,
    required String images,
    @JsonKey(name: 'is_active')
    required String isActive,
    @JsonKey(name: 'deleted_at')
    DateTime? deletedAt,
    @JsonKey(name: 'created_at')
    required DateTime createdAt,
    @JsonKey(name: 'updated_at')
    required DateTime updatedAt,
    required String price,
    required String discount,
  }) = _ProductData;

  factory ProductData.fromJson(Map<String, dynamic> json) => _$ProductDataFromJson(json);
}
