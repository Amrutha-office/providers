import 'package:flutter/material.dart';
import '../models/orders.dart';
import '../models/cart_items.dart';
import '../services/api_servieces.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> fetchOrders() async {
    final data = await ApiService.getCollection("orders");
    _orders = data.map((e) => Order.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> items) async {
    final newOrder = await ApiService.createItem(
      "orders",
      {
        "items": items.map((item) => item.toJson()).toList(),
      },
    );
    _orders.add(Order.fromJson(newOrder));
    notifyListeners();
  }

  Future<void> deleteOrder(String id) async {
    await ApiService.deleteItem("orders", id);
    _orders.removeWhere((order) => order.id == id);
    notifyListeners();
  }
}
