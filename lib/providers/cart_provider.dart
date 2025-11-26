import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> _cartItems = [];
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<ProductModel> get cartItems => _cartItems;

  void addToCart(ProductModel product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }

  // Hitung diskon berdasarkan NIM (Ganjil/Genap)
  // Diskon ganjil: 5%, Diskon genap: 10%
  double getDiscount(String nim) {
    int lastDigit = int.parse(nim[nim.length - 1]);
    if (lastDigit % 2 == 1) {
      // Ganjil: 5%
      return totalPrice * 0.05;
    } else {
      // Genap: 10%
      return totalPrice * 0.10;
    }
  }

  double getFinalPrice(String nim) {
    return totalPrice - getDiscount(nim);
  }

  // Checkout dengan update stok di Firebase
  Future<void> checkout(String nim) async {
    try {
      // Gunakan transaction untuk atomic write
      await _db.runTransaction((transaction) async {
        for (var item in _cartItems) {
          DocumentReference productRef = _db.collection('products').doc(item.productId);
          
          // Kurangi stok
          transaction.update(productRef, {
            'stock': FieldValue.increment(-1),
          });
        }
      });

      // Jika berhasil, clear cart
      clearCart();
      print('Checkout berhasil! Stok diupdate.');
    } catch (e) {
      print('Error saat checkout: $e');
      rethrow;
    }
  }
}

