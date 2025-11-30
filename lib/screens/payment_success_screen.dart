import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/loading_indicator.dart';

class CheckoutScreen_Rapli extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems_Rapli;
  final double totalPrice_Rapli;
  final String pickupTime_Rapli;

  const CheckoutScreen_Rapli({
    super.key,
    required this.cartItems_Rapli,
    required this.totalPrice_Rapli,
    required this.pickupTime_Rapli,
  });

  @override
  State<CheckoutScreen_Rapli> createState() => _CheckoutScreen_RapliState();
}

class _CheckoutScreen_RapliState extends State<CheckoutScreen_Rapli> {
  bool _isProcessing_Rapli = false;

  void _showPaymentSuccess_Rapli(BuildContext context) {
    // Generate random Order ID
    final orderId_Rapli = 'EK${Random().nextInt(90000) + 10000}'; // EK10000-99999

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circle check icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue.shade700,
                size: 80,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pembayaran Berhasil!',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 8),
            Text(
              'ごじゅうしん (Gojushin)',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            // Order ID
            Text(
              'ID Pesanan: $orderId_Rapli',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Total & Pickup
            Text(
              'Total: Rp ${widget.totalPrice_Rapli.toInt()}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Ambil pada: ${widget.pickupTime_Rapli}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmOrder_Rapli(BuildContext context) async {
    if (_isProcessing_Rapli) return;
    setState(() => _isProcessing_Rapli = true);

    // show modal loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: SizedBox(height: 80, child: Center(child: LoadingIndicator_Rapli())),
      ),
    );

    try {
      // simulate processing time (here you would call backend / save order)
      await Future.delayed(const Duration(seconds: 1));

      // dismiss loading
      Navigator.of(context).pop();

      // show success
      _showPaymentSuccess_Rapli(context);
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Checkout gagal: $e')));
    } finally {
      if (mounted) setState(() => _isProcessing_Rapli = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pesanan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Pickup: ${widget.pickupTime_Rapli}'),
            const SizedBox(height: 20),
            const Text('Metode: Cash'),
            const Spacer(),
            Text('Total: Rp ${widget.totalPrice_Rapli.toInt()}', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessing_Rapli ? null : () => _confirmOrder_Rapli(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: _isProcessing_Rapli
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Konfirmasi & Bayar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
