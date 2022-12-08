
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id; 
  final String categoryId;   
  final String brandId;
  final String sku;
  final String name;   
  final String shortDescription;  
  final String longDescription;
  final String thumbnail;
  final String images;   
  final int isActive;
  final String price;
  final String discount;

  const Product({
    required this.id, 
    required this.categoryId, 
    required this.brandId, 
    required this.sku, 
    required this.name, 
    required this.shortDescription, 
    required this.longDescription, 
    required this.thumbnail, 
    required this.images, 
    required this.isActive, 
    required this.price, 
    required this.discount,
  });


  @override
  List<Object> get props {
    return [
      id,
      categoryId,
      brandId,
      sku,
      name,
      shortDescription,
      longDescription,
      thumbnail,
      images,
      isActive,
      price,
      discount,
    ];
  }

  @override  
  bool? get stringify => true;
}
