import 'package:flutter/material.dart';

/// Payment Success Screen - Anggota 5 (Rapli: QA Lead & Integration)
/// Watermark Code: _Rapli suffix diterapkan pada semua variabel & fungsi
/// Fungsi: Menampilkan order ID, total, dan waktu pickup setelah pembayaran berhasil
class PaymentSuccessScreen_Rapli extends StatelessWidget {
  final double totalPrice_Rapli;
  final String pickupTime_Rapli;
  final String? orderId_Rapli; // Order ID dari Firestore (Anggota 4: Taruna)

  const PaymentSuccessScreen_Rapli({
    super.key,
    required this.totalPrice_Rapli,
    required this.pickupTime_Rapli,
    this.orderId_Rapli,
  });

  /// Build Success Screen dengan order details
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran Berhasil'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade50, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Icon - Watermark: _Rapli
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade100,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green.shade700,
                    size: 80,
                  ),
                ),
                const SizedBox(height: 24),

                // Title - Watermark: _Rapli
                Text(
                  'Pembayaran Berhasil!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 16),

                // Order ID Card - Watermark: _Rapli
                if (orderId_Rapli != null)
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'ID Pesanan',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          SelectableText(
                            orderId_Rapli!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Courier',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // Order Details Container - Watermark: _Rapli
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // Total Price - Watermark: _Rapli
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total:'),
                          Text(
                            'Rp ${totalPrice_Rapli.toInt()}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Pickup Time - Watermark: _Rapli
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Ambil pada:'),
                          Text(
                            pickupTime_Rapli,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Back to Home Button - Watermark: _Rapli
                ElevatedButton.icon(
                  onPressed: () => _navigateHome_Rapli(context),
                  icon: const Icon(Icons.home),
                  label: const Text('Kembali ke Beranda'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Navigate ke Home Screen - Watermark: _Rapli
  void _navigateHome_Rapli(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',
      (route) => false,
    );
  }
}
