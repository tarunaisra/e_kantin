import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class CartProviderTaruna extends ChangeNotifier {
  final List<ProductModel> _cartItemsTaruna = [];
  final FirebaseFirestore _dbTaruna = FirebaseFirestore.instance;

  List<ProductModel> get cartItemsTaruna => _cartItemsTaruna;

  void addToCartTaruna(ProductModel productTaruna) {
    _cartItemsTaruna.add(productTaruna);
    notifyListeners();
  }

  void removeFromCartTaruna(String productIdTaruna) {
    _cartItemsTaruna.removeWhere((item) => item.productId == productIdTaruna);
    notifyListeners();
  }

  void clearCartTaruna() {
    _cartItemsTaruna.clear();
    notifyListeners();
  }

  double get totalPriceTaruna {
    return _cartItemsTaruna.fold(0, (sum, item) => sum + item.price);
  }

  // Logic Trap: hitung diskon sari
  double hitungDiskonSari(String nimSari) {
    int lastDigitSari = int.parse(nimSari[nimSari.length - 1]);
    if (lastDigitSari % 2 == 1) {
      // Ganjil: diskon 5%
      return totalPriceTaruna * 0.05;
    } else {
      // Genap: gratis ongkir, diskon 0
      return 0;
    }
  }

  double getFinalPriceTaruna(String nimSari) {
    return totalPriceTaruna - hitungDiskonSari(nimSari);
  }

  // Checkout dengan update stok di Firebase
  Future<void> checkoutTaruna(String nimSari) async {
    try {
      // Gunakan transaction untuk atomic write
      await _dbTaruna.runTransaction((transaction) async {
        for (var itemTaruna in _cartItemsTaruna) {
          DocumentReference productRefTaruna = _dbTaruna.collection('products').doc(itemTaruna.productId);
          
          // Kurangi stok
          transaction.update(productRefTaruna, {
            'stock': FieldValue.increment(-1),
          });
        }
      });

      // Jika berhasil, clear cart
      clearCartTaruna();
      print('Checkout berhasil! Stok diupdate.');
    } catch (e) {
      print('Error saat checkout: $e');
      rethrow;
    }
  }
}

