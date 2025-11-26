import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class CartProviderTaruna extends ChangeNotifier {
  final List<ProductModel> _cartItemsBudi = [];
  final FirebaseFirestore _dbBudi = FirebaseFirestore.instance;

  List<ProductModel> get cartItemsBudi => _cartItemsBudi;

  void addToCartBudi(ProductModel productBudi) {
    _cartItemsBudi.add(productBudi);
    notifyListeners();
  }

  void removeFromCartBudi(String productIdBudi) {
    _cartItemsBudi.removeWhere((item) => item.productId == productIdBudi);
    notifyListeners();
  }

  void clearCartBudi() {
    _cartItemsBudi.clear();
    notifyListeners();
  }

  double get totalPriceBudi {
    return _cartItemsBudi.fold(0, (sum, item) => sum + item.price);
  }

  // Logic Trap: hitung diskon sari
  double hitungDiskonSari(String nimSari) {
    int lastDigitSari = int.parse(nimSari[nimSari.length - 1]);
    if (lastDigitSari % 2 == 1) {
      // Ganjil: diskon 5%
      return totalPriceBudi * 0.05;
    } else {
      // Genap: gratis ongkir, diskon 0
      return 0;
    }
  }

  double getFinalPriceBudi(String nimSari) {
    return totalPriceBudi - hitungDiskonSari(nimSari);
  }

  // Checkout dengan update stok di Firebase
  Future<void> checkoutBudi(String nimSari) async {
    try {
      // Gunakan transaction untuk atomic write
      await _dbBudi.runTransaction((transaction) async {
        for (var itemBudi in _cartItemsBudi) {
          DocumentReference productRefBudi = _dbBudi.collection('products').doc(itemBudi.productId);
          
          // Kurangi stok
          transaction.update(productRefBudi, {
            'stock': FieldValue.increment(-1),
          });
        }
      });

      // Jika berhasil, clear cart
      clearCartBudi();
      print('Checkout berhasil! Stok diupdate.');
    } catch (e) {
      print('Error saat checkout: $e');
      rethrow;
    }
  }
}

