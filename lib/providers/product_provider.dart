import 'package:flutter/material.dart';
import '../models/products.dart';
import '../services/api_servieces.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    final data = await ApiService.getCollection("products");
    _products = data.map((e) => Product.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await ApiService.createItem("products", product.toJson());
    _products.add(Product.fromJson(newProduct));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    if (product.id == null) return;
    await ApiService.updateItem("products", product.id!, product.toJson());
    await fetchProducts();
  }

  Future<void> deleteProduct(String id) async {
    await ApiService.deleteItem("products", id);
    _products.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
