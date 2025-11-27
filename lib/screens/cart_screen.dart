import 'package:flutter/material.dart';
import '../services/checkout_service.dart';
import '../widgets/loading_indicator.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // this example keeps cart locally for UI demo; widget variable names have bac
  final List<Map<String, dynamic>> cartItemsbac = [
    {'product id': 'P001', 'name': 'Nasi Goreng', 'price': 15000, 'qty': 1},
    {'product id': 'P002', 'name': 'Ayam Geprek', 'price': 18000, 'qty': 2},
  ];

  bool loadingbac = false;

  Future<void> _onCheckoutbac() async {
    setState(() => loadingbac = true);
    // NIM 141 (digit last = 1) -> odd -> discount 5% (Logic Trap)
    try {
      final res = await CheckoutService().checkoutbac(nimbac: '141', itemsbac: cartItemsbac);
      // show result
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Checkout Result'),
          content: Text('Total final: Rp ${res['totalFinal']}\nDiscount: Rp ${res['discount']}\nShipping: Rp ${res['shipping']}'),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Checkout gagal: $e')));
    } finally {
      setState(() => loadingbac = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final listViewbac = ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: cartItemsbac.length,
      itemBuilder: (ctx, i) {
        final it = cartItemsbac[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(it['name'] as String),
            subtitle: Text('Qty: ${it['qty']}'),
            trailing: Text('Rp ${it['price'] * it['qty']}'),
          ),
        );
      },
    );

    final checkoutButtonbac = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loadingbac ? null : _onCheckoutbac,
        child: loadingbac ? const CircularProgressIndicator() : const Text('CHECKOUT'),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: Column(
        children: [
          Expanded(child: listViewbac),
          Padding(padding: const EdgeInsets.all(16), child: checkoutButtonbac),
        ],
      ),
    );
  }
}
