import 'package:equatable/equatable.dart';


class CartItem extends Equatable {
  final String productId;
  final int quantity;
  final double price;
  final String name;
  final String crptographicSignature;


  const CartItem({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.name, 
    required this.crptographicSignature,
  });

  double get totalItemPrice => price * quantity;

  @override
  List<Object?> get props => [productId, quantity, price, name, crptographicSignature];
  CartItem copyWith({
    String? productId,
    int? quantity,
    double? price,
    String? name,
    String? crptographicSignature,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      name: name ?? this.name,
      crptographicSignature: crptographicSignature ?? this.crptographicSignature,
    );
  }
}
