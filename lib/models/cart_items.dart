import 'products.dart';

class CartItem {
  String? id;
  Product product;

  CartItem({this.id, required this.product});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json["_id"],
      product: Product.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product": product.toJson(),
    };
  }
}
