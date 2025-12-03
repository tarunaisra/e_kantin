import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/loading_indicator.dart';
import '../providers/cart_provider.dart';

class CheckoutScreen_Rapli extends StatefulWidget {
  final String nim_Rapli;
  final String pickupTime_Rapli;

  const CheckoutScreen_Rapli({
    super.key,
    required this.nim_Rapli,
    required this.pickupTime_Rapli,
  });

  @override
  State<CheckoutScreen_Rapli> createState() => _CheckoutScreen_RapliState();
}

class _CheckoutScreen_RapliState extends State<CheckoutScreen_Rapli> {
  bool _isProcessing_Rapli = false;

  void _showPaymentSuccess_Rapli(BuildContext context, String trxId_Rapli, double finalPrice_Rapli) {
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
            // Transaction ID
            Text(
              'ID Transaksi: $trxId_Rapli',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Total & Pickup
            Text(
              'Total: Rp ${finalPrice_Rapli.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
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

  Future<void> _confirmOrder_Rapli(BuildContext context, CartProvider_taruna provider) async {
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
      // Quick guard: if cart empty or total is 0, abort and inform user
      if (provider.totalPrice <= 0) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Keranjang kosong. Tambahkan produk sebelum checkout.'),
          backgroundColor: Colors.orange,
        ));
        return;
      }
      // Call real checkout from provider (save to Firestore + update stok)
      final result = await provider.checkout_taruna(
        nim: widget.nim_Rapli,
        pickupTime: widget.pickupTime_Rapli,
      );

      // dismiss loading
      Navigator.of(context).pop();

      // result contains trxId and finalPrice (we captured finalPrice before clearing cart)
      final trxId_Rapli = (result['trxId'] ?? '') as String;
      final finalPriceFromResult = (result['finalPrice'] ?? 0.0) as double;

      // show success dengan final price (use captured value)
      _showPaymentSuccess_Rapli(context, trxId_Rapli, finalPriceFromResult);
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Checkout gagal: $e'),
        backgroundColor: Colors.red,
      ));
    } finally {
      if (mounted) setState(() => _isProcessing_Rapli = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider_taruna>(context);
    final totalPrice_Rapli = provider.totalPrice;
    final discount_Rapli = provider.getDiscount_taruna(widget.nim_Rapli);
    final finalPrice_Rapli = provider.getFinalPrice_taruna(widget.nim_Rapli);
    final discountType_Rapli = provider.getDiscountType_taruna(widget.nim_Rapli);

    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pesanan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('NIM: ${widget.nim_Rapli}'),
            const SizedBox(height: 12),
            Text('Pickup: ${widget.pickupTime_Rapli}'),
            const SizedBox(height: 12),
            const Text('Metode: Cash'),
            const SizedBox(height: 20),
            // Divider
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 16),
            // Pricing breakdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal:'),
                Text('Rp ${totalPrice_Rapli.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(discountType_Rapli),
                Text(
                  '- Rp ${discount_Rapli.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 12),
            // Final Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  'Rp ${finalPrice_Rapli.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessing_Rapli ? null : () => _confirmOrder_Rapli(context, provider),
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

