import 'package:flutter/material.dart';
import 'dart:math';

class CheckoutScreen_Rapli extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems_Rapli;
  final double totalPrice_Rapli;
  final String pickupTime_Rapli;

  const CheckoutScreen_Rapli({
    super.key,
    required this.cartItems_Rapli,
    required this.totalPrice_Rapli,
    required this.pickupTime_Rapli,
  });

  void _showPaymentSuccess_Rapli(BuildContext context) {
    // Generate random Order ID
    final orderId_Rapli =
        'EK${Random().nextInt(90000) + 10000}'; // EK10000-99999

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
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.green.shade700,
                size: 80,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pembayaran Berhasil!',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
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
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Total & Pickup
            Text(
              'Total: Rp ${totalPrice_Rapli.toInt()}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Ambil pada: $pickupTime_Rapli',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
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

  void _confirmOrder_Rapli(BuildContext context) {
    // Di sini bisa tambahkan logic simpan order ke Firestore jika mau
    _showPaymentSuccess_Rapli(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pesanan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Pickup: $pickupTime_Rapli'),
            const SizedBox(height: 20),
            const Text('Metode: Cash'),
            const Spacer(),
            Text(
              'Total: Rp ${totalPrice_Rapli.toInt()}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _confirmOrder_Rapli(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Konfirmasi & Bayar'),
            ),
          ],
        ),
      ),
    );
  }
}
