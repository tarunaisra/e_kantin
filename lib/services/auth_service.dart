// File: lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Watermark Code diterapkan pada nama Class
class AuthService_Rapli {
  // Inisialisasi Firebase Auth dan Firestore dengan Watermark
  final FirebaseAuth _auth_Rap = FirebaseAuth.instance;
  final FirebaseFirestore _firestore_Rap = FirebaseFirestore.instance;

  // Fungsi Validasi Email Domain Kampu
  String? validateEmail_Rapli(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    // Perbaikan: Menggunakan RegExp untuk validasi format email + domain wajib
    const String campusdomainR = r'@gmail\.com$';
    final RegExp emailregexR = RegExp(r'^[a-zA-Z0-9.]+' + campusdomainR);

    if (!emailregexR.hasMatch(value)) {
      return 'Wajib gunakan format email yang valid dan domain kampus (ex: @gmail.com)!';
    }
    return null;
  }

  // 2. Fungsi Validasi Password (> 6 Char) 
  String? validatePassword_Rapli(String? value) {
    if (value == null || value.length <= 6) {
      return 'Password harus lebih dari 6 karakter (Min. 7 Karakter)';
    }
    return null;
  }

  // 3. Logika Login 
  Future<User?> signInUser_Rapli(String email, String password) async {
    try {
      UserCredential usercredentialR = await _auth_Rap
          .signInWithEmailAndPassword(email: email, password: password);
      return usercredentialR.user;
    } catch (e) {
      print("Error Login: $e");
      return null;
    }
  }

  // 4. Logika Registe
  Future<User?> registerUser_Rapli({
    required String email,
    required String password,
    required String nim,
    required String fullName,
  }) async {
    try {
      // 1. Buat Akun Auth
      UserCredential usercredentialR = await _auth_Rap
          .createUserWithEmailAndPassword(email: email, password: password);
      final userR = usercredentialR.user;

      if (userR != null) {
        // 2. Simpan Data ke Firestore (Collection: Users)
        await _firestore_Rap.collection('Users').doc(nim).set({
          'user_id': nim,
          'email': email,
          'full name': fullName,
          'password': password, // Disimpan sesuai Data Dictionary
        });
      }
      return userR;
    } catch (e) {
      print("Error Register: $e");
      return null;
    }
  }

  // 5. Ambil NIM berdasarkan Email 
  Future<String?> getUserNimByEmail_Rapli(String email) async {
    try {
      final querySnapshot = await _firestore_Rap
          .collection('Users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }
      return null;
    } catch (e) {
      print("Error getting NIM: $e");
      return null;
    }
  }
}
