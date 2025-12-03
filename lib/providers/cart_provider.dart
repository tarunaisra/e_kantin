import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/transaction_model.dart';
import 'dart:math';

class CartProvider_taruna extends ChangeNotifier { 
  final List<ProductModel_taruna> _cartItems = [];
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<ProductModel_taruna> get cartItems => _cartItems;

  void addToCart(ProductModel_taruna product) {
    _cartItems.add(product);
    notifyListeners();
  }

  // Remove a single occurrence of a product from the cart (decrement quantity)
  void removeFromCart(String productId) {
    final index = _cartItems.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }

  // Logic Trap: Hitung diskon berdasarkan NIM (Ganjil/Genap)
  // Ganjil: Diskon 5% | Genap: Gratis ongkir (simulasi = 10% diskon)
  double getDiscount_taruna(String nim) {
    try {
      int lastDigit = int.parse(nim[nim.length - 1]);
      if (lastDigit % 2 == 1) {
        // Ganjil: 5%
        return totalPrice * 0.05;
      } else {
        // Genap: 10% (simulasi gratis ongkir)
        return totalPrice * 0.10;
      }
    } catch (e) {
      print('Error parsing NIM: $e');
      return 0.0;
    }
  }

  double getFinalPrice_taruna(String nim) {
    return totalPrice - getDiscount_taruna(nim);
  }

  String getDiscountType_taruna(String nim) {
    try {
      int lastDigit = int.parse(nim[nim.length - 1]);
      if (lastDigit % 2 == 1) {
        return 'Ganjil: Diskon 5%';
      } else {
        return 'Genap: Gratis Ongkir (10%)';
      }
    } catch (e) {
      return 'N/A';
    }
  }

  // Checkout dengan update stok + save transaction ke Firestore
  Future<Map<String, dynamic>> checkout_taruna({
    required String nim,
    required String pickupTime,
  }) async {
    try {
      // Generate Transaction ID
      final trxId = 'TRX${DateTime.now().millisecondsSinceEpoch}${Random().nextInt(1000)}';

      // Group items by productId to compute quantities
      final Map<String, Map<String, dynamic>> grouped = {};
      for (var item in _cartItems) {
        final key = item.productId;
        if (!grouped.containsKey(key)) {
          grouped[key] = {
            'product': item,
            'quantity': 1,
          };
        } else {
          grouped[key]!['quantity'] = grouped[key]!['quantity'] + 1;
        }
      }

      // Prepare items list untuk transaction dengan quantity
      final itemsForTransaction = grouped.values.map((e) {
        final ProductModel_taruna p = e['product'];
        final int q = e['quantity'];
        return {
          'product_id': p.productId,
          'name': p.name,
          'price': p.price,
          'quantity': q,
        };
      }).toList();

      final finalPrice = getFinalPrice_taruna(nim);

      // Gunakan transaction untuk atomic write (update stok + save transaksi)
      await _db.runTransaction((transaction) async {
        // 1. Update stok untuk setiap produk (aggregate by quantity)
        for (var entry in grouped.entries) {
          final productId = entry.key;
          final int qty = entry.value['quantity'];
          DocumentReference productRef = _db.collection('products').doc(productId);
          transaction.update(productRef, {
            'stock': FieldValue.increment(-qty),
          });
        }

        // 2. Save transaction record ke Firestore
        final transactionModel = TransactionModel_taruna(
          trxId: trxId,
          totalFinal: finalPrice,
          status: 'Success',
          items: itemsForTransaction,
          userId: nim,
          createdAt: DateTime.now(),
          pickupTime: pickupTime,
        );

        DocumentReference transactionRef = _db.collection('transactions').doc(trxId);
        transaction.set(transactionRef, transactionModel.toJson());
      });

      // Simpan data yang akan dikembalikan sebelum mengosongkan cart
      final result = {
        'trxId': trxId,
        'finalPrice': finalPrice,
        'items': itemsForTransaction,
      };

      // Jika berhasil, clear cart
      clearCart();
      print('Checkout berhasil! Trx ID: $trxId');
      return result; // Return transaction info untuk digunakan oleh UI
    } catch (e) {
      print('Error saat checkout: $e');
      rethrow;
    }
  }
}

