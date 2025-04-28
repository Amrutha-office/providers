import 'package:flutter/material.dart';
import '../models/cart_items.dart';
import '../models/products.dart';
import '../services/api_servieces.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  Future<void> fetchCart() async {
    final data = await ApiService.getCollection("cart");
    _items = data.map((e) => CartItem.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> addToCart(Product product) async {
    final newItem = await ApiService.createItem("cart", {"product": product.toJson()});
    _items.add(CartItem.fromJson(newItem));
    notifyListeners();
  }

  Future<void> removeFromCart(String id) async {
    await ApiService.deleteItem("cart", id);
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> clearCart() async {
    for (var item in _items) {
      await ApiService.deleteItem("cart", item.id!);
    }
    _items.clear();
    notifyListeners();
  }
}
