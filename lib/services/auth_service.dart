// File: lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Watermark Code diterapkan pada nama Class
class AuthService_Rapli {
  // Inisialisasi Firebase Auth dan Firestore dengan Watermark
  final FirebaseAuth _auth_Rap = FirebaseAuth.instance;
  final FirebaseFirestore _firestore_Rap = FirebaseFirestore.instance;

  // Fungsi Validasi Email Domain Kampus dan Gmail
  String? validateEmail_Rapli(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    // Validasi format email yang menerima domain kampus dan gmail.com
    final RegExp emailregexR = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );

    if (!emailregexR.hasMatch(value)) {
      return 'Gunakan format email yang valid (kampus atau gmail.com)';
    }
    
    // Validasi tambahan untuk memastikan email kampus atau gmail
    if (!value.endsWith('.ac.id') && !value.endsWith('@gmail.com')) {
      return 'Gunakan email kampus (.ac.id) atau gmail.com';
    }
    
    return null;
  }

  // 2. Fungsi Validasi Password (> 6 Char) 
  String? validatePassword_Rapli(String? value) {
    // Minimal 6 karakter sesuai permintaan
    if (value == null || value.length < 6) {
      return 'Password harus minimal 6 karakter (Min. 6 Karakter)';
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
