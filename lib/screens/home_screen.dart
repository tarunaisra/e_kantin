import 'package:flutter/material.dart';
import '../services/checkout_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Example product list (UI-only). Variables for widgets must have 'bac'
  @override
  Widget build(BuildContext context) {
    final products = [
      {'product id': 'P001', 'name': 'Nasi Goreng', 'price': 15000},
      {'product id': 'P002', 'name': 'Ayam Geprek', 'price': 18000},
    ];

    final listViewbac = ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      itemBuilder: (ctx, i) {
        final p = products[i];
        final tilebac = ListTile(
          leading: const Icon(Icons.fastfood),
          title: Text(p['name'] as String),
          subtitle: Text('Rp ${p['price']}'),
          trailing: ElevatedButton(
            onPressed: () {
              // for UI demo: go to cart
              Navigator.pushNamed(context, '/cart');
            },
            child: const Text('Add'),
          ),
        );
        return Card(margin: const EdgeInsets.only(bottom: 12), child: tilebac);
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Smart E-Kantin')),
      body: listViewbac,
      // optional bottom nav or action can be added
    );
  }
}
