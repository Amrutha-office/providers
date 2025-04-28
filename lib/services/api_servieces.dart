// class ApiService {
//   static const String baseUrl = "https://crudcrud.com/api/42ecda5c6bf640738d9df65eaadef796";

//   static const String productEndpoint = "$baseUrl/products";
//   static const String cartEndpoint = "$baseUrl/cart";
//   static const String orderEndpoint = "$baseUrl/orders";
// }
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://crudcrud.com/api/57b22e6608374982aefeff7910289ddf";
  
  static Future<List<dynamic>> getCollection(String collection) async {
    final res = await http.get(Uri.parse('$baseUrl/$collection'));
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> createItem(String collection, Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse('$baseUrl/$collection'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return jsonDecode(res.body);
  }

  static Future<void> updateItem(String collection, String id, Map<String, dynamic> data) async {
    await http.put(
      Uri.parse('$baseUrl/$collection/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  static Future<void> deleteItem(String collection, String id) async {
    await http.delete(Uri.parse('$baseUrl/$collection/$id'));
  }
}
