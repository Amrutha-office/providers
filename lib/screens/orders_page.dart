import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_providers.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: orderProvider.orders.isEmpty
          ? const Center(child: Text('No Orders Found'))
          : ListView.builder(
              itemCount: orderProvider.orders.length,
              itemBuilder: (ctx, index) {
                final order = orderProvider.orders[index];
                return ListTile(
                  title: Text('Order ${index + 1}'),
                  subtitle: Text('${order.items.length} Items'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await orderProvider.deleteOrder(order.id!);
                    },
                  ),
                );
              },
            ),
    );
  }
}
