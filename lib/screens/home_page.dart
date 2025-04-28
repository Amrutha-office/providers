import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/cart_providers.dart';
import '../models/products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();

  void _showProductDialog({Product? product}) {
    if (product != null) {
      _titleController.text = product.title;
      _priceController.text = product.price.toString();
    } else {
      _titleController.clear();
      _priceController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(product == null ? 'Add Product' : 'Edit Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              String title = _titleController.text.trim();
              double? price = double.tryParse(_priceController.text.trim());

              if (title.isNotEmpty && price != null) {
                if (product == null) {
                  await Provider.of<ProductProvider>(context, listen: false)
                      .addProduct(Product(title: title, price: price));
                } else {
                  await Provider.of<ProductProvider>(context, listen: false)
                      .updateProduct(Product(
                          id: product.id, title: title, price: price));
                }
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home (Products)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showProductDialog(),
          ),
        ],
      ),
      body: productProvider.products.isEmpty
          ? const Center(child: Text('No Products Found'))
          : ListView.builder(
              itemCount: productProvider.products.length,
              itemBuilder: (ctx, index) {
                final product = productProvider.products[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'edit') {
                        _showProductDialog(product: product);
                      } else if (value == 'delete') {
                        await productProvider.deleteProduct(product.id!);
                      } else if (value == 'add_to_cart') {
                        await cartProvider.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart')),
                        );
                      }
                    },
                    itemBuilder: (ctx) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                      const PopupMenuItem(
                        value: 'add_to_cart',
                        child: Text('Add to Cart'),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
