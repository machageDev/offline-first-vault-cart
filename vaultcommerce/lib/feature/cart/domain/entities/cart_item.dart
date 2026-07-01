import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String cryptographicSignature;

  const CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.cryptographicSignature = '',
  });

  /// Business Rule: A calculated getter to compute the total cost of this item 
  /// block inside memory space without allowing external mutations.
  double get totalItemPrice => price * quantity;

  /// Business Rule: Creates a modified duplicate instance of the entity. 
  /// Because fields are final, this is the only legitimate way to mutate a 
  /// state (e.g., changing quantity) without breaking structural immutability.
  CartItem copyWith({
    String? productId,
    String? name,
    double? price,
    int? quantity,
    String? cryptographicSignature,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      cryptographicSignature: cryptographicSignature ?? this.cryptographicSignature,
    );
  }

  @override
  List<Object?> get props => [
        productId,
        name,
        price,
        quantity,
        cryptographicSignature,
      ];
}