class Product {
  String? id;
  String title;
  double price;

  Product({this.id, required this.title, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      title: json["title"],
      price: (json["price"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "price": price,
    };
  }
}
