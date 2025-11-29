// lib/controllers/auth_controller.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController_Taruna {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // function logic names must have 'bac' suffix
  Future<void> loginbac({
    required String emailbac,
    required String passbac,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: emailbac, password: passbac);
      // navigate on success
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login error: $e')));
    }
  }

  Future<void> registerbac({
    required String emailbac,
    required String passbac,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: emailbac, password: passbac);
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register error: $e')));
    }
  }
}
