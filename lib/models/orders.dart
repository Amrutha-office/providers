import 'cart_items.dart';

class Order {
  String? id;
  List<CartItem> items;

  Order({this.id, required this.items});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["_id"],
      items: (json["items"] as List)
          .map((e) => CartItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "items": items.map((item) => item.toJson()).toList(),
    };
  }
}
