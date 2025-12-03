import 'package:cloud_firestore/cloud_firestore.dart';

/// Transaction Model - Anggota 1 (Backend Architect)
/// Menyimpan record pesanan yang telah dibuat
/// Watermark: suffix `_taruna` applied untuk konsistensi dengan ProductModel_taruna
class TransactionModel_taruna {
  final String trxId;
  final double totalFinal; // Harga setelah diskon
  final String status; // 'Success' atau 'Pending'
  final List<Map<String, dynamic>> items; // Produk yang dibeli
  final String userId; // NIM pembeli
  final DateTime createdAt;
  final String pickupTime;

  TransactionModel_taruna({
    required this.trxId,
    required this.totalFinal,
    required this.status,
    required this.items,
    required this.userId,
    required this.createdAt,
    required this.pickupTime,
  });

  /// Convert ke Firestore format
  Map<String, dynamic> toJson() {
    return {
      'trx_id': trxId,
      'total_final': totalFinal,
      'status': status,
      'items': items,
      'user_id': userId,
      'created_at': Timestamp.fromDate(createdAt),
      'pickup_time': pickupTime,
    };
  }

  /// Convert dari Firestore format
  factory TransactionModel_taruna.fromJson(Map<String, dynamic> json) {
    return TransactionModel_taruna(
      trxId: json['trx_id'] ?? '',
      totalFinal: (json['total_final'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'Pending',
      items: List<Map<String, dynamic>>.from(json['items'] ?? []),
      userId: json['user_id'] ?? '',
      createdAt: (json['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      pickupTime: json['pickup_time'] ?? '',
    );
  }
}
