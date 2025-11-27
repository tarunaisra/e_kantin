import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// apply discount and perform Firestore transaction (stock decrement + create transaction)
  /// function name MUST include bac
  Future<Map<String, dynamic>> checkoutbac({
    required String nimbac,
    required List<Map<String, dynamic>> itemsbac,
  }) async {
    // compute subtotal
    double subtotalbac = 0;
    for (final it in itemsbac) {
      subtotalbac += (it['price'] as num) * (it['qty'] as num);
    }

    // last digit logic
    final int lastDigitbac = int.parse(nimbac[nimbac.length - 1]);
    final bool isOddbac = lastDigitbac % 2 == 1;
    final double discountbac = isOddbac ? subtotalbac * 0.05 : 0.0;
    final double shippingbac = isOddbac ? 0.0 : 0.0; // As spec: odd -> diskon 5%, even -> gratis ongkir. shipping set 0 for both cases; if you want shipping fee when odd, set value.
    final double totalFinalbac = subtotalbac - discountbac + shippingbac;

    // Example Firestore transaction (safe update) — optional if you don't use Firestore, you can skip
    final db = _db;
    await db.runTransaction((txn) async {
      // validate stocks
      for (final it in itemsbac) {
        final docRef = db.collection('Products').doc(it['product id']);
        final snap = await txn.get(docRef);
        if (!snap.exists) throw Exception('Product not found ${it['product id']}');
        final currentStock = (snap.data()!['stock'] as num).toInt();
        if (currentStock < (it['qty'] as int)) throw Exception('Stok tidak cukup untuk ${it['product id']}');
      }

      // create transaction doc
      final trxRef = db.collection('Transactions').doc();
      txn.set(trxRef, {
        'trx id': trxRef.id,
        'total final': totalFinalbac,
        'status': 'Success',
        'items': itemsbac,
        'discount': discountbac,
        'shipping': shippingbac,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // decrement stocks
      for (final it in itemsbac) {
        final docRef = db.collection('Products').doc(it['product id']);
        txn.update(docRef, {'stock': FieldValue.increment(-(it['qty'] as int))});
      }
    });

    return {'subtotal': subtotalbac, 'discount': discountbac, 'shipping': shippingbac, 'totalFinal': totalFinalbac};
  }
}
