import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class SeedService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> seedProducts() async {
    List<ProductModel> items = [
      ProductModel(productId: "1", name: "Nasi Goreng", price: 15000, stock: 20, imageUrl: "https://via.placeholder.com/300?text=Nasi+Goreng"),
      ProductModel(productId: "2", name: "Ayam Geprek", price: 14000, stock: 15, imageUrl: "https://via.placeholder.com/300?text=Ayam+Geprek"),
      ProductModel(productId: "3", name: "Soto Ayam", price: 12000, stock: 25, imageUrl: "https://via.placeholder.com/300?text=Soto+Ayam"),
      ProductModel(productId: "4", name: "Gado-gado", price: 11000, stock: 18, imageUrl: "https://via.placeholder.com/300?text=Gado+Gado"),
      ProductModel(productId: "5", name: "Lumpia Goreng", price: 10000, stock: 30, imageUrl: "https://via.placeholder.com/300?text=Lumpia"),
      ProductModel(productId: "6", name: "Rendang Daging", price: 18000, stock: 12, imageUrl: "https://via.placeholder.com/300?text=Rendang"),
      ProductModel(productId: "7", name: "Bakso Kuah", price: 13000, stock: 22, imageUrl: "https://via.placeholder.com/300?text=Bakso"),
      ProductModel(productId: "8", name: "Mie Rebus", price: 9000, stock: 35, imageUrl: "https://via.placeholder.com/300?text=Mie+Rebus"),
      ProductModel(productId: "9", name: "Es Cendol", price: 8000, stock: 40, imageUrl: "https://via.placeholder.com/300?text=Es+Cendol"),
      ProductModel(productId: "10", name: "Tahu Goreng", price: 7000, stock: 28, imageUrl: "https://via.placeholder.com/300?text=Tahu+Goreng"),
      ProductModel(productId: "11", name: "Perkedel", price: 6000, stock: 32, imageUrl: "https://via.placeholder.com/300?text=Perkedel"),
      ProductModel(productId: "12", name: "Sup Iga", price: 16000, stock: 14, imageUrl: "https://via.placeholder.com/300?text=Sup+Iga"),
    ];

    for (var item in items) {
      await _db.collection("products").doc(item.productId).set(item.toJson());
    }
  }
}
