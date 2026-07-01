import 'package:hive/hive.dart';
import 'package:vaultcommerce/feature/catalog/product.dart';




@HiveType(typeId: 0) 
class ProductModel extends Product {
  
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @override
  final String description;

  @HiveField(3)
  @override
  final double price;

  @HiveField(4)
  @override
  final String imageUrl;

  @HiveField(5)
  @override
  final int currentStock;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.currentStock,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          imageUrl: imageUrl,
          currentStock: currentStock,
        );

  /// Factory constructor to deserialize raw JSON payloads from the remote catalog API
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
      currentStock: json['current_stock'] as int,
    );
  }

  /// Converts the model instance into a map payload for caching structures
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'current_stock': currentStock,
    };
  }

  /// Helper factory to cleanly cast a base domain Product entity back into a Data Layer Model
  factory ProductModel.fromEntity(Product entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      imageUrl: entity.imageUrl,
      currentStock: entity.currentStock,
    );
  }
}